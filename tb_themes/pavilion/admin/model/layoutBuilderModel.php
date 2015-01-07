<?php

require_once dirname(__FILE__) . '/../../model/layoutBuilderModel.php';

class Theme_Admin_LayoutBuilderModel extends Theme_LayoutBuilderModel
{
    public function getLayouts()
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $result = $this->getThemeModel()->getLayouts();

        if ($result) {
            $tb_layout_id = $this->getThemeModel()->getLayoutIdByName('TB_Widgets');
            unset($result[$tb_layout_id]);
        }

        return $result;
    }

    public function getLayoutsExcludingRoute($route)
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $sql = 'SELECT DISTINCT(l.layout_id)
                FROM ' . DB_PREFIX . 'layout_route AS lr
                LEFT JOIN ' . DB_PREFIX . 'layout AS l on lr.layout_id = l.layout_id
                WHERE lr.route LIKE "%' . implode('%" OR lr.route LIKE "%', (array) $route) . '%"';

        $ids = array_column($this->db->query($sql)->rows, 'layout_id');

        $result = $this->getLayouts();
        foreach ($result as $id => $layout) {
            if (in_array($id, $ids)) {
                unset($result[$id]);
            }
        }

        return $result;
    }

    public function getRouteForSystemPage($page_id)
    {
        foreach ($this->getSystemPages() as $group_name => $group_items) {
            foreach ($group_items as $page_name => $page) {
                if ($group_name . '/' . $page_name == $page_id) {
                    return $page['route'];
                }
            }
        }

        return false;
    }

    public function determineAreaParams($area_name, $area_type, $area_id, $type, $store_id = null)
    {
        if (null === $store_id) {
            $store_id = $this->context->getStoreId();
        }

        // the slot prefix from the template which will display the widgets.
        // This method changes the slot prefix if it will hold a real prefix from a template, else its 'default' value is left
        // If its value is 'default' the prefix will be replaced with the current route in LayoutBuilderPlugin:getArea()
        $slot_prefix = false;
        // the settings key to load the default widgets from
        $area_key = false;
        $widgetManager = $this->manager->getWidgetManager();

        if ($area_type == 'page') {
            $layout_id = $this->getInformationLayoutId($area_id, $store_id);
            $slot_prefix = 'information/information';

            if (!$layout_id || !$widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type, $store_id)) {
                $layout_id = $this->getLayout($slot_prefix, $store_id);
            }

            if ($layout_id && $widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type, $store_id)) {
                $area_key = 'layout_' . $layout_id;
            } else
            if ($widgetManager->areaExists($area_name . '_global', $type, $store_id)) {
                $area_key = 'global';
            } else
            if ($widgetManager->areaExists($area_name . '_default_information/information', $type, $store_id)) {
                $area_key = 'default_information/information';
            }
            else {
                $area_key = 'default';
            }
        } else

        if ($area_type == 'category') {
            $layout_id = $this->getCategoryLayoutId($area_id, $store_id);
            $slot_prefix = 'product/category';

            if (!$layout_id || !$widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type, $store_id)) {
                $layout_id = $this->getLayout($slot_prefix, $store_id);
            }

            if ($layout_id && $widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type, $store_id)) {
                $area_key = 'layout_' . $layout_id;
            } else {
                if (is_numeric($area_id)) {
                    $categoryTree = $this->getThemeModel('category')->getCategoriesFlatTree($store_id);
                    $level = $categoryTree[$area_id]['level'];
                    if ($widgetManager->areaExists($area_name . '_category_level_' . $level, $type, $store_id)) {
                        $area_key = 'category_level_' . $level;
                    }
                }

                if (false == $area_key) {
                    if ($widgetManager->areaExists($area_name . '_category_global', $type, $store_id)) {
                        $area_key = 'category_global';
                    } else {
                        $category_defaults = $widgetManager->getAreaSettings($area_name . '_default_product/category', $type, $store_id);
                        $global_record = $widgetManager->getAreaSettings($area_name . '_global', $type, $store_id);

                        if ($category_defaults && (!$global_record || $category_defaults['respect_global_record'] == 0)) {
                            $area_key = 'default_product/category';
                        } else
                        if ($global_record) {
                            $area_key = 'global';
                        } else {
                            $area_key = 'default';
                        }
                    }
                }
            }
        } else {
            $area_key = 'default';

            if ($area_type == 'layout') {
                $sql = 'SELECT `route`
                        FROM ' . DB_PREFIX . 'layout_route
                        WHERE `store_id` = ' . $store_id. ' AND
                              `layout_id` = ' . (int) $area_id;
                $routes = array_column($this->db->query($sql)->rows, 'route');

                foreach ($routes as $route) {
                    $system_page = $this->getSystemPageForRoute($route);
                    if (false !== $system_page) {
                        $area_type = 'system';
                        $area_id = $route;
                        break;
                    }
                }

                if ($area_type != 'system') {
                    $layout = $this->getOcModel('design/layout')->getLayout($area_id);
                    if (strpos(strtolower($layout['name']), 'product*') !== false) {
                        $area_type   = '';
                        $slot_prefix = 'product/product';

                        $layout_id = $this->getLayout($slot_prefix, $store_id);
                        if ($layout_id && $widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type, $store_id)) {
                            $area_key = 'layout_' . $layout_id;
                        } else {
                            $area_key    = 'default_product/product';
                        }
                    }
                }
            }

            if ($area_type == 'system') {
                $system_page = $this->getSystemPageForRoute($area_id);
                if (false === $system_page) {
                    throw new InvalidArgumentException('A matching system configuration has not been found');
                }

                $slot_prefix = $system_page['route'];
                $layout_id = $this->getLayout($slot_prefix, $store_id);

                if ($layout_id && $widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type, $store_id)) {
                    $area_key = 'layout_' . $layout_id;
                } else {
                    $system_defaults = $widgetManager->getAreaSettings($area_name . '_default_' . $system_page['route'], $type, $store_id);
                    $global_record = $widgetManager->areaExists($area_name . '_global', $type, $store_id);

                    if ($system_defaults && (!$global_record || $system_defaults['respect_global_record'] == 0)) {
                        $area_key = 'default_' . $system_page['route'];
                    }
                }
            } else
            if ($area_type == 'global') {
                $slot_prefix = 'default';
            }

            if ($area_key == 'default' && $widgetManager->areaExists($area_name . '_global', $type, $store_id)) {
                $area_key = 'global';
            } else
            if ($area_type == 'home') {
                $area_key = false;
            }
        }

        return array($slot_prefix, $area_key);
    }

    public function buildOverrideInformationMessage($area_name, $area_type, $area_id, $type)
    {
        $layout_id = 0;
        $msg = '';
        $widgetManager = $this->manager->getWidgetManager();

        if ($area_type == 'category' && !is_numeric($area_id)) {
            $layout_id = $this->getCategoryLayoutId($area_id);

            if (!$layout_id || !$widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type)) {
                $layout_id = $this->getLayout('product/category');
            }
        }

        if ($area_type == 'page' && !is_numeric($area_id)) {
            $layout_id = $this->getInformationLayoutId($area_id);

            if (!$layout_id || !$widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type)) {
                $layout_id = $this->getLayout('information/information');
            }
        }

        if ($area_type == 'system' && !$widgetManager->areaExists($area_name . '_' . $area_type . '_' . $area_id, $type)) {
            $system_page = $this->getSystemPageForRoute($area_id);
            if (false === $system_page) {
                throw new InvalidArgumentException('A matching system configuration has not been found');
            }

            $layout_id = $this->getLayout($system_page['route']);
        }

        $layout = false;
        if ($layout_id && $widgetManager->areaExists($area_name . '_layout_' . $layout_id, $type)) {
            $layout = $this->getOcModel('design/layout')->getLayout($layout_id);
        }

        if (false !== $layout) {
            $msg = 'Layout: ' . $layout['name'];
        }

        return $msg;
    }

    public function buildInheritInformationMessage($area_key)
    {
        $msg = 'Default built-in settings';

        if (0 === strpos($area_key, 'default_') && substr($area_key, 8) == 'product/category') {
            $msg = 'Default built-in category settings';
        } else
        if (0 === strpos($area_key, 'category_level_')) {
            $msg = 'The settings for <strong class="tbParentArea">Level ' . substr($area_key, 15) . ' categories</strong>';
        } else
        if ($area_key == 'category_global') {
            $msg = 'The settings for <strong class="tbParentArea">All categories</strong>';
        } else
        if (0 === strpos($area_key, 'layout_') && is_numeric(substr($area_key, 7))) {
            $layout_id = substr($area_key, 7);
            $layout = $this->getOcModel('design/layout')->getLayout($layout_id);
            $msg = 'The settings for <strong class="tbParentArea">Layout: ' . $layout['name'] . '</strong>';
        } else
        if ($area_key == 'global') {
            $msg = 'The settings for <strong class="tbParentArea">GLOBAL</strong>';
        }

        return $msg;
    }

    public function getAreaSystemSettings($area_name, $area_type, $area_id)
    {
        $settings = array();

        if ($area_type == 'layout') {
            $sql = 'SELECT `route`
                    FROM ' . DB_PREFIX . 'layout_route
                    WHERE `store_id` = ' . $this->context->getStoreId(). ' AND `layout_id` = ' . (int) $area_id;
            $routes = array_column($this->db->query($sql)->rows, 'route');

            foreach ($routes as $route) {
                $system_page = $this->getSystemPageForRoute($route);
                if (false !== $system_page) {
                    $area_type = 'system';
                    $area_id = $route;
                    break;
                }
            }

            if ($area_type != 'system') {
                $layout = $this->getOcModel('design/layout')->getLayout($area_id);
                if (strpos(strtolower($layout['name']), 'product*') !== false) {
                    $area_type = 'system';
                    $area_id   = 'product/product';
                }
            }
        }

        if ($area_type == 'system') {
            $settings = $this->getSystemPageForRoute($area_id);
        } else

        if ($area_type == 'category') {
            $settings = $this->getSystemPageForRoute('product/category');
        } else

        if ($area_type == 'page') {
            $settings = $this->getSystemPageForRoute('information/information');
        }

        if (!empty($settings)) {
            foreach ($settings['widgets'] as $key => $widget_config) {
                $areas = array_map('trim', explode(',', $widget_config['areas']));
                if (!in_array($area_name, $areas)) {
                    unset($settings['widgets'][$key]);
                }
            }
        }

        if ($area_type == 'global' || $area_type == 'layout') {
            $system_global = require $this->manager->getContext()->getConfigDir() . '/system_widgets/global.php';
            $layout_type = $this->manager->getThemeData()->theme_settings['style']['wrapper']['layout']['type'];

            if (isset($system_global[$layout_type][$area_name]['global_widgets']) && !empty($system_global[$layout_type][$area_name]['global_widgets'])) {
                $settings = array(
                    'route'   => 'default',
                    'widgets' => $system_global[$layout_type][$area_name]['global_widgets']
                );
            }
        }

        return $settings;
    }

    public function buildModifiedMenu($area_name, array $settings_keys)
    {
        $settings_keys = array_keys($settings_keys);
        if (!empty($area_name)) {
            foreach ($settings_keys as $key => $value) {
                if (0 !== strpos($value, $area_name) || 0 === strpos($value, $area_name . '_default')) {
                    unset($settings_keys[$key]);
                } else {
                    $settings_keys[$key] = str_replace($area_name . '_', '', $value);
                }
            }
        }

        $modified = array(
            'global' => array(
                'items' => array()
            ),
            'home' => array(
                'items' => array()
            ),
            'page' => array(
                'title' => 'Information Pages',
                'items' => array()
            ),
            'category' => array(
                'title' => 'Categories',
                'items' => array()
            ),
            'layout' => array(
                'title' => 'Layouts',
                'items' => array()
            ),
            'system' => array(
                'title' => 'System pages',
                'items' => array()
            )
        );
        $has_modified = false;

        if (false !== array_search('global', $settings_keys)) {
            $modified['global']['items'][] = array(
                'value' => 'global',
                'label' => 'GLOBAL'
            );
            $has_modified = true;
        }

        if (false !== array_search('home', $settings_keys)) {
            $modified['home']['items'][] = array(
                'value' => 'home',
                'label' => 'Home'
            );
            $has_modified = true;
        }

        if (false !== array_search('category_global', $settings_keys)) {
            $modified['category']['items'][] = array(
                'value' => 'category_global',
                'label' => 'All categories'
            );
            $has_modified = true;
        }

        foreach ($this->getCategoryLevels() as $level) {
            if (false !== array_search('category_level_' . $level['level'], $settings_keys)) {
                $modified['category']['items'][] = array(
                    'label'      => 'Level ' . $level['level'] . ' categories',
                    'value'      => $level['value']
                );
                $has_modified = true;
            }
        }

        $categories_flat = $this->getThemeModel('category')->getCategoriesFlatTree();
        $information_pages = $this->getThemeModel()->getInformationPages();
        $layouts = $this->getLayouts();

        foreach ($settings_keys as $key) {

            if (preg_match('/^page_(\d+)$/', $key, $matches) && isset($information_pages[$matches[1]])) {
                $modified['page']['items'][] = array(
                    'value' => $matches[1],
                    'label' => $information_pages[$matches[1]]['title']
                );
                $has_modified = true;
            }

            if (preg_match('/^category_(\d+)$/', $key, $matches) && isset($categories_flat[$matches[1]])) {
                $name = array();
                foreach (explode('_', $categories_flat[$matches[1]]['path']) as $category_id) {
                    $name[] =  $categories_flat[$category_id]['name'];
                }

                $modified['category']['items'][] = array(
                    'value' => $matches[1],
                    'label' => implode(' > ', $name)
                );
                $has_modified = true;
            }

            if (preg_match('/^layout_(\d+)$/', $key, $matches) && isset($layouts[$matches[1]])) {
                $modified['layout']['items'][] = array(
                    'value' => $matches[1],
                    'label' => $layouts[$matches[1]]['name']
                );
                $has_modified = true;
            }

            if (preg_match('/^system_(.*)$/', $key, $matches)) {
                $system_page = $this->getSystemPageForRoute($matches[1]);
                if (false !== $system_page && $system_page['display']) {
                    $modified['system']['items'][] = array(
                        'value' => $matches[1],
                        'label' => $system_page['label']
                    );
                    $has_modified = true;
                }
            }
        }

        if (!$has_modified) {
            $modified = array();
        }

        return $modified;
    }

    public function deleteDefaultAreaSettings()
    {
        $theme_settings = $this->manager->getThemeModel()->getSettings(true);

        foreach (array('footer', 'intro', 'content', 'column_left', 'column_right') as $area_name) {
            $sql = 'DELETE FROM ' . DB_PREFIX . 'tb_setting
                    WHERE `store_id` = 0 AND `group` = "theme_' . $this->manager->getThemeMachineName() . '" AND (
                              `key` LIKE "area_' . $area_name . '_default%" OR
                              `key` LIKE "area_settings_' . $area_name . '_default%"
                          )';
            $this->db->query($sql);

            foreach (array('area_keys', 'area_settings_keys') as $index) {
                if (isset($theme_settings[$index])) {
                    foreach ($theme_settings[$index] as $key => $value) {
                        if (0 === strpos($key, $area_name . '_default')) {
                            unset($theme_settings[$index][$key]);
                        }
                    }
                } else {
                    $theme_settings[$index] = array();
                }
            }
        }

        $this->manager->getThemeModel()->persistCustomSettings($theme_settings);
        $this->manager->getThemeModel()->setSetting('area_keys', $theme_settings['area_keys']);
        $this->manager->getThemeModel()->setSetting('area_settings_keys', $theme_settings['area_settings_keys']);
    }

    public function getCategoryLevels()
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $result = array();
        $categories_max_level = $this->getThemeModel('category')->getCategoriesMaxLevel();
        for ($i = 1; $i < $categories_max_level; $i++) {
            $result[] = array(
                'label' => 'Level ' . $i . ' categories',
                'value' => 'level_' . $i,
                'level' => $i
            );
        }

        return $result;
    }

    public function rebuildDefaultAreaSettings()
    {
        $this->deleteDefaultAreaSettings();
        $theme_settings = $this->manager->getThemeModel()->getSettings(true);

        foreach ($this->getSystemPages() as $pages) {
            foreach ($pages as $page) {
                if (isset($page['default'])) {
                    $this->saveSystemAreas($page['default'], $theme_settings, '_' . $page['route']);
                }
            }
        }

        $system_global = require $this->manager->getContext()->getConfigDir() . '/system_widgets/global.php';
        $this->saveSystemAreas($system_global, $theme_settings, '', true);

        $system_routes = array();
        foreach ($this->getSystemPages() as $pages) {
            foreach ($pages as $page) {
                $system_routes[$page['route']] = isset($page['ssl']) ? (int) $page['ssl'] : 0;
            }
        }

        $theme_settings = $this->manager->getThemeModel()->getSettings(true);
        $theme_settings['system_routes'] = $system_routes;
        $this->manager->getThemeModel()->persistCustomSettings($theme_settings);
        $this->manager->getThemeModel()->setSetting('system_routes', $system_routes);
    }

    protected function saveSystemAreas($areas, array $theme_settings, $area_key_postfix = '')
    {
        $wrapper_layout = $theme_settings['style']['wrapper']['layout']['type'];
        if (isset($areas[$wrapper_layout])) {
            $areas = $areas[$wrapper_layout];
        }

        $widgetManager = $this->manager->getWidgetManager();

        foreach ($areas as $area_name => $settings) {
            $global_rows = $this->createSystemGlobalRows($settings, $area_name);
            $widgetManager->persistWidgets($global_rows, $area_name . '_default' . $area_key_postfix, $area_name);
        }
    }

    public function createSystemGlobalRows($area, $area_name)
    {
        $settings = array();
        if (isset($area['settings'])) {
            $settings = $area['settings'];
        }
        $this->filterSettings($settings, 'area_' . $area_name, $this->getAreaDefaultColors($area_name));
        $area['settings'] = $settings;

        if (isset($area['global_widgets'])) {
            unset($area['global_widgets']);
        }

        if (!isset($area['rows'])) {
            return $area;
        }

        $rows = array();
        $i = 0;
        foreach ($area['rows'] as $row) {
            $rows[$i]['id'] = isset($row['id']) ? $row['id'] : TB_Utils::genRandomString();
            $rows[$i]['columns_number'] = count($row['columns']);

            if (!isset($row['settings'])) {
                $row['settings'] = array();
            }
            //$row_defaults = array();
            $this->filterSettings($row['settings'], 'widgets_row', $this->getRowDefaultColors());
            $rows[$i]['settings'] = $row['settings'];
            //$rows[$i]['settings'] = array_merge_recursive_distinct($row_defaults, $row['settings']);

            $j = 0;
            foreach ($row['columns'] as $column) {
                $rows[$i]['columns'][$j]['grid_proportion'] = $column['grid_proportion'];
                $rows[$i]['columns'][$j]['widgets'] = array();

                foreach ($column['widgets'] as $widget) {
                    $class = 'Theme_SystemWidget';
                    if (isset($widget['class'])) {
                        $class = $widget['class'];
                    }

                    $instance_settings = array();
                    if (isset($widget['settings'])) {
                        $instance_settings = $widget['settings'];
                    }

                    $instance_settings['is_active']   = 1;
                    $instance_settings['slot_prefix'] = isset($area['route']) ? $area['route'] : 'default';
                    $instance_settings['slot_name']   = $widget['slot'];

                    $widget_id = $class . '_' . (isset($widget['id']) ? $widget['id'] : TB_Utils::genRandomString(8));
                    $instance = $this->manager->getWidgetManager()->createWidgetFromId($widget_id, $instance_settings);
                    $instance->setName($widget['label']);

                    $instances[$widget_id] = $instance;
                    $rows[$i]['columns'][$j]['widgets'][] = array(
                        'id'       => $widget_id,
                        'settings' => $instance->getSettings()
                    );
                }
                $j++;
            }
            $i++;
        }

        $area['rows'] = $rows;

        return $area;
    }

    public function filterAreaSettings(array &$area_settings, $area_name, array $theme_colors = array())
    {
        $this->filterSettings($area_settings, $area_name);
        TB_ColorSchemer::getInstance()
            ->filterThemeColors($theme_colors, $this->manager->getThemeData()->colors)
            ->filterAreaColors($area_settings['colors'], $this->getAreaDefaultColors($area_name), $area_name);
    }

    public function filterRowSettings(array &$row_settings, $area_name = '', array $area_settings = array(), array $theme_colors = array())
    {
        static $filtered_areas = array();

        if (!empty($area_name) && !isset($filtered_areas[$area_name])) {
            $this->filterAreaSettings($area_settings, $area_name, $theme_colors);
        }

        $this->filterSettings($row_settings, 'widgets_row');
        TB_ColorSchemer::getInstance()->filterRowColors($row_settings['colors'], $this->getRowDefaultColors());
    }

    public function getInformationLayoutId($information_id, $store_id = null)
    {
        if (null === $store_id) {
            $store_id = $this->context->getStoreId();
        }

        $sql = "SELECT *
                FROM " . DB_PREFIX . "information_to_layout
                WHERE information_id = '" . (int) $information_id . "' AND store_id = '" . $store_id . "'";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }

    public function getCategoryLayoutId($category_id, $store_id = null)
    {
        if (null === $store_id) {
            $store_id = $this->context->getStoreId();
        }

        $sql = "SELECT *
                FROM " . DB_PREFIX . "category_to_layout
                WHERE category_id = '" . (int) $category_id . "' AND store_id = '" . $store_id . "'";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }

    public function getLayout($route, $store_id = null)
    {

        if (null === $store_id) {
            $store_id = $this->context->getStoreId();
        }

        $sql = "SELECT *
                FROM " . DB_PREFIX . "layout_route
                WHERE '" . $this->db->escape($route) . "' LIKE CONCAT(route, '%') AND store_id = '" . $store_id . "'
                ORDER BY route DESC LIMIT 1";
        $query = $this->db->query($sql);

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }
}