<?php

require_once TB_THEME_ROOT . '/library/ThemeManager.php';
require_once TB_THEME_ROOT . '/library/AdminController.php';
require_once TB_THEME_ROOT . '/library/AdminExtension.php';
require_once TB_THEME_ROOT . '/library/AdminUrl.php';
require_once TB_THEME_ROOT . '/library/AdminDataPluginInterface.php';

class TB_AdminDispatcher
{
    /**
     * @var TB_AdminDispatcher
     */
    protected static $instance;

    /**
     * @var TB_ThemeManager
     */
    private static $manager;

    /**
     * @var Registry
     */
    private $registry;

    /**
     * @var string
     */
    private $basename;

    protected function __construct($registry, $basename, $store_id)
    {
        $this->registry = $registry;
        $this->basename = $basename;
        $this->initThemeManager($store_id);
    }

    public static function getInstance(Registry $registry, $basename, $store_id)
    {
        if (!isset(self::$instance)) {
            if (null === $registry) {
                throw new InvalidArgumentException('You must supply Registry instance');
            }
            self::$instance = new self($registry, $basename, $store_id);
        }

        return self::$instance;
    }

    public function dispatch($extension_name, $controller_name, $action)
    {
        $extension = self::$manager->getExtension($extension_name);
        self::$manager->updateThemeDataAfterRouting($extension);

        $event = new sfEvent($this, 'core:admin_dispatch', array(
            'controller_name' => $controller_name,
            'action_name'     => $action,
            'extension_name'  => $extension_name
        ));
        self::$manager->getEventDispatcher()->notify($event);

        $controller = $extension->getController($controller_name);
        if (method_exists($controller, 'init')) {
            call_user_func(array($controller, 'init'));
        }
        if (method_exists($controller, $action)) {
            try {
                call_user_func(array($controller, $action));
            } catch (Exception $e) {
                $controller->renderString(renderException($e));
            }
        } else {
            throw new Exception('Controller action not found: ' . $controller_name . '->' . $action . ' for the extension: ' . $extension_name);
        }
    }

    protected function initThemeManager($store_id)
    {
        $theme_config = TB_EnvHelper::getInstance($this->registry)->getThemeConfig($this->basename);
        $current_lang = TB_EnvHelper::getInstance($this->registry)->getCurrentLanguage();
        $config = $this->registry->get('config');

        if ($store_id != 0) {
            $query = $this->registry->get('db')->query('SELECT * FROM ' . DB_PREFIX . 'setting WHERE store_id = ' . $store_id);

            foreach ($query->rows as $setting) {
                if (!$setting['serialized']) {
                    $config->set($setting['key'], $setting['value']);
                } else {
                    $config->set($setting['key'], unserialize($setting['value']));
                }
            }
        }

        $context = new TB_Context($this->registry, $this->basename, $store_id, 'admin', $current_lang, $theme_config);

        self::$manager = TB_ThemeManager::getInstance($context, $this->registry, $theme_config);

        $config->set('config_store_id', $store_id);
        $config->set('theme_' . $this->basename, null);

        self::$manager->boot();
        $this->registry->set('tbManager', self::$manager);
    }

    public function installTheme()
    {
        self::$manager->getEventDispatcher()->notify(new sfEvent($this, 'core:admin_module_install'));
    }

    public function uninstallTheme()
    {
        self::$manager->getEventDispatcher()->notify(new sfEvent($this, 'core:admin_module_uninstall'));
    }
}