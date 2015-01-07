<?php

class Theme_Admin_WidgetController extends TB_AdminController
{
    public function createForm()
    {
        if (!isset($this->request->post['settings']) || !isset($this->request->get['class_name'])) {
            return $this->sendJsonError('Invalid arguments. Cannot create widget');
        }

        $widget_settings = unserialize(gzuncompress(base64_decode((string) $this->request->post['settings'])));
        if (!is_array($widget_settings)) {
            return $this->sendJsonError('Cannot create settings form. Invalid settings data.');
        }

        $args = $this->getAreaArgs();
        if (null === $args) {
            return $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;

        $class_name      = (string) $this->request->get['class_name'];
        $area_settings   = $this->getAreaSettings($area_name, $area_type, $area_id);
        $row_settings    = unserialize(gzuncompress(base64_decode((string) $this->request->post['row_settings'])));
        $theme_colors    = json_decode(html_entity_decode((string) $this->request->post['theme_colors'], ENT_COMPAT, 'UTF-8'), true);

        $this->getModel('layoutBuilder')->filterRowSettings($row_settings, 'area_' . $area_name, $area_settings, $theme_colors['colors']);

        $widgetManager = $this->manager->getWidgetManager();
        $widget = $widgetManager->createFilterAndEditWidget($class_name, $widget_settings);

        $this->data['widget'] = $widget;
        $this->data['settings'] = $widget->getSettings();

        $this->renderTemplate('widget/' . $widget->getTemplateName());
    }

    public function convertFormDataToSettings()
    {
        if (!isset($this->request->post['widget_data']) || !isset($this->request->get['class_name'])) {
            return $this->sendJsonError('Invalid arguments. Cannot create widget');
        }

        $args = $this->getAreaArgs();
        if (null === $args) {
            return $this->sendJsonError('Invalid arguments');
        }

        list ($area_name, $area_type, $area_id) = $args;

        $class_name      = (string) $this->request->get['class_name'];
        $widget_settings = (array) $this->request->post['widget_data'];
        $area_settings   = $this->getAreaSettings($area_name, $area_type, $area_id);
        $row_settings    = unserialize(gzuncompress(base64_decode((string) $this->request->post['row_settings'])));
        $theme_colors    = json_decode(html_entity_decode((string) $this->request->post['theme_colors'], ENT_COMPAT, 'UTF-8'), true);

        $this->getModel('layoutBuilder')->filterRowSettings($row_settings, 'area_' . $area_name, $area_settings, $theme_colors['colors']);

        $widgetManager = $this->manager->getWidgetManager();
        $widget = $widgetManager->createTransformAndFilterWidget($class_name, $widget_settings);

        $result = array(
            'title' => $widget->getPresentationTitle(),
            'data'  => $widget->getSettingsEncoded()
        );

        $this->setOutput(json_encode($result));
    }

    protected function getAreaSettings($area_name, $area_type, $area_id)
    {
        if (!empty($this->request->post['area_settings'])) {
            $area_settings = json_decode(html_entity_decode((string) $this->request->post['area_settings'], ENT_COMPAT, 'UTF-8'), true);
            $area_settings = $area_settings['area'][$area_name];
        } else {
            $area_key = strpos($area_id, $area_type) !== 0 ? $area_type . '_' . $area_id : $area_id;
            $area_settings = $this->manager->getWidgetManager()->getAreaSettings($area_name . '_' . $area_key, 'settings');

            if (empty($area_settings)) {
                try {
                    $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, $area_type, $area_id, 'settings');
                } catch (Exception $e) {
                    return $this->sendJsonError($e->getMessage());
                }

                list(, $area_key) = $params;
                $area_settings = $this->manager->getWidgetManager()->getAreaSettings($area_name . '_' . $area_key, 'settings');
            }

            if (empty($area_settings)) {
                $area_settings = array();
            }
        }

        return $area_settings;
    }

    protected function getAreaArgs()
    {
        $area_name = null;
        if (isset($this->request->request['area_name'])) {
            $name = (string) $this->request->request['area_name'];
            if (in_array((string) $name, array('footer', 'content', 'intro', 'column_left', 'column_right'))) {
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
}