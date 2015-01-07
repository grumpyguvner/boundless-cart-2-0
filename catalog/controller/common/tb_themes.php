<?php

class ControllerCommonTbThemes extends Controller
{
    public function index($front_controller)
    {
        $config = $this->registry->get('config');
        $basename = $config->get('config_template');

        define('TB_THEME_ROOT', realpath(DIR_SYSTEM . '../') . '/tb_themes/' . $basename);
        define('TB_STORE_ID', $config->get('config_store_id'));

        if (!$config->get('theme_' . $basename)) {
            if (is_dir(TB_THEME_ROOT)) {
                die('There theme module has not been installed. Please, enter the admin area and install <strong>' . ucfirst($basename) . ' CP</strong> module.');
            }

            return;
        }

        if (!is_file(TB_THEME_ROOT . '/catalog/boot.php')) {
            die ('The theme boot file cannot be found. Please, check if everything is uploaded correctly');
        }

        require TB_THEME_ROOT . '/catalog/boot.php';

        if (is_array($front_controller)) {
            // OC2 passes the arguments as array
            $front_controller = $front_controller['front'];
        }

        TB_Boot::bootTheme($this->registry, $front_controller, $basename, TB_STORE_ID);
    }
}