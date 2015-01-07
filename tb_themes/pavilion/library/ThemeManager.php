<?php

require_once TB_THEME_ROOT . '/library/vendor/sfFinder.php';
require_once TB_THEME_ROOT . '/library/vendor/sfEventDispatcher.php';
require_once TB_THEME_ROOT . '/library/vendor/MathFraction.php';
require_once TB_THEME_ROOT . '/library/vendor/JShrinkMinifier.php';

require_once TB_THEME_ROOT . '/library/Get.php';
require_once TB_THEME_ROOT . '/library/Utils.php';
require_once TB_THEME_ROOT . '/library/Cache.php';
require_once TB_THEME_ROOT . '/library/Widget.php';
require_once TB_THEME_ROOT . '/library/Context.php';
require_once TB_THEME_ROOT . '/library/DataBag.php';
require_once TB_THEME_ROOT . '/library/DbHelper.php';
require_once TB_THEME_ROOT . '/library/ViewSlot.php';
require_once TB_THEME_ROOT . '/library/Extension.php';
require_once TB_THEME_ROOT . '/library/Controller.php';
require_once TB_THEME_ROOT . '/library/FormHelper.php';
require_once TB_THEME_ROOT . '/library/WidgetsArea.php';
require_once TB_THEME_ROOT . '/library/ViewDataBag.php';
require_once TB_THEME_ROOT . '/library/StyleBuilder.php';
require_once TB_THEME_ROOT . '/library/ColorSchemer.php';
require_once TB_THEME_ROOT . '/library/RequestHelper.php';
require_once TB_THEME_ROOT . '/library/SettingsModel.php';
require_once TB_THEME_ROOT . '/library/WidgetManager.php';
require_once TB_THEME_ROOT . '/library/ResourceLoader.php';
require_once TB_THEME_ROOT . '/library/ExtensionModel.php';
require_once TB_THEME_ROOT . '/library/DummyController.php';
require_once TB_THEME_ROOT . '/library/ExtensionPlugin.php';
require_once TB_THEME_ROOT . '/library/DbSettingsHelper.php';
require_once TB_THEME_ROOT . '/library/ImageManipulator.php';
require_once TB_THEME_ROOT . '/library/StaticThemeManager.php';
require_once TB_THEME_ROOT . '/library/ExtensionPluginBootstrap.php';

class TB_ThemeManager
{
    protected static $instances = array();

    /**
     * @var TB_DbSettingsHelper
     */
    protected static $dbSettingsHelper;

    /*
     * @var TB_DbHelper
     */
    protected static $dbHelper;

    /**
     * @var TB_WidgetManager
     */
    protected static $widgetManager;

    /**
     * @var TB_EnvHelper
     */
    protected static $envHelper;

    /**
     * @var TB_Cache
     */
    protected static $cache;

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var TB_SettingsModel
     */
    protected $settingsModel;

    /**
     * @var TB_SettingsModel
     */
    protected $builderSettingsModel;

    /**
     * @var Registry OpenCart registry
     */
    protected $registry;

    /**
     * @var TB_ResourceLoader
     */
    protected $resourceLoader;

    /**
     * @var TB_Extension
     */
    protected $themeExtension;

    /**
     * @var TB_DataBag
     */
    protected $routesBag;

    /**
     * @var TB_ViewDataBag
     */
    protected $themeData;

    /**
     * @var array
     */
    protected $theme_config;

    /**
     * @var TB_Extension[]
     */
    protected $extensions = array();

    /**
     * @var TB_Extension[]
     */
    protected $notInstalledExtensions = array();

    /**
     * @var array
     */
    protected $oc_translations = array();

    protected function __construct(TB_Context $context, Registry $registry, array $theme_config)
    {
        $this->registry     = $registry;
        $this->context      = $context;
        $this->theme_config = $theme_config;

        if (empty(self::$instances)) {
            self::$dbHelper         = new TB_DbHelper($registry->get('db'), DB_PREFIX, $context->getBasename());
            self::$dbSettingsHelper = new TB_DbSettingsHelper(self::$dbHelper);
            self::$widgetManager    = new TB_WidgetManager($this);
            self::$cache            = new TB_Cache($this->context->getTbCacheDir(), $theme_config['default_cache'], $context->getBasename());
            self::$envHelper        = TB_EnvHelper::getInstance($registry);

            if ($this->gteOc2()) {
                self::$dbSettingsHelper->setGroupFieldName('code');
            }
        }

        $this->eventDispatcher = new sfEventDispatcher();
        $this->resourceLoader  = new TB_ResourceLoader($context, $registry, $theme_config);
        $this->themeData       = new TB_ViewDataBag($context, new TB_ViewSlot($this->eventDispatcher));
        $this->routesBag       = new TB_DataBag();
        $this->settingsModel   = $this->getSettingsModelInstance();

        TB_StaticThemeManager::set($this);
    }

    /**
     * @param TB_Context $context
     *
     * @param Registry $registry
     * @param array $theme_config
     *
     * @return TB_ThemeManager
     */
    public static function getInstance(TB_Context $context, Registry $registry, array $theme_config)
    {
        $area = $context->getArea();
        if (!isset(self::$instances[$area])) {
            self::$instances[$area] = new self($context, $registry, $theme_config);
        }

        return self::$instances[$area];
    }

    /**
     * @param $namespace
     * @param null|int $store_id
     * @return TB_SettingsModel
     */
    public function getTbSettingsModelInstance($namespace, $store_id = null)
    {
        static $models = array();
        static $dbSettingsHelper = null;

        if  (null === $dbSettingsHelper) {
            $dbSettingsHelper = new TB_DbSettingsHelper(self::$dbHelper, 'tb_setting');
        }

        if (null === $store_id) {
            $store_id = $this->context->getStoreId();
        }

        $hash = $namespace . '_' . $store_id;

        if (!isset($models[$hash])) {
            $settings_group = $namespace . '_' . $this->context->getBasename();

            if (null === $store_id) {
                $store_id = $this->context->getStoreId();
            }

            $models[$hash] = new TB_SettingsModel($dbSettingsHelper, $settings_group, $store_id);
        }

        return $models[$hash];
    }


    /**
     * @param null|int $store_id
     * @return TB_SettingsModel
     */
    public function getSettingsModelInstance($store_id = null)
    {
        static $models = array();

        if (null === $store_id) {
            $store_id = $this->context->getStoreId();
        }

        $namespace = $this->context->getBasename();
        $hash = $namespace . '_' . $store_id;

        if (!isset($models[$hash])) {
            $models[$hash] = new TB_SettingsModel(self::$dbSettingsHelper, $namespace, $store_id, $namespace);
        }

        return $models[$hash];
    }

    public function boot()
    {
        if (!empty($this->extensions)) {
            // Already booted
            return $this;
        }

        if ($this->getOcConfig()->get('theme_' . $this->context->getBasename())) {
            $this->settingsModel->setScopeSettings('theme', $this->getOcConfig()->get('theme_' . $this->context->getBasename()));
        }
        $this->settingsModel->setScopeSettings('extensions', $this->getOcConfig()->get('extensions'));
        $this->builderSettingsModel = $this->getTbSettingsModelInstance('theme');

        $resourceLoader = $this->resourceLoader;
        $this->initThemeData();

        $theme_extension_class = $resourceLoader->loadThemeExtensionClass();
        list($theme_name, $theme_class) = each($theme_extension_class);

        /** @var $themeExtension TB_Extension */
        $themeExtension = new $theme_class($this, $theme_name);
        $themeExtension->setThemeData($this->themeData);
        $themeExtension->loadDefaultTranslation();
        $themeExtension->init();
        $themeExtension->configure();

        $this->themeExtension = $themeExtension;

        $this->eventDispatcher->notify(new sfEvent($this, 'core:extensions_preconfigure'));

        $notInstalledExtensions = array();
        $installedExtensions = array();
        $extensions_classes = $resourceLoader->loadExtensionClasses();

        foreach ($extensions_classes as $name => $class) {
            /** @var $extension TB_Extension */
            $extension = new $class($this, $name);
            $extension->loadDefaultTranslation();
            /** @var $extensionsModel Theme_ExtensionsModel */
            $extensionsModel = $themeExtension->getModel('extensions');
            if (!$extensionsModel->isExtensionInstalled($name) && !$extension->isCoreExtension()) {
                $notInstalledExtensions[$name] = $extension;
            } else {
                $installedExtensions[$extension->getInitOrder() . '-' . TB_Utils::genRandomString()] = $extension;
            }
        }

        $this->notInstalledExtensions = $notInstalledExtensions;
        ksort($installedExtensions);

        foreach ($installedExtensions as $extension) {
            $extension->setThemeData($this->themeData);
            $extension->configure();
            $event = new sfEvent($this, 'core:extension_postconfigure.' . $extension->getName(), array('extension' => $extension));
            $this->eventDispatcher->notify($event);
            $this->extensions[$extension->getName()] = $extension;
        }

        $this->eventDispatcher->notify(new sfEvent($this, 'core:extensions_postconfigure'));

        return $this;
    }

    protected function initThemeData()
    {
        $context = $this->context;

        $init_vars['root_dir']        = $context->getRootDir();
        $init_vars['current_url']     = $context->getRequestUrl();
        $init_vars['current_baseurl'] = $context->getCurrentBaseUrl();
        $init_vars['image_url']       = $context->getImageUrl();
        $init_vars['base_http']       = $context->getBaseHttp();
        $init_vars['base_https']      = $context->getBaseHttps();
        $init_vars['base_httpsIf']    = $context->getBaseHttpsIf();
        $init_vars['basename']        = $context->getBasename();
        $init_vars['store_id']        = $context->getStoreId();
        $init_vars['theme_name']      = $this->getThemeMachineName();
        $init_vars['token']           = isset($this->getOcSession()->data['token']) ? $this->getOcSession()->data['token'] : null;
        $init_vars['isHTTPS']         = TB_RequestHelper::isRequestHTTPS();

        $init_vars['theme_catalog_resource_url']   = $context->getThemeCatalogResourceUrl();
        $init_vars['theme_catalog_image_url']      = $context->getThemeCatalogImageUrl();
        $init_vars['theme_catalog_stylesheet_url'] = $context->getThemeCatalogStylesheetUrl();
        $init_vars['theme_catalog_javascript_url'] = $context->getThemeCatalogJavascriptUrl();

        $init_vars['theme_admin_resource_url']   = $context->getThemeAdminResourceUrl();
        $init_vars['theme_admin_image_url']      = $context->getThemeAdminImageUrl();
        $init_vars['theme_admin_font_url']       = $context->getThemeAdminFontUrl();
        $init_vars['theme_admin_stylesheet_url'] = $context->getThemeAdminStylesheetUrl();
        $init_vars['theme_admin_javascript_url'] = $context->getThemeAdminJavascriptUrl();
        $init_vars['theme_admin_javascript_relative_url'] = $context->getThemeAdminJavascriptUrl(true);

        $this->themeData->importVars($init_vars);
    }

    public function updateThemeDataAfterRouting(TB_Extension $extension)
    {
        static $booted = false;

        if ($booted) {
            throw new Exception('The theme data can be updated only once after routing');
        }

        if ($extension->isThemeExtension()) {
            $init_vars['extension_catalog_resource_url'] = $this->context->getThemeCatalogResourceUrl();
            $init_vars['extension_admin_resource_url']   = $this->context->getThemeAdminResourceUrl();
        } else {
            $extension_url = $this->context->getExtensionsUrl() . $extension->getName() . '/';
            $init_vars['extension_catalog_resource_url'] = $extension_url . 'catalog/view/';
            $init_vars['extension_admin_resource_url']   = $extension_url . 'admin/view/';
        }

        $booted = true;

        $this->themeData->importVars($init_vars);
    }

    /**
     * @param $key
     * @param null $callback
     * @param array $args
     * @param null $expire
     * @return mixed|null
     * @throws Exception
     */
    public function getCacheVar($key, $callback = null, array $args = array(), $expire = null, $eager = false)
    {
        if (!$eager && !$this->themeData['system']['cache_enabled']) {
            return null !== $callback ? call_user_func_array($callback, $args) : null;
        }

        $result = self::$cache->get($key);
        if (empty($result)) {

            if (null === $callback) {
                return null;
            }

            if (is_callable($callback, false, $callable_name)) {
                $result = call_user_func_array($callback, $args);
                $this->setCacheVar($key, $result, $expire);
            } else {
                throw new Exception('Invalid callback supplied: ' . $callable_name);
            }
        }

        return $result;
    }

    public function setCacheVar($key, $var, $expire = null, $keep_timestamp = false)
    {
        if ($this->themeData['system']['cache_enabled']) {
            self::$cache->set($key, $var, $expire, $keep_timestamp);
        }
    }

    public function wipeAllCache($pattern = '*', $brace = false)
    {
        $this->wipeVarsCache($pattern, $brace);
        $this->wipeStylesCache($pattern, $brace);
    }

    public function wipeVarsCache($pattern = '*', $brace = false)
    {
        $flags = GLOB_NOSORT;
        if ($brace) {
            $flags |= GLOB_BRACE;
        }

        $path = $this->context->getTbCacheDir() .'/';
        is_dir($path) && ($files = glob($path . 'cache.' . $pattern, $flags)) && array_map('unlink', array_filter($files, 'is_file'));

    }

    public function wipeStylesCache($pattern = '*', $brace = false)
    {
        $flags = GLOB_NOSORT;
        if ($brace) {
            $flags |= GLOB_BRACE;
        }

        $path = $this->context->getImageDir() . '/cache/tb/';
        is_dir($path) && ($files = glob($path . $pattern, $flags)) && array_map('unlink', array_filter($files, 'is_file'));
    }

    /**
     * @return TB_ViewDataBag
     */
    public function getThemeData()
    {
        return $this->themeData;
    }

    /**
     * @param null|string $key
     *
     * @return mixed
     */
    public function getThemeConfig($key = null)
    {
        if (null !== $key) {
            return $this->theme_config[$key];
        }

        return $this->theme_config;
    }

    /**
     * @return TB_Context
     */
    public function getContext()
    {
        return $this->context;
    }

    /**
     * @return TB_DbHelper
     */
    public function getDbHelper()
    {
        return self::$dbHelper;
    }

    public function getResourceLoader()
    {
        return $this->resourceLoader;
    }

    /**
     * @return TB_SettingsModel
     */
    public function getSettingsModel()
    {
        return $this->settingsModel;
    }

    /**
     * @return TB_SettingsModel
     */
    public function getBuilderSettingsModel()
    {
        return $this->builderSettingsModel;
    }

    /**
     * @return TB_WidgetManager
     */
    public function getWidgetManager()
    {
        return self::$widgetManager;
    }

    /**
     * @return TB_DbSettingsHelper
     */
    public function getDbSettingsHelper()
    {
        return self::$dbSettingsHelper;
    }

    public function getExtensions()
    {
        return $this->extensions;
    }

    public function getCoreExtensions()
    {
        $result = array();

        foreach ($this->extensions as $extension) {
            if ($extension->isCoreExtension()) {
                $result[] = $extension;
            }
        }

        return $result;
    }

    /**
     * @param $name
     * @throws Exception
     * @return TB_Extension
     */
    public function getExtension($name)
    {
        if ($name == $this->context->getBasename() || $name == 'theme') {
            return $this->themeExtension;
        }

        if (!isset($this->extensions[$name])) {
            throw new Exception('The following extension does not exists: ' . $name);
        }

        return $this->extensions[$name];
    }

    /**
     * @param $name
     * @return TB_ExtensionModel
     * @throws Exception
     */
    public function getExtensionModel($name)
    {
        $parts = explode('/', $name);

        if (2 != count($parts)) {
            $parts[1] = 'default';
        }

        return $this->getExtension($parts[0])->getModel($parts[1]);
    }

    /**
     * @return TB_Extension
     */
    public function getThemeExtension()
    {
        return $this->themeExtension;
    }

    /**
     * @param $name
     *
     * @return bool
     */
    public function isExtensionInstalled($name)
    {
        return isset($this->extensions[$name]);
    }

    /**
     * @return bool
     */
    public function isThemeExtensionLoaded()
    {
        return null !== $this->themeExtension;
    }

    public function getNotInstalledExtensions()
    {
        return $this->notInstalledExtensions;
    }

    /**
     * @return Registry
     */
    public function getOcRegistry()
    {
        return $this->registry;
    }

    /**
     * @return Cache
     */
    public function getOcCache()
    {
        return $this->registry->get('cache');
    }

    /**
     * @return Session
     */
    public function getOcSession()
    {
        return $this->registry->get('session');
    }

    /**
     * @return Request
     */
    public function getOcRequest()
    {
        return $this->registry->get('request');
    }

    /**
     * @return Response
     */
    public function getOcResponse()
    {
        return $this->registry->get('response');
    }

    /**
     * @param string|null $key
     * @return Config|mixed
     */
    public function getOcConfig($key = null)
    {
        if (null !== $key) {
            return $this->registry->get('config')->get($key);
        }

        return $this->registry->get('config');
    }

    /**
     * @return Cart
     */
    public function getOcCart()
    {
        return $this->registry->get('cart');
    }

    /**
     * @return Customer
     */
    public function getOcCustomer()
    {
        return $this->registry->get('customer');
    }

    /**
     * @return Affiliate
     */
    public function getOcAffiliate()
    {
        return $this->registry->get('affiliate');
    }

    /**
     * @return Currency
     */
    public function getOcCurrency()
    {
        return $this->registry->get('currency');
    }

    /**
     * @return Tax
     */
    public function getOcTax()
    {
        return $this->registry->get('tax');
    }

    /**
     * @return Url
     */
    public function getOcUrl()
    {
        return $this->registry->get('url');
    }

    /**
     * @return User
     */
    public function getOcUser()
    {
        return $this->registry->get('user');
    }

    /**
     * @return DB
     */
    public function getOcDb()
    {
        return $this->registry->get('db');
    }

    /**
     * @param $name
     * @return Model
     */
    public function getOcModel($name)
    {
        $model_full_name = 'model_' . str_replace('/', '_', $name);
        if (!$this->registry->has($model_full_name)) {
            $this->registry->get('load')->model($name);
        }

        return $this->registry->get($model_full_name);
    }

    /**
     * @return Document
     */
    public function getOcDocument()
    {
        return $this->registry->get('document');
    }

    public function loadOcTranslation($filename = '')
    {
        if (empty($filename)) {
            $filename = $this->context->getCurrentLanguage('filename');
        }

        if (isset($this->oc_translations['oc_' . $filename])) {
            return $this->oc_translations['oc_' . $filename];
        }

        $translation = $this->resourceLoader->loadOcTranslation($filename);
        $this->oc_translations['oc_' . $filename] = $translation;

        return $translation;
    }

    public function getEnabledLanguages($cache = true)
    {
        $languages = self::$envHelper->getLanguages($cache);
        foreach ($languages as $id => $language) {
            if ($language['status'] == 0) {
                unset($languages[$id]);
            }
        }

        return $languages;
    }

    public function getDefaultCatalogLanguage($key = null)
    {
        foreach ($this->getEnabledLanguages() as $language) {
            if ($language['code'] == $this->getOcConfig()->get('config_language')) {
                return $key !== null ? $language[$key]: $language;
            }
        };

        return null;
    }

    /**
     * {@inheritDoc}
     */
    public function getThemeModel($name = 'default')
    {
        return $this->getThemeExtension()->getModel($name);
    }

    public function getCurrentStoreId()
    {
        return $this->context->getStoreId();
    }


    /**
     * @return sfEventDispatcher
     */
    public function getEventDispatcher()
    {
        return $this->eventDispatcher;
    }

    /**
     * @return TB_DataBag
     */
    public function getRoutesBag()
    {
        return $this->routesBag;
    }

    public function gteOc2()
    {
        return version_compare(VERSION, '2.0.0.0') >= 0;
    }

    public function isThemeEnabled()
    {
        return $this->getOcConfig()->get('config_template') == $this->context->getBasename();
    }

    /**
     * Returns the theme version
     *
     * @return string
     */
    public function getThemeVersion()
    {
        return '1.2.3';
    }

    /**
     * Returns the theme machine name. Useful when checking compatibility.
     * Do not change it, it may prevent extensions from working.
     *
     * @return string
     */
    public function getThemeMachineName()
    {
        return 'pavilion';
    }
}
