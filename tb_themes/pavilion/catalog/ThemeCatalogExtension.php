<?php

class Theme_Catalog_Extension extends TB_CatalogExtension
{
    protected $init_order = 0;
    protected $settings = array();
    protected $route;
    protected $document_styles_before_render = array();
    protected $document_scripts_before_render = array();
    protected $request_areas = array();
    protected $request_areas_settings = array();
    protected $js_contents = '';
    protected $js_contents_hashes = array();
    protected $styles_cache_key;
    protected $main_css_cache_key;
    protected $file_hash;
    protected $filter_header = true;
    protected $filter_footer = true;

    /**
     * @var TB_ExtensionPluginBootstrap
     */
    protected $pluginBootstrapper;

    /**
     * @var TB_StyleBuilder
     */
    protected $styleBuilder;

    public function configure()
    {
        $this->eventDispatcher->connect('core:filterRoute',   array($this, 'determineBrandCategory'));
        $this->eventDispatcher->connect('core:beforeRouting', array($this, 'beforeRouting'));
        $this->eventDispatcher->connect('core:afterRouting',  array($this, 'afterRouting'));
        $this->eventDispatcher->connect('core:afterDispatch', array($this, 'afterDispatch'));
        $this->eventDispatcher->connect('viewSlot:oc_footer', array($this, 'viewSlotOcFooter'));
        $this->eventDispatcher->connect('view:output',        array($this, 'viewOutput'));

        $this->pluginBootstrapper = new TB_ExtensionPluginBootstrap($this->manager, $this);
        $this->pluginBootstrapper->configureAll();
    }

    public function determineBrandCategory(sfEvent $event, $route)
    {
        if ($route != 'product/category' || !isset($this->request->get['path'])  || !is_numeric($this->request->get['path']) || !isset($this->request->get['manufacturer_id'])) {
            return $route;
        }

        $route = 'category/manufacturer';
        $this->manager->getOcRequest()->get['c_id'] = (int) $this->request->get['path'];
        $this->manager->getOcRequest()->get['man_id'] = (int) $this->request->get['manufacturer_id'];

        unset($this->manager->getOcRequest()->get['path']);

        return $route;
    }

    public function beforeRouting()
    {
        $this->route = '';
        $this->settings = $this->getModel()->getSettings();
        $this->registerRoutes();
        $this->themeData->importVars($this->loadDefaultTranslation());
    }

    protected function registerRoutes()
    {
        $this->registerCatalogRoute(array(
            'name'       => 'category_manufacturer',
            'route'      => 'category/manufacturer',
            'controller' => 'brand_category'
        ));

        $this->registerCatalogRoute(array(
            'name'       => 'tb',
            'route'      => 'tb',
            'controller' => 'tb'
        ));
    }

    public function afterRouting()
    {
        $this->route = $this->themeData->route;
        $this->styleBuilder = new TB_StyleBuilder($this->context, $this->getModel('fonts'));

        $this->themeData->addCallable(array($this, 'link'));
        $this->themeData->addCallable(array($this, 'getThemeCssLink'));
        $this->themeData->addCallable(array($this, 'echoHeader'));
        $this->themeData->addCallable(array($this, 'echoFooter'));

        $this->setCategoryPath();
        $this->setInformationId();
        $this->setLayout();
        $this->setTouch();
        $this->determineAreasForRequest();
        $this->setCurrencyCode();
        $this->setLanguageDirection();
        $this->determineStylesCacheKey();

        $this->eventDispatcher->notify(new sfEvent($this, 'core:pluginsPreBootstrap'));
        $this->pluginBootstrapper->bootstrapAll();
        $this->eventDispatcher->notify(new sfEvent($this, 'core:pluginsPostBootstrap'));
    }

    public function setHeaderFilter($do_filter)
    {
        $this->filter_header = (bool) $do_filter;
    }

    public function setFooterFilter($do_filter)
    {
        $this->filter_footer = (bool) $do_filter;
    }

    public function echoHeader($header)
    {
        if (!$this->filter_header) {
            return;
        }

        $this->themeData->slotStart('oc_header');
        echo $header;
        $this->themeData->slotStop();

        ob_start();
        ob_implicit_flush(0);
        $this->themeData->header_catched = true;
    }

    public function echoFooter($footer)
    {
        if (!$this->filter_footer) {
            return;
        }

        $this->themeData->slotStart('oc_footer');
        echo $footer;
        $this->themeData->slotStop();

        ob_start();
        ob_implicit_flush(0);

        $tbData = $this->themeData;
        require tb_modification($this->context->getCatalogTemplateDir() . '/tb/layout.tpl');

        $content = ob_get_clean();

        $event = new TB_ViewSlotEvent($this, 'view:output');
        $event->setContent($content);

        $this->eventDispatcher->notify($event);

        ob_end_clean();

        echo trim($event->getAllContent());
    }

    public function viewSlotOcFooter(TB_ViewSlotEvent $event)
    {
        $this->assignStyles();
        $header = $this->themeData->viewSlot->getContent('oc_header');

        $font_links = '';
        foreach ($this->themeData->webfonts as $font) {
            $font_links .= '<link href="//fonts.googleapis.com/css?family=' . $font['family'] . '&amp;subset=' . $font['subset'] . '" rel="stylesheet" type="text/css">' . "\n";
        }

        $old_page_css_link = $this->context->getImageUrl() . 'cache/tb/content_home.' . $this->themeData->language_direction . '.' . ($this->themeData->is_touch ? 'touch.' : '') . $this->context->getStoreId() . '.styles.css';
        $old_main_css_link = $this->context->getImageUrl() . 'cache/tb/main.'  . $this->main_css_cache_key . '.styles.css';;

        $header = str_replace(array('<!--{{google_fonts_link}}-->', $old_page_css_link, $old_main_css_link), array($font_links, $this->themeData->theme_page_css_src, $this->themeData->theme_main_css_src), $header);

        $this->themeData->viewSlot->setContent('oc_header', $header);
        $this->document_styles_before_render = $this->manager->getOcDocument()->getStyles();
        $this->document_scripts_before_render = $this->manager->getOcDocument()->getScripts();
    }

    public function viewOutput(TB_ViewSlotEvent $event)
    {
        $this->eventDispatcher->notify(new sfEvent($this, 'core:generateJs'));

        $js = trim($this->js_contents . $this->themeData->viewSlot->getJsContents());

        $html = $event->getContent();

        foreach (array_diff($this->manager->getOcDocument()->getStyles(), $this->document_styles_before_render) as $style) {
            $style_tag = '<link href="'. $style['href'] . '" type="text/css" rel="' . $style['rel']. '" media="'. $style['media']. '" />';
            if (false === strpos($html, $style_tag)) {
                $html = str_replace('</head>', $style_tag . "\n</head>", $html);
            }
        }

        foreach (array_diff($this->manager->getOcDocument()->getScripts(), $this->document_scripts_before_render) as $script) {
            if (false === strpos($html, '<script type="text/javascript" src="'. $script . '"></script>')) {
                $html = str_replace('</head>', '<script type="text/javascript" src="'. $script . '"></script>' . "\n</head>", $html);
            }
        }

        if ($this->manager->getThemeConfig('catalog_minify_page_js') && !$this->context->isDebug()) {
            $external_js = '';
            if (false !== preg_match_all('/(<script type="text\/javascript" src=".*?">.*?<\/script>)/s', $js, $matches)) {
                foreach ($matches[1] as $match) {
                    $external_js .= $match . "\n";
                }
                $js = preg_replace('/(<script type="text\/javascript" src=".*?">.*?<\/script>)/s', '', $js);
            }
            $js = str_replace(array('<script type="text/javascript"><!--', '<script type="text/javascript">', '<script>', '</script>', '--></script>'), '', $js);
            $js = JShrink_Minifier::minify($js);
            $js = $external_js . '<script type="text/javascript">' . $js . '</script>';
        }

        if (!empty($js)) {
            $html = str_replace('</body>', $js . "\n</body>", $html);
            $event->setContent($html);
        }
    }

    public function link($route, $args = '', $connection = 'NONSSL')
    {
        if (!$this->manager->getOcConfig()->get('config_seo_url')) {
            return $this->url->link($route, $args, $connection);
        }

        $base_url = $connection ==  'NONSSL' ? $this->context->getBaseHttp() : $this->context->getBaseHttps();
        $base_url .= 'index.php?route=';
        $url = $base_url . $route;
        if ($args) {
            $url .= '&' . ltrim($args, '&');
        }

        $url_info = parse_url(str_replace('&amp;', '&', $url));
        $data = array();
        parse_str($url_info['query'], $data);

        if (isset($data['route'])) {

            if ($data['route'] == 'category/manufacturer' && isset($data['c_id']) && isset($data['man_id'])) {

                $category_url = $this->url->link('product/category' , 'path=' . (int) $data['c_id']);
                if (str_replace('&amp;', '&', $category_url) == $base_url . 'product/category&category_id=' . (int) $data['c_id']) {
                    return str_replace('&', '&amp;', $url);
                }

                $brand_url = $this->url->link('product/manufacturer/info' , 'manufacturer_id=' . (int) $data['man_id']);
                if (str_replace('&amp;', '&', $brand_url) == $base_url . 'product/manufacturer/info&manufacturer_id=' . (int) $data['man_id']) {
                    return $category_url . '&amp;manufacturer_id=' . (int) $data['man_id'];
                }

                $pos = strspn($category_url ^ $brand_url, "\0");

                return $category_url . '/' . substr_replace($brand_url, '', 0, $pos);
            }
        }

        return $this->url->link($route, $args, $connection);
    }

    public function addJsContents($str, $hash = null)
    {
        if (null !== $hash && isset($this->js_contents_hashes[$hash])) {
            return;
        }

        $this->js_contents .= $str;

        if (null !== $hash) {
            $this->js_contents_hashes[$hash] = 1;
        }
    }

    public function setTouch()
    {
        $this->themeData->is_touch = null;

        if (isset($_COOKIE['is_touch'])) {
            $this->themeData->is_touch = (int) $_COOKIE['is_touch'];
        } else {
            $mobileDetect = new Mobile_Detect();
            if ($mobileDetect->isMobile() || $mobileDetect->isTablet()) {
                $this->themeData->is_touch = 1;
                setcookie('is_touch', 1, time() + 604800, '/', $this->request->server['HTTP_HOST']);
            }
        }
    }

    protected function setCategoryPath()
    {
        $path = (substr($this->route, 0, 16) == 'product/category' && isset($this->request->get['path']) && !empty($this->request->get['path'])) ? (string) $this->request->get['path'] : null;

        if (null == $path) {
            return;
        }

        $path = array_map(create_function('$value', 'return abs((int) $value);'), explode('_', $path));
        $cnt = count($path);
        $this->themeData->category_id = $path[$cnt-1];
        if ($cnt > 1) {
            $this->themeData->category_top_id = $path[0];
            $this->themeData->category_parent_id = $path[$cnt-2];
        }
        $this->themeData->category_path = implode('_', $path);
    }

    protected function setCurrencyCode()
    {
        $currency_code = $this->manager->getOcRegistry()->get('currency')->getCode();
        if (isset($this->request->post['currency_code'])) {
            foreach ($this->manager->getOcModel('localisation/currency')->getCurrencies() as $currency) {
                if ($currency == (string) $this->request->post['currency_code']) {
                    $currency_code = $this->request->post['currency_code'];
                }
            }
        }

        $this->themeData->currency_code = $currency_code;
    }

    protected function setLanguageDirection()
    {
        $lang = $this->manager->loadOcTranslation();
        $direction = $lang['direction'];

        if (!in_array($direction, array('ltr', 'rtl'))) {
            $direction = 'ltr';
        }

        $this->themeData->language_direction = $direction;
    }

    protected function setInformationId()
    {
        if ($this->route == 'information/information' && isset($this->request->get['information_id'])) {
            $this->themeData->information_id = (int) $this->request->get['information_id'];
        }
    }

    protected function setLayout()
    {
        $layout_id = 0;

        if ($this->themeData->category_id) {
            $layout_id = (int) $this->manager->getOcModel('catalog/category')->getCategoryLayoutId($this->themeData->category_id);
        }

        if (substr($this->route, 0, 16) == 'product/product' && isset($this->request->get['product_id'])) {
            $layout_id = (int) $this->manager->getOcModel('catalog/product')->getProductLayoutId((int) $this->request->get['product_id']);
        }

        if (substr($this->route, 0, 24) == 'information/information' && isset($this->request->get['information_id'])) {
            $layout_id = (int) $this->manager->getOcModel('catalog/information')->getInformationLayoutId((int) $this->request->get['information_id']);
        }

        $route_layout_id = (int) $this->manager->getThemeModel()->getLayoutIdByRoute($this->route);

        if (!$layout_id && $route_layout_id) {
            $layout_id = $route_layout_id;
        }

        $this->themeData->layout_id = $layout_id;
        $this->themeData->route_layout_id = $route_layout_id;
    }

    protected function determineStylesCacheKey()
    {
        $this->file_hash = $this->buildResourceCacheHash('css');

        $file_path = $this->context->getImageDir() . '/cache/tb/' . $this->file_hash;
        $this->main_css_cache_key =  $this->themeData->language_direction . '.' . $this->context->getStoreId() . (TB_RequestHelper::isRequestHTTPS() ? '.https': '');

        $ie8_main_css_path = $this->context->getImageDir() . '/cache/tb/ie8_main.' . $this->main_css_cache_key . '.styles.css';;
        $ie8_external_css_path = $this->context->getImageDir() . '/cache/tb/ie8_external.' . $this->main_css_cache_key . '.styles.css';

        if (!file_exists($file_path . '.styles.css') || !file_exists($file_path . '.meta.cache') || !file_exists($ie8_main_css_path) || !file_exists($ie8_external_css_path)) {
            $this->styles_cache_key = false;
        } else {
            $this->styles_cache_key = $this->file_hash;
        }
    }

    protected function buildResourceCacheHash($type)
    {
        static $file_hash = array();

        if (!isset($file_hash[$type])) {
            $hash = array();

            foreach ($this->themeData->request_areas as $area => $key) {
                $hash[] = $area . '_' . str_replace('/', '_', $key);
            }

            if (!empty($hash)) {
                $hash = implode('.', $hash);
            } else {
                $hash = 'no_area';
            }

            if ($type == 'css') {
                $hash .= '.' . $this->themeData->language_direction . '.' . ($this->themeData->is_touch ? 'touch.' : '') . $this->context->getStoreId();
                if (TB_RequestHelper::isRequestHTTPS()) {
                    $hash .= '.https';
                }
            }

            $file_hash[$type] = $hash;
        }

        return $this->context->getBasename() . '.' . $file_hash[$type];
    }

    public function getStylesCacheKey()
    {
        return $this->styles_cache_key;
    }

    public function getStylesFileHash()
    {
        return $this->file_hash;
    }

    public function afterDispatch(sfEvent $event)
    {
        /*
        if (isset($this->request->get['returnThemeLayoutBuilderData'])) {
            $result = array();
            foreach ($this->themeData->request_areas as $area_name => $area_key) {
                $key_parts = explode('_', $area_key);
                $result[] = array(
                    'area_name' => $area_name,
                    'area_type' => array_shift($key_parts),
                    'area_id'   => implode('_', $key_parts)
                );
            }
            foreach ($result as &$area) {
                switch ($area['area_type']) {
                    case 'home':
                        $area['label'] = 'Home';
                        break;
                    case 'default':
                        // Може да е system или layout
                        if ($system_page = $this->getModel('layoutBuilder')->getSystemPageForRoute($this->route)) {
                            $area['label'] = $system_page['label'];
                        } else
                        if ($route_layout_id = (int) $this->manager->getOcModel('design/layout')->getLayout($this->route)) {

                        } else {
                            $area['label'] = 'GLOBAL';
                        }

                        break;
                }
            }
            $event->setReturnValue(json_encode(
                $result
            ));
            $event->setProcessed(true);
        }
        */
        if (isset($this->request->get['setLivePreviewMode'])) {
            $key = $this->manager->getOcConfig()->get($this->context->getBasename() . '_livePreviewToken');
            if ($key == base64_decode((string) $this->request->get['setLivePreviewMode'])) {
                setcookie('livePreviewMode', 1, time() + 14400, '/', $this->request->server['HTTP_HOST']);
            }
        }

        if (isset($_COOKIE['livePreviewMode']) && $_COOKIE['livePreviewMode']) {
            $key = $this->manager->getOcConfig()->get($this->context->getBasename() . '_livePreviewToken');
            $parts = explode('!*!', $key);
            if (!$key || $parts[1] != TB_Utils::getIp()) {
                $this->manager->getDbSettingsHelper()->deleteKey($this->context->getBasename() . '_livePreviewToken', $this->context->getStoreId());
                unset($_COOKIE['livePreviewMode']);
                setcookie('livePreviewMode', null, -1, '/', $this->request->server['HTTP_HOST']);
            } else {
                if (!TB_RequestHelper::isAjaxRequest() && $this->route != 'error/not_found' && false === stripos($this->route, 'captcha')) {
                    $url = TB_Utils::removeQueryStringVar($this->context->getRequestUrl(), 'setLivePreviewMode');
                    $this->manager->getDbSettingsHelper()->persistKey($this->context->getBasename() . '_livePreviewToken', $this->context->getStoreId(), 'config', $url . '!*!' . $parts[1] . '!*!' . time());
                }
            }
        }

        $event = new sfEvent($this->themeData, 'core:assignAssets');
        $this->manager->getEventDispatcher()->notify($event);

        $this->assignJavascript();

        $tb_setting_keys = $this->themeData->getTbSettingsLoadKeys();
        if (!empty($tb_setting_keys)) {
            $settings = $this->manager->getDbSettingsHelper()->getKeyCollection($tb_setting_keys, $this->context->getStoreId());
            foreach ($settings as $key => $value) {
                $this->themeData[$key] = $value;
            }

            $event = new sfEvent($this->themeData, 'core:loadTbSettings');
            $this->manager->getEventDispatcher()->notify($event);
        }

    }

    protected function assignJavascript()
    {
        $this->themeData->registerJavascriptResource('libs.js');
        $this->themeData->registerJavascriptResource('common.js');

        if (!$this->settings['system']['cache_enabled'] || !$this->settings['system']['cache_scripts']) {

            $this->themeData->setJavascriptResources(array('external' => array_merge(
                $this->themeData->getJavascriptResources('merged'),
                $this->themeData->getJavascriptResources('external')
            )));

            return;
        }

        $cache_file = 'cache/tb/' . $this->buildResourceCacheHash('js') . '.script.js';
        $this->themeData->theme_js_src = $this->context->getImageUrl() . $cache_file;

        if (is_file($this->context->getImageDir() . '/' . $cache_file)) {
            return;
        }

        $js = $this->themeData->createJavascriptVars();
        if ($this->manager->getThemeConfig('catalog_minify_js') && !$this->context->isDebug()) {
            $js = JShrink_Minifier::minify($js);
        }

        foreach($this->themeData->getJavascriptResources('merged') as $resource) {
            if ($this->manager->getThemeConfig('catalog_minify_js') && !$this->context->isDebug() && basename($resource['dir']) == 'common.js') {
                $js .= "\n" . JShrink_Minifier::minify(file_get_contents($resource['dir']));
            } else {
                $js .= "\n" . file_get_contents($resource['dir']);
            }
        }

        /*
        if ($this->manager->getThemeConfig('catalog_minify_js') && !$this->context->isDebug()) {
            $js = preg_replace('/(?:(?:\/\*(?:[^*]|(?:\*+[^*\/]))*\*+\/)|(?:(?<!\:|\\\)\/\/.*))/', '', $js);
            $js = preg_replace('/\n\s*\n/', "\n", $js);
        }
        */

        if (!is_dir($this->context->getImageDir() . '/cache/tb/')) {
            mkdir($this->context->getImageDir() . '/cache/tb/', 0777);
        }

        file_put_contents($this->context->getImageDir() . '/' . $cache_file, $js, LOCK_EX);
    }

    protected function assignStyles()
    {
        static $assigned = false;

        if ($assigned) {
            return;
        }

        if (!is_dir($this->context->getImageDir() . '/cache/tb/')) {
            mkdir($this->context->getImageDir() . '/cache/tb/', 0777);
        }

        $file_path = $this->context->getImageDir() . '/cache/tb/' . $this->buildResourceCacheHash('css');
        $meta = false;

        if (!$this->settings['system']['cache_enabled'] || !$this->settings['system']['cache_styles'] || false === $this->styles_cache_key) {

            $this->generateStyles();

            $basedir = dirname($file_path);
            if (!is_dir($basedir)) {
                mkdir($basedir, 0777);
            }

            $css = $this->fetchTemplate('page.css', array(
                'scoped_colors_css'       => $this->styleBuilder->getScopedColorsString(),
                'plugins_css'             => $this->styleBuilder->getCssString(),
                'fonts_css'               => $this->styleBuilder->getFontsString(),
                'theme_catalog_image_url' => $this->context->getThemeCatalogImageUrl()

            ));

            if ($this->manager->getThemeConfig('catalog_minify_css') && !$this->context->isDebug()) {
                $css = TB_Utils::minifyCss($css);
            }

            file_put_contents($file_path . '.styles.css', $css, LOCK_EX);

            $compatibility_css = false;
            foreach ($this->themeData->request_areas as $area => $key) {
                if ($area == 'content' && $key == 'home') {
                    $compatibility_css = 'content_home.' . $this->themeData->language_direction . '.' . ($this->themeData->is_touch ? 'touch.' : '') . $this->context->getStoreId();
                    break;
                }
            }

            if (false !== $compatibility_css) {
                file_put_contents($this->context->getImageDir() . '/cache/tb/' . $compatibility_css . '.styles.css', $css, LOCK_EX);
            }

            $meta = array(
                'webfonts' => $this->styleBuilder->getWebFonts(),
                'css_hash' => md5($css)
            );
            file_put_contents($file_path . '.meta.cache', serialize($meta), LOCK_EX);

            if (!$this->settings['system']['cache_styles']) {
                $meta['css_hash'] .= '.' . mt_rand();
            }
        }

        if (!$meta) {
            $meta = unserialize(file_get_contents($file_path . '.meta.cache'));
        }

        $page_css_src = $this->context->getImageUrl() . 'cache/tb/' . $this->buildResourceCacheHash('css') . '.styles.css';
        $this->themeData->theme_page_css_src = $page_css_src . '?id=' . $meta['css_hash'];
        $this->themeData->webfonts = $meta['webfonts'];

        $main_css_path = $this->context->getImageDir() . '/cache/tb/main.' . $this->main_css_cache_key . '.styles';

        $ie8_main_css_path = $this->context->getImageDir() . '/cache/tb/ie8_main.' . $this->main_css_cache_key . '.styles.css';;
        $ie8_external_css_path = $this->context->getImageDir() . '/cache/tb/ie8_external.' . $this->main_css_cache_key . '.styles.css';

        if (!$this->settings['system']['cache_enabled'] || !$this->settings['system']['cache_styles'] || !file_exists($main_css_path . '.css') || !file_exists($main_css_path . '.meta.cache') || !file_exists($ie8_main_css_path) || !file_exists($ie8_external_css_path)) {

            $css = $this->fetchTemplate('main.css', array(
                'media_queries'           => true,
                'external_css'            => $this->styleBuilder->getExternalCss(),
                'global_colors_css'       => $this->styleBuilder->getGlobalColorsString(),
                'theme_catalog_image_url' => $this->context->getThemeCatalogImageUrl()

            ));

            if ($this->manager->getThemeConfig('catalog_minify_css') && !$this->context->isDebug()) {
                $css = TB_Utils::minifyCss($css);
            }

            file_put_contents($main_css_path . '.css', $css, LOCK_EX);

            $meta = array(
                'css_hash' => md5($css)
            );

            file_put_contents($main_css_path . '.meta.cache', serialize($meta), LOCK_EX);

            if (!file_exists($ie8_main_css_path) || !file_exists($ie8_external_css_path)) {
                file_put_contents($ie8_external_css_path, $this->styleBuilder->getExternalCss(), LOCK_EX);
                $css = $this->fetchTemplate('main.css', array(
                    'media_queries'           => false,
                    'external_css'            => '',
                    'global_colors_css'       => $this->styleBuilder->getGlobalColorsString(),
                    'theme_catalog_image_url' => $this->context->getThemeCatalogImageUrl()

                ));
                file_put_contents($ie8_main_css_path, $css, LOCK_EX);
            }
        } else {
            $meta = unserialize(file_get_contents($main_css_path . '.meta.cache'));
        }

        $main_css_src = $this->context->getImageUrl() . 'cache/tb/main.'  . $this->main_css_cache_key . '.styles.css';
        $this->themeData->theme_main_css_src = $main_css_src . '?id=' . $meta['css_hash'];

        $assigned = true;
    }

    public function getThemeCssLink()
    {
        $result = '';

        if (TB_RequestHelper::lteIe9()) {
            $ie8_main_css_path = $this->context->getImageDir() . '/cache/tb/ie8_main.' . $this->main_css_cache_key . '.styles.css';;
            $ie8_external_css_path = $this->context->getImageDir() . '/cache/tb/ie8_external.' . $this->main_css_cache_key . '.styles.css';

            $result .= '<link rel="stylesheet" type="text/css" href="' . $this->context->getImageUrl() . 'cache/tb/ie8_external.'  . $this->main_css_cache_key . '.styles.css?id=' . (is_file($ie8_external_css_path) ? md5(file_get_contents($ie8_external_css_path)) : mt_rand()) . '" media="all" />' . "\n";
            $result .= '<link rel="stylesheet" type="text/css" href="' . $this->context->getImageUrl() . 'cache/tb/ie8_main.'  . $this->main_css_cache_key . '.styles.css?id=' . (is_file($ie8_external_css_path)  ?md5(file_get_contents($ie8_main_css_path)) : mt_rand()) . '" media="all" />' . "\n";
        } else {
            $result .= '<link rel="stylesheet" type="text/css" href="' . $this->context->getImageUrl() . 'cache/tb/main.'  . $this->main_css_cache_key . '.styles.css' . '" media="all" />' . "\n";
        }

        $result .=  '<link rel="stylesheet" type="text/css" href="' . $this->context->getImageUrl() . 'cache/tb/content_home.' . $this->themeData->language_direction . '.' . ($this->themeData->is_touch ? 'touch.' : '') . $this->context->getStoreId() . '.styles.css" media="all" />' . "\n";

        return $result;
    }

    protected function generateStyles()
    {
        static $generated = false;

        if ($generated) {
            return;
        }

        $this->styleBuilder->setBaseLineHeight($this->themeData->fonts['body']['line-height']);

        foreach ($this->getPlugins() as $plugin) {
            if (method_exists($plugin, 'buildStyles')) {
                $plugin->buildStyles($this->styleBuilder, $this->themeData);
            }
        }

        $generated = true;
    }

    protected function determineAreasForRequest()
    {
        $themeData = $this->themeData;
        $content = $this->determineAreaData($this->settings['area_keys'], 'rows');
        $settings = $this->determineAreaData($this->settings['area_settings_keys'], 'settings');

        foreach ($settings as $area_name => $area_id) {
            if (!isset($content[$area_name])) {
                unset($settings[$area_name]);
            }
        }

        $this->request_areas = $themeData->request_areas = $content;
        $this->request_areas_settings = $themeData->request_areas_settings = $settings;

        if ($this->context->isDebug()) {
            fb(array(
                'area'         => $this->request_areas,
                'settings'     => $this->request_areas_settings,
                'layout'       => $this->themeData->layout_id,
                'route layout' => $this->themeData->route_layout_id,
                'route'        => $this->themeData->route,
                'rnd'          => mt_rand()
            ));
        }
    }

    protected function determineAreaData(array $keys, $type)
    {
        $result = array(
            'intro'        => null,
            'content'      => null,
            'column_left'  => null,
            'column_right' => null,
            'footer'       => null
        );

        $themeData = $this->themeData;

        $category_level = 0;
        if ($themeData->category_id) {
            $category_level = count(explode('_', $themeData->category_path));
        }

        foreach ($result as $area_name => $area_id) {

            if ($this->route == 'common/home' && isset($keys[$area_name . '_home'])) {
                $result[$area_name] = 'home';
            } else

            if ($themeData->information_id) {
                if (isset($keys[$area_name . '_page_' . $themeData->information_id])) {
                    $result[$area_name] = 'page_' . $themeData->information_id;
                } else
                if (isset($keys[$area_name . '_layout_' . $themeData->layout_id])) {
                    $result[$area_name] = 'layout_' . $themeData->layout_id;
                } else
                if (isset($keys[$area_name . '_layout_' . $themeData->route_layout_id])) {
                    $result[$area_name] = 'layout_' . $themeData->route_layout_id;
                } else
                if (isset($keys[$area_name . '_global'])) {
                    $result[$area_name] = 'global';
                } else
                if (isset($keys[$area_name . '_default_' . $this->route])) {
                    $result[$area_name] = 'default_' . $this->route;
                } else
                if (isset($keys[$area_name . '_default'])) {
                    $result[$area_name] = 'default';
                }
            } else

            if ($themeData->category_id || $themeData->route == 'product/category') {
                if (isset($keys[$area_name . '_category_' . $themeData->category_id])) {
                    $result[$area_name] = 'category_' . $themeData->category_id;
                } else
                if (isset($keys[$area_name . '_layout_' . $themeData->layout_id])) {
                    $result[$area_name] = 'layout_' . $themeData->layout_id;
                } else
                if (isset($keys[$area_name . '_layout_' . $themeData->route_layout_id])) {
                    $result[$area_name] = 'layout_' . $themeData->route_layout_id;
                } else
                if (isset($keys[$area_name . '_category_level_' . $category_level])) {
                    $result[$area_name] = 'category_level_' . $category_level;
                } else
                if (isset($keys[$area_name . '_category_global'])) {
                    $result[$area_name] = 'category_global';
                } else {
                    $has_category_defaults = isset($keys[$area_name . '_default_' . $this->route]);
                    $has_global_record = isset($keys[$area_name . '_global']);

                    if ($has_category_defaults && (!$has_global_record || $keys[$area_name . '_default_' . $this->route] == 0)) {
                        $result[$area_name] = 'default_' . $this->route;
                    } else
                    if ($has_global_record) {
                        $result[$area_name] = 'global';
                    } else
                    if (isset($keys[$area_name . '_default'])) {
                        $result[$area_name] = 'default';
                    }
                }
            } else

            if (isset($keys[$area_name . '_system_' . $this->route])) {
                $result[$area_name] = 'system_' . $this->route;
            } else

            if (isset($keys[$area_name . '_layout_' . $themeData->layout_id]) && ($type == 'settings' || $this->route != 'common/home')) {
                $result[$area_name] = 'layout_' . $themeData->layout_id;
            } else

            if ($themeData->layout_id != $themeData->route_layout_id && $themeData->route == 'product/product') {
                $layout_name = $this->getModel()->getLayoutNameById($themeData->layout_id);
                if (strpos(strtolower($layout_name), 'product*') !== false) {
                    if (isset($keys[$area_name . '_layout_' . $themeData->route_layout_id])) {
                        $result[$area_name] = 'layout_' . $themeData->route_layout_id;
                    }
                }
            }

            if (!isset($result[$area_name])) {
                $has_system_defaults = false;
                if (false !== in_array($this->route, $this->getModel()->getSetting('system_routes'))) {
                    $has_system_defaults = isset($keys[$area_name . '_default_' . $this->route]);
                }
                $has_global_record = isset($keys[$area_name . '_global']);

                if ($has_system_defaults && (!$has_global_record || $keys[$area_name . '_default_' . $this->route] == 0)) {
                    $result[$area_name] = 'default_' . $this->route;
                } else
                if ($has_global_record) {
                    $result[$area_name] = 'global';
                } else
                if (isset($keys[$area_name . '_default']) && ($type == 'settings' || $this->route != 'common/home')) {
                    $result[$area_name] = 'default';
                }
            }

        }

        foreach ($result as $key => $value) {
            if (null === $value) {
                unset($result[$key]);
            }
        }

        return $result;
    }

    protected function checkCategoryLevelArea($category_level, $area_widgets)
    {
        if ($category_level && isset($area_widgets['category_level_' . $category_level]) && !empty($area_widgets['category_level_' . $category_level]['rows'])) {
            return true;
        }

        return false;
    }

    protected function checkCategoryGlobalArea($category_level, $area_widgets)
    {
        if ($category_level && isset($area_widgets['category_global']) && !empty($area_widgets['category_global']['rows'])) {
            return true;
        }

        return false;
    }

    public function getRequestAreas()
    {
        return $this->request_areas;
    }

    /**
     * @return array|TB_ExtensionPlugin[]
     */
    public function getPlugins()
    {
        return $this->pluginBootstrapper->getPlugins();
    }

    /**
     * @param $name
     * @return TB_ExtensionPlugin
     */
    public function getPlugin($name)
    {
        return $this->pluginBootstrapper->getPlugin($name);
    }

}