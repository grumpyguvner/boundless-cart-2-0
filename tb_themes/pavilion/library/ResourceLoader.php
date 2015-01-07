<?php

class TB_ResourceLoader
{
    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var Registry
     */
    protected $registry;

    /**
     * @var array
     */
    protected $theme_config;

    public function __construct(TB_Context $context, Registry $registry, array $theme_config)
    {
        $this->context      = $context;
        $this->registry     = $registry;
        $this->config       = $registry->get('config');
        $this->theme_config = $theme_config;

        $this->controllers = array();
        $this->models      = array();
    }

    public function fetchExtensionTemplate(TB_Extension $extension, $filename, array $data = array())
    {
        if ($extension->isThemeExtension() && $this->context->getArea() == 'catalog') {
            $file = $this->context->getCatalogTemplateDir() . '/tb/' . $filename . '.tpl';
        } else {
            $file = $extension->getAreaDir() . '/view/template/' . $filename . '.tpl';
        }

        if (!file_exists($file)) {
            throw new Exception('Could not load template ' . $file);
        }

        extract($data);

        ob_start();

        /** @noinspection PhpIncludeInspection */
        require tb_modification($file);

        $content = ob_get_contents();

        ob_end_clean();

        return $content;
    }

    public function resolveExtensionTranslationFilename(TB_Extension $extension, $filename)
    {
        $current_language = $this->context->getCurrentLanguage();

        return $extension->getAreaDir() . '/language/' . $current_language['directory'] . '/' . $filename . '.lang.php';
    }

    public function loadExtensionTranslation(TB_Extension $extension, $filename)
    {
        if ($extension->isThemeExtension() && $this->context->getArea() == 'catalog') {
            return $this->loadCatalogTranslation($filename);
        }

        $file_path = $this->resolveExtensionTranslationFilename($extension, $filename);

        if (!file_exists($file_path)) {
            $config = $this->theme_config;
            $fallback_file = $extension->getAreaDir() . '/language/' . $config['fallback_language'] . '/' . $filename . '.lang.php';
            if (!file_exists($fallback_file)) {
                return array();
            }

            $file_path = $fallback_file;
        }

        $_ = array();

        /** @noinspection PhpIncludeInspection */
        require_once tb_modification($file_path);

        return $_ ;
    }

    public function loadCatalogTranslation($filename)
    {
        $current_language = $this->context->getCurrentLanguage();
        $language_file = $this->context->getCatalogLanguageDir() . '/' . $current_language['directory'] . '/' .
            $this->context->getBasename() . '/' . $filename . '.lang.php';

        $fallback_language = $this->theme_config['fallback_language'];

        $fallback_dir = $this->context->getAreaDir() . '/language/' . $fallback_language;
        if (!is_dir($fallback_dir)) {
            $notice = 'The fallback language "' . $fallback_language . '" does not exist. Please, make sure the ' . $fallback_language . ' folder is accessible: ' . $fallback_dir;
            trigger_error($notice);
        }

        $fallback_file = $fallback_dir . '/' . $this->context->getBasename() . '/' . $filename . '.lang.php';
        if ($fallback_dir != $current_language['directory'] && file_exists($fallback_file)) {
            $_ = array();

            /** @noinspection PhpIncludeInspection */
            require_once tb_modification($fallback_file);

            if (file_exists($language_file)) {
                $_fallback = $_;
                $_ = array();

                /** @noinspection PhpIncludeInspection */
                require_once tb_modification($language_file);

                foreach ($_fallback as $key => $value) {
                    if (!isset($_[$key])) {
                        $_[$key] = $value;
                    }
                }
            }
        } else {
            $_ = array();
            if (!file_exists($language_file)) {
                $notice = 'The language file "' . $language_file . '" does not exist.';
                trigger_error($notice);
            }

            /** @noinspection PhpIncludeInspection */
            require_once tb_modification($language_file);
        }

        return $_ ;
    }

    public function loadOcTranslation($filename)
    {
        $file = $this->context->getCatalogLanguageDir() . '/' . $this->context->getCurrentLanguage('directory') . '/' . $filename . '.php';

        if (!file_exists($file)) {
            $fallback_dir = $this->context->getCatalogLanguageDir() . '/' . $this->theme_config['fallback_language'];
            $file = $fallback_dir . '/' . $filename . '.php';
        }

        if (!file_exists($file)) {
            $fallback_file = $fallback_dir . '/default.php';

            if (!file_exists($fallback_file)) {
                throw new Exception('Could not include the language file ' . $file);
            }

            $file = $fallback_file;
        }

        $_ = array();

        /** @noinspection PhpIncludeInspection */
        require tb_modification($file);

        return $_;
    }

    public function loadExtensionClasses()
    {
        $paths = sfFinder::type('dir')->maxdepth(0)->in($this->context->getExtensionDir());
        $area = $this->context->getArea();
        $classes = array();
        foreach ($paths as $extension_path) {
            if (!is_dir($extension_path . '/' . $area)) {
                continue;
            }

            $extension_name = strtolower(basename($extension_path));

            $extension_file = $extension_path . '/' . $area . '/';
            $extension_file .= TB_Utils::camelize($extension_name) . ucfirst($area) . 'Extension.php';
            if (!file_exists($extension_file)) {
                throw new Exception('Could not initialize extension file ' . $extension_file);
            }

            /** @noinspection PhpIncludeInspection */
            require_once tb_modification($extension_file);

            $class_name = TB_Utils::camelize($extension_name) . '_' . ucfirst($area) . '_Extension';
            if (!class_exists($class_name)) {
                throw new Exception('Could not initialize extension class ' . $class_name);
            }

            $classes[$extension_name] = $class_name;
        }

        return $classes;
    }

    public function loadThemeExtensionClass()
    {
        $area = $this->context->getArea();
        $class_name =  'Theme_' . ucfirst($area) . '_Extension';

        if (class_exists($class_name)) {
            return array ('theme' => $class_name);
        }

        $file = $this->context->getThemeDir() . '/' . $area . '/' . 'Theme' . ucfirst($area) . 'Extension.php';
        if (!is_file($file)) {
            throw new Exception('Could not find the theme extension file: ' . $file);
        }

        /** @noinspection PhpIncludeInspection */
        require tb_modification($file);

        if (!class_exists($class_name)) {
            throw new Exception('Could not initialize the theme extension class: ' . $class_name);
        }

        return array ('theme' => $class_name);
    }


    /**
     * @param TB_Extension $extension
     * @param string $controller_name
     *
     * @throws Exception
     *
     * @return string
     */
    public function loadExtensionController(TB_Extension $extension, $controller_name)
    {
        $extension_name = $extension->getName();
        $area = $this->context->getArea();

        $controller_name = TB_Utils::camelize($controller_name);
        $controller_file = $extension->getAreaDir() . '/controller/' . $controller_name . 'Controller.php';
        if (!file_exists($controller_file)) {
            throw new Exception('Could not include controller file ' . $controller_file);
        }

        /** @noinspection PhpIncludeInspection */
        require_once tb_modification($controller_file);

        $class = TB_Utils::camelize($extension_name) . '_' . ucfirst($area) . '_' . ucfirst($controller_name) . 'Controller';
        if (!class_exists($class)) {
            throw new Exception('Could not initialize controller ' . $class);
        }

        return $class;
    }

    /**
     * @param TB_Extension $extension
     * @param string $model_name
     *
     * @throws Exception
     *
     * @return string
     */
    public function loadExtensionModel(TB_Extension $extension, $model_name = 'default')
    {
        $extension_name = $extension->getName();
        $area = $this->context->getArea();

        $model_class =  TB_Utils::camelize($extension_name) . '_' . ucfirst($area) . '_' . ucfirst($model_name) . 'Model';

        if (class_exists($model_class)) {
            return $model_class;
        }

        $model_file = $extension->getAreaDir() . '/model/' . $model_name . 'Model.php';
        if (!is_file($model_file)) {
            throw new Exception('Could not include model file ' . $model_file);
        }

        /** @noinspection PhpIncludeInspection */
        require tb_modification($model_file);

        if (!class_exists($model_class)) {
            throw new Exception('The class does not exists: ' . $model_class);
        }

        return $model_class;
    }
}