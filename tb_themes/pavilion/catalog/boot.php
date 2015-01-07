<?php

if (version_compare(VERSION, '2.0.0.0') == 0) {
    echo '<h3>Your current OpenCart version is 2.0.0.0. Pavilion 1.2 is intentionally not compatible with it, because it contains many issues that would affect your shop. Please, <a href="http://www.opencart.com/index.php?route=download/download">upgrade to OpenCart 2.0.1.0</a>, which includes many important bugfixes.<br /><br /> If you have any questions, do not hesitate to ask in <a href="http://support.themeburn.com">our support forums</a> </h3>';
    exit();
}

if (defined('TB_STORE_ID') && is_file(TB_THEME_ROOT . '/config/data/class_cache_' . TB_STORE_ID . '.php')) {
    define('TB_CLASS_CACHE', 1);
    require TB_THEME_ROOT . '/config/data/class_cache_' . TB_STORE_ID . '.php';
} else {
    require TB_THEME_ROOT . '/library/EnvHelper.php';
    require TB_THEME_ROOT . '/library/Utils.php';
    require TB_THEME_ROOT . '/library/Context.php';
    require TB_THEME_ROOT . '/library/CatalogDispatcher.php';
}

final class TB_Boot
{
    public static function bootTheme(Registry $registry, Front $front_controller, $basename, $store_id)
    {
        $theme_config = TB_EnvHelper::getInstance($registry)->getThemeConfig($basename);
        $current_lang = TB_EnvHelper::getInstance($registry)->getCurrentLanguage();

        $context = new TB_Context($registry, $basename, $store_id, 'catalog', $current_lang, $theme_config);

        if ($context->isDebug()) {
            if (!defined('TB_CLASS_CACHE')) {
                require TB_THEME_ROOT . '/library/vendor/FirePHP.php';
            }

            FB::setOptions(array(
                'maxObjectDepth'      => 7,
                'maxArrayDepth'       => 7,
                'maxDepth'            => 10,
                'useNativeJsonEncode' => true,
                'includeLineNumbers'  => true
            ));
        } else
        if (!function_exists('fb')) {
            function fb($arg) {
                return $arg;
            }
        }

        $dispatcher = new TB_CatalogDispatcher($registry, $context, $front_controller);

        $dispatcher->dispatch($theme_config);
    }
}