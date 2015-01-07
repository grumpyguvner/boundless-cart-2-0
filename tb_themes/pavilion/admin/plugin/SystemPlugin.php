<?php

require_once TB_THEME_ROOT . '/library/ClassCacheGenerator.php';

class Theme_Admin_SystemPlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    public function getConfigKey()
    {
        return 'system';
    }

    public function filterSettings(array &$system_settings)
    {
        $default_vars = array(
            'cache_enabled'  => 1,
            'cache_styles'   => 1,
            'cache_scripts'  => 1,
            'cache_settings' => 1,
            'cache_menu'     => 1,
            'cache_classes'  => 1,
            'cache_content'  => 1,
            'cache_widgets'  => array(
                'Theme_LatestProductsWidget' => array(
                    'enabled' => 1,
                    'ttl'     => 60
                ),
                'Theme_LatestReviewsWidget' => array(
                    'enabled' => 1,
                    'ttl'     => 60
                )
            ),
            'compatibility_menu'     => 1,
            'compatibility_colorbox' => 0,
            'compatibility_jquery'   => 0,
            'tb_optimizations_mod'   => 0,
            'pages' => array()
        );

        if ($this->manager->gteOc2()) {
            $default_vars['compatibility_moment_js'] = 1;
        }

        if (defined('TB_OPTIMIZATIONS_MOD')) {
            $default_vars['tb_optimizations_mod'] = 1;

            foreach (unserialize(TB_OPTIMIZATIONS_COMPATIBILITY) as $key => $value) {
                $default_vars['compatibility_' . $key] = $value['default'];
            }

            foreach (unserialize(TB_OPTIMIZATIONS_CACHE) as $key => $value) {
                $default_vars['cache_' . $key] = $value['default'];
            }
        }

        $system_settings = TB_FormHelper::initFlatVarsSimple($default_vars, $system_settings);

        $cache_widgets_defaults = array();
        foreach ($this->getCacheWidgetNames() as $class => $name) {
            $cache_widgets_defaults[$class]['enabled'] = 1;
            $cache_widgets_defaults[$class]['ttl'] = 240;
        }

        $system_settings['cache_widgets'] = array_replace($cache_widgets_defaults, $system_settings['cache_widgets']);
    }

    protected function getCacheWidgetNames()
    {
        $classes = $this->manager->getWidgetManager()->getAvailableWidgetNames();

        $exclude = array(
            'Theme_GroupWidget',
            'Theme_TextWidget',
            'Theme_SeparatorWidget',
            'Theme_BannerWidget',
            'Theme_CallToActionWidget',
            'Theme_GalleryWidget',
            'Theme_IconListWidget',
            'Theme_GoogleMapsWidget',
            'Theme_FireSliderWidget',
            'Theme_MenuWidget',
            'Theme_OpenCartWidget'
        );

        foreach ($classes as $class => $name) {
            if (in_array($class, $exclude) || TB_Utils::strEndsWith($class, 'SystemWidget')) {
                unset($classes[$class]);
            }
        }

        $oc_widgets = $this->manager->getWidgetManager()->caveOpenCartWidgets();
        foreach ($oc_widgets as $widget) {
            $classes[TB_Utils::underscore($widget->getName())] = $widget->getName();
        }

        return $classes;
    }

    public function setDataForView(&$system_settings, TB_ViewDataBag $themeData)
    {
        $themeData->cache_widget_names = $this->getCacheWidgetNames();
        if (defined('TB_OPTIMIZATIONS_MOD')) {
            $themeData->optimizations_compatibility = unserialize(TB_OPTIMIZATIONS_COMPATIBILITY);
            $themeData->optimizations_cache = unserialize(TB_OPTIMIZATIONS_CACHE);
        } else {
            $system_settings['tb_optimizations_mod'] = 0;
        }
    }

    public function saveData($post_data, &$theme_settings)
    {
        $theme_data = $theme_settings[$this->getConfigKey()];
        $data = $post_data[$this->getConfigKey()];

        if (!$data['cache_styles']) {
            $data['cache_settings'] = 0;
        }

        if ($data['cache_classes'] && $data['cache_enabled']) {
            TB_ClassCacheGenerator::buildCache($this->context->getStoreId(), $this->context->isDebug());
        } else {
            TB_ClassCacheGenerator::deleteCache($this->context->getStoreId());
        }

        if (!$data['cache_enabled'] && ($theme_data['cache_enabled'] != $data['cache_enabled'])) {
            $this->manager->wipeAllCache();
        } else {
            if ($theme_data['cache_content'] != $data['cache_content']) {
                $this->manager->wipeVarsCache('*area_contents*');
            }
        }

        if (isset($theme_settings['system']['pages'])) {
            foreach ($theme_settings['system']['pages'] as $hash => $page) {
                $remove = true;
                if (isset($data['pages']) && !empty($data['pages'])) {
                    foreach ($data['pages'] as $data_hash => $data_page) {
                        if ($data_page['route'] == $page['route']) {
                            $remove = false;
                            break;
                        }
                    }
                }
                if (true === $remove) {
                    unset($theme_settings['system_routes'][$page['route']]);
                    unset($theme_settings['system']['pages'][$hash]);
                }
            }
        }

        if (isset($data['pages']) && !empty($data['pages'])) {
            foreach ($data['pages'] as $data_page) {
                $theme_settings['system_routes'][$data_page['route']] = 1;
            }
        }

        return array(
            $this->getConfigKey() => $data
        );
    }
}