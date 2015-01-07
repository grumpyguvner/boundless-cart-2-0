<?php

class Theme_Admin_LayoutBuilderController extends TB_AdminController
{
    /**
     * @var TB_WidgetManager
     */
    protected $widgetManager;

    protected $section_map = array(
        'intro' => array(
            'ajax'     => true,
            'group'    => 'builder_section',
            'template' => 'theme_builder_area'
        ),
        'content' => array(
            'ajax'     => true,
            'group'    => 'builder_section',
            'template' => 'theme_builder_area'
        ),
        'footer' => array(
            'ajax'     => true,
            'group'    => 'builder_section',
            'template' => 'theme_builder_area'
        ),
        'column_left' => array(
            'ajax'     => true,
            'group'    => 'builder_section',
            'template' => 'theme_builder_area'
        ),
        'column_right' => array(
            'ajax'     => true,
            'group'    => 'builder_section',
            'template' => 'theme_builder_area'
        )
    );

    public function init()
    {
        $this->widgetManager = $this->manager->getWidgetManager();
    }

    public function index()
    {
        $area_name = 'content';
        $tabsVal = TB_Utils::getTbAppValue('tbLayoutBuilderTabs');
        if (isset($tabsVal['area_name']) && $this->isAreaValid($tabsVal['area_name'])) {
            $area_name = $tabsVal['area_name'];
        }

        if ($area_name == 'content') {
            $area_type = 'home';
            $area_id   = 'home';
        } else {
            $area_type = 'global';
            $area_id   = 'global';
        }

        $this->section_map[$area_name]['ajax'] = false;

        $this->data['widgets']             = $this->widgetManager->getWidgetsByArea($area_name);
        $this->data['system_widgets_html'] = $this->getSystemWidgetsHtml($area_name, 'global', 'global');
        $this->data['area_name']           = $area_name;
        $this->data['area_type']           = $area_type;
        $this->data['area_id']             = $area_id;

        $this->renderTemplate('theme_builder');
    }

    protected function renderBuilderSectionGroup($section)
    {
        $args = $this->getAreaArgs();

        if (null === $args) {
            if ($section == 'content') {
                $this->populateAreaBuilderData($section, 'home', 'home');
            } else {
                $this->populateAreaBuilderData($section, 'global', 'global');
            }
        } else {
            $this->populateAreaBuilderData($args[0], $args[1], $args[2]);
        }
    }

    public function areaBuilder()
    {
        $args = $this->getAreaArgs();
        if (null === $args) {
            $this->sendJsonError('Arguments error');
        } else {
            list ($area_name, $area_type, $area_id) = $args;
            $this->populateAreaBuilderData($area_name, $area_type, $area_id);

            $this->renderTemplate('theme_builder_area');
        }
    }

    protected function populateAreaBuilderData($area_name, $area_type, $area_id)
    {
        $this->data['area_name'] = $area_name;
        $this->data['area_type'] = $area_type;
        $this->data['area_id']   = $area_id;
        $this->data['can_add_rows'] = $this->user->hasPermission('modify', 'module/' . $this->context->getBasename());

        $slot_prefix = false;
        $inherit_msg = '';
        $override_msg = '';

        $area_key = strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id;
        $area = $this->widgetManager->getAreaSettings($area_name . '_' . $area_key, 'area');
        $inherit_key = '';
        $can_delete = !empty($area);

        if (empty($area) && !($area_name == 'content' && $area_key == 'home')) {
            try {
                $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, $area_type, $area_id, 'rows');
            } catch (Exception $e) {
                $this->sendJsonError($e->getMessage());
                return;
            }

            list($slot_prefix, $area_key) = $params;
            if (false !== $area_key) {
                $area = $this->widgetManager->getAreaSettings($area_name . '_' . $area_key, 'area');
                $inherit_msg = $this->getModel('layoutBuilder')->buildInheritInformationMessage($area_key);
                $inherit_key = $area_key;
            } else {
                $inherit_msg = true;
            }
        } else {
            if (empty($area) && $area_name == 'content' && $area_key == 'home') {
                $inherit_msg = true;
            } else {
                $override_msg = $this->getModel('layoutBuilder')->buildOverrideInformationMessage($area_name, $area_type, $area_id, 'rows');
            }
        }

        if ($this->context->isDebug()) {
            fb('area_type: ' . $area_type . ' | area_key:  ' . $area_key . ' | area_name: ' . $area_name . ' | area_id:    ' . $area_id . ' | slot_prefix: ' . $slot_prefix);
        }

        if (!empty($area)) {
            foreach($area['rows'] as &$row) {
                foreach ($row['columns'] as &$column) {
                    if (isset($column['widgets'])) {
                        foreach ($column['widgets'] as $key => $value) {
                            $widget = $this->widgetManager->createWidgetFromId($value['id'], $value['settings']);

                            if (false !== $slot_prefix && $widget instanceof Theme_SystemWidget) {
                                $widget->setSlotPrefix($slot_prefix);
                            }

                            if ($widget instanceof Theme_GroupWidget && isset($value['subwidgets'])) {
                                foreach ($value['subwidgets'] as $subwidget) {
                                    $instance = $this->widgetManager->createWidgetFromId($subwidget['id'], $subwidget['settings']);
                                    $widget->addSubWidget($instance);
                                }
                            }

                            $column['widgets'][$key] = $widget;
                        }
                    }
                }
            }
        }

        $area_settings = isset($area['settings']) ? $area['settings'] : array();
        $this->getModel('layoutBuilder')->filterAreaSettings($area_settings, 'area_' . $area_name);

        $rows_html = '';
        if (isset($area['rows']) && !empty($area['rows'])) {
            $i = 0;
            foreach ($area['rows'] as &$row) {

                $this->getModel('layoutBuilder')->filterRowSettings($row['settings']);

                $data = array(
                    'row'                  => $row,
                    'key'                  => ++$i,
                    'row_settings_encoded' => base64_encode(gzcompress(serialize($row['settings']), 9))
                );
                $rows_html .= $this->fetchTemplate('theme_builder_row', array_merge($this->data, $data));
            }
        }

        $this->data['area_settings_encoded'] = base64_encode(serialize($area_settings));
        $this->data['area_empty']            = empty($area);
        $this->data['can_delete']            = $can_delete && !empty($area);
        $this->data['rows_html']             = $rows_html;
        $this->data['inherit_msg']           = $inherit_msg;
        $this->data['inherit_key']           = $inherit_key;
        $this->data['override_msg']          = $override_msg;
        $this->data['layouts']               = $this->getModel('layoutBuilder')->getLayoutsExcludingRoute(array('common/home', 'product/category'));
        $this->data['store_has_categories']  = $this->getModel('category')->storeHasCategories();
        $this->data['pages']                 = $this->getModel('default')->getInformationPages();
        $this->data['category_levels']       = $this->getModel('layoutBuilder')->getCategoryLevels();
        $this->data['modified']              = $this->getModel('layoutBuilder')->buildModifiedMenu($area_name, (array) $this->getModel()->getSetting('area_keys'));
    }

    public function modifiedMenu()
    {
        $area_name = null;
        if (isset($this->request->get['area_name'])) {
            $name = (string) $this->request->get['area_name'];
            if ($this->isAreaValid($name)) {
                $area_name = $name;
            }
        }

        $record_type = (string) $this->request->get['record_type'];

        if (null == $area_name || !in_array($record_type, array('rows', 'settings'))) {
            return $this->sendJsonError('Not existing area');
        }

        if ($record_type == 'settings') {
            $db_key = 'area_settings';
        } else {
            $db_key = 'area';
        }

        $settings_keys = (array) $this->getModel()->getSetting($db_key . '_keys');

        $this->data['modified'] = $this->getModel('layoutBuilder')->buildModifiedMenu($area_name, $settings_keys);

        $this->renderTemplate('theme_builder_modified');
    }

    public function removeSettings()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('Not a valid action');
        }

        $args = $this->getAreaArgs();
        $record_type = (string) $this->request->get['record_type'];

        if (null === $args || !in_array($record_type, array('rows', 'settings'))) {
            return $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;
        $area_key = strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id;

        $current_area_id   = (string) $this->request->get['current_area_id'];
        $current_area_type = (string) $this->request->get['current_area_type'];

        $current_area_key = '';
        if (!empty($current_area_type)) {
            // Can be empty on the initial tab load, when the combobox has not been changed and there is no currentItem
            $current_area_key = strpos($current_area_id, $current_area_type) !== 0 ? $current_area_type . '_' . $current_area_id : $current_area_id;
        }

        $reload = 0;
        if (!empty($current_area_key) && $area_key != $current_area_key) {
            try {
                // Check current inherit key before removal
                $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, $current_area_type, $current_area_id, $record_type);
                list(, $current_area_key) = $params;
            } catch (Exception $e) {
                return $this->sendJsonError($e->getMessage());
            }

            $this->widgetManager->removeWidgetArea($area_name . '_' . $area_key, $record_type);

            try {
                // Check current inherit key after removal
                $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, $current_area_type, $current_area_id, $record_type);
                list(, $new_area_key) = $params;
            } catch (Exception $e) {
                return $this->sendJsonError($e->getMessage());
            }

            $reload = $current_area_key != $new_area_key;
        } else {
            $this->widgetManager->removeWidgetArea($area_name . '_' . $area_key, $record_type);
        }

        $this->manager->wipeAllCache('*' . $area_name . '_' . str_replace('/', '_', $area_key) . '*');

        return $this->sendJsonSuccess('Settings removed for key ' . $area_key, array('reload' => $reload ? 1 : 0));
    }

    public function systemBlocks()
    {
        $args = $this->getAreaArgs();
        if (null === $args) {
            $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;

        $this->setOutput($this->getSystemWidgetsHtml($area_name, $area_type, $area_id));
    }

    protected function getSystemWidgetsHtml($area_name, $area_type, $area_id)
    {
        $widgets_config = $this->getModel('layoutBuilder')->getAreaSystemSettings($area_name, $area_type, $area_id);
        if (!empty($widgets_config)) {
            $widgets = $this->widgetManager->createSystemWidgets($widgets_config);
            $widgets_html = $this->fetchTemplate('theme_builder_system_widgets', array('widgets' => $widgets));
        } else {
            $widgets_html = '<p>There are no system blocks for the current area.</p>';
        }

        return $widgets_html;
    }

    public function copyArea()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('Not a valid action');
        }

        $args = $this->getAreaArgs();
        if (null === $args || !isset($this->request->get['new_store_id'])) {
            $this->sendJsonError('Arguments error');
            return;
        }

        list ($area_name, $area_type, $area_id) = $args;

        $area_key = $area_name . '_' . (strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id);
        $area = $this->widgetManager->getAreaSettings($area_key, 'area');

        if (empty($area)) {
            $this->sendJsonError('Area not found');
            return;
        }

        $store_id = (int) $this->request->get['new_store_id'];
        $this->manager->getBuilderSettingsModel()->setAndPersistScopeSettings('area_' . $area_key, $area, $store_id);

        $settingsModel = $this->manager->getSettingsModelInstance($store_id);
        $theme_settings = $settingsModel->getScopeSettings('theme', true);
        $theme_settings['area_keys'][$area_key] = 1;
        $settingsModel->setAndPersistScopeSettings('theme', $theme_settings);

        $this->sendJsonSuccess('The area has been copied');
    }

    public function getNewWidgetRow()
    {
        $args = $this->getAreaArgs();
        if (null === $args) {
            return $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;

        $area_settings = $this->getAreaSettings($area_name, $area_type, $area_id);

        $settings = array();
        $area_name = (string) $this->request->get['area_name'];

        $theme_colors = json_decode(html_entity_decode((string) $this->request->post['theme_colors'], ENT_COMPAT, 'UTF-8'), true);

        $this->getModel('layoutBuilder')->filterRowSettings($settings, 'area_' . $area_name, $area_settings, $theme_colors);

        $row = array(
            'id'             => TB_Utils::genRandomString(),
            'columns_number' => '1',
            'settings'       => $settings
        );

        $this->data['key']       = 0;
        $this->data['area_name'] = $area_name;
        $this->data['area_type'] = $area_type;
        $this->data['area_id']   = $area_id;
        $this->data['row']       = $row;
        $this->data['row_settings_encoded'] = base64_encode(gzcompress(serialize($row['settings']), 9));

        $this->renderTemplate('theme_builder_row');
    }

    public function saveRows()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('Not a valid action');
        }

        $area_name = (string) $this->request->post['area_name'];
        if (!$this->isAreaValid($area_name)) {
            return $this->sendJsonError('Not a valid area');
        }

        $area_type = "page";
        if (isset($this->request->post['area_type'])) {
            $type = (string) $this->request->post['area_type'];
            if (in_array($type, array('global', 'home', 'page', 'category', 'layout', 'system'))) {
                $area_type = $type;
            }
        }

        $area_id = 0;
        if (isset($this->request->post['area_id'])) {
            $area_id = (string) $this->request->post['area_id'];
        }

        $rows = array();
        if (isset($this->request->post['rows']) && !empty($this->request->post['rows'])) {
            $rows = (array) $this->request->post['rows'];
        }

        $settings = '';
        if (isset($this->request->post['settings']) && !empty($this->request->post['settings'])) {
            $settings = unserialize(base64_decode((string) $this->request->post['settings']));
        }

        $area_key = $area_name . '_' . (strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id);

        //$theme_settings = $this->getModel()->getSettings();unset($theme_settings['area_keys']['area_footer']);$this->getModel()->setAndPersistSettings($theme_settings);
        $wipe_cache_widget_ids = array();
        foreach ($rows as &$row) {
            $row['settings'] = unserialize(gzuncompress(base64_decode($row['settings'])));

            if (!isset($row['columns']) || empty($row['columns'])) {
                continue;
            }

            foreach ($row['columns'] as &$column) {
                if (!isset($column['widgets']) || empty($column['widgets'])) {
                    continue;
                }

                foreach ($column['widgets'] as &$widget) {
                    if ($widget['is_dirty']) {
                        $wipe_cache_widget_ids[] = $widget['id'];
                    }
                    unset($widget['is_dirty']);
                    $widget['settings'] = unserialize(gzuncompress(base64_decode($widget['settings'])));
                    if (!isset($widget['subwidgets']) || empty($widget['subwidgets'])) {
                        continue;
                    }

                    foreach ($widget['subwidgets'] as &$subwidget) {
                        if ($subwidget['is_dirty']) {
                            $wipe_cache_widget_ids[] = $subwidget['id'];
                        }
                        unset($subwidget['is_dirty']);
                        $subwidget['settings'] = unserialize(gzuncompress(base64_decode($subwidget['settings'])));
                    }
                }
            }
        }

        if (!empty($wipe_cache_widget_ids)) {
            $this->manager->wipeVarsCache('*' . '{' . implode(',', $wipe_cache_widget_ids) . '}*', true);
        }

        $this->widgetManager->persistWidgets(array('rows' => $rows, 'settings' => $settings), $area_key, $area_name);
        $this->manager->wipeAllCache('*' . str_replace('/', '_', $area_key) . '*');

        $data = array(
            'override_msg' => $this->getModel('layoutBuilder')->buildOverrideInformationMessage($area_name, $area_type, $area_id, 'rows')
        );

        if ($url = $this->getLivePreviewUrl()) {
            $data['livePreviewUrl'] = $url;
        }

        return $this->sendJsonSuccess('The data has been saved', $data);
    }

    public function createRowSettingsForm()
    {
        if (!isset($this->request->post['settings']) || !isset($this->request->get['row_id'])) {
            return $this->sendJsonError('Cannot create settings form. Missing parameters.');
        }

        $settings = unserialize(gzuncompress(base64_decode((string) $this->request->post['settings'])));
        if (!is_array($settings)) {
            return $this->sendJsonError('Cannot create settings form. Invalid settings data.');
        }

        $args = $this->getAreaArgs();
        if (null === $args) {
            return $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;

        $area_settings   = $this->getAreaSettings($area_name, $area_type, $area_id);
        $theme_colors = json_decode((string) html_entity_decode($this->request->post['theme_colors'], ENT_COMPAT, 'UTF-8'), true);

        $this->getModel('layoutBuilder')->filterRowSettings($settings, 'area_' . $area_name, $area_settings, $theme_colors['colors']);

        if (isset($settings['background']['rows']) && !empty($settings['background']['rows'])) {
            foreach ($settings['background']['rows'] as &$bg_row) {
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

        $this->data['row'] = $settings;
        $this->data['section'] = 'widgets_row';

        $this->renderTemplate('theme_builder_options');
    }

    protected function getAreaSettings($area_name, $area_type, $area_id)
    {
        if (!empty($this->request->post['area_settings'])) {
            $area_settings = json_decode(html_entity_decode((string) $this->request->post['area_settings'], ENT_COMPAT, 'UTF-8'), true);
            $area_settings = $area_settings['area'][$area_name];
        } else {
            $area_key = strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id;
            $area_settings = $this->widgetManager->getAreaSettings($area_name . '_' . $area_key, 'settings');

            if (empty($area_settings)) {
                try {
                    $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, $area_type, $area_id, 'settings');
                } catch (Exception $e) {
                    return $this->sendJsonError($e->getMessage());
                }

                list(, $area_key) = $params;
                $area_settings = $this->widgetManager->getAreaSettings($area_name . '_' . $area_key, 'settings');
            }

            if (empty($area_settings)) {
                $area_settings = array();
            }
        }

        return $area_settings;
    }

    public function convertRowFormDataToSettings()
    {
        $section = (string) $this->request->get['section'];
        $settings = (array) $this->request->post[$section];

        $theme_colors = array();
        if (isset($this->request->post['theme_colors'])) {
            $theme_colors = json_decode(html_entity_decode($this->request->post['theme_colors'], ENT_COMPAT, 'UTF-8'), true);
        }

        $args = $this->getAreaArgs();

        if (null === $args) {
            return $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;
        $area_settings   = $this->getAreaSettings($area_name, $area_type, $area_id);

        $this->getModel('layoutBuilder')->filterRowSettings($settings, 'area_' . $area_name, $area_settings, $theme_colors['colors']);

        $this->setOutput(base64_encode(gzcompress(serialize($settings))));
    }

    protected function getAreaArgs()
    {
        $area_name = null;
        if (isset($this->request->request['area_name'])) {
            $name = (string) $this->request->request['area_name'];
            if ($this->isAreaValid($name)) {
                $area_name = $name;
            }
        }

        $area_type = null;
        if (isset($this->request->request['area_type'])) {
            $type = (string) $this->request->request['area_type'];
            if (in_array($type, array('global', 'home', 'page', 'category', 'layout', 'system'))) {
                $area_type = $type;
            }
        }

        $area_id = null;
        if (isset($this->request->request['area_id'])) {
            $area_id = (string) $this->request->request['area_id'];
        }

        if ($area_name == null || $area_type == null || $area_id == null) {
            return null;
        }

        return array($area_name, $area_type, $area_id);
    }

    protected function isAreaValid($area_name)
    {
        return in_array((string) $area_name, array('header', 'menu', 'footer', 'content', 'intro', 'column_left', 'column_right'));
    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', 'module/' . $this->context->getBasename())) {
            $this->error['warning'] = $this->extension->translate('error_permission');
        }

        return empty($this->error);
    }
}