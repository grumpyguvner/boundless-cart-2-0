<?php

class Theme_OpenCartWidget extends TB_Widget
{
    protected $areas = array();
    protected $oc_module_settings = null;

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active' => 1
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'code'       => '',
            'sort_order' => 1
        ), $settings));
    }

    public function initFrontend()
    {
        $this->manager->getEventDispatcher()->connect('core:assignAssets', array($this, 'assignAssets'));
    }

    public function assignAssets()
    {
        $module_settings = $this->getOcModuleSettings();

        if ($module_settings['code'] == 'carousel') {
            $this->themeData->registerJavascriptResource('swiper.min.js');
            $this->themeData->registerStylesheetResource('swiper.css');
        }
    }

    public function onAreaContentOutput(&$html)
    {
        if (!isset($this->themeData->category_products_current['restrictions'])) {
            return;
        }

        $sizes = $this->getSettings('sizes');

        if ($this->getAttribute('grid_proportion')) {
            $sizes['grid_proportion'] = $this->getAttribute('grid_proportion');
        }

        $restrictions = $this->themeData->category_products_current['restrictions'];
        $this->manager->getThemeExtension()->getPlugin('product')->calculateProductsPerRow($restrictions, $sizes);

        $classes = 'tb_gut_' . $restrictions['items_spacing'] . ' tb_size_' . $restrictions['items_per_row'];

        $html = str_replace('tb_' . $this->getDomId() . '_classes', $classes, $html);
    }

    public function render(array $view_data = array())
    {
        if ($this->isRendered()) {
            return $this->getAttribute('content');
        }

        $module_settings = $this->getOcModuleSettings();
        $content = '';

        if (!empty($module_settings)) {
            $content = $this->themeData->loadController('module/' . $module_settings['code'], $module_settings);
            $content = trim(str_replace(array('{{widget_dom_id}}', '{{within_group}}'), array($this->getDomId(), $this->parent === null ? 'true' : 'false'), $content));
        }

        return parent::renderContent($content);
    }

    public function isActive()
    {
        $module_settings = $this->getOcModuleSettings();
        $result = isset($module_settings['status']) && !empty($module_settings['status']);

        return $result;
    }

    public function getOcModuleSettings()
    {
        if (null !== $this->oc_module_settings) {
            return $this->oc_module_settings;
        }

        return $this->manager->gteOc2() ? $this->getOcModuleSettings2() : $this->getOcModuleSettings1();
    }

    public function getOcModuleSettings1()
    {
        $this->oc_module_settings = array();

        $modules = $this->manager->getOcConfig()->get($this->settings['code'] . '_module');
        if (!$modules) {
            return $this->oc_module_settings;
        }

        $layout_id = $this->getThemeModel()->getLayoutIdByName('TB_Widgets');

        foreach ($modules as $module) {
            $layouts = (array) $module['layout_id'];

            if (!strlen($module['sort_order']) || $module['sort_order'] != $this->settings['sort_order'] || !in_array($layout_id, $layouts)) {
                continue;
            }

            $module['code'] = $this->settings['code'];
            $this->oc_module_settings = $module;
            $this->oc_module_settings['_idx'] = $this->settings['sort_order'];
            break;
        }

        return $this->oc_module_settings;
    }

    public function getOcModuleSettings2()
    {
        $module_settings = array(
            'status' => 0
        );

        $parts = explode('.', $this->settings['code']);
        $type = $parts[0];

        if (isset($parts[1])) {
            $module_settings = $this->getOcModel('extension/module')->getModule($parts[1]);

            if (!$module_settings || !$module_settings['status']) {
                return $module_settings;
            }
        } else
        if ($this->manager->getOcConfig()->get($type . '_status')) {
            return $module_settings;
        }

        $module_settings['code'] = $type;
        $module_settings['status'] = 1;
        $module_settings['_idx'] = $this->settings['sort_order'];

        $this->oc_module_settings = $module_settings;

        return $module_settings;
    }

    protected function getDefaultFonts()
    {
        return array(
            'body' => array(
                'section_name'      => 'Body',
                'elements'          => '',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 13,
                'line-height'       => 20,
                'letter-spacing'    => '',
                'word-spacing'      => '',
                'transform'         => '',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => false,
                'has_effects'       => false,
                'show_built_styles' => false,
                'multiple_variants' => true,
                'built-in'          => true,
                'can_inherit'       => true
            ),
            'title' => array(
                'section_name'      => 'Block Title',
                'elements'          => ' .box-heading, .tb_widget_open_cart .panel-heading',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 18,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => true,
                'has_effects'       => true,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true
            )
        );
    }

}