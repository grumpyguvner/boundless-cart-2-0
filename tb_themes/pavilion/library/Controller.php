<?php


class TB_Controller extends Controller
{
    protected $data = array();
    protected $children = array();

    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var TB_ViewDataBag
     */
    protected $themeData;

    /**
     * @var TB_AdminExtension
     */
    protected $extension;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var User
     */
    protected $user;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @var Response
     */
    protected $response;

    /**
     * @var Session
     */
    protected $session;

    /**
     * @var Document
     */
    protected $document;

    public function __construct(TB_ThemeManager $manager, TB_Extension $extension)
    {
        parent::__construct($manager->getOcRegistry());

        $this->manager   = $manager;
        $this->extension = $extension;

        $this->themeData = $manager->getThemeData();
        $this->context   = $manager->getContext();
        $this->user      = $manager->getOcUser();
        $this->request   = $manager->getOcRequest();
        $this->response  = $manager->getOcResponse();
        $this->session   = $manager->getOcSession();
        $this->document  = $manager->getOcDocument();
    }

    public function translate($key)
    {
        return $this->extension->translate($key);
    }

    public function mergeData($data)
    {
        $this->data = array_merge($this->data, $data);
    }

    public function addData($key, $value)
    {
        $this->data[$key] = $value;
    }

    public function renderString($str)
    {
        $this->setOutput($str);
    }

    protected function getArrayKey($key, $source = array(), $default = '')
    {
        return isset($source[$key]) ? $source[$key] : $default;
    }

    protected function buildUrl($data, $allowed)
    {
        foreach($data as $key => $value) {
            if(!in_array($key, $allowed)) {
                unset($data[$key]);
            }
        }

        return http_build_query($data);
    }


    /**
     * {@inheritDoc}
     */
    protected function getModel($model_name = 'default')
    {
        return $this->extension->getModel($model_name);
    }

    /**
     * @param $name
     *
     * @return Model
     */
    protected function getOcModel($name)
    {
        return $this->manager->getOcModel($name);
    }

    protected function fetchTemplate($filename, array $data = array())
    {
        return $this->extension->fetchTemplate($filename, $data);
    }

    protected function renderTemplate($filename)
    {
        foreach ($this->children as $child) {
            $this->data[basename($child)] = $this->extension->loadController($child);
        }

        $output = $this->fetchTemplate($filename, $this->data);

        $this->setOutput($output);
    }

    protected function sendJsonError($msg, array $vars = array())
    {
        if (!isset($vars['reload'])) {
            $vars['reload'] = 0;
        }

        $this->setOutput(
            json_encode(array('success' => false, 'message' => $msg) + $vars)
        );

        return true;
    }

    protected function sendJsonSuccess($msg = '', array $vars = array())
    {
        if (!isset($vars['reload'])) {
            $vars['reload'] = 0;
        }

        $this->setOutput(
            json_encode(array('success' => true, 'message' => $msg) + $vars)
        );

        return true;
    }

    protected function setOutput($output)
    {
        $this->output = $output;
        $this->response->addHeader('Theme-Machine-Name: ' . $this->context->getBasename());
        $this->response->setOutput($output);
    }

    public function __toString()
    {
        return get_class($this);
    }
}