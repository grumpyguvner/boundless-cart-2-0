<?php

require_once dirname(__FILE__) . '/../../model/extensionsModel.php';

class Theme_Admin_ExtensionsModel extends Theme_ExtensionsModel
{
    public function installExtension($name)
    {
        $setting_name = 'extensions';
        $setting_extensions = $this->settingsModel[$setting_name];
        if (null == $setting_extensions) {
            $setting_extensions = array();
        }

        $ext = $this->extension;

        if (isset($setting_extensions[$name])) {
            $extension = $this->manager->getExtension($name);
            return array(
              'success' => false,
              'message' => sprintf($ext->translate('extension_already_installed'), $extension->getInitOption('title'))
            );
        }

        $not_installed_extensions = $this->manager->getNotInstalledExtensions();
        if (!isset($not_installed_extensions[$name])) {
            return array(
              'success' => false,
              'message' => sprintf($ext->translate('extension_cannot_be_found'), $name)
            );
        }
        $extension = $not_installed_extensions[$name];

        if (method_exists($extension, 'checkRequirements')) {
            $result = call_user_func(array($extension, 'checkRequirements'));
            if (true !== $result) {
                return array(
                  'success' => false,
                  'message' => (string) $result
                );
            }
        }

        if (method_exists($extension, 'install')) {
            call_user_func(array($extension, 'install'));
        }

        $setting_extensions[$name] = array(
            'isntalled_on' => date('d-m-Y h:i')
        );

        $this->settingsModel->deleteScopeSettings($setting_name);
        $this->settingsModel->setAndPersistScopeSettings($setting_name, $setting_extensions);

        return array(
          'success' => true,
          'message' => sprintf($ext->translate('extension_has_been_installed'), $extension->getInitOption('title'))
        );
    }

    public function uninstallExtension($name)
    {
        $setting_name = 'extensions';
        $setting_extensions = $this->settingsModel[$setting_name];
        if (null == $setting_extensions) {
            $setting_extensions = array();
        }

        $ext = $this->extension;

        if (!isset($setting_extensions[$name])) {
            return array(
              'success' => false,
              'message' => sprintf($ext->translate('extension_cannot_be_found'), $name)
            );
        }

        $extension = $this->manager->getExtension($name);
        if (method_exists($extension, 'uninstall')) {
            call_user_func(array($extension, 'uninstall'));
        }
        $result = array(
          'success' => true,
          'message' => sprintf($ext->translate('extension_has_been_uninstalled'), $extension->getInitOption('title'))
        );

        unset($setting_extensions[$name]);
        $this->settingsModel->setAndPersistScopeSettings($setting_name, $setting_extensions);

        return $result;
    }
}