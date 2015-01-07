<?php

class Theme_Admin_ExportController extends TB_AdminController
{
    public function settings()
    {
        $store_id = (int) $this->request->get['export_store_id'];
        $theme_settings = $this->manager->getSettingsModelInstance($store_id)->getScopeSettings('theme', true);
        if (empty($theme_settings)) {
            return $this->sendJsonError('There are no saved settings for the selected store');
        }

        $theme_settings['area_keys'] = array();
        $theme_settings['first_time'] = 0;

        $language_id = $this->manager->getDefaultCatalogLanguage('id');

        $theme_settings['font'] = array(
            1 => $theme_settings['font'][$language_id]
        );

        $theme_settings['twitter'] = array(
            1 => $theme_settings['twitter'][$language_id]
        );

        $theme_settings['facebook'] = array(
            1 => $theme_settings['facebook'][$language_id]
        );

        $area_settings_keys = array();
        foreach($theme_settings['area_settings_keys'] as $area_key => $value) {
            foreach (array('content', 'footer', 'intro', 'column_left', 'column_right') as $area) {
                if (strpos($area_key, $area) === 0 && strpos($area_key, $area . '_default') !== 0) {
                    $area_settings_keys[$area_key] = $value;
                    break;
                }
            }
        }
        $theme_settings['area_settings_keys'] = $area_settings_keys;

        $db_area_settings_keys = array();
        foreach (array_keys($area_settings_keys) as $key) {
            $db_area_settings_keys[] = 'area_settings_' . $key;
        }
        $tb_settings = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($db_area_settings_keys);

        $content = array();
        $content_keys = array();
        $last_footer_row = array();
        if ($store_id == 0) {
            // default
            $content_keys = array('area_footer_global', 'area_content_layout_2', 'area_content_category_global', 'area_content_system_product/search', 'area_content_system_category/manufacturer', 'area_content_system_product/manufacturer/info', 'area_content_system_product/special');
            $content = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($content_keys);
            $last_footer_row = end($content['area_footer_global']['rows']);
        } else
        if ($store_id == 2) {
            // stylish
            $content_keys = array(
                'area_footer_global', 'area_intro_category_global', 'area_intro_category_level_1', 'area_intro_system_product/search', 'area_intro_system_category/manufacturer', 'area_intro_system_product/manufacturer/info', 'area_intro_system_product/special',
                'area_content_layout_2', 'area_content_category_global', 'area_content_category_level_1', 'area_content_system_product/search', 'area_content_system_category/manufacturer', 'area_content_system_product/manufacturer/info', 'area_content_system_product/special'
            );
            $content = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($content_keys);
            end($content['area_footer_global']['rows']);
            $last_footer_row = prev($content['area_footer_global']['rows']);
        } else
        if ($store_id == 4) {
            // shoppica
            $content_keys = array('area_footer_global', 'area_intro_global', 'area_content_category_global');
            $content = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($content_keys);
            end($content['area_footer_global']['rows']);
            $last_footer_row = prev($content['area_footer_global']['rows']);
        } else
        if ($store_id == 5) {
            // minimal
            $content_keys = array('area_footer_global', 'area_intro_global', 'area_intro_home', 'area_content_category_global');
            $content = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($content_keys);
            end($content['area_footer_global']['rows']);
            $last_footer_row = prev($content['area_footer_global']['rows']);
        } else
        if ($store_id == 6) {
            // dark
            $content_keys = array(
                'area_footer_global', 'area_footer_global', 'area_content_layout_2',
                'area_content_category_global', 'area_content_system_product/search', 'area_content_system_category/manufacturer', 'area_content_system_product/manufacturer/info', 'area_content_system_product/special'
            );
            $content = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($content_keys);
            end($content['area_footer_global']['rows']);
            $last_footer_row = prev($content['area_footer_global']['rows']);
        }
        $content['area_footer_global'] = array(
            'rows' => array(
                0 => $last_footer_row
            )
        );

        foreach ($content_keys as $key) {
            $theme_settings['area_keys'][str_replace('area_', '', $key)] = 1;
        }

        if ($store_id != 0) {
            $store_name = TB_Utils::slugify($this->manager->getDbSettingsHelper()->getKey('config_name', $store_id, 'config'));
        } else {
            $store_name = 'default';
        }

        $file_path = $this->context->getConfigDir() . '/data/demo_' . $store_name . '/data_settings.php';
        $basedir = dirname($file_path);
        if (!is_dir($basedir)) {
            mkdir($basedir, 0777);
        }

        $exported = array(
            'settings'    => $theme_settings,
            'tb_settings' => $tb_settings,
            'content'     => $content
        );

        file_put_contents($file_path, base64_encode(serialize($exported)));

        return $this->sendJsonSuccess('The settings have been exported');
    }

    public function content()
    {
        $store_id = (int) $this->request->get['export_store_id'];
        $theme_settings = $this->manager->getSettingsModelInstance($store_id)->getScopeSettings('theme', true);
        if (empty($theme_settings)) {
            return $this->sendJsonError('There are no saved settings for the selected store');
        }

        $area_keys = array();
        foreach($theme_settings['area_keys'] as $area_key => $value) {
            foreach (array('content', 'footer', 'intro', 'column_left', 'column_right') as $area) {
                if (strpos($area_key, $area) === 0 && strpos($area_key, $area . '_default') !== 0) {
                    $area_keys[$area_key] = $value;
                    break;
                }
            }
        }

        $db_area_keys = array();
        foreach (array_keys($area_keys) as $key) {
            $db_area_keys[] = 'area_' . $key;
        }

        $language_id = $this->manager->getDefaultCatalogLanguage('id');
        $export_content = $this->manager->getBuilderSettingsModel()->loadScopeSettingsCollection($db_area_keys);
        foreach ($export_content as $are_key => $area_value) {

            foreach ($area_value['rows'] as $row_key => $row_value) {

                foreach ($row_value['columns'] as $column_key => $column_value) {
                    if (!isset($column_value['widgets'])) {
                        continue;
                    }

                    foreach ($column_value['widgets'] as $widget_key => $widget_value) {
                        if (isset($widget_value['settings']['lang'][$language_id])) {
                            $export_content[$are_key]['rows'][$row_key]['columns'][$column_key]['widgets'][$widget_key]['settings']['lang'] = array(
                                1 => $widget_value['settings']['lang'][$language_id]
                            );
                        }
                        if (isset($widget_value['settings']['common']['font'][$language_id])) {
                            $export_content[$are_key]['rows'][$row_key]['columns'][$column_key]['widgets'][$widget_key]['settings']['common']['fonts'] = array(
                                1 => $widget_value['settings']['common']['font'][$language_id]
                            );
                        }
                    }
                    if (isset($column_value['subwidgets'])) {
                        foreach ($column_value['subwidgets'] as $widget_key => $widget_value) {
                            if (isset($widget_value['settings']['lang'])) {
                                $export_content[$are_key]['rows'][$row_key]['columns'][$column_key]['widgets'][$widget_key]['settings']['lang'] = array(
                                    1 => $widget_value['settings']['lang'][$language_id]
                                );
                            }
                            if (isset($widget_value['settings']['common']['font'][$language_id])) {
                                $export_content[$are_key]['rows'][$row_key]['columns'][$column_key]['widgets'][$widget_key]['settings']['common']['fonts'] = array(
                                    1 => $widget_value['settings']['common']['font'][$language_id]
                                );
                            }
                        }
                    }
                }

                if (isset($row_value['settings']['font'][$language_id])) {
                    $export_content[$are_key]['rows'][$row_key]['settings']['font'] = array(
                        1 => $row_value['settings']['font'][$language_id]
                    );
                }
            }

            if (isset($export_content[$are_key]['settings']['font'][$language_id])) {
                $export_content[$are_key]['settings']['font'] = array(
                    1 => $export_content['settings']['font'][$language_id]
                );
            }
        }

        $exported = array(
            'content'   => $export_content,
            'sliders'   => $this->manager->getTbSettingsModelInstance('slider', 0)->getValues(),
            'area_keys' => $area_keys
        );

        if ($store_id != 0) {
            $store_name = TB_Utils::slugify($this->manager->getDbSettingsHelper()->getKey('config_name', $store_id, 'config'));
        } else {
            $store_name = 'default';
        }

        $file_path = $this->context->getConfigDir() . '/data/demo_' . $store_name . '/data_content.php';
        $basedir = dirname($file_path);
        if (!is_dir($basedir)) {
            mkdir($basedir, 0777);
        }

        file_put_contents($file_path, base64_encode(serialize($exported)));

        return $this->sendJsonSuccess('The settings have been exported');
    }

    public function defaults()
    {
        $theme_settings = $this->manager->getSettingsModelInstance()->getScopeSettings('theme', true);

        $language_id = $this->manager->getDefaultCatalogLanguage('id');

        $theme_settings['font'] = array(
            $language_id => $theme_settings['font'][$language_id]
        );

        $theme_settings['twitter'] = array(
            $language_id => $theme_settings['twitter'][$language_id]
        );

        $theme_settings['facebook'] = array(
            $language_id => $theme_settings['facebook'][$language_id]
        );

        $theme_settings['area_keys']['content_home'] = 1;

        $content_home = $this->manager->getBuilderSettingsModel()->getScopeSettings('area_content_home', true);

        $file_path = $this->context->getConfigDir() . '/data/install_data.php';

        file_put_contents($file_path, base64_encode(serialize(array(
            'theme_settings' => $theme_settings,
            'content'        => array(
                'area_content_home' => $content_home
            )
        ))));

        return $this->sendJsonSuccess('The settings have been exported');
    }

    public function colorsCss()
    {
        $styleBuilder = new TB_StyleBuilder($this->context, $this->getModel('fonts'));

        foreach ($this->extension->getSetting('colors') as $group) {
            foreach ($group as $color_rule) {
                $styleBuilder->addGlobalColorRule($color_rule);
            }
        }

        TB_ColorSchemer::getInstance()->setFilteredColors($this->themeData->colors, 'theme');

        $theme_settings = $this->manager->getSettingsModelInstance()->getScopeSettings('theme', true);

        $db_keys = array();

        foreach (array('area', 'area_settings') as $scope) {
            foreach (array_keys($theme_settings[$scope . '_keys']) as $key) {
                foreach (array('footer', 'content', 'intro', 'column_left', 'column_right') as $area_name) {
                    if (strpos($key, $area_name . '_default') === 0) {
                        $db_keys[$scope . '_' . $key] = 0;
                    } else {
                        $db_keys[$scope . '_' . $key] = $this->manager->getContext()->getStoreId();
                    }
                }
            }
        }

        $areas = array();
        $settings = array();
        foreach ($this->manager->getBuilderSettingsModel()->loadScopeSettingsStoreCollection($db_keys) as $key => $data) {

            $area_name = '';
            $type = strpos($key, 'area_settings') === 0 ? 'area_settings' : 'area';
            foreach (array('footer', 'content', 'intro', 'column_left', 'column_right') as $area_name) {
                if (strpos($key, $type . '_' . $area_name) === 0) {
                    break;
                }
            }

            $data['area_name'] = $area_name;

            if ((0 === strpos($key, 'area_settings_'))) {
                $settings[$key] = $data;
            } else {
                $areas[$key] = $data;
            }
        }

        foreach ($settings as $area_settings) {
            $area_name = $area_settings['area_name'];
            $area_default_colors = $this->getModel('layoutBuilder')->getAreaDefaultColors('area_' . $area_name);

            if (isset($area_settings['colors'])) {
                TB_ColorSchemer::getInstance()->filterAreaColors($area_settings['colors'], $area_default_colors, 'area_' . $area_name);
                $this->getModel('layoutBuilder')->cleanSettingsColorsBeforePersist($area_settings['colors']);
            }

            $area_css_id = strtolower(str_replace(' ', '_', $area_name));

            $this->addStyleColors($area_settings, $area_css_id, $styleBuilder, true);

            //$styleBuilder->buildEffectsCss($area_settings, '#' . $area_css_id);
        }

        foreach ($areas as $area) {
            $area_name = $area['area_name'];

            foreach ($area['rows'] as $row) {
                //$styleBuilder->buildEffectsCss($row['settings'], '#' . 'row_' . $row['id']);

                if (isset($row['settings']['colors'])) {
                    TB_ColorSchemer::getInstance()->filterRowColors($row['settings']['colors'], $this->getModel('layoutBuilder')->getRowDefaultColors(), true);
                    $this->getModel('layoutBuilder')->cleanSettingsColorsBeforePersist($row['settings']['colors']);
                }
                $this->addStyleColors($row['settings'], 'row_' . $row['id'], $styleBuilder);

                /** @var TB_Widget[] $widgets */
                $widgets = array();
                foreach ($row['columns'] as $column) {
                    if (isset($column['widgets'])) {
                        foreach ($column['widgets'] as $key => $value) {
                            $widget = $this->manager->getWidgetManager()->createAndFilterWidgetFromId($value['id'], $value['settings']);
                            if ($widget->isActive()) {
                                $widgets[] = $widget;
                                if ($widget instanceof Theme_GroupWidget && isset($value['subwidgets'])) {
                                    foreach ($value['subwidgets'] as $vvalue) {
                                        $subWidget = $this->manager->getWidgetManager()->createAndFilterWidgetFromId($vvalue['id'], $vvalue['settings']);
                                        if ($subWidget->isActive()) {
                                            $subWidget->setParent($widget);
                                            $widgets[] = $subWidget;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                foreach ($widgets as $widget) {
                    $settings = $widget->getSettings('common');
                    if (empty($settings)) {
                        continue;
                    }

                    if (isset($settings['colors'])) {
                        TB_ColorSchemer::getInstance()->filterWidgetColors($settings['colors'], $widget->getDefaultColors());
                        $this->getModel('layoutBuilder')->cleanSettingsColorsBeforePersist($settings['colors']);
                        $widget->setSettings($settings, 'common');
                    }

                    //$styleBuilder->buildEffectsCss($settings, '#' . $widget->getDomId());

                    $this->addStyleColors($settings, $widget->getDomId(), $styleBuilder);
                }
            }
        }

        $css = $styleBuilder->getGlobalColorsString() . "\n" . $styleBuilder->getScopedColorsString();

        if ($this->manager->getThemeConfig('catalog_minify_js') && !$this->context->isDebug()) {
            $css = JShrink_Minifier::minify($css);
        }

        $css .= $styleBuilder->getCssString();

        file_put_contents($this->context->getImageDir() . '/cache/tb/merged_color_styles.css', $css);
    }

    protected function addStyleColors(array $settings, $id, TB_StyleBuilder $styleBuilder)
    {
        if (!isset($settings['colors']) || !is_array($settings['colors'])) {
            return;
        }

        $bg_color = isset($settings['background']['solid_color']) ? $settings['background']['solid_color'] : null;

        foreach ($settings['colors'] as $group_values) {
            foreach ($group_values as $color_rule) {
                if (is_array($color_rule)) {
                    $styleBuilder->addScopedColorRule($id, $color_rule, $bg_color);
                }
            }
        }
    }
}