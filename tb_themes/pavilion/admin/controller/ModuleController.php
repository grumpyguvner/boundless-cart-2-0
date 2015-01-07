<?php

class Theme_Admin_ModuleController extends Controller
{
    public function index()
    {
        /** @var $request Request */
        $request = $this->request;

        if (($request->server['REQUEST_METHOD'] == 'POST') && !$this->user->hasPermission('modify', 'module/' . TB_BASENAME) && !$this->ignoredPostPermissions()) {
            if (TB_RequestHelper::isAjaxRequest()) {
                return $this->response->setOutput(json_encode(array('success' => false, 'message' => 'Permission error')));
            } else {
                return new Action('error/permission');
            }
        }

        $store_id = 0;
        if (isset($request->get['store_id'])) {
            $store_id = (int) $request->get['store_id'];
        } else
        if (isset($request->post['store_id'])) {
            $store_id = (int) $request->post['store_id'];
        }

        $dispatcher = TB_AdminDispatcher::getInstance($this->registry, TB_BASENAME, $store_id);
        if (!in_array(TB_BASENAME, $this->registry->get('tbManager')->getThemeModel()->getInstalledOcModules())) {
            return new Action('error/permission');
        }

        $extension_name = TB_BASENAME;
        if (isset($request->get['extension'])) {
            $extension_name = (string) $request->get['extension'];
        } else
        if (isset($request->post['extension'])) {
            $extension_name = (string) $request->post['extension'];
        }

        $controller_name = 'default';
        if (isset($request->get['controller'])) {
            $controller_name = (string) $request->get['controller'];
        } else
        if (isset($request->post['controller'])) {
            $controller_name = (string) $request->post['controller'];
        }

        $action = 'index';
        if (isset($request->get['action'])) {
            $action = (string) $request->get['action'];
        } else
        if (isset($request->post['action'])) {
            $action = (string) $request->post['action'];
        }

        $dispatcher->dispatch($extension_name, $controller_name, $action);
    }

    protected function ignoredPostPermissions()
    {
        /** @var $request Request */
        $request = $this->request;

        if (isset($request->get['controller']) && $request->get['controller'] == 'LayoutBuilder' && isset($request->get['action']) && $request->get['action'] == 'createRowSettingsForm') {
            return true;
        }

        if (isset($request->get['controller']) && $request->get['controller'] == 'Widget' && isset($request->get['action']) && $request->get['action'] == 'createForm') {
            return true;
        }

        return false;
    }

    public function install()
    {
        $dispatcher = TB_AdminDispatcher::getInstance($this->registry, TB_BASENAME, 0);
        $dispatcher->installTheme();
    }

    public function uninstall()
    {
        $dispatcher = TB_AdminDispatcher::getInstance($this->registry, TB_BASENAME, 0);
        $dispatcher->uninstallTheme();
    }
}