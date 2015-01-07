<?php

require_once dirname(__FILE__) . '/../../model/defaultModel.php';

class Theme_Catalog_DefaultModel extends Theme_DefaultModel
{
    public function getUser($user_id)
    {
        $user_table = '`' . DB_PREFIX . 'user`';
        $user_group_table = '`' . DB_PREFIX . 'user_group`';
        $sql = "SELECT *
                FROM $user_table AS u
                INNER JOIN $user_group_table AS ug ON u.user_group_id  = ug.user_group_id
                WHERE user_id = '" . (int) $user_id . "'";
        $query = $this->db->query($sql);
        if ($query->num_rows > 0) {
            $query->row['permission'] = unserialize($query->row['permission']);
        }

        return $query->row;
    }

    public function getLayoutIdByRoute($route)
    {
        $layout_id = 0;

        $sql = "SELECT *
                FROM " . DB_PREFIX . "layout_route
                WHERE '" . $this->db->escape($route) . "' LIKE CONCAT(route, '%') AND store_id = '" . $this->getOcConfig()->get('config_store_id') . "' ORDER BY route DESC LIMIT 1";

        $query = $this->db->query($sql);
        if ($query->rows) {
            $layout_id = (int) $query->row['layout_id'];
        }

        return $layout_id;
    }

    public function getThemeModulesForOC()
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $result = array();
        $setting_extensions = $this->settingsModel['extensions'];
        if ($setting_extensions) {
            foreach ($setting_extensions as $name => $settings) {
                if ($this->manager->isExtensionInstalled($name)) {
                    $result[$name] = array(
                        'extension_id' => rand(9999, 9999999),
                        'type'         => 'module',
                        'code'         => $name
                    );
                }
            }
        }

        return $result;
    }

    public function themeModuleForOCExists($name)
    {
        $modules = $this->getThemeModulesForOC();

        return isset($modules[$name]);
    }

    public function getCustomerGroupId()
    {
        if ($this->manager->getOcCustomer()->isLogged()) {
            if ($this->manager->gteOc2()) {
                $group_id = $this->manager->getOcCustomer()->getGroupId();
            } else{
                $group_id = $this->manager->getOcCustomer()->getCustomerGroupId();
            }
        } else {
          $group_id = $this->getOcConfig()->get('config_customer_group_id');
        }

        return (int) $group_id;
    }

    public function getSystemMenuPagesLang($id = null)
    {
        static $pages = null;

        if (null === $pages) {
            $lang_file = $this->extension->loadDefaultTranslation();
            foreach ($this->settings['system_routes'] as $route => $ssl) {
                if (isset($lang_file['text_' . str_replace('/', '_', $route)])) {
                    $pages[str_replace('/', '_', $route)] = array (
                        'title' => $lang_file['text_' . str_replace('/', '_', $route)],
                        'route' => $route,
                        'ssl'   => $ssl
                    );
                }
            }
        }

        if (null === $id) {
            return $pages;
        }

        return isset($pages[$id]) ? $pages[$id] : false;
    }

    public function resizeImage($filename, $width, $height, $type = "")
    {
        $image = $this->getOcModel('tool/image')->resize($filename, $width, $height, $type);

        if (!$this->manager->getThemeConfig('image_serve_domain')) {
            return $image;
        }

        if (TB_RequestHelper::isRequestHTTPS()) {
            $search = $this->manager->getOcConfig()->get('config_ssl');
            $replace = 'https://' . $this->manager->getThemeConfig('image_serve_domain');
        } else {
            $search = $this->manager->getOcConfig()->get('config_url');
            $replace = 'http://' . $this->manager->getThemeConfig('image_serve_domain');
        }

        return str_replace($search, $replace, $image);
    }

    public function resizeImageAdvanced($filename, $width, $height, $method = 'fit')
    {
        if (!is_file(DIR_IMAGE . $filename)) {
            return '';
        }

        $info = pathinfo($filename);
        $extension = $info['extension'];

        $old_image = $filename;

        $new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . '-' . $method .'.' . $extension;

        if (!is_file(DIR_IMAGE . $new_image) || (filemtime(DIR_IMAGE . $old_image) > filemtime(DIR_IMAGE . $new_image))) {
            $path = '';

            $directories = explode('/', dirname(str_replace('../', '', $new_image)));

            foreach ($directories as $directory) {
                $path = $path . '/' . $directory;

                if (!file_exists(DIR_IMAGE . $path)) {
                    @mkdir(DIR_IMAGE . $path, 0777);
                }
            }

            list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);

            if ($width_orig > $width || $height_orig > $height) {
                $image = new TB_ImageManipulator(DIR_IMAGE . $old_image);
                $image->resize($width, $height, array('method' => $method));
                $image->save(DIR_IMAGE . $new_image);
            } else {
                $new_image = $old_image;
            }
        }

        return  $new_image;
    }
}