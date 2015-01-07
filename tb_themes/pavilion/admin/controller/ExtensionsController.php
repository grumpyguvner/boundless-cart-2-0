<?php

class Theme_Admin_ExtensionsController extends TB_AdminController
{
    public function index()
    {
        foreach ($this->extension->getPlugin('extensions')->setForm() as $key => $data) {
            $this->data[$key] = $data;
        }

        $this->renderTemplate('theme_extensions');
    }

    public function installExtension()
    {
        if (!$this->validate()) {
            return $this->sendJsonError($this->error['warning']);
        }

        $name = $this->request->get['name'];
        $result = $this->getModel('extensions')->installExtension($name);

        if (true == $result['success']) {
            $this->session->data['success_alert'] = $result['message'];
            return $this->sendJsonSuccess($result['message'], array('reload' => 1));
        } else {
            return $this->sendJsonError($result['message']);
        }
    }

    public function uninstallExtension()
    {
        if (!$this->validate()) {
            return $this->sendJsonError($this->error['warning']);
        }

        $name = $this->request->get['name'];
        $result = $this->getModel('extensions')->uninstallExtension($name);
        if (true == $result['success']) {
            $this->session->data['success_alert'] = $result['message'];
            return $this->sendJsonSuccess($result['message'], array('reload' => 1));
        } else {
            return $this->sendJsonError($result['message']);
        }
    }
}