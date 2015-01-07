<?php

abstract class TB_Extension
{
    /**
     * @var string
     */
    private $rootDir;

    /**
     * @var string
     */
    protected $name;

    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var TB_ViewDataBag
     */
    protected $themeData;

    /**
     * @var TB_Controller[]
     */
    protected $controllers;

    /**
     * @var TB_ExtensionModel[]
     */
    protected $models;

    /**
     * @var array
     */
    protected $translations;

    protected $init_order = 500;

    public function __construct(TB_ThemeManager $manager, $name)
    {
        $this->manager = $manager;
        $this->name    = $name;

        $this->context         = $manager->getContext();
        $this->eventDispatcher = $manager->getEventDispatcher();

        $this->controllers  = array();
        $this->models       = array();
        $this->translations = array();
    }

    public function init()
    {
        $this->themeData->addCallable(array($this, 'createJavascriptVars'));
        $this->themeData->addCallable(array($this, 'loadController'));
    }

    public function configure(){}

    public function setThemeData(TB_ViewDataBag $themeData)
    {
        $this->themeData = $themeData;
    }

    /**
     * @return TB_ViewDataBag
     */
    public function getThemeData()
    {
        return $this->themeData;
    }

    /**
     * @return TB_ViewDataBag
     */
    public function getDataBag()
    {
        return $this->themeData;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getInitOrder()
    {
        return $this->init_order;
    }

    public function isThemeExtension()
    {
        return $this->name == 'theme';
    }

    // Indicates whether the extension should be installed or is enabled by default
    public function isCoreExtension()
    {
        return false;
    }


    public function getRootDir()
    {
        if (null === $this->rootDir) {
            if ($this->isThemeExtension()) {
                $this->rootDir = $this->context->getThemeDir();
            } else {
                $r = new ReflectionObject($this);
                $this->rootDir = realpath(dirname($r->getFileName()) . '/../');
            }
        }

        return $this->rootDir;
    }

    public function getAreaDir()
    {
        return $this->getRootDir() . '/' . $this->manager->getContext()->getArea();
    }

    public function getViewDir()
    {
        return $this->getAreaDir() . '/view';
    }

    public function getAreaViewUrl($relative = false)
    {
        return $this->manager->getContext()->getExtensionsUrl($relative) . $this->getName() . '/' . $this->manager->getContext()->getArea() . '/view/';
    }

    protected function loadTranslation($filename)
    {
        $resourceLoader = $this->manager->getResourceLoader();

        $file_path = $resourceLoader->resolveExtensionTranslationFilename($this, $filename);
        if (isset($this->translations[$file_path])) {
            return $this->translations[$file_path];
        }

        $contents = $resourceLoader->loadExtensionTranslation($this, $filename);
        $this->translations[$file_path] = $contents;

        return $contents;
    }

    public function loadDefaultTranslation()
    {
        return $this->loadTranslation($this->name);
    }

    public function getTranslation($name = '')
    {
        return (empty($name)) ? $this->loadDefaultTranslation() : $this->loadTranslation($name);
    }

    public function getTranslations()
    {
        return $this->translations;
    }

    public function translate($key)
    {
        foreach ($this->translations as $translation) {
            if (isset($translation[$key])) {
                return $translation[$key];
            }
        }

        return null;
    }

    public function getSettings($raw = false)
    {
        return $this->getModel()->getSettings($raw);
    }

    public function getSetting($key)
    {
        return $this->getModel()->getSetting($key);
    }

    /**
     * @param string $controller_name
     *
     * @return TB_Controller
     */
    public function getController($controller_name)
    {
        $class_name = $this->manager->getResourceLoader()->loadExtensionController($this, $controller_name);
        if (isset($this->controllers[$class_name])) {
            return $this->controllers[$class_name];
        }

        $class = new $class_name($this->manager, $this);
        $this->controllers[$class_name] = $class;

        return $class;
    }

    /**
     * @param $model_name
     *
     * @return TB_ExtensionModel| Theme_Catalog_DefaultModel| Theme_Admin_DefaultModel
     */
    public function getModel($model_name = 'default')
    {
        $class_name = $this->manager->getResourceLoader()->loadExtensionModel($this, $model_name);
        if (isset($this->models[$class_name])) {
            return $this->models[$class_name];
        }

        $class = new $class_name($this->manager, $this);
        $this->models[$class_name] = $class;

        return $class;
    }

    public function fetchTemplate($filename, array $data = array())
    {
        $data['tbData'] = $this->themeData;

        if (empty($this->translations)) {
            $this->loadDefaultTranslation();
        }

        foreach ($this->translations as $translation) {
            foreach ($translation as $key => $value) {
                $data['text_' . $key] = $value;
            }
        }

        return $this->manager->getResourceLoader()->fetchExtensionTemplate($this, $filename, $data);
    }


    public function createJavascriptVars($cacheable = true)
    {
        $bag = $this->themeData;
        if (!isset($bag['javascript']) || !is_array($bag['javascript'])) {
            return '';
        }

        $js_arr = array();
        foreach ($bag['javascript'] as $section => $vars) {
            foreach ($vars as $key => $value) {
                if ($cacheable && $bag->isJavascriptVarCacheable($section, $key) || !$cacheable && !$bag->isJavascriptVarCacheable($section, $key)) {
                    $js_arr['/' . $section . '/' . $key] = $value;
                }
            }
        }

        if (empty($js_arr)) {
            return '';
        }

        return trim($this->fetchTemplate('javascript_vars', array('jsarr' => $js_arr)));
    }

    public function loadController($route, $args = array())
    {
        if ($this->manager->gteOc2()) {
            $action = new Action($route, $args);
            $content = $action->execute($this->manager->getOcRegistry());
        } else {
            $controller = new TB_DummyController($this->manager->getOcRegistry());
            $content = $controller->getChildController($route, $args);
        }

        return $content;
    }
}