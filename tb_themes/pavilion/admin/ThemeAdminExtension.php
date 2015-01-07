<?php

class Theme_Admin_Extension extends TB_AdminExtension
{
    protected $init_order = 0;

    /**
     * @var TB_ExtensionPluginBootstrap
     */
    protected $pluginBootstrapper;

    public function getConfig() {}

    public function configure()
    {
        $this->eventDispatcher->connect('core:extensions_preconfigure',  array($this, 'configurePlugins'));
        $this->eventDispatcher->connect('core:extensions_postconfigure', array($this, 'bootstrapPlugins'));
        $this->eventDispatcher->connect('core:admin_dispatch',           array($this, 'checkCurrentStoreSettings'));
        $this->eventDispatcher->connect('core:admin_dispatch',           array($this, 'afterRouting'));
        $this->eventDispatcher->connect('core:admin_module_install',     array($this, 'installTheme'));
        $this->eventDispatcher->connect('core:admin_module_uninstall',   array($this, 'uninstallTheme'));
    }

    public function configurePlugins()
    {
        $this->pluginBootstrapper = new TB_ExtensionPluginBootstrap($this->manager, $this);
        $this->pluginBootstrapper->configureAll();
    }

    function afterRouting()
    {
        $languages = $this->manager->getEnabledLanguages();
        $language_ids = array();
        foreach ($languages as $language) {
            $language_ids[] = $language['id'];
        }

        $this->themeData->manufacturers = $this->manager->getOcModel('catalog/manufacturer')->getManufacturers();
        $this->themeData->gteOc2 = $this->manager->gteOc2();

        $js_manufacturers = array();
        foreach ($this->themeData->manufacturers as $manufacturer) {
            $js_manufacturers[] = array(
                'id'   => $manufacturer['manufacturer_id'],
                'name' => $manufacturer['name']
            );
        }

        $this->themeData->user = $this->manager->getOcUser();
        $this->themeData->admin_javascript_url = $this->context->getAdminJavascriptUrl();
        $this->themeData->fileManagerUrl = $this->manager->gteOc2() ? $this->getTbUrl()->generateJs('default/fileManager') : 'index.php?route=common/filemanager&token=' . $this->themeData['token'];

        $this->themeData->addJavascriptVar('tb/Theme-Machine-Name',                $this->manager->getThemeMachineName());
        $this->themeData->addJavascriptVar('tb/languages',                         $languages);
        $this->themeData->addJavascriptVar('tb/language_ids',                      $language_ids);
        $this->themeData->addJavascriptVar('tb/manufacturers',                     $js_manufacturers);
        $this->themeData->addJavascriptVar('tb/no_image',                          $this->getModel()->getNoImage());
        $this->themeData->addJavascriptVar('tb/url/storeUrl',                      $this->context->getStoreUrl());
        $this->themeData->addJavascriptVar('tb/url/baseHttpsIf',                   $this->context->getBaseHttpsIf());
        $this->themeData->addJavascriptVar('tb/url/theme_admin_javascript_url',    $this->context->getThemeAdminJavascriptUrl());
        $this->themeData->addJavascriptVar('tb/url/image_url',                     $this->context->getImageUrl());
        $this->themeData->addJavascriptVar('tb/url/fileManager',                   $this->themeData->fileManagerUrl);
        $this->themeData->addJavascriptVar('tb/url/fonts/getFontData',             $this->getTbUrl()->generateJs('fonts/getFontData'));
        $this->themeData->addJavascriptVar('tb/url/fonts/getFontsList',            $this->getTbUrl()->generateJs('fonts/getFontsList'));
        $this->themeData->addJavascriptVar('tb/url/icon/getList',                  $this->getTbUrl()->generateJs('icon/getList'));
        $this->themeData->addJavascriptVar('tb/url/style/renderSection',           $this->getTbUrl()->generateJs('style/renderSection'));
        $this->themeData->addJavascriptVar('tb/url/getLivePreviewToken',           $this->getTbUrl()->generateJs('default/getLivePreviewToken'));
        $this->themeData->addJavascriptVar('tb/url/getImagePath',                  $this->getTbUrl()->generateJs('default/getImagePath'));
        $this->themeData->addJavascriptVar('tb/url/getCategoryFlatTreeJSON',       $this->getTbUrl()->generateJs('default/getCategoryFlatTreeJSON'));
        $this->themeData->addJavascriptVar('tb/url/layoutBuilder/areaBuilder',     $this->getTbUrl()->generateJs('layoutBuilder/areaBuilder'));
        $this->themeData->addJavascriptVar('tb/url/layoutBuilder/modifiedMenu',    $this->getTbUrl()->generateJs('layoutBuilder/modifiedMenu'));
        $this->themeData->addJavascriptVar('tb/url/layoutBuilder/systemBlocks',    $this->getTbUrl()->generateJs('layoutBuilder/systemBlocks'));
        $this->themeData->addJavascriptVar('tb/url/layoutBuilder/removeSettings',  $this->getTbUrl()->generateJs('layoutBuilder/removeSettings'));
        $this->themeData->addJavascriptVar('tb/url/layoutBuilder/getNewWidgetRow', $this->getTbUrl()->generateJs('layoutBuilder/getNewWidgetRow'));
        $this->themeData->addJavascriptVar('tb/url/layoutBuilder/saveRows',        $this->getTbUrl()->generateJs('layoutBuilder/saveRows'));
        $this->themeData->addJavascriptVar('tb/url/adminBase',                     $this->context->getAdminBaseUrl());
        $this->themeData->addJavascriptVar('tb/auth_token',                        $this->themeData->token);
    }

    public function installTheme()
    {
        if (!$this->checkInstallRequirements()) {
            TB_RequestHelper::redirect($this->getTbUrl()->generate('default'));
        }

        $dbHelper = $this->manager->getDbHelper();

        $sql = 'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'tb_setting` (
                  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
                  `store_id` smallint(6) unsigned NOT NULL,
                  `group` varchar(32) NOT NULL,
                  `key` varchar(128) NOT NULL,
                  `value` longtext NOT NULL,
                  `serialized` tinyint(4) NOT NULL,
                  PRIMARY KEY (`setting_id`),
                  KEY `theme_name` (`group`,`key`)
               ) ENGINE=MyISAM COLLATE=utf8_general_ci;';
        $dbHelper->getDb()->query($sql);

        $dbHelper->getDb()->query('ALTER TABLE `' . DB_PREFIX . 'setting` CHANGE `value` `value` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL');

        $indexes = array(
            'product'             => 'manufacturer_id',
            'category'            => 'parent_id',
            'category_to_store'   => 'category_id',
            'product_to_category' => 'category_id'
        );
        foreach ($indexes as $table => $index) {
            if (!$dbHelper->getDb()->query('SHOW INDEX FROM `' . DB_PREFIX . $table . '` WHERE KEY_NAME = "' . $index . '"')->num_rows) {
                $dbHelper->getDb()->query('ALTER TABLE `' . DB_PREFIX . $table . '` ADD INDEX (`' . $index . '`)');
            }
        }

        if (!$this->manager->getThemeModel()->getLayoutIdByName('TB_Widgets')) {
            $dbHelper->addRecord('layout', array(
                'name' => 'TB_Widgets'
            ));
        }

        if (!$dbHelper->getDb()->query('SELECT * FROM `' . DB_PREFIX . 'layout_route` WHERE route = "product/manufacturer/info"')->rows) {
            $dbHelper->addRecord('layout', array(
                'name' => 'Manufacturer Info'
            ));
            $layout_id = $dbHelper->getLastId();

            foreach ($this->manager->getThemeModel()->getAllStores() as $store) {
                $dbHelper->addRecord('layout_route', array(
                    'layout_id' => $layout_id,
                    'store_id'  => $store['store_id'],
                    'route'     => 'product/manufacturer/info'
                ));
            }
        }

        foreach ($this->manager->getThemeModel()->getAllStores() as $store) {
            if ($store['store_id'] == 0 || $this->manager->getDbSettingsHelper()->getKey('config_template', $store['store_id'], 'config') == $this->manager->getThemeMachineName()) {
                $this->checkStoreSettings($store['store_id']);
                $this->manager->getDbSettingsHelper()->persistKey('config_product_count', $store['store_id'], 'config', 0);
            }
        }

        if ($this->manager->gteOc2()) {
            $this->installOc2();
        } else {
            TB_RequestHelper::redirect($this->getTbUrl()->generate('default'));
        }
    }

    protected function checkInstallRequirements()
    {
        $errors = array();

        if ($this->manager->gteOc2() && !is_writable(DIR_SYSTEM . 'modification')) {
            $errors[] = 'The folder <strong>' . DIR_SYSTEM . 'modification</strong> needs to be writable for OpenCart to work. Please change its permissions to 777';
        }

        if (!empty($errors)) {
            $this->manager->getSettingsModelInstance()->setAndPersistScopeSettings('theme', array('install_errors' => $errors));

            return false;
        }

        return true;
    }

    protected function installOc2()
    {
        $xml = file_get_contents($this->context->getConfigDir() . '/data/theme.ocmod.xml');
        $dom = new DOMDocument('1.0', 'UTF-8');
        $dom->loadXml($xml);

        $data = array(
            'name'    => $dom->getElementsByTagName('name')->item(0)->nodeValue,
            'author'  => $dom->getElementsByTagName('author')->item(0)->nodeValue,
            'version' => $this->manager->getThemeVersion(),
            'link'    => $dom->getElementsByTagName('link')->item(0)->nodeValue,
            'status'  => 1,
            'xml'     => $xml,
            'code'    => $this->context->getBasename() . '_default'
        );

        $this->manager->getOcModel('extension/modification')->addModification($data);

        $_SESSION['tb_redirect'] = 'module/' . $this->context->getBasename();
        $this->manager->getThemeExtension()->loadController('extension/modification/refresh');
    }

    public function uninstallTheme()
    {
        $this->manager->wipeAllCache();
        TB_ClassCacheGenerator::deleteCache();

        foreach ($this->manager->getOcModel('setting/store')->getStores() as $store) {
            $this->manager->getSettingsModelInstance($store['store_id'])->deleteScopeSettings('theme');
        }

        $this->manager->getOcDb()->query('DELETE FROM `' . DB_PREFIX . 'tb_setting` WHERE `group` LIKE "%' . $this->manager->getThemeMachineName() . '"');

        if (!$this->manager->getOcDb()->query('SELECT setting_id FROM `' . DB_PREFIX . 'tb_setting`')->num_rows) {

            $this->manager->getOcDb()->query('DROP TABLE IF EXISTS `' . DB_PREFIX . 'tb_setting`');

            $indexes = array(
                'product'             => 'manufacturer_id',
                'category'            => 'parent_id',
                'category_to_store'   => 'category_id',
                'product_to_category' => 'category_id'
            );

            foreach ($indexes as $table => $index) {
                if ($this->manager->getOcDb()->query('SHOW INDEX FROM `' . DB_PREFIX . $table . '` WHERE KEY_NAME = "' . $index . '"')->num_rows) {
                    $this->manager->getOcDb()->query('ALTER TABLE `' . DB_PREFIX . $table . '` DROP INDEX `' . $index . '`');
                }
            }
        }

        $this->manager->getDbHelper()->deleteRecord('layout', array('name' => 'TB_Widgets'));

        if ($this->manager->gteOc2()) {
            $mods = $this->manager->getDbHelper()->getRecords('modification', array('code' => $this->context->getBasename() . '_default'));
            foreach ($mods as $mod) {
                $this->manager->getOcModel('extension/modification')->deleteModification((int) $mod['modification_id']);
            }

            // Clear all modification files
            foreach(new RecursiveIteratorIterator(new RecursiveDirectoryIterator(DIR_MODIFICATION, FilesystemIterator::SKIP_DOTS), RecursiveIteratorIterator::CHILD_FIRST) as $path) {
                $path->isDir() ? rmdir($path->getPathname()) : (basename($path->getPathname()) != 'index.html' && unlink($path->getPathname()));
            }

            $this->themeData->disable_redirect = true;
            $this->manager->getThemeExtension()->loadController('extension/modification/refresh');
            $this->themeData->disable_redirect = false;
        }
    }

    public function checkCurrentStoreSettings()
    {
        $this->checkStoreSettings($this->context->getStoreId());
    }

    public function checkStoreSettings($store_id)
    {
        $settings = $this->manager->getSettingsModelInstance($store_id)->getScopeSettings('theme', true);
        if (empty($settings)) {
            $this->installDefaultSettings($store_id);
            $this->manager->wipeAllCache();
            TB_ClassCacheGenerator::deleteCache($store_id);
            $this->getModel('layoutBuilder')->rebuildDefaultAreaSettings();
        }
    }

    public function installDefaultSettings($store_id)
    {
        $default_file = $this->context->getConfigDir() . '/data/install_data.php';
        if (!file_exists($default_file)) {
            throw new Exception('Cannot find the default initialization data file: ' . $default_file);
        }

        $default_data = unserialize(base64_decode(file_get_contents($default_file)));
        $theme_settings = $default_data['theme_settings'];

        $theme_settings['first_time'] = 1;
        $theme_settings['store_id'] = $store_id;

        $language_id = $this->manager->getDefaultCatalogLanguage('id');

        if ($language_id != 1) {
            $theme_settings['font'] = array(
                $language_id => $theme_settings['font'][1]
            );

            $theme_settings['twitter'] = array(
                $language_id => $theme_settings['twitter'][1]
            );

            $theme_settings['facebook'] = array(
                $language_id => $theme_settings['facebook'][1]
            );
        }

        $this->manager->getSettingsModelInstance($store_id)->setAndPersistScopeSettings('theme', $theme_settings);

        foreach ($default_data['content'] as $key => $data) {
            $this->manager->getTbSettingsModelInstance('theme', $store_id)->persistCustomSettings($data, $key);
        }

        return $theme_settings;
    }

    public function getInitOptions()
    {
        return false;
    }

    public function bootstrapPlugins()
    {
        $this->pluginBootstrapper->bootstrapAll();
        $theme_settings = $this->getModel()->getSettings();
        if (empty($theme_settings)) {
            $theme_settings = array();
        }
        $this->filterThemeSettings($theme_settings);
        $this->getModel()->setSettings($theme_settings);
        $this->setPluginsViewData($theme_settings);
        $this->themeData['theme_settings'] = $theme_settings;
    }

    public function filterThemeSettings(array &$data)
    {
        foreach ($this->pluginBootstrapper->getPlugins() as $plugin) {
            if ($plugin instanceof TB_AdminDataPlugin) {
                if  (!isset($data[$plugin->getConfigKey()])) {
                    $data[$plugin->getConfigKey()] = array();
                }
                $plugin->filterSettings($data[$plugin->getConfigKey()]);
            }
        }
    }

    public function setPluginsViewData(array &$data)
    {
        foreach ($this->pluginBootstrapper->getPlugins() as $plugin) {
            if ($plugin instanceof TB_AdminDataPlugin && isset($data[$plugin->getConfigKey()])) {
                $plugin->setDataForView($data[$plugin->getConfigKey()], $this->themeData);
            } else
            if (method_exists($plugin, 'setDataForView')) {
                $plugin->setDataForView($data, $this->themeData);
            }
        }
    }

    /**
     * @return array|TB_ExtensionPlugin[]
     */
    public function getPlugins()
    {
        return $this->pluginBootstrapper->getPlugins();
    }

    /**
     * @param string $name
     * @return TB_ExtensionPlugin
     */
    public function getPlugin($name)
    {
        return $this->pluginBootstrapper->getPlugin($name);
    }

    public function loadDefaultTranslation()
    {
        return $this->loadTranslation('theme');
    }
}