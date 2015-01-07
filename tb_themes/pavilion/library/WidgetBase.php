<?php

abstract class TB_WidgetBase
{
    /**
     * @var string widget id
     */
    protected $id;

    /**
     * @var string widget's name
     */
    protected $name;

    /**
     * @var array widget instance settings
     */
    protected $settings = array();

    /**
     * @var array
     */
    protected $attributes = array();

    /**
     * @var string marks if the widgets has content after it has been rendered
     */
    protected $has_content = false;

    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var TB_WidgetManager
     */
    protected $widgetManager;

    /**
     * @var array filtered settings to be passed to the view
     */
    protected $view_settings;

    /**
     * @var TB_ViewDataBag
     */
    protected $themeData;

    /**
     * @var array defines the areas the widget is compatible with
     */
    protected $areas = array();

    /**
     * @var int current language id
     */
    protected $language_id;

    /**
     * @var bool
     */
    protected $is_rendered = false;

    public function __construct(TB_ThemeManager $manager, TB_WidgetManager $widgetManager, array $attributes = array())
    {
        $this->manager       = $manager;
        $this->widgetManager = $widgetManager;
        $this->attributes    = $attributes;
        $this->language_id   = $this->manager->getContext()->getCurrentLanguage('language_id');
        $this->themeData     = $manager->getThemeData();
    }

    public function setName($name)
    {
        $this->name = $name;
        $this->settings['widget_name'] = $name;
    }

    public function getName()
    {
        if (null !== $this->name) {
            return $this->name;
        }

        if (isset($this->settings['widget_name'])) {
            return (string) $this->settings['widget_name'];
        }

        $class = $this->getClassName();
        $result = TB_Utils::underscore(str_replace('Widget', '', substr($class, strrpos($class, '_') + 1)));
        $result = explode('_', $result);
        $result = implode(' ', array_map('ucfirst', $result));

        return $result;
    }

    public function setAttributes(array $attributes)
    {
        $this->attributes = $attributes;
    }

    public function mergeAttributes(array $attributes)
    {
        $this->attributes = array_merge($this->attributes, $attributes);
    }

    public function addAttribute($key, $value)
    {
        $this->attributes[$key] = $value;
    }

    public function removeAttribute($key)
    {
        unset($this->attributes[$key]);
    }

    public function getAttribute($key)
    {
        return isset($this->attributes[$key]) ? $this->attributes[$key] : null;
    }

    public function getAttributes()
    {
        return $this->attributes;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getId()
    {
        return $this->id;
    }

    public function getDomId()
    {
        return str_replace(array('Theme_', 'Widget'), '', $this->id);
    }

    public function isRendered()
    {
        return $this->is_rendered;
    }

    public function getClassName()
    {
        return get_class($this);
    }

    public function getTemplateName()
    {
        $class = $this->getClassName();

        return TB_Utils::underscore(str_replace('Widget', '', substr($class, strrpos($class, '_') + 1)));
    }

    public function getAreas()
    {
        return $this->areas;
    }

    public function hasArea($name)
    {
        return in_array($name, $this->areas);
    }

    public function hasEditableSettings()
    {
        return true;
    }

    public function hasCommonOptions()
    {
        return true;
    }

    public function addSettings($key, $setting)
    {
        $this->settings[$key] = $setting;
    }

    /**
     * @param array $settings
     * @throws Exception
     */
    public function setSettings(array $settings, $parent = null)
    {
        if (!isset($settings['widget_name']) && isset($this->settings['widget_name'])) {
            $settings['widget_name'] = $this->settings['widget_name'];
        }

        if (null === $parent) {
            $this->settings = $settings;
        } else {
            $this->settings[$parent] = $settings;
        }
    }

    public function getSettings($key = null)
    {
        if (null == $key) {
            return $this->settings;
        } else
        if (isset($this->settings[$key])) {
            return $this->settings[$key];
        }

        return null;
    }

    public function getSettingsEncoded()
    {
        return base64_encode(gzcompress(serialize($this->getSettings())));
    }

    public function render(array $view_data = array())
    {
        $view_data['widget_id'] = $this->getId();
        $view_data['widget_dom_id'] = $this->getDomId();
        $view_data['widget'] = $this;

        return $this->manager->getThemeExtension()->fetchTemplate('widget/' . $this->getTemplateName(), $view_data);
    }

    public function hasContent()
    {
        if (null === $this->has_content) {
            throw new LogicException("The widget has not been rendered yet");
        }

        return false !== $this->has_content;
    }

    public function setHasContent($bool)
    {
        $this->has_content = $bool;
    }

    protected function getThemeSetting($key)
    {
        return $this->manager->getThemeExtension()->getSetting($key);
    }

    /**
     * @param string $name
     *
     * @return TB_ExtensionModel
     */
    public function getThemeModel($name = 'default')
    {
        return $this->manager->getThemeExtension()->getModel($name);
    }

    public function getOcModel($name)
    {
        return $this->manager->getOcModel($name);
    }

    public function initFlatVars(array $default_vars, array $request_vars)
    {
        $result = array();
        foreach ($default_vars as $key => $value) {
            if (isset($request_vars[$key])) {
                $result[$key] = $request_vars[$key];
            } else {
                $result[$key] = $value;
            }
        }

        return $result;
    }

    public function initLangVars(array $default_vars, array $request_vars)
    {
        $result = array();
        foreach ($this->manager->getEnabledLanguages() as $language) {
            $lid = $language['language_id'];
            foreach ($default_vars as $key => $value) {
                if (isset($request_vars['lang'][$lid][$key])) {
                    $result['lang'][$lid][$key] = $request_vars['lang'][$lid][$key];
                } else {
                    $result['lang'][$lid][$key] = $value;
                }
            }
        }

        return $result;
    }

    public function __sleep()
    {
        unset(
            $this->settings['common']['colors'],
            $this->settings['common']['font'],
            $this->settings['common']['border'],
            $this->settings['common']['border_radius'],
            $this->settings['common']['box_shadow']
        );

        if (isset($this->settings['lang'])) {
            foreach ($this->manager->getEnabledLanguages() as $language) {
                if ($this->language_id != $language['language_id']) {
                    unset($this->settings['lang'][$language['language_id']]);
                }
            }
        }

        return array('id', 'name', 'settings');
    }

    public function __wakeup()
    {
        $this->manager       = TB_StaticThemeManager::get();
        $this->widgetManager = $this->manager->getWidgetManager();
        $this->language_id   = $this->manager->getContext()->getCurrentLanguage('language_id');
        $this->themeData     = $this->manager->getThemeData();
    }
}