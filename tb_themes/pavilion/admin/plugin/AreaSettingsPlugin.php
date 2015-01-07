<?php

class Theme_Admin_AreaSettingsPlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    public function getConfigKey()
    {
        return 'area';
    }

    public function filterSettings(array &$style_settings)
    {

    }

    public function setDataForView(&$style_settings, TB_ViewDataBag $themeData)
    {

    }

    public function saveData($post_data, &$theme_settings)
    {
        foreach ($post_data['area'] as $area_name => &$area_settings) {
            if (!isset($post_data['area_' . $area_name . '_key'])) {
                continue;
            }

            $area_key = $area_name . '_' . $post_data['area_' . $area_name . '_key'];

            $this->getModel('layoutBuilder')->cleanSettingsDataBeforePersist($area_settings);
            $this->manager->getBuilderSettingsModel()->setAndPersistScopeSettings('area_settings_' . $area_key, $area_settings);

            $theme_settings['area_settings_keys'][$area_key] = 1;

            $this->manager->wipeAllCache('*' . str_replace('/', '_', $area_key) . '*');
        }
    }
}