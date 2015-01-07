<?php

class Theme_Admin_ImportController extends TB_AdminController
{
    public function installSampleData()
    {
        if (!$this->validate()) {
            $this->sendJsonError($this->error['warning']);

            return;
        }

        $import_stores = array();
        foreach ((array) $this->request->get['import_stores'] as $store_id => $import_settings) {
            if ($import_settings['design'] != '0') {
                $import_stores[$store_id] = $import_settings;
            }
        }

        if (empty($import_stores)) {
            $this->sendJsonError('No stores selected for import');
        }

        $is_existing = $this->request->get['store_type'] == 'existing';

        if (!$this->importDemoSettings($import_stores, $is_existing)) {
            return;
        }

        $result = false;
        if ($is_existing) {
            foreach ($import_stores as $store_id => $value) {
                if (!isset($value['oc_modules']) || !$value['oc_modules']) {
                    unset($import_stores[$store_id]);
                }
            }
            if (!empty($import_stores)) {
                $result = $this->importExisting($import_stores);
            }
        } else {
            $result = $this->importDemoData($import_stores);
        }

        if ($result) {
            $this->getModel('layoutBuilder')->rebuildDefaultAreaSettings();
        }

        $this->manager->wipeAllCache();
    }

    protected function importExisting(array $import_stores)
    {
        $tb_layout_id = $this->manager->getThemeModel()->getLayoutIdByName('TB_Widgets');

        if (empty($tb_layout_id)) {
            return $this->sendJsonError('The modules cannot be imported due to a missing TB_Widgets layout');
        }

        $keys_to_persist = array();

        /** @var TB_SettingsModel[] $settingsModels  */
        $settingsModels = array();
        $theme_settings = array();
        foreach (array_keys($import_stores) as $store_id) {
            $settingsModels[$store_id] = $this->manager->getSettingsModelInstance($store_id);
        }

        foreach ($settingsModels as $store_id => $model) {
            $theme_settings[$store_id] = $model->getScopeSettings('theme', true);
        }

        $all_modules = array();
        foreach ($this->getModel()->getInstalledOcModules() as $extension) {
            //if ($extension != 'latest') continue;
            $modules = $this->manager->getOcConfig()->get($extension . '_module');
            if (!$modules) {
                continue;
            }

            $tb_sort_orders = array();
            foreach ($modules as $key => $settings) {
                if (!$settings['status']) {
                    continue;
                }

                if ($settings['layout_id'] == $tb_layout_id) {
                    $tb_sort_orders[] = $settings['sort_order'];
                }
            }

            $cloned_modules = array();
            foreach ($modules as $key => $settings) {
                if ($settings['layout_id'] == $tb_layout_id || !$settings['status']) {
                    continue;
                }

                $temp_settings = $settings;
                unset($temp_settings['sort_order'], $temp_settings['layout_id']);
                $hash = md5(serialize($temp_settings));

                if (isset($all_modules[$hash])) {
                    $all_modules[$hash]['settings']['old_layout_id'][] = $settings['layout_id'];
                } else {
                    $order = abs((int)$settings['sort_order']);
                    while (in_array($order, $tb_sort_orders)) {
                        $order++;
                    }

                    $tb_sort_orders[] = $order;
                    $settings['sort_order'] = $order;
                    $settings['old_layout_id'] = array($settings['layout_id']);
                    $settings['layout_id'] = $tb_layout_id;

                    $all_modules[$hash] = array(
                        'extension' => $extension,
                        'settings'  => $settings
                    );
                    $cloned_modules[] = $settings;
                }
            }

            $keys_to_persist[] = array($extension . '_module', 0, $extension, array_merge($modules, $cloned_modules));
        }

        if (!class_exists('Theme_OpenCartWidget')) {
            require_once $this->manager->getContext()->getWidgetsDir() . '/OpenCartWidget.php';
        }

        foreach ($all_modules as $new_module) {

            $module      = $new_module['settings'];
            $extension   = $new_module['extension'];

            foreach ($module['old_layout_id'] as $old_layout_id) {

                $routes      = $this->manager->getOcModel('design/layout')->getLayoutRoutes($old_layout_id);
                $route_names = array_column($routes, 'route');
                $stores      = array();

                foreach ($routes as $route) {
                    if (array_key_exists($route['store_id'], $import_stores)) {
                        $stores[] = $route['store_id'];
                    }
                }
                $stores = array_unique($stores);

                if (!count($stores)) {
                    continue;
                }

                list($area_name, $position) = explode('_', $module['position']);

                if ($area_name == 'column') {
                    $area_name = $module['position'];
                } else {
                    $area_name = 'content';
                }

                if (!in_array($position, array('top', 'bottom'))) {
                    $position = 'bottom';
                }

                foreach ($stores as $store_id) {

                    if (in_array('product/category', $route_names)) {
                        $area_key = $area_name . '_category_global';
                    } else
                    if (in_array('common/home', $route_names)) {
                        $area_key = $area_name . '_home';
                    } else {
                        $area_key = $area_name . '_layout_' . $old_layout_id;
                    }

                    $area = array();
                    if (isset($theme_settings[$store_id]['area_keys'][$area_key])) {
                        $area = $this->manager->getWidgetManager()->getAreaSettings($area_key, 'area',  $store_id, true);
                    } else {
                        if ($area_key != 'content_home') {
                            try {
                                $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, 'layout', $old_layout_id, 'rows', $store_id);
                            } catch (Exception $e) {
                                return $this->sendJsonError($e->getMessage());
                            }

                            list(, $default_area_key) = $params;

                            $area = $this->manager->getWidgetManager()->getAreaSettings($area_name . '_' . $default_area_key, 'area', $store_id, true);
                        }
                        $theme_settings[$store_id]['area_keys'][$area_key] = 1;
                    }

                    $area_settings = $this->manager->getWidgetManager()->getAreaSettings($area_key, 'settings', $store_id, true);

                    if (empty($area_settings)) {
                        try {
                            $params = $this->getModel('layoutBuilder')->determineAreaParams($area_name, 'layout', $old_layout_id, 'settings', $store_id);
                        } catch (Exception $e) {
                            return $this->sendJsonError($e->getMessage());
                        }

                        list(, $default_area_key) = $params;
                        $area_settings = $this->manager->getWidgetManager()->getAreaSettings($area_name . '_' . $default_area_key, 'settings', $store_id, true);
                    }

                    if (empty($area_settings)) {
                        $area_settings = array();
                    }

                    $row_settings = array();
                    $this->getModel('layoutBuilder')->filterRowSettings($row_settings, 'area_' . $area_name, (array) $area_settings);

                    $row = array(
                        'id'             => TB_Utils::genRandomString(),
                        'columns_number' => '1',
                        'settings'       => $row_settings,
                        'columns'        => array(
                            0 => array(
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'Theme_OpenCartWidget_' . TB_Utils::genRandomString(8),
                                        'settings' => array(
                                            'code'        => $extension,
                                            'sort_order'  => $module['sort_order'],
                                            'widget_name' => 'OC ' . ucfirst($extension) . ' ' . $module['sort_order']
                                        )
                                    )
                                ),
                                'grid_proportion' => '1_1'
                            )
                        )
                    );

                    if (empty($area)) {
                        $area = array(
                            'rows' => array(
                                0 => $row
                            )
                        );
                    } else {
                        switch($position) {
                            case 'top':
                                array_unshift($area['rows'], $row);
                                break;
                            case 'bottom':
                                array_push($area['rows'], $row);
                                break;
                        }
                    }

                    $this->manager->getWidgetManager()->persistWidgets($area, $area_key, $area_name, $store_id);
                }
            }
        }

        $layout_route = $this->manager->getOcDb()->query('SELECT * FROM `' . DB_PREFIX . 'layout_route` WHERE route = "product/product"');
        if (!$layout_route->num_rows) {
            $this->manager->getDbHelper()->addRecord('layout', array(
                'name' => 'Product'
            ));
            $product_layout_id = $this->manager->getDbHelper()->getLastId();
        } else {
            $product_layout_id = $layout_route->row['layout_id'];
        }

        foreach ($settingsModels as $store_id => $model) {
            $theme_settings[$store_id]['product']['designs']['layout'] = array();
            $layout_route = $this->manager->getOcDb()->query('SELECT * FROM `' . DB_PREFIX . 'layout_route` WHERE layout_id = ' . $product_layout_id . ' AND store_id = ' . $store_id);
            if (!$layout_route->num_rows) {
                $this->manager->getDbHelper()->addRecord('layout_route', array(
                    'layout_id' => $product_layout_id,
                    'store_id'  => $store_id,
                    'route'     => 'product/product'
                ));
            }
        }

        foreach ($keys_to_persist as $value) {
            $this->manager->getDbSettingsHelper()->persistKey($value[0], $value[1], $value[2], $value[3]);
        }

        foreach ($settingsModels as $store_id => $model) {
            $model->setAndPersistScopeSettings('theme', $theme_settings[$store_id]);
        }

        return $this->sendJsonSuccess('The modules have been imported');
    }

    protected function importDemoData(array $import_stores)
    {
        foreach ($import_stores as $store_id => $import_settings) {

            if ($import_settings['design'] == '0') {
                continue;
            }

            $demo_dir = $this->context->getConfigDir() . '/data/demo_' . $import_settings['design'];

            $demo_content_file = $demo_dir . '/data_content.php';
            if (!file_exists($demo_content_file)) {
                $this->sendJsonError('Cannot find the sample data file: ' . $demo_content_file);

                return false ;
            }

            $import_data = unserialize(base64_decode(file_get_contents($demo_content_file)));
            if ($this->manager->gteOc2()) {
                $import_data = json_decode(str_replace('data\/sample_data\/', 'catalog\/sample_data\/', json_encode($import_data)), true);
            }
            foreach ($import_data['content'] as $key => $data) {
                $this->manager->getBuilderSettingsModel()->persistCustomSettings($data, $key, $store_id);
            }

            foreach ($import_data['sliders'] as $key => $data) {
                $this->manager->getTbSettingsModelInstance('slider', 0)->persistCustomSettings($data, $key);
            }

            $settings = $this->manager->getSettingsModelInstance($store_id)->getScopeSettings('theme', true);
            $settings['area_keys'] = $import_data['area_keys'];
            $settings['store_id'] = $store_id;
            $this->manager->getSettingsModelInstance($store_id)->persistCustomSettings($settings, 'theme');

            $logo_path = ($this->manager->gteOc2() ? 'catalog/' : 'data/') . 'sample_data/' . ($import_settings['design'] != 'default' ? $import_settings['design'] : 'pavilion');
            $this->manager->getDbSettingsHelper()->persistGroup('config', array('config_logo' => $logo_path . '_logo.png'), $store_id);
        }

        $data_sql_file = $this->context->getConfigDir() . '/data/demo_sql.php';
        if (!file_exists($data_sql_file)) {
            $this->sendJsonError('Cannot find the default demo sql file: ' . $data_sql_file);

            return false;
        }

        $tables_to_truncate = array(
            'category', 'category_description', 'category_filter', 'category_path', 'category_to_layout', 'customer',
            'coupon_product', 'filter', 'filter_description', 'filter_group', 'filter_group_description', 'information',
            'information_description', 'information_to_layout', 'layout', 'layout_route', 'manufacturer', 'option',
            'option_description', 'option_value', 'option_value_description', 'order', 'order_history', 'order_option',
            'order_product', 'order_recurring', 'order_recurring_transaction', 'order_total', 'product',
            'product_attribute', 'product_description', 'product_discount', 'product_filter', 'product_image',
            'product_option', 'product_option_value', 'product_related', 'product_special',  'product_to_category',
            'product_to_layout', 'return', 'return_history', 'review', 'url_alias'
        );
        $this->manager->getDbHelper()->truncateTable($tables_to_truncate);

        $sql = file($data_sql_file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        foreach ($sql as &$line) {
            if ($this->manager->gteOc2()) {
                $line = str_replace(', `option_value`', ', `value`', $line);
                $line = str_replace('data/sample_data/', 'catalog/sample_data/', $line);
            }
            if (DB_PREFIX) {
                $line = str_replace('INSERT INTO `', 'INSERT INTO `' . DB_PREFIX, $line);
            }
        }
        $this->manager->getDbHelper()->importSQL($sql);

        $this->manager->getDbHelper()->deleteRecord('attribute_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('attribute_group_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('banner_image_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('category_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('customer_group_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('custom_field_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('custom_field_value_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('filter_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('filter_group_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('information_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('length_class_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('option_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('option_value_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('order_status', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('product_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('return_action', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('return_reason', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('return_status', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('stock_status', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('voucher_theme_description', 'language_id <> 1');
        $this->manager->getDbHelper()->deleteRecord('weight_class_description', 'language_id <> 1');

        if ($this->manager->gteOc2()) {
            $this->manager->getDbHelper()->deleteRecord('recurring_description', 'language_id <> 1');
        } else {
            $this->manager->getDbHelper()->deleteRecord('profile_description', 'language_id <> 1');
        }

        $image_data = array('canon_eos_5d', 'hp', 'htc_touch_hd', 'imac', 'iphone', 'ipod_classic', 'ipod_nano', 'ipod_shuffle', 'ipod_touch', 'macbook', 'macbook_air', 'macbook_pro', 'nikon_d300', 'palm_treo_pro', 'samsung_tab', 'sony_vaio');
        $product_images_new = array();
        foreach ($this->manager->getOcDb()->query('SELECT * FROM ' . DB_PREFIX . 'product')->rows as $product_row) {
            $image = current($image_data);

            $image = $this->manager->gteOc2() ? 'catalog/demo/' . $image : 'data/demo/' . $image;
            $this->manager->getDbHelper()->updateRecord('product', array('image' => $image . '_1.jpg'), 'product_id = ' . $product_row['product_id']);

            $product_images = array();
            foreach ($this->manager->getOcDb()->query('SELECT * FROM ' . DB_PREFIX . 'product_image WHERE product_id = ' . $product_row['product_id'])->rows as $row) {
                $product_images[$row['product_id']][] = $row['product_image_id'];
            }

            foreach ($product_images as $product_id => $product_image_ids) {
                for ($i = 1; $i <= count($product_image_ids); $i++) {
                    $product_images_new[] = array($product_id, $image . '_' . ($i + 1) . '.jpg');
                }
            }

            if (false === next($image_data)) {
                reset($image_data);
            }
        }
        if (!empty($product_images_new)) {
            $this->manager->getDbHelper()->truncateTable(array('product_image'));
            $this->manager->getDbHelper()->addMultipleRecords('product_image', array('product_id', 'image'), $product_images_new);
        }
        foreach ($this->manager->getOcDb()->query('SELECT * FROM ' . DB_PREFIX . 'category')->rows as $category_row) {
            $image = current($image_data);
            $image = $this->manager->gteOc2() ? 'catalog/demo/' . $image : 'data/demo/' . $image;

            $this->manager->getDbHelper()->updateRecord('category', array('image' => $image . '_1.jpg'), 'category_id = ' . $category_row['category_id']);

            if (false === next($image_data)) {
                reset($image_data);
            }
        }

        $this->manager->getDbHelper()->truncateTable(array('language'));

        if (!$this->manager->gteOc2()) {
            $sql = "INSERT INTO `" . DB_PREFIX . "language`
                    (`language_id`, `name`, `code`, `locale`, `image`, `directory`, `filename`, `sort_order`, `status`)
                    VALUES (1, 'English', 'en', 'en_US.UTF-8,en_US,en-gb,english', 'gb.png', 'english', 'english', 1, 1);";
        } else {
            $sql = "INSERT INTO `" . DB_PREFIX . "language`
                    (`language_id`, `name`, `code`, `locale`, `image`, `directory`, `sort_order`, `status`)
                    VALUES (1, 'English', 'en', 'en_US.UTF-8,en_US,en-gb,english', 'gb.png', 'english', 1, 1);";
        }

        $this->manager->getDbHelper()->importSQL($sql);
        foreach ($import_stores as $store_id => $import_settings) {
            $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                'config_country_id' => 222,
                'config_zone_id'    => 3563,
                'config_language'   => 'en',
                'config_currency'   => 'USD'
            ), $store_id);
        }

        $this->manager->getEnabledLanguages(false);

        $tables_to_truncate = array('category_to_store', 'information_to_store', 'manufacturer_to_store', 'product_to_store');
        $this->manager->getDbHelper()->truncateTable($tables_to_truncate);

        $category_ids     = array_column($this->getModel('category')->getAllCategories(), 'category_id');
        $information_ids  = array_column($this->getModel()->getAllInformationPages(), 'information_id');
        $manufacturer_ids = array_column($this->getModel()->getAllManufacturers(), 'manufacturer_id');
        $product_ids      = array_column($this->getModel()->getAllProducts(), 'product_id');

        foreach ($import_stores as $store_id => $import_settings) {
            $category_to_store_data = $this->arrayAddColumn('store_id', $store_id, 'category_id', $category_ids);
            $this->manager->getDbHelper()->addMultipleRecords('category_to_store', array('store_id', 'category_id'), $category_to_store_data);

            $information_to_store_data = $this->arrayAddColumn('store_id', $store_id, 'information_id', $information_ids);
            $this->manager->getDbHelper()->addMultipleRecords('information_to_store', array('store_id', 'information_id'), $information_to_store_data);

            $manufacturer_to_store_data = $this->arrayAddColumn('store_id', $store_id, 'manufacturer_id', $manufacturer_ids);
            $this->manager->getDbHelper()->addMultipleRecords('manufacturer_to_store', array('store_id', 'manufacturer_id'), $manufacturer_to_store_data);

            $product_to_store_data = $this->arrayAddColumn('store_id', $store_id, 'product_id', $product_ids);
            $this->manager->getDbHelper()->addMultipleRecords('product_to_store', array('store_id', 'product_id'), $product_to_store_data);
        }

        $this->importStoriesData($import_stores);

        return $this->sendJsonSuccess('Data imported');
    }

    protected function importStoriesData(array $import_stores)
    {
        if ($this->manager->getDbSettingsHelper()->getKey('stories_settings', 0, 'stories')) {
            $tables_to_truncate = array('story', 'story_description', 'story_tag', 'story_to_layout', 'story_to_store', 'story_to_tag');
            $this->manager->getDbHelper()->truncateTable($tables_to_truncate);
        } else {
            if ($this->manager->gteOc2()) {
                $this->manager->getOcModel('extension/extension')->install('module', 'stories');
            } else {
                $this->manager->getOcModel('setting/extension')->install('module', 'stories');
            }

            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'access', 'module/stories');
            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'access', 'stories/index');
            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'access', 'stories/tag');
            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'access', 'stories/module');

            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'modify', 'module/stories');
            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'modify', 'stories/index');
            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'modify', 'stories/tag');
            $this->manager->getOcModel('user/user_group')->addPermission($this->manager->getOcUser()->getId(), 'modify', 'stories/module');

            $this->manager->getOcModel('stories/system')->install();
        }

        $data_sql_file = $this->context->getConfigDir() . '/data/demo_stories_sql.php';
        if (!file_exists($data_sql_file)) {
            $this->sendJsonError('Cannot find the default demo sql file: ' . $data_sql_file);

            return false;
        }

        $sql = file($data_sql_file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        foreach ($sql as &$line) {
            if ($this->manager->gteOc2()) {
                $line = str_replace('data/sample_data/', 'catalog/sample_data/', $line);
            }
            if (DB_PREFIX) {
                $line = str_replace('INSERT INTO `', 'INSERT INTO `' . DB_PREFIX, $line);
            }
        }
        $this->manager->getDbHelper()->importSQL($sql);

        $story_ids = array_column($this->getOcModel('stories/index')->getStories(), 'story_id');
        $stories_settings = unserialize('a:13:{s:4:"lang";a:2:{i:1;a:3:{s:10:"page_title";s:4:"Blog";s:10:"meta_title";s:4:"Blog";s:16:"meta_description";s:0:"";}i:3;a:3:{s:10:"page_title";s:0:"";s:10:"meta_title";s:0:"";s:16:"meta_description";s:0:"";}}s:16:"stories_per_page";i:2;s:7:"keyword";s:4:"blog";s:12:"auto_seo_url";i:1;s:18:"thumbnail_position";s:3:"top";s:10:"text_limit";i:400;s:16:"image_list_width";i:800;s:17:"image_list_height";i:320;s:23:"image_description_width";i:800;s:24:"image_description_height";i:480;s:8:"comments";s:6:"disqus";s:16:"disqus_shortname";s:9:"themeburn";s:12:"social_share";s:0:"";}');

        foreach ($import_stores as $store_id => $import_settings) {
            $story_to_store_data = $this->arrayAddColumn('store_id', $store_id, 'story_id', $story_ids);
            $this->manager->getDbHelper()->addMultipleRecords('story_to_store', array('store_id', 'story_id'), $story_to_store_data);

            $this->manager->getDbSettingsHelper()->persistKey('stories_settings', $store_id, 'stories', $stories_settings);
        }
    }

    public function importDemoSettings(array $import_stores, $is_existing)
    {
        if (!$this->validate()) {
            $this->sendJsonError($this->error['warning']);

            return;
        }

        foreach ($import_stores as $store_id => $import_settings) {

            if ($import_settings['design'] == '0') {
                continue;
            }

            $demo_dir = $this->context->getConfigDir() . '/data/demo_' . $import_settings['design'];

            $demo_settings_file =  $demo_dir . '/data_settings.php';
            if (!file_exists($demo_settings_file)) {
                $this->sendJsonError('Cannot find the sample data file: ' . $demo_settings_file);
                return false;
            }

            $import_data = unserialize(base64_decode(file_get_contents($demo_settings_file)));
            if ($this->manager->gteOc2()) {
                $import_data = json_decode(str_replace('data\/sample_data\/', 'catalog\/sample_data\/', json_encode($import_data)), true);
            }

            if ($is_existing) {
                $theme_settings = $this->manager->getSettingsModelInstance($store_id)->getScopeSettings('theme', true);
                if (empty($theme_settings)) {
                    $theme_settings = $this->extension->installDefaultSettings($store_id);
                }

                foreach ($import_data['settings']['area_settings_keys'] as $key => $value) {
                    /*
                     * remove all concrete category and layout settings
                    foreach (array('footer', 'content', 'intro', 'column_left', 'column_right') as $area_name) {
                        if (strpos($key, $area_name . '_category_') === 0 && is_numeric(substr($key, strlen($area_name . '_category_')))) {
                            unset($import_data['settings']['area_settings_keys'][$key]);
                        }
                        if (strpos($key, $area_name . '_layout_') === 0 && is_numeric(substr($key, strlen($area_name . '_layout_')))) {
                            unset($import_data['settings']['area_settings_keys'][$key]);
                        }
                    }
                    */
                }

                $settings_keys = array();

                if ($import_settings['design'] == 'default') {
                    $settings_keys = array('footer_global', 'intro_global', 'content_global', 'content_home', 'content_category_global', 'content_system_product/search', 'content_system_product/special', 'content_system_product/manufacturer/info', 'content_system_category/manufacturer');
                } else
                if ($import_settings['design'] == 'stylish') {
                    $settings_keys = array('footer_global', 'intro_global', 'content_global', 'content_category_global', 'content_layout_2', 'content_system_product/search', 'content_system_product/special', 'content_system_product/manufacturer/info', 'content_system_category/manufacturer');
                } else
                if ($import_settings['design'] == 'dark') {
                    $settings_keys = array('footer_global', 'intro_global', 'content_global', 'content_home', 'content_category_global', 'content_system_product/search', 'content_system_product/special', 'content_system_product/manufacturer/info', 'content_system_category/manufacturer');
                } else
                if ($import_settings['design'] == 'minimal') {
                    $settings_keys = array('footer_global', 'intro_global', 'content_global');
                } else
                if ($import_settings['design'] == 'shoppica') {
                    $settings_keys = array('footer_global', 'intro_global', 'content_global', 'content_category_global', 'content_layout_2', 'content_system_product/search', 'content_system_product/special', 'content_system_product/manufacturer/info', 'content_system_category/manufacturer');
                }

                foreach ($import_data['settings']['area_settings_keys'] as $key => $value) {
                    if (!in_array($key, $settings_keys)) {
                        unset($import_data['settings']['area_settings_keys'][$key]);
                        unset($import_data['tb_settings']['area_settings_' . $key]);
                    }
                }

                $import_data['settings']['area_keys'] = array_merge($import_data['settings']['area_keys'], $theme_settings['area_keys']);
                $import_data['settings']['area_settings_keys'] = array_merge($import_data['settings']['area_settings_keys'], $theme_settings['area_settings_keys']);
                $import_data['settings']['store_id'] = $store_id;
                $import_data['settings']['system']['compatibility_menu'] = 1;
                $import_data['settings']['store']['menu'] = array();

                unset($import_data['settings']['product']['designs']['layout']);
                unset($import_data['settings']['product']['designs']['option']);

                foreach ($import_data['content'] as $key => $data) {
                    $this->manager->getTbSettingsModelInstance('theme', $store_id)->persistCustomSettings($data, $key);
                }

                $import_data['settings']['system']['compatibility_jquery'] = 1;
                if (trim($import_data['settings']['common']['custom_css'])) {
                    $skin_css = TB_Utils::strGetBetween($import_data['settings']['common']['custom_css'], '/**** SKIN CUSTOM CSS ****/', '/**** END SKIN CUSTOM CSS ****/');
                    $import_data['settings']['common']['custom_css'] = '/**** ' . strtoupper($import_settings['design']) . ' SKIN CUSTOM CSS ****/' . "\n\n" . trim($skin_css);
                }
            }

            $this->manager->getThemeModel()->persistCustomSettings($import_data['settings'], $store_id);

            $settingsInstance = $this->manager->getTbSettingsModelInstance('theme', $store_id);
            foreach ($import_data['tb_settings'] as $key => $data) {
                $settingsInstance->persistCustomSettings($data, $key);
            }

            $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                'config_image_product_width'  => 350,
                'config_image_product_height' => 400,
                'config_image_cart_width'     => 70,
                'config_image_cart_height'    => 80
            ), $store_id);

            switch ($import_settings['design']) {
                case 'default':
                case 'minimal':
                    $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                        'config_image_category_width'  => 120,
                        'config_image_category_height' => 120,
                        'config_image_thumb_width'     => 525,
                        'config_image_thumb_height'    => 600,
                        'config_image_popup_width'     => 875,
                        'config_image_popup_height'    => 1000
                    ), $store_id);
                    break;
                case 'stylish':
                    $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                        'config_image_category_width'  => 120,
                        'config_image_category_height' => 120,
                        'config_image_thumb_width'     => 700,
                        'config_image_thumb_height'    => 800,
                        'config_image_popup_width'     => 1050,
                        'config_image_popup_height'    => 1200
                    ), $store_id);
                    break;
                case 'dark':
                    $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                        'config_image_category_width'  => 150,
                        'config_image_category_height' => 150,
                        'config_image_thumb_width'     => 525,
                        'config_image_thumb_height'    => 600,
                        'config_image_popup_width'     => 875,
                        'config_image_popup_height'    => 1000
                    ), $store_id);
                    break;
                case 'shoppica':
                    $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                        'config_image_category_width'  => 150,
                        'config_image_category_height' => 150,
                        'config_image_thumb_width'     => 700,
                        'config_image_thumb_height'    => 800,
                        'config_image_popup_width'     => 1050,
                        'config_image_popup_height'    => 1200
                    ), $store_id);
                    break;
            }
        }

        return $this->sendJsonSuccess('Demo settings have been imported');
    }

    protected function arrayAddColumn($column_key, $column_value, $array_key, array $array)
    {
        $result = array();

        foreach ($array as $value) {
            $result[] = array(
                $column_key => $column_value,
                $array_key  => $value
            );
        }

        return $result;
    }
}