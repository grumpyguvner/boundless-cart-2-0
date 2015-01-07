<?php

class Theme_Admin_DefaultController extends TB_AdminController
{
    public function index()
    {
        /*
        $footer_global = $this->manager->getTbSettingsModelInstance('theme', 5)->getScopeSettings('area_footer_global');
        unset($footer_global['rows']['0']);
        fb(base64_encode(serialize($footer_global)));
        */

        $this->children = array(
            'common/header',
            'common/footer'
        );

        if ($this->manager->gteOc2()) {
            $this->children[] = 'common/column_left';
        } else {
            $this->data['column_left'] = '';
        }

        if ($this->extension->getSetting('install_errors')) {
            $this->data['errors'] = $this->extension->getSetting('install_errors');
            $this->data['theme_name'] = $this->context->getThemeConfig('name');
            $this->data['install_theme_url'] = $this->manager->getOcUrl()->link('extension/module/install', 'token=' . $this->session->data['token'] . '&extension=' . $this->context->getBasename(), 'SSL');

            $this->renderTemplate('install_errors');

            if ($this->manager->gteOc2()) {
                $this->manager->getOcModel('extension/extension')->uninstall('module', $this->context->getBasename());
            }

            $this->manager->getSettingsModel()->deleteScopeSettings('theme');

            return;
        }

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->saveSettings($this->request->post);
            if (TB_RequestHelper::isAjaxRequest()) {
                $data = array();
                if ($url = $this->getLivePreviewUrl()) {
                    $data['livePreviewUrl'] = $url;
                }

                $this->sendJsonSuccess("CP Saved!", $data);

                return;
            } else {
                $this->redirect($this->tbUrl->generate('default'));
            }
        }

        $this->document->setTitle($this->translate('heading_title'));

        $this->data['first_time'] = $this->getModel()->getSetting('first_time');

        $this->renderTemplate('theme');
    }

    protected function saveSettings($post_data)
    {
        $theme_settings = $this->getModel()->getSettings(true);

        if (empty($theme_settings)) {
            $theme_settings = array();
        }

        if (isset($post_data['form_data'])) {
             $post_data = json_decode(html_entity_decode((string) $post_data['form_data'], ENT_COMPAT, 'UTF-8'), true);
        }

        foreach ($this->extension->getPlugins() as $plugin) {
            if ($plugin instanceof TB_AdminDataPlugin && (isset($post_data[$plugin->getConfigKey()]) || $plugin->saveAlways())) {
                $result = $plugin->saveData($post_data, $theme_settings);
                if (false !== $result && null !== $result && is_array($result)) {
                    foreach ($result as $key => $value) {
                        if (isset($theme_settings[$key]) && !empty($value)) {
                            $value = array_replace($theme_settings[$key], $value);
                        }
                        $theme_settings[$key] = $value;
                    }
                }
            }
        }

        $filterEvent = new sfEvent($this->getModel(), 'admin.beforePersistMainForm', array('form' => $post_data, 'theme_settings' => $theme_settings));
        $this->manager->getEventDispatcher()->notify($filterEvent);

        $theme_settings['first_time'] = 0;
        $theme_settings['store_id'] = $this->context->getStoreId();
        unset($theme_settings['area']);


        $this->getModel()->setAndPersistSettings($theme_settings);
        $this->manager->wipeStylesCache();

        $filterEvent = new sfEvent($this->getModel(), 'admin.afterPersistMainForm', array('form' => $post_data, 'theme_settings' => $theme_settings));
        $this->manager->getEventDispatcher()->notify($filterEvent);
    }

    public function getLivePreviewToken()
    {
        $token = $this->context->getStoreUrl() . '!*!' . TB_Utils::getIp() . '!*!' . time();

        $this->manager->getDbSettingsHelper()->persistKey($this->context->getBasename() . '_livePreviewToken', $this->context->getStoreId(), 'config', $token);

        return $this->sendJsonSuccess("Preview mode activated", array('livePreviewToken' => base64_encode($token)));
    }

    public function clearCache()
    {
        if (!$this->validate()) {
            $this->sendJsonError($this->error['warning']);

            return;
        }

        $this->manager->wipeAllCache();
        TB_ClassCacheGenerator::deleteCache();
        $this->getModel('layoutBuilder')->rebuildDefaultAreaSettings();

        $this->sendJsonSuccess('The cache has been removed');
    }

    public function getCategoryFlatTreeJSON()
    {
        $flat_tree = $this->getModel('category')->getCategoriesFlatTree();
        $result = array();
        // hack because json_encode doesn't respect hashes if the key is numeric - it reorders the array by key
        foreach ($flat_tree as $item) {
            $result[] = $item;
        }

        $this->setOutput(json_encode($result));
    }

    public function fileManager()
    {
        $this->load->controller('common/filemanager');
        $this->data['filemanager'] = $this->response->getOutput();

        $this->renderTemplate('filemanager');
    }

    public function getImagePath()
    {
        if (!isset($this->request->get['filename'])) {
            return $this->sendJsonError('Not existing path to image');
        }

        $filename = (string) $this->request->get['filename'];

        if (!is_file(DIR_IMAGE . $filename)) {
            return $this->sendJsonError('Invalid path to image ' . $filename);
        }

        $width = $this->getArrayKey('width', $this->request->get, 100);
        $height = $this->getArrayKey('height', $this->request->get, 100);

        $this->setOutput(json_encode(array('path' => $this->getOcModel('tool/image')->resize($filename, $width, $height))));
    }
}
