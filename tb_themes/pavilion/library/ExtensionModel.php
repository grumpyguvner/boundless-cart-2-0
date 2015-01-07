<?php
abstract class TB_ExtensionModel
{
    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var TB_Extension
     */
    protected $extension;

    /**
     * @var TB_SettingsModel
     */
    protected $settingsModel;

    /*
     * @var TB_Context
     */
    protected $context;

    /**
     * @var TB_DbHelper
     */
    protected $dbHelper;

    /**
     * OpenCart DB class
     *
     * @var DB
     */
    protected $db;

    /**
     * @var Registry
     */
    protected $registry;

    /**
     * @var array
     */
    protected $settings;

    public function __construct(TB_ThemeManager $manager, TB_Extension $extension)
    {
        $this->manager   = $manager;
        $this->extension = $extension;

        $this->registry      = $manager->getOcRegistry();
        $this->context       = $manager->getContext();
        $this->dbHelper      = $manager->getDbHelper();
        $this->db            = $manager->getOcDb();
        $this->settingsModel = $manager->getSettingsModel();

        $settings = $this->settingsModel[$extension->getName()];
        if (empty($settings)) {
            $settings = array();
        }
        $this->settings = $settings;
    }

    public function getSetting($key, $default = null)
    {
        if (!isset($this->settings[$key])) {
            return $default !== null ? $default : null;
        }

        return $this->settings[$key];
    }

    public function setSetting($key, $value)
    {
        $this->settings[$key] = $value;
    }

    public function getSettings($raw = false)
    {
        if (false === $raw) {
            return $this->settings;
        } else {
            return $this->settingsModel->getScopeSettings($this->extension->getName(), true);
        }
    }

    public function setSettings($settings)
    {
        $this->settingsModel[$this->extension->getName()] = $settings;
        $this->settings = $settings;
    }

    public function persistSettings()
    {
        $this->settingsModel[$this->extension->getName()] = $this->settings;
        $this->settingsModel->persistScopeSettings($this->extension->getName());
    }

    public function setAndPersistSettings($settings)
    {
        $this->setSettings($settings);
        $this->persistSettings();
    }

    public function persistCustomSettings($settings, $store_id = null)
    {
        $this->settingsModel->persistCustomSettings($settings, $this->extension->getName(), $store_id);
    }

    protected function getOcConfig()
    {
        return $this->manager->getOcConfig();
    }

    protected function getOcModel($name)
    {
        return $this->manager->getOcModel($name);
    }

    protected function getThemeModel($name = 'default')
    {
        return $this->manager->getThemeModel($name);
    }
}