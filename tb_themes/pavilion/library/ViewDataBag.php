<?php

class TB_ViewDataBag extends TB_DataBag
{
    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var TB_ViewSlot
     */
    public $viewSlot;

    protected $non_cacheable_javascript_vars = array();
    protected $javascript_resources = array();
    protected $stylesheet_resources = array();
    protected $tb_setting_load_keys = array();

    public function __construct(TB_Context $context, TB_ViewSlot $viewSlot)
    {
        $this->context  = $context;
        $this->viewSlot = $viewSlot;
    }

    public function addJavascriptVar($space, $var, $cacheable = true)
    {
        if (!strpos($space, '/')) {
            throw new Exception('You must specify a javascript registry space for the variable ' . $space);
        }

        list($section, $name) = explode('/', $space, 2);
        $this->container['javascript'][$section][$name] = $var;

        if (false === $cacheable) {
            $this->non_cacheable_javascript_vars[$section][$name] = 1;
        }
    }

    public function isJavascriptVarCacheable($section, $name)
    {
        return !isset($this->non_cacheable_javascript_vars[$section][$name]);
    }

    protected function registerResource($type, $path, TB_CatalogExtension $extension = null, $external = false)
    {
        $view_dir = null !== $extension ? $extension->getViewDir() : $this->context->getCatalogResourceDir();

        if (0 !== strpos($path, '//')) {
            $view_url = null !== $extension ? $extension->getAreaViewUrl() : $this->context->getThemeCatalogResourceUrl();
            $view_url .= $type . '/' . $path;
        } else {
            $view_url = $path;
        }

        $hash = md5($path);

        $this->{"{$type}_resources"}[$external ? 'external' : 'merged'][$hash] = array(
            'dir' => $view_dir . '/' . $type . '/' . $path,
            'url' => $view_url
        );

        return $hash;
    }

    protected function getResource($type, $key = null)
    {
        if (null !== $key) {
            if (isset($this->{"{$type}_resources"}[$key])) {
                return $this->{"{$type}_resources"}[$key];
            }

            return array();
        }

        return $this->{"{$type}_resources"};
    }

    public function registerJavascriptResource($path, TB_CatalogExtension $extension = null, $external = false)
    {
        $this->registerResource('javascript', $path, $extension, $external);
    }

    public function setJavascriptResources(array $resources)
    {
        $this->javascript_resources = $resources;
    }

    public function getJavascriptResources($key = null)
    {
        return $this->getResource('javascript', $key);
    }

    public function registerStylesheetResource($path, TB_CatalogExtension $extension = null, $external = null)
    {
        $hash = $this->registerResource('stylesheet', $path, $extension, $external === true);
        if (is_array($external)) {
            $url = null !== $extension ? $extension->getAreaViewUrl() : $this->context->getThemeCatalogResourceUrl();
            foreach ($external as $search => $replace) {
                $this->stylesheet_resources['merged'][$hash]['path_replace'][$search] = str_replace('{path}', $url, $replace);
            }
        }
    }

    public function getStylesheetResources($key = null)
    {
        return $this->getResource('stylesheet', $key);
    }

    public function addTbSettingsLoadKey($key)
    {
        $this->tb_setting_load_keys[] = $key;
    }

    public function getTbSettingsLoadKeys()
    {
        return $this->tb_setting_load_keys;
    }

    public function slotStartSystem($name = '', array $params = array())
    {
        $this->viewSlot->startSystem($name, $params);
    }

    public function slotStartHeader()
    {
        $this->viewSlot->start('oc_header');
    }

    public function slotStopHeader()
    {
        $this->viewSlot->stop(true);
        ob_start();
        ob_implicit_flush(0);
        $this['header_catched'] = true;
    }

    public function slotStart($name = '', array $params = array())
    {
        $this->viewSlot->start($name, $params);
    }

    public function slotStop($capture = true, $stack = false)
    {
        $this->viewSlot->stop($capture, $stack);
    }

    public function slotStartJs()
    {
        $this->viewSlot->startJs();
    }

    public function slotStopJs()
    {
        $this->viewSlot->stopJs();
    }

    public function slotStopEcho()
    {
        $this->slotStop(false);
    }

    public function slotStopStack()
    {
        $this->slotStop(true, true);
    }

    public function slotEcho($name)
    {
        $this->viewSlot->display($name);
    }

    public function slotFlag($name, array $params = array())
    {
        $this->viewSlot->flag($name, $params);
    }

    public function slotFilter($name, &$value, array $params = array())
    {
        return $this->viewSlot->filter($name, $value, $params);
    }

    public function slotHasContent($name)
    {
        return $this->viewSlot->hasContent($name);
    }
}