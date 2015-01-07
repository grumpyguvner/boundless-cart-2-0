<?php

require_once TB_THEME_ROOT . '/library/ThemeManager.php';
require_once TB_THEME_ROOT . '/library/CatalogController.php';
require_once TB_THEME_ROOT . '/library/CatalogExtension.php';
require_once TB_THEME_ROOT . '/library/CatalogModuleAction.php';

class TB_CatalogDispatcher
{
    /**
     * @var Registry
     */
    protected $registry;


    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var Front
     */
    protected $front_controller;

    public function __construct(Registry $registry, TB_Context $context, Front $front_controller)
    {
        $this->registry         = $registry;
        $this->context          = $context;
        $this->front_controller = $front_controller;
    }

    public function dispatch(array $theme_config)
    {
        $registry = $this->registry;

        $theme_settings = $registry->get('config')->get('theme_' . $this->context->getBasename());
        if ($theme_settings['store_id'] != $this->context->getStoreId()) {
            die('There are no saved settings for the current store. Please, enter the theme control panel and select the store.');
        }

        $this->manager = TB_ThemeManager::getInstance($this->context, $registry, $theme_config)->boot();

        $registry->set('tbManager', $this->manager);

        $request         = $registry->get('request');
        $themeData       = $this->manager->getThemeData();
        $eventDispatcher = $this->manager->getEventDispatcher();

        $event = new sfEvent($registry, 'core:initUrl', array(
            'themeData' => $themeData,
            'request'   => $request,
            'url'       => $this->registry->get('url')
        ));
        $eventDispatcher->notify($event);

        if ($event->isProcessed() && $event->getReturnValue() instanceof TB_Url) {
            $registry->set('url', $event->getReturnValue());
        }

        $ocUrl = $this->doRouting($eventDispatcher, $request, $themeData);
        $callable = $this->doExtensionsRoutesDispatching($themeData->route);

        $event = new sfEvent($this->registry, 'core:afterDispatch', array(
            'tbData'  => $themeData,
            'request' => $request,
            'route'   => $themeData->route
        ));
        $eventDispatcher->notify($event);

        if ($event->isProcessed()) {
            $this->registry->get('response')->setOutput($event->getReturnValue());
            $this->registry->get('response')->output();
            exit;
        }

        if (false !== $callable && false !== call_user_func($callable)) {
            $this->registry->get('response')->output();
            exit;
        }

        if (null !== $ocUrl) {
            $this->registry->set('url', $ocUrl);
        }
    }

    protected function doRouting(sfEventDispatcher $eventDispatcher, Request $request, $themeData)
    {
        $event = new sfEvent($this->registry, 'core:beforeRouting', array('themeData' => $themeData, 'request' => $request));
        $eventDispatcher->notify($event);

        $ocUrl = null;

        if ($event->isProcessed()) {
            $route = $event->getReturnValue();
        } else {
            if (!($this->registry->get('url') instanceof TB_Url)) {
                // prevent double rewrite after common/seo_url.php action
                $ocUrl = clone $this->registry->get('url');
            }

            $theme_config = $this->manager->getThemeConfig();

            $this->manager->getThemeExtension()->loadController($theme_config['seo_action']);

            if (isset($this->registry->get('request')->get['route'])) {
                $route = $request->get['route'];
            } else {
                $route = 'common/home';
            }
        }

        $event = new sfEvent($this->registry, 'core:filterRoute', array('tbData' => $themeData, 'request' => $request));
        $route = $eventDispatcher->filter($event, $route)->getReturnValue();

        if (isset($request->get['_route_'])) {
            $request->get['original_route'] = $request->get['_route_'];
            unset($request->get['_route_']);
        }

        $request->get['route'] = $route;
        $themeData->route = $route;

        $event = new sfEvent($this->registry, 'core:afterRouting', array('tbData' => $themeData, 'request' => $request, 'route' => $route));
        $eventDispatcher->notify($event);

        return $ocUrl;
    }

    public function doExtensionsRoutesDispatching($request_route)
    {
        $extension_name = '';
        $controller_name = '';
        $registered_routes = $this->manager->getRoutesBag()->exportVars();
        $action = 'index';
        foreach ($registered_routes as $extension => $routes) {
            foreach ($routes as $route) {
                if (0 === stripos($request_route, $route['route'])) {
                    $extension_name = $extension;
                    $controller_name = $route['controller'];
                    $action_name = trim(substr($request_route, strlen($route['route'])), '/');

                    if (!empty($action_name)) {
                        $action = $action_name;
                    }

                    break;
                }
            }
        }

        if (empty($extension_name) || empty($controller_name)) {
            return false;
        }

        $controller = $this->manager->getExtension($extension_name)->getController($controller_name);
        if (!method_exists($controller, $action)) {
            return false;
        }

        return array($controller, $action);
    }
}