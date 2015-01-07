<?php

abstract class TB_ExtensionPlugin
{
    /**
     * @var TB_ExtensionPluginBootstrap
     */
    protected $bootstrapper;

    /**
     * @var TB_Extension
     */
    protected $extension;

    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    /**
     * The current active language id
     *
     * @var int
     */
    protected $language_id;

    protected $name;
    protected $init_order = 500;

    public function __construct(TB_ExtensionPluginBootstrap $bootstrapper, TB_Extension $extension, TB_ThemeManager $manager)
    {
        $this->bootstrapper       = $bootstrapper;
        $this->extension          = $extension;
        $this->manager            = $manager;
        $this->context            = $manager->getContext();
        $this->eventDispatcher    = $manager->getEventDispatcher();
        $this->language_id        = $this->context->getCurrentLanguage('id');
    }

    public function configure(TB_ViewDataBag $themeData) {}
    public function execute(TB_ViewDataBag $themeData, Request $request) {}

    protected function bootstrap($plugin_name = '')
    {
        if (empty($plugin_name)) {
            $plugin_name = $this->name;
        }

        $this->bootstrapper->bootstrap($plugin_name);
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getInitOrder()
    {
        return $this->init_order;
    }

    protected function getModel($name = 'default')
    {
        return $this->extension->getModel($name);
    }

    protected function getOcModel($name)
    {
        return $this->manager->getOcModel($name);
    }

    protected function getSettings()
    {
        if (!$this instanceof TB_AdminDataPlugin) {
            throw new LogicException('The plugin ' . $this->getName() . 'does not implement TB_AdminDataPlugin interface');
        }

        $db_data = $this->extension->getSettings();
        if (!isset($db_data[$this->getConfigKey()])) {
            return array();
        }

        return $db_data[$this->getConfigKey()];
    }

    protected function getSetting($key)
    {
        return $this->extension->getSetting($key);
    }

    /**
     * @return TB_ViewDataBag
     */
    protected function getThemeData()
    {
        return $this->extension->getThemeData();
    }

    public function saveAlways()
    {
        return false;
    }
}