<?php

class Theme_Catalog_LayoutBuilderPlugin extends TB_ExtensionPlugin
{
    protected $init_order              = 5000;
    /**
     * @var TB_WidgetsArea[]
     */
    protected $areas                   = array();
    protected $area_contents           = array();
    protected $area_settings_cache_key = '';
    protected $area_contents_cache_key = '';
    protected $area_cache_expire;

    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        /*
         * ToDo LazyLoading to determine areas and layout builder blocks. Process on demand.
        if (TB_RequestHelper::isAjaxRequest()) {
            return;
        }
        */

        $this->bootstrap('common');
        $this->bootstrap('fonts');
        $this->bootstrap('style');
        $this->bootstrap('maintenance');

        $themeData->addCallable(array($this, 'hasArea'));
        $themeData->addCallable(array($this, 'getArea'));
        $themeData->addCallable(array($this, 'getAreaSettings'));
        $themeData->addCallable(array($this, 'areaExists'));
        $themeData->addCallable(array($this, 'getContentCssClasses'));

        $this->manager->getWidgetManager()->loadWidgetClasses();
        $this->area_cache_expire = $this->manager->getThemeConfig('default_cache');

        /*
        if ($themeData->route != 'error/not_found') {
            $content_cache_key = substr($this->context->getRequestUrl(), strlen($this->context->getBaseHttpsIf()));
        } else {
            $content_cache_key = 'error/not_found';
        }

        if (empty($content_cache_key)) {
            $content_cache_key = 'home';
        } else {
            $content_cache_key = preg_replace('/^index.php\?route=/s', '', $content_cache_key);
            $content_cache_key = strtolower(trim(preg_replace('/[^A-Za-z0-9-_\.]+/', '-', $content_cache_key)));
        }
        $this->area_contents_cache_key = 'area_html.' . $content_cache_key;
        */

        $request_area_keys = array();
        foreach ($themeData->request_areas as $area_name => $area_id) {
            $request_area_keys[] = $area_name . '_' . $area_id;
        }
        $cache_key = str_replace('/', '_', implode('.', $request_area_keys)) . '.' . $this->context->getStoreId() . '.' . $this->language_id;

        if ($themeData->information_id) {
            $additional_cache_key =  '.information-' . $themeData->information_id;
        } else
        if ($themeData->category_id) {
            $additional_cache_key =  '.category-' . $themeData->category_id;
        } else
        if ($themeData->route == 'product/product' && isset($this->manager->getOcRequest()->get['product_id']) && is_numeric($this->manager->getOcRequest()->get['product_id'])) {
            $additional_cache_key =  '.product-' . (int) $this->manager->getOcRequest()->get['product_id'];
        } else {
            $additional_cache_key = '.' . strtolower(trim(preg_replace('/[^A-Za-z0-9-_\.]+/', '-', $this->getThemeData()->route)));
            /*
            $additional_cache_key = substr($this->context->getRequestUrl(), strlen($this->context->getBaseHttpsIf()));
            $additional_cache_key = str_replace('&', '-', html_entity_decode($additional_cache_key, ENT_QUOTES, 'UTF-8'));
            $additional_cache_key = trim(preg_replace('/^index.php\?route=/s', '', $additional_cache_key));
            if (!empty($additional_cache_key)) {
                $additional_cache_key = '.' . strtolower(trim(preg_replace('/[^A-Za-z0-9-_\.]+/', '-', $additional_cache_key)));
            }
            */
        }

        if (TB_RequestHelper::isRequestHTTPS()) {
            $additional_cache_key .= '.https';
        }
        $additional_cache_key .= '.' . $themeData->currency_code;

        $this->area_contents_cache_key = 'area_contents.' . $cache_key . $additional_cache_key;

        $cached_contents = $this->manager->getCacheVar($this->area_contents_cache_key);

        $area_settings_keys = array();
        foreach ($themeData->request_areas_settings as $area_name => $area_id) {
            $area_settings_keys[] = $area_name . '_' . $area_id;
        }
        //$settings_cache_key = str_replace('/', '_', implode('.', $area_settings_keys)) . '.' . $this->context->getStoreId() . '.' . $this->language_id;
        $this->area_settings_cache_key = 'area_settings.' . $cache_key;

        if (false === $this->extension->getStylesCacheKey() || !$themeData['system']['cache_enabled'] || !$themeData['system']['cache_settings']) {
            $this->buildAreaSettings($request_area_keys, $area_settings_keys);
        } else {
            $this->areas = $this->manager->getCacheVar($this->area_settings_cache_key);

            if (null === $this->areas) {
                $this->buildAreaSettings($request_area_keys, $area_settings_keys);
            } else {
                $this->initAreas($themeData);
                if (!$cached_contents) {
                    foreach ($this->areas as $area) {
                        $area->configureWidgets();
                    }
                }
            }
        }

        $build_cache = false;

        if ($cached_contents) {

            foreach ($cached_contents as $area_name => $contents) {
                /** @var TB_WidgetsArea $area */
                $area = $this->areas[$area_name];

                $area->addJsContents($contents['js']);

                foreach ($contents['widgets'] as $id => $attributes) {
                    $widget = $area->getWidget($id);
                    $widget->mergeAttributes($attributes);

                    if (!$widget->getAttribute('cacheContent')) {
                        if (!$widget->getAttribute('configured')) {
                            $area->configureWidgetById($id);
                        }
                    } else
                    if ($widget->getAttribute('cacheExpire') < time()) {
                        $widget->addAttribute('cacheExpire', $widget->getAttribute('cacheTTL') + time());
                        $widget->removeAttribute('content');
                        $widget->removeAttribute('asyncCache');
                        $area->configureWidgetById($id);
                        $build_cache = true;
                    } else {
                        $widget->setHasContent(true);
                    }
                }

                $this->area_contents[$area_name] = $contents;
            }
        } else
        if (!empty($this->areas)) {
            $build_cache = true;
        }

        if ($build_cache && $themeData['system']['cache_enabled'] && $themeData['system']['cache_content']) {
            $this->eventDispatcher->connect('view:output', array($this, 'buildContentCache'));
        }
        $this->eventDispatcher->connect('core:generateJs', array($this, 'buildAreasJs'));
    }

    public function buildAreaSettings(array $area_keys, array $area_settings_keys)
    {
        $this->areas = array();
        $themeData = $this->getThemeData();
        $widgetManager = $this->manager->getWidgetManager();

        $keys = $widgetManager->loadAreasData($area_keys, $area_settings_keys);

        foreach ($themeData->request_areas as $area_name => $area_id) {
            if (!isset($keys['area'][$area_name])) {
                continue;
            }

            if ($keys['area'][$area_name] != $area_id) {
                throw new Exception('Area detection mismatch');
            }

            $area_data = $widgetManager->getAreaSettings($area_name . '_' . $area_id, 'area');

            if (!isset($keys['area_settings'][$area_name])) {
                $area_data['settings'] = array();
            } else {
                $area_data['settings'] = $widgetManager->getAreaSettings($area_name . '_' . $keys['area_settings'][$area_name], 'settings');
            }

            $area = new TB_WidgetsArea($area_name, $widgetManager);
            $area->createFromArray($area_data);

            if (!count($area->getRows())) {
                continue;
            }

            $area->configureWidgets();
            if ($area_name != 'content') {
                $area->addData('css_classes', $this->buildLayoutClasses($area->getSettings(), false));
            }

            $this->areas[$area_name] = $area;
        }

        $this->initAreas($themeData);
        if ($themeData['system']['cache_styles'] && $themeData['system']['cache_settings'] && !empty($this->areas)) {
            $this->eventDispatcher->connect('view:output', array($this, 'buildSettingsCache'));
        }
    }

    protected function initAreas(TB_ViewDataBag $themeData)
    {
        foreach ($this->areas as $area) {
            $area->initWidgets($themeData);
            $area_name = $area->getName();

            if ($area_name != 'content') {
                $themeData->{$area_name . '_css_classes'} = $area->getData('css_classes');
            }

            $themeData->{$area_name . '_layout_settings'} = $area->getSetting('layout', array());

            $cache_widgets = $themeData['system']['cache_widgets'];
            $expire = 0;

            foreach ($area->getWidgets() as $widget) {
                $cache_key = get_class($widget);
                if ($cache_key == 'Theme_OpenCartWidget') {
                    $cache_key = TB_Utils::underscore($widget->getName());
                }

                if (isset($cache_widgets[$cache_key]) && $cache_widgets[$cache_key]['enabled']) {
                    if ($cache_widgets[$cache_key]['ttl'] > $expire) {
                        $expire = (int) $cache_widgets[$cache_key]['ttl'];
                    }
                } else
                if (get_class($widget) == 'Theme_OpenCartWidget') {
                    // OpenCart widget needs pre-rendering because of the addScripts() and addStyles() calls. Its layout is 'TB_Widgets' and the widget does not get called from open cart
                    $widget->render();
                }
            }

            $expire = abs($expire * 60);

            if ($expire > $this->area_cache_expire) {
                $this->area_cache_expire = $expire;
            }
        }
    }

    public function buildContentCache()
    {
        $cache = array();

        foreach ($this->area_contents as $area_name => $contents) {

            $area = $this->areas[$area_name];

            $contents['html'] = preg_replace('/\n\s*\n/', "\n", $contents['html']);
            if (!isset($contents['js'])) {
                $contents['js'] = '';
            }

            $this->eventDispatcher->notify(new sfEvent($area, 'core:buildContentCache'));

            foreach ($area->getWidgets() as $widget) {
                // $contents['widgets'] hold the widgets that are to be rendered as placeholders
                if (isset($contents['widgets'][$widget->getId()]) && $widget->getAttribute('renderPlaceHolder')) {
                    if (!$widget->getAttribute('cacheContent')) {
                        $widget->removeAttribute('content');
                        $widget->removeAttribute('js');
                        $widget->removeAttribute('configured');
                    } else {
                        if (!$widget->getAttribute('asyncCache') && method_exists($widget, 'onAreaContentOutput')) {
                            $widget_html = $widget->getAttribute('content');
                            $widget->onAreaContentOutput($widget_html);
                            $widget->addAttribute('content', $widget_html);
                        }
                        if ($js = $widget->getAttribute('js')) {
                            $widget->addAttribute('js', preg_replace('/\n\s*\n/', "\n", $js));
                        }
                        $widget->addAttribute('asyncCache', 1);
                    }

                    $contents['widgets'][$widget->getId()] = $widget->getAttributes();
                } else
                // Fully cached widgets
                if ($widget->getAttributes()) {
                    if (method_exists($widget, 'onAreaContentOutput')) {
                        $widget->onAreaContentOutput($contents['html']);
                    }
                    if ($js = $widget->getAttribute('js')) {
                        $contents['js'] .= preg_replace('/\n\s*\n/', "\n", $js);
                    }
                }
            }

            $cache[$area_name] = $contents;
        }

        $this->manager->setCacheVar($this->area_contents_cache_key, $cache, null, true);
    }

    public function buildSettingsCache()
    {
        foreach ($this->areas as $area) {
            foreach ($area->getWidgets() as $widget) {
                if ($widget instanceof Theme_SystemWidget && $widget->getAttribute('defaultSlotPrefix')) {
                    $widget->setSlotPrefix('default');
                }
            }
        }
        $this->manager->setCacheVar($this->area_settings_cache_key, $this->areas);
    }

    public function buildAreasJs()
    {
        foreach ($this->areas as $area) {
            $this->manager->getThemeExtension()->addJsContents($area->getJsContents());
        }
    }

    public function hasArea($area_name, $slot_prefix = null)
    {
        if (!isset($this->areas[$area_name])) {
            return false;
        }

        $area = $this->areas[$area_name];

        if (!$area->getAttribute('system_widgets_booted')) {
            if (null == $slot_prefix) {
                $slot_prefix = $this->getThemeData()->route;
            }

            foreach ($area->getWidgets() as $widget) {

                if ($widget instanceof Theme_SystemWidget && 'default' == $widget->getSlotPrefix()) {
                    $widget->setSlotPrefix($slot_prefix);
                    $widget->addAttribute('defaultSlotPrefix', 1);
                }

                if ($widget instanceof Theme_GroupWidget) {
                    foreach ($widget->getSubWidgets() as $subWidget) {
                        if ($subWidget instanceof Theme_SystemWidget && 'default' == $subWidget->getSlotPrefix()) {
                            $subWidget->setSlotPrefix($slot_prefix);
                            $widget->addAttribute('defaultSlotPrefix', 1);
                        }
                    }
                }
            }

            $area->addAttribute('system_widgets_booted', 1);
        }

        if (!isset($this->area_contents[$area_name])) {
            $this->buildArea($area, $slot_prefix);
        }

        return !empty($this->area_contents[$area_name]['html']);
    }

    public function areaExists($area_name)
    {
        return isset($this->areas[$area_name]) ? 1 : 0;
    }

    public function getAreaSettings($area_name, $key = null)
    {
        if (!isset($this->areas[$area_name])) {
            return null;
        }

        return $key !== null ? $this->areas[$area_name]->getSetting($key) : $this->areas[$area_name]->getSettings();
    }

    public function getArea($area_name, $slot_prefix = null)
    {
        if (!$this->hasArea($area_name, $slot_prefix)) {
            return '';
        }

        $area = $this->areas[$area_name];
        $contents = $this->area_contents[$area_name];

        foreach ($contents['widgets'] as $id => $attributes) {
            $widget = $area->getWidget($id);
            if (null === $widget) {
                if ($this->context->isDebug()) {
                    fb('Invalid widget somehow: ' . $widget->getId() . ' - ' . $widget->getName());
                }
                continue;
            }

            $widget_html = $widget->getAttribute('content');

            if (null === $widget_html && !$widget->isRendered()) {
                // The widget is rendered as placeholder in the cache and its cache has expired (or turned off)
                $widget_html = $widget->render();
                $expired_widgets[] = $widget->getId();
            }

            $contents['html'] = str_replace('{{' . $widget->getId() . '}}', $widget_html, $contents['html']);
        }

        foreach ($area->getWidgets() as $widget) {
            if ($js = $widget->getAttribute('js')) {
                $area->addJsContents($js);
            }

            // If the widget is fully cached, getAttributes will return empty array
            // The following condition is true before building the cache or if the widget is rendered as placeholder but not cached (widgets with cache off and system widgets)
            // The additional asyncCache attribute is used instead of cacheContent, because before building the cache every widget has cacheContent 1 and asyncCache 0, and after building the cache the widgets with different TTL have asyncCache 1
            if ($widget->getAttributes() && !$widget->getAttribute('asyncCache')) {
                if (method_exists($widget, 'onAreaContentOutput')) {
                    $widget->onAreaContentOutput($contents['html']);
                }
            }
            if ($widget instanceof Theme_GroupWidget) {
                $contents['html'] = str_replace('{{current_url}}', $this->getThemeData()->current_url, $contents['html']);
            }
        }
        // This is the html with the placeholders rendered
        //$this->area_contents[$area_name]['html'] = $contents['html'];

        return $contents['html'];
    }

    public function buildArea(TB_WidgetsArea $area)
    {
        $system_settings = $this->getThemeData()->system;

        $result = array(
            'html'    => '',
            'widgets' => array()
        );

        foreach ($area->getRows() as $row) {

            $this->getModel('layoutBuilder')->filterRowSettings($row['settings']);

            /* @var $row_widgets TB_Widget[] */
            $row_widgets = array();

            foreach ($row['columns'] as &$column) {
                if (isset($column['widgets'])) {
                    foreach ($column['widgets'] as $widget) {
                        if ($widget instanceof Theme_GroupWidget) {
                            foreach ($widget->getSubWidgets() as $subWidget) {
                                $row_widgets[] = $subWidget;
                            }
                        }
                        $row_widgets[] = $widget;
                    }
                }
            }

            $row['row_classes'] = $this->buildLayoutClasses($row['settings']);
            $row['area_name']   = $area->getName();

            if ($system_settings['cache_enabled'] && $system_settings['cache_content']) {
                foreach ($row_widgets as $widget) {

                    if ($widget instanceof Theme_SystemWidget || !$widget->allowAddToAreaContentCache()) {
                        $widget->addAttribute('renderPlaceHolder', 1);
                        $widget->addAttribute('cacheContent', 0);

                        continue;
                    }

                    $cache_key = get_class($widget);
                    if ($cache_key == 'Theme_OpenCartWidget') {
                        $cache_key = TB_Utils::underscore($widget->getName());
                    }

                    if (isset($system_settings['cache_widgets'][$cache_key])) {
                        if (!$system_settings['cache_widgets'][$cache_key]['enabled']) {
                            $widget->addAttribute('renderPlaceHolder', 1);
                            $widget->addAttribute('cacheContent', 0);
                        } else {
                            if (($system_settings['cache_widgets'][$cache_key]['ttl'] * 60) < $this->area_cache_expire) {
                                $widget->addAttribute('renderPlaceHolder', 1);
                                $ttl = $system_settings['cache_widgets'][$cache_key]['ttl'] * 60;
                                $widget->addAttribute('cacheTTL',  $ttl);
                                $widget->addAttribute('cacheExpire', $ttl + time());
                            } else {
                                $widget->addAttribute('renderPlaceHolder', 0);
                            }
                            $widget->addAttribute('cacheContent', 1);
                        }
                    }
                }
            }

            $row_html = $this->renderRow($row);

            $has_content = false;
            foreach ($row_widgets as $widget) {
                if ($widget->hasContent()) {
                    $has_content = true;

                    if (!$system_settings['cache_enabled'] || !$system_settings['cache_content']) {
                        break;
                    }

                    if ($widget->getAttribute('renderPlaceHolder')) {
                        $result['widgets'][$widget->getId()] = $widget->getAttributes();
                    }
                }
            }

            if ($has_content) {
                $result['html'] .= $row_html;
            }

        }

        $this->area_contents[$area->getName()] = $result;
    }

    protected function renderRow($row)
    {
        $columns_content = array();
        foreach ($row['columns'] as $key => $column) {
            $columns_content[$key] = '';
            if (!isset($column['widgets']) || empty($column['widgets'])) {
                continue;
            }
            foreach ($column['widgets'] as $widget) {
                $widget_content = $widget->render();
                if ($widget->hasContent()) {
                    if ($widget->getAttribute('renderPlaceHolder')) {
                        $columns_content[$key] .= '{{' . $widget->getId() . '}}';
                    } else {
                        $columns_content[$key] .= $widget_content;
                    }
                }
            }
        }

        $last_key = null;
        foreach ($row['columns'] as $key => $column) {
            $contents = trim($columns_content[$key]);
            $row['columns'][$key]['changed_grid_proportion'] = false;

            if (!empty($contents) || !$row['settings']['layout']['merge_columns']) {
                $row['columns'][$key]['html_contents'] = $contents;
                $last_key = $key;
            } else {
                $near_key = null;

                if (null !== $last_key) {
                    $near_key = $last_key;
                } else
                    if (isset($row['columns'][$key-1])) {
                        $near_key = $key-1;
                    } else
                        if (isset($row['columns'][$key+1])) {
                            $near_key = $key+1;
                        }

                if (null !== $near_key) {
                    list($num, $denum) = explode('_', $column['grid_proportion']);
                    list($near_num, $near_denum) = explode('_', $row['columns'][$near_key]['grid_proportion']);

                    $fraction = new MathFraction($num, $denum);
                    $near_proportion = $fraction->add(new MathFraction($near_num, $near_denum));

                    $row['columns'][$near_key]['grid_proportion'] = str_replace('/', '_', $near_proportion);
                    $row['columns'][$near_key]['changed_grid_proportion'] = true;
                    unset($row['columns'][$key]);
                } else {
                    $row['columns'][$key]['html_contents'] = '';
                }
            }
        }

        foreach ($row['columns'] as $column) {
            if ($column['changed_grid_proportion']) {
                foreach ($column['widgets'] as $widget) {
                    $widget->addAttribute('grid_proportion', $column['grid_proportion']);
                }
            }
        }

        return $this->manager->getResourceLoader()->fetchExtensionTemplate($this->extension, 'builder_row', $row);
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {
        TB_ColorSchemer::getInstance()->setFilteredColors($this->getThemeData()->colors, 'theme');

        foreach ($this->areas as $area) {

            $area_name = $area->getName();
            $area_settings = $area->getSettings();
            $area_default_colors = $this->getModel('layoutBuilder')->getAreaDefaultColors('area_' . $area_name);

            if (empty($area_settings)) {
                // The area has no default settings in global.php
                $this->getModel('layoutBuilder')->filterSettings($area_settings, 'area_' . $area_name, $area_default_colors);
                if (isset($area_settings['font'][$this->language_id])) {
                    $this->getModel('layoutBuilder')->cleanFontDataBeforePersist($area_settings['font']);
                }
            }

            if (isset($area_settings['colors'])) {
                // Need to filter them because of force_print value. If the main colors are saved without loading the area settings, the area settings may contain wrong inherited color values with force_print setting. They need to be resolved from the main colors.
                TB_ColorSchemer::getInstance()->filterAreaColors($area_settings['colors'], $area_default_colors, 'area_' . $area_name);
            }

            $this->getModel('layoutBuilder')->cleanSettingsColorsBeforePersist($area_settings['colors']);

            $area_css_id = strtolower(str_replace(' ', '_', $area_name));

            $this->addStyleColors($area_settings, $area_css_id, $styleBuilder, true);

            $styleBuilder->buildEffectsCss($area_settings, '#' . $area_css_id);
            if (isset($area_settings['font'][$this->language_id])) {
                $styleBuilder->addFonts($area_settings['font'][$this->language_id], $area_css_id);
            }

            foreach ($area->getRows() as $row) {
                $styleBuilder->buildEffectsCss($row['settings'], '#' . 'row_' . $row['id']);

                if (isset($row['settings']['font'][$this->language_id])) {
                    $styleBuilder->addFonts($row['settings']['font'][$this->language_id], 'row_' . $row['id']);
                }

                if (isset($row['settings']['colors'])) {
                    // Filter to resolve force_print values.
                    TB_ColorSchemer::getInstance()->filterRowColors($row['settings']['colors'], $this->getModel('layoutBuilder')->getRowDefaultColors(), true);
                    $this->getModel('layoutBuilder')->cleanSettingsColorsBeforePersist($row['settings']['colors']);
                }
                $this->addStyleColors($row['settings'], 'row_' . $row['id'], $styleBuilder);

                foreach ($row['columns'] as $column) {
                    if (isset($column['widgets'])) {
                        foreach ($column['widgets'] as $widget) {
                            $this->addWidgetAssets($widget, $styleBuilder);
                        }
                    }
                }
            }
        }
    }

    protected function addWidgetAssets(TB_Widget $widget, TB_StyleBuilder $styleBuilder)
    {
        $settings = $widget->getSettings('common');
        if (empty($settings)) {
            return;
        }

        if (isset($settings['colors'])) {
            // Filter to resolve force_print values.
            TB_ColorSchemer::getInstance()->filterWidgetColors($settings['colors'], $widget->getDefaultColors());
            $this->getModel('layoutBuilder')->cleanSettingsColorsBeforePersist($settings['colors']);
            $widget->setSettings($settings, 'common');
        }

        $css_id = $widget->getDomId();

        $styleBuilder->buildEffectsCss($settings, '#' . $css_id);

        if (isset($settings['font'][$this->language_id])) {
            $styleBuilder->addFonts($settings['font'][$this->language_id], $css_id);
        }

        $this->addStyleColors($settings, $css_id, $styleBuilder);

        if (method_exists($widget, 'buildStyles')) {
            $widget->buildStyles($styleBuilder);
        }

        if ($widget instanceof Theme_GroupWidget) {
            foreach ($widget->getSubWidgets() as $widget) {
                $this->addWidgetAssets($widget, $styleBuilder);
            }
        }
    }

    protected function addStyleColors(array $settings, $id, TB_StyleBuilder $styleBuilder)
    {
        if (!isset($settings['colors']) || !is_array($settings['colors'])) {
            return;
        }

        $bg_color = isset($settings['background']['solid_color']) ? $settings['background']['solid_color'] : null;

        foreach ($settings['colors'] as $group_values) {
            foreach ($group_values as $color_rule) {
                // The color rule can be string because of colors filtering in self::buildStyles()
                if (is_array($color_rule)) {
                    $styleBuilder->addScopedColorRule($id, $color_rule, $bg_color);
                }
            }
        }
    }

    public function buildLayoutClasses(array $settings, $gutter = true)
    {
        if (!isset($settings['layout'])) {
            return '';
        }

        $layout = $settings['layout'];

        $classes  = 'tb_row';
        if (isset($layout['extra_class'])) {
            $classes .= ' ' . $layout['extra_class'];
        }
        $classes .= ' tb_row_' . $layout['type'];
        $classes .= ' tb_mt_'  . $layout['margin_top'];
        $classes .= ' tb_mb_'  . $layout['margin_bottom'];
        $classes .= ' tb_mr_'  . $layout['margin_right'];
        $classes .= ' tb_ml_'  . $layout['margin_right'];

        if ($layout['type'] != 'separate' && $layout['type'] != 'no_max_width tb_row_separate' && $layout['type'] != 'content_separate') {
            $classes .= ' tb_pt_'  . $layout['padding_top'];
            $classes .= ' tb_pr_'  . $layout['padding_right'];
            $classes .= ' tb_pb_'  . $layout['padding_bottom'];
            $classes .= ' tb_pl_'  . $layout['padding_right'];
            if ($gutter) {
                $classes .= ' tb_gut_' . $layout['columns_gutter'];
            }
        }

        if ($layout['type'] == 'separate') {
            $classes .= ' tb_row_fixed';
            $classes .= ' tb_ip_'  . $layout['inner_padding'];
        }

        if ($layout['type'] == 'no_max_width tb_row_separate') {
            $classes .= ' tb_ip_'  . $layout['inner_padding'];
        }

        if ($layout['type'] == 'content_separate') {
            $classes .= ' tb_row_fixed';
        }

        return $classes;
    }

    public function getContentCssClasses()
    {
        $classes = '';

        if (isset($this->areas['content'])) {
            $classes .= $this->buildLayoutClasses($this->areas['content']->getSettings(), false);
        }

        if (!$this->hasArea('column_right') && !$this->hasArea('column_left')) {
            $classes .= ' tb_single_col';
        } else {
            $cols = 1;

            if ($this->hasArea('column_right')) {
                $cols++;
                $classes .= ' tb_sidebar_right';
            }

            if ($this->hasArea('column_left')) {
                $cols++;
                $classes .= ' tb_sidebar_left';
            }

            if ($cols > 1) {
                // $classes = str_replace('tb_row_full', 'tb_row_fixed', $classes);
            }

            $classes .= ' tb_' . $cols . '_cols';
        }

        return $classes;
    }
}