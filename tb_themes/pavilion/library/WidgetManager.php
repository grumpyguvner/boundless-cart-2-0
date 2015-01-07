<?php

class TB_WidgetManager
{
    /**
     * @var TB_ThemeManager
     */
    protected $manager;
    protected $area_settings = array();
    protected $areas = array('header', 'menu', 'content', 'footer', 'intro', 'column_left', 'column_right');

    public function __construct(TB_ThemeManager $manager)
    {
        $this->manager = $manager;
    }

    /**
     * @param string $name
     * @throws Exception
     * @return TB_Widget[]
     */
    public function getWidgetsByArea($name)
    {
        $result = array();
        $files = sfFinder::type('file')
            ->not_name('/^Abstract.*$/')
            ->name('/^[a-zA-Z]+Widget.php$/')
            ->sort_by_name()
            ->in($this->manager->getContext()->getWidgetsDir());

        foreach ($files as $filename) {
            $widget = $this->createWidgetInstance('Theme_' . basename(basename($filename), '.php'));
            $settings = array();
            $this->filterWidgetInstance($widget, $settings);
            $this->initWidgetInstance($widget, $settings);

            if ($widget->hasArea($name)) {
                $result[] = $widget;
            }
        }

        return array_merge($result, $this->caveOpenCartWidgets());
    }

    public function getAvailableWidgetNames()
    {
        $result_start = array();
        $result_end = array();

        $files = sfFinder::type('file')
            ->not_name('/^Abstract.*$/')
            ->name('/^[a-zA-Z]+Widget.php$/')
            ->sort_by_name()
            ->in($this->manager->getContext()->getWidgetsDir());

        foreach ($files as $filename) {
            $class = 'Theme_' . basename(basename($filename), '.php');

            $name = TB_Utils::underscore(str_replace('Widget', '', substr($class, strrpos($class, '_') + 1)));
            $name = explode('_', $name);
            $name = implode(' ', array_map('ucfirst', $name));

            if (TB_Utils::strEndsWith($class, 'SystemWidget')) {
                $result_end[$class] = $name;
            } else {
                $result_start[$class] = $name;
            }
        }

        return $result_start + $result_end;
    }

    public function loadWidgetClasses()
    {
        if (defined('TB_CLASS_CACHE')) {
            return;
        }

        $abstract = sfFinder::type('file')
            ->name('/^Abstract[a-zA-Z]+Widget.php$/')
            ->in($this->manager->getContext()->getWidgetsDir());

        foreach ($abstract as $filename) {
            require_once tb_modification($filename);
        }

        $files = sfFinder::type('file')
            ->not_name('/^Abstract.*$/')
            ->name('/^[a-zA-Z]+Widget.php$/')
            ->in($this->manager->getContext()->getWidgetsDir());

        foreach ($files as $filename) {
            require_once tb_modification($filename);
        }
    }

    public function loadAreasData(array $area_keys, array $area_settings_keys = array())
    {
        $db_keys = array();

        foreach (array('area', 'area_settings') as $scope) {
            foreach (${$scope . '_keys'} as $key) {
                foreach ($this->areas as $area) {
                    if (strpos($key, $area) === 0) {
                        if (strpos($key, $area . '_default') === 0) {
                            $db_keys[$scope . '_' . $key] = 0;
                        } else {
                            $db_keys[$scope . '_' . $key] = $this->manager->getContext()->getStoreId();
                        }
                    }
                }
            }
        }

        $result = array(
            'area'          => array(),
            'area_settings' => array()
        );

        if (empty($db_keys)) {
            return $result;
        }

        $keys = array_keys($this->manager->getBuilderSettingsModel()->loadScopeSettingsStoreCollection($db_keys));

        foreach ($keys as $k) {
            $scope = (0 === strpos($k, 'area_settings_')) ? 'area_settings' : 'area';
            $value = str_replace($scope . '_', '', $k);
            foreach ($this->areas as $area) {
                if (strpos($value, $area) === 0) {
                    $result[$scope][$area] = substr($value, strlen($area) + 1);
                }
            }
        }

        return $result;
    }

    public function getAreaSettings($area_key, $type, $store_id = null, $raw = false)
    {
        if (null === $store_id) {
            $store_id = $this->manager->getContext()->getStoreId();
        }

        if ($type == 'settings') {
            $db_key = 'area_settings';
        } else {
            $db_key = 'area';
        }

        foreach ($this->areas as $area) {
            if (strpos($area_key, $area . '_default') === 0) {
                $store_id = 0;
            }
        }

        return $this->manager->getBuilderSettingsModel()->getScopeSettings($db_key . '_' . $area_key, $raw, $store_id);
    }

    public function areaExists($area_key, $type, $store_id = null)
    {
        if (null === $store_id) {
            $store_id = $this->manager->getContext()->getStoreId();
        }

        if ($type == 'settings') {
            $db_key = 'area_settings';
        } else {
            $db_key = 'area';
        }

        $theme_settings = $this->manager->getSettingsModelInstance($store_id)->getScopeSettings('theme');

        if (!isset($theme_settings[$db_key . '_keys'])) {
            return false;
        }

        $area_keys = $theme_settings[$db_key . '_keys'];

        return null !== $area_keys && isset($area_keys[$area_key]);
    }


    public function removeWidgetArea($area_key, $type)
    {
        if ($type == 'settings') {
            $db_key = 'area_settings';
        } else {
            $db_key = 'area';
        }

        $theme_settings = $this->manager->getThemeModel()->getSettings();
        if (isset($theme_settings[$db_key . '_keys']) && isset($theme_settings[$db_key . '_keys'][$area_key])) {
            unset($theme_settings[$db_key . '_keys'][$area_key]);
            $this->manager->getThemeModel()->setAndPersistSettings($theme_settings);
        }



        $this->manager->getBuilderSettingsModel()->deleteScopeSettings($db_key . '_' . $area_key);
    }

    public function caveOpenCartWidgets()
    {
        static $widgets = null;

        if (null !== $widgets) {
            return $widgets;
        }

        if (!class_exists('Theme_OpenCartWidget')) {
            require_once $this->manager->getContext()->getWidgetsDir() . '/OpenCartWidget.php';
        }

        $widgets = $this->manager->gteOc2() ? $this->caveOC2Widgets() : $this->caveOC1Widgets();

        return $widgets;
    }

    protected function caveOC1Widgets()
    {
        $widgets = array();
        $layout_id = $this->manager->getThemeModel()->getLayoutIdByName('TB_Widgets');

        foreach ($this->manager->getThemeModel()->getInstalledOcModules() as $extension) {
            if ($modules = $this->manager->getOcConfig()->get($extension . '_module')) {
                $sort_orders = array();
                foreach ($modules as $settings) {
                    $layouts = (array) $settings['layout_id'];
                    if (strlen($settings['sort_order']) && !isset($sort_orders[$settings['sort_order']]) && $settings['status'] && in_array($layout_id, $layouts)) {

                        $widget = new Theme_OpenCartWidget($this->manager, $this);
                        $widget->setName('OC ' . ucfirst($extension) . ' ' . $settings['sort_order']);
                        $widget->setSettings(array(
                            'code'       => $extension,
                            'sort_order' => $settings['sort_order']
                        ));

                        $widgets[] = $widget;
                        $sort_orders[] = $settings['sort_order'];
                    }
                }
            }
        }

        return $widgets;
    }

    protected function caveOC2Widgets()
    {
        $layout_id = $this->manager->getThemeModel()->getLayoutIdByName('TB_Widgets');
        if (!$layout_modules = $this->manager->getOcModel('design/layout')->getLayoutModules($layout_id)) {
            return array();
        }

        $widgets = array();
        $sort_orders = array();

        foreach ($layout_modules as $module) {

            if (!isset($module['code']) || !strlen($module['sort_order'])) {
                continue;
            }

            $parts = explode('.', $module['code']);
            $type = $parts[0];

            if(empty($type) || isset($sort_orders[$type][$module['sort_order']]) || (!isset($parts[1]) && !$this->manager->getOcConfig($type . '_status'))) {
                continue;
            }

            if (isset($part[1]) && !(($module_settings = $this->manager->getOcModel('extension/module')->getModule($part[1])) || !$module_settings['status'])) {
                continue;
            }

            $widget = new Theme_OpenCartWidget($this->manager, $this);
            $widget->setName('OC ' . ucfirst($type) . ' ' . $module['sort_order']);
            $widget->setSettings(array(
                'code'       => $module['code'],
                'sort_order' => $module['sort_order']
            ));

            $widgets[] = $widget;
            $sort_orders[$type][] = $module['sort_order'];
        }

        return $widgets;
    }

    public function persistWidgets(array $widgets_data, $area_key, $area_name, $store_id = null)
    {
        if (null === $store_id) {
            $store_id = $this->manager->getContext()->getStoreId();
        }

        $area_settings = array();
        if (isset($widgets_data['settings'])) {
            // Used only when importing config/system_widgets
            if (!empty($widgets_data['settings'])) {
                $area_settings = $widgets_data['settings'];
                $this->manager->getThemeModel('layoutBuilder')->cleanSettingsDataBeforePersist($area_settings);
            }
            unset($widgets_data['settings']);
        }

        foreach ($this->areas as $area) {
            if (strpos($area_key, $area . '_default') === 0) {
                $store_id = 0;
            }
        }

        if (isset($widgets_data['rows']) && !empty($widgets_data['rows'])) {
            foreach ($widgets_data['rows'] as &$row) {

                $this->manager->getThemeModel('layoutBuilder')->cleanSettingsDataBeforePersist($row['settings']);

                if (isset($row['columns']) && !empty($row['columns'])) {
                    foreach ($row['columns'] as &$column) {
                        if (isset($column['widgets']) && !empty($column['widgets'])) {

                            $sizes = array(
                                'area_name'      => $area_name,
                                'columns_num'    => count($row['columns']),
                                'row_layout'     => $row['settings']['layout']['type'],
                                'row_margin'     => (int) $row['settings']['layout']['margin_right'] * 2,
                                'row_padding'    => (int) $row['settings']['layout']['padding_right'] * 2,
                                'column_spacing' => (int) $row['settings']['layout']['columns_gutter'],
                                'column_padding' => (int) $row['settings']['layout']['inner_padding'] * 2
                            );

                            foreach ($column['widgets'] as &$widget_form) {

                                $class_name = substr($widget_form['id'], 0, strrpos($widget_form['id'], '_'));
                                $widget = $this->createWidgetInstance($class_name);

                                if ($widget instanceof Theme_GroupWidget && isset($widget_form['subwidgets'])) {
                                    foreach ($widget_form['subwidgets'] as &$subwidget_form) {
                                        $class_name = substr($subwidget_form['id'], 0, strrpos($subwidget_form['id'], '_'));
                                        $subWidget = $this->createWidgetInstance($class_name);
                                        $subWidget->setParent($widget);

                                        $this->filterWidgetInstance($subWidget, $subwidget_form['settings']);
                                        $widget->onPersistSystem($subwidget_form['settings']);

                                        if (is_callable(array($subWidget, 'onPersist'))) {
                                            $subWidget->onPersist($subwidget_form['settings']);
                                        }
                                    }
                                }

                                $this->filterWidgetInstance($widget, $widget_form['settings']);
                                $widget->onPersistSystem($widget_form['settings']);

                                if (is_callable(array($widget, 'onPersist'))) {
                                    $widget->onPersist($widget_form['settings']);
                                }

                                $sizes['widget_margin']   = (int) $widget_form['settings']['common']['layout']['margin_right'] * 2;
                                $sizes['widget_padding']  = (int) $widget_form['settings']['common']['layout']['padding_right'] * 2;
                                $sizes['grid_proportion'] = $column['grid_proportion'];
                                $sizes['group_margin']    = 0;
                                $sizes['group_padding']   = 0;

                                $widget_form['settings']['sizes'] = $sizes;

                                if ($widget instanceof Theme_GroupWidget && isset($widget_form['subwidgets'])) {
                                    $sizes['group_margin']  = (int) $widget_form['settings']['common']['layout']['margin_right'] * 2;
                                    $sizes['group_padding'] = (int) $widget_form['settings']['common']['layout']['padding_right'] * 2;

                                    foreach ($widget_form['subwidgets'] as &$subwidget_form) {
                                        $sizes['widget_margin']  = (int) $subwidget_form['settings']['common']['layout']['margin_right'] * 2;
                                        $sizes['widget_padding'] = (int) $subwidget_form['settings']['common']['layout']['padding_right'] * 2;

                                        $subwidget_form['settings']['sizes'] = $sizes;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        if (isset($widgets_data['rows'])) {
            $this->manager->getBuilderSettingsModel()->setAndPersistScopeSettings('area_' . $area_key, $widgets_data, $store_id);
        }

        $persist_theme_settings = false;
        $theme_settings = $this->manager->getThemeModel()->getSettings(true);
        $respect_global = isset($widgets_data['respect_global_record']) ? (int) $widgets_data['respect_global_record'] : 1;

        if (!isset($theme_settings['area_keys'])) {
            $theme_settings['area_keys'] = array();
            $persist_theme_settings = true;
        }

        if (!isset($theme_settings['area_keys'][$area_key]) && isset($widgets_data['rows'])) {
            $theme_settings['area_keys'][$area_key] = $respect_global;
            ksort($theme_settings['area_keys']);
            $persist_theme_settings = true;
        }

        if (!empty($area_settings)) {
            $area_settings['respect_global_record'] = $respect_global;
            $this->manager->getBuilderSettingsModel()->setAndPersistScopeSettings('area_settings_' . $area_key, $area_settings, $store_id);

            if (!isset($theme_settings['area_settings_keys'])) {
                $theme_settings['area_settings_keys'] = array();
                $persist_theme_settings = true;
            }

            if (!isset($theme_settings['area_settings_keys'][$area_key]) || $theme_settings['area_settings_keys'][$area_key] != $respect_global) {
                $theme_settings['area_settings_keys'][$area_key] = $respect_global;
                ksort($theme_settings['area_settings_keys']);
                $persist_theme_settings = true;
            }
        }

        if ($persist_theme_settings) {
            $this->manager->getThemeModel()->setAndPersistSettings($theme_settings);
        }
    }

    /**
     * @param string $id
     * @param array $settings
     * @return TB_Widget
     */
    public function createWidgetFromId($id, array $settings = array())
    {
        $widget_class = substr($id, 0, strrpos($id, '_'));
        $widget = $this->createWidget($widget_class, $settings);
        $widget->setId($id);

        return $widget;
    }

    /**
     * @param string $id
     * @param array $settings
     * @return TB_Widget
     */
    public function createAndFilterWidgetFromId($id, array $settings = array())
    {
        $widget = $this->createWidgetInstance(substr($id, 0, strrpos($id, '_')));

        $widget->setId($id);
        $this->filterWidgetInstance($widget, $settings);
        $widget->setSettings($settings);
        $this->initWidgetInstance($widget, $settings);

        return $widget;

    }

    /**
     * @param $class_name
     * @param array $settings
     *
     * @return TB_Widget
     */
    public function createAndFilterWidget($class_name, array $settings = array())
    {
        $widget = $this->createWidgetInstance($class_name);
        $this->filterWidgetInstance($widget, $settings);
        $widget->setSettings($settings);

        $this->initWidgetInstance($widget, $settings);

        return $widget;
    }

    /**
     * @param $class_name
     * @param array $settings
     *
     * @return TB_Widget
     */
    public function createFilterAndEditWidget($class_name, array $settings = array())
    {
        $widget = $this->createWidgetInstance($class_name);
        $this->filterWidgetInstance($widget, $settings);
        $widget->setSettings($settings);

        $widget->onEditSystem($settings);
        if (is_callable(array($widget, 'onEdit'))) {
            $widget->onEdit($settings);
        }

        $this->initWidgetInstance($widget, $settings);

        return $widget;
    }

    /**
     * @param $class_name
     * @param array $settings
     *
     * @return TB_Widget
     */
    public function createTransformAndFilterWidget($class_name, array $settings)
    {
        $widget = $this->createWidgetInstance($class_name);
        if (is_callable(array($widget, 'onTransformSettings'))) {
            $widget->onTransformSettings($settings);
        }
        $this->filterWidgetInstance($widget, $settings);
        $this->initWidgetInstance($widget, $settings);

        return $widget;
    }

    /**
     * @param string $widget_class
     * @param string|array $settings
     * @return TB_Widget
     * @throws Exception
     */
    public function createWidget($widget_class, $settings = array())
    {
        $widget = $this->createWidgetInstance($widget_class);
        $this->initWidgetInstance($widget, $settings);

        return $widget;
    }

    /**
     * @param $widget_class
     * @return TB_Widget
     * @throws Exception
     */
    protected function createWidgetInstance($widget_class)
    {
        if (!class_exists($widget_class)) {
            $widget_file = $this->manager->getContext()->getWidgetsDir() . '/' . str_replace('Theme_', '', $widget_class) . '.php';
            if (!file_exists($widget_file)) {
                throw new Exception ('The widget file cannot be found: ' . $widget_file);
            }

            require_once $widget_file;
        }

        return new $widget_class($this->manager, $this);
    }

    protected function filterWidgetInstance(TB_Widget $widget, array &$settings)
    {
        $widget->onFilterSystem($settings);
        if (is_callable(array($widget, 'onFilter'))) {
            $widget->onFilter($settings);
        }
    }

    /**
     * @param TB_Widget $widget
     * @param array $settings
     */
    protected function initWidgetInstance(TB_Widget $widget, array $settings)
    {
        if (is_callable(array($widget, 'onInit'))) {
            $widget->onInit($settings);
        }
        $widget->setSettings($settings);
    }

    /**
     * @param string|array $settings
     * @return TB_Widget[]
     * @throws Exception
     */
    public function createSystemWidgets($settings)
    {
        $result = array();

        if (!isset($settings['widgets']) || !is_array($settings['widgets'])) {
            return $result;
        }

        foreach ($settings['widgets'] as $widget_config) {
            $class = isset($widget_config['class']) ? $widget_config['class'] : 'Theme_SystemWidget';
            $widget = $this->createWidget($class, array(
                'is_active'   => 1,
                'slot_prefix' => $settings['route'],
                'slot_name'   => $widget_config['slot']
            ));
            $widget->setName($widget_config['label']);

            if (isset($widget_config['locked']) && $widget_config['locked']) {
                $widget->lock();
            }

            $result[] = $widget;
        }

        return $result;
    }
}