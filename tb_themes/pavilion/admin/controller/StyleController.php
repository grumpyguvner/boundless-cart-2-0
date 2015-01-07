<?php

class Theme_Admin_StyleController extends TB_AdminController
{
    protected $section_map = array(
        'index' => array(
            'ajax'     => false,
            'template' => 'theme_style'
        ),
        'common' => array(
            'ajax'     => false,
            'template' => 'theme_style_common'
        ),
        'wrapper' => array(
            'ajax'     => true,
            'group'    => 'style_section',
            'template' => 'theme_style_section'
        ),
        'header' => array(
            'ajax'     => true,
            'group'    => 'style_section',
            'template' => 'theme_style_section'
        ),
        'menu' => array(
            'ajax'     => true,
            'group'    => 'style_section',
            'template' => 'theme_style_section'
        ),
        'intro' => array(
            'ajax'     => true,
            'group'    => 'area',
            'template' => 'theme_style_area'
        ),
        'content' => array(
            'ajax'     => true,
            'group'    => 'area',
            'template' => 'theme_style_area'
        ),
        'footer' => array(
            'ajax'     => true,
            'group'    => 'area',
            'template' => 'theme_style_area'
        ),
        'bottom' => array(
            'ajax'     => true,
            'group'    => 'style_section',
            'template' => 'theme_style_section'
        )
    );

    protected function renderStyleSectionGroup($section)
    {
        $style_settings = $this->themeData['theme_settings']['style'];

        $this->data['settings']  = $style_settings[$section];
        $this->data['menu_name'] = ucfirst($section) . ' Styles';
    }

    protected function renderAreaGroup($area_name)
    {
        $area_type = 'global';
        if (isset($this->request->get['area_type'])) {
            $type = (string) $this->request->get['area_type'];
            if (in_array($type, array('global', 'home', 'page', 'category', 'layout', 'system'))) {
                $area_type = $type;
            }
        }

        if (isset($this->request->get['area_id'])) {
            $area_id = (string) $this->request->get['area_id'];
        } else {
            $area_id = $area_type;
        }

        $area_key = strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id;
        $area_settings = $this->manager->getWidgetManager()->getAreaSettings($area_name . '_' . $area_key, 'settings');

        $inherit_msg = '';
        $display_override_msg = false;

        if (empty($area_settings)) {
            try {
                $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, $area_type, $area_id, 'settings');
            } catch (Exception $e) {
                $this->sendJsonError($e->getMessage());
                return;
            }

            list(, $settings_key) = $params;
            $area_settings = $this->manager->getWidgetManager()->getAreaSettings($area_name . '_' . $settings_key, 'settings');
            $inherit_msg = $this->getModel('layoutBuilder')->buildInheritInformationMessage($settings_key);
        } else {
            $display_override_msg = true;
        }

        $override_msg = $this->getModel('layoutBuilder')->buildOverrideInformationMessage($area_name, $area_type, $area_id, 'settings');

        if (empty($area_settings)) {
            $area_settings = array();
        }

        $this->getModel('layoutBuilder')->filterAreaSettings($area_settings, 'area_' . $area_name);

        if (isset($area_settings['background']['rows']) && !empty($area_settings['background']['rows'])) {
            foreach ($area_settings['background']['rows'] as &$bg_row) {
                if ($bg_row['background_type'] == 'image') {
                    if (!empty($bg_row['image'])  && file_exists(DIR_IMAGE . $bg_row['image'])) {
                        $bg_row['preview'] = $this->getOcModel('tool/image')->resize($bg_row['image'], 100, 100);
                    } else {
                        $bg_row['image'] = '';
                        $bg_row['preview'] = $this->getModel()->getNoImage();
                    }
                }
            }
        }

        $this->data['pages']        = $this->getModel('default')->getInformationPages();
        $this->data['layouts']      = $this->getModel('layoutBuilder')->getLayoutsExcludingRoute(array('common/home', 'product_category'));
        $this->data['modified']     = $this->getModel('layoutBuilder')->buildModifiedMenu($area_name, (array) $this->getModel()->getSetting('area_settings_keys'));
        $this->data['area_name']    = $area_name;
        $this->data['area_type']    = $area_type;
        $this->data['area_id']      = $area_id;
        $this->data['area_key']     = $area_key;
        $this->data['menu_name']    = ucfirst($area_name) . ' Styles';
        $this->data['settings']     = $area_settings;
        $this->data['inherit_msg']  = $inherit_msg;
        $this->data['override_msg'] = $override_msg;

        $this->data['display_override_msg'] = $display_override_msg;
        $this->data['category_levels']      = $this->getModel('layoutBuilder')->getCategoryLevels();
        $this->data['store_has_categories'] = $this->getModel('category')->storeHasCategories();
    }
}