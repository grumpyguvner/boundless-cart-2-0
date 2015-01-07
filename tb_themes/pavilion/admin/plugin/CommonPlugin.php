<?php

class Theme_Admin_CommonPlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    public function getConfigKey()
    {
        return 'common';
    }

    public function filterSettings(array &$common_settings)
    {
        $default_vars = array(
            'manufacturers_enabled'       => 1,
            'compare_enabled'             => 1,
            'wishlist_enabled'            => 1,
            'checkout_enabled'            => 1,
            'voucher_enabled'             => 1,
            'affiliate_enabled'           => 1,
            'returns_enabled'             => 1,
            'currency_label'              => 'code',
            'language_label'              => 'flag+name',
            'label_new_days'              => 5,
            'custom_css'                  => '',
            'custom_javascript'           => ''
        );

        $common_settings = TB_FormHelper::initFlatVarsSimple($default_vars, $common_settings);
    }

    public function setDataForView(&$common_settings, TB_ViewDataBag $themeData)
    {
        $themeData->addCallable(array($this, 'getCategoriesLevel1'));
        $themeData->addCallable(array($this, 'getCategoryName'));
        $themeData->addCallable(array($this->getModel('default'), 'getInformationPages'));

        $themeData->theme_version = $this->manager->getThemeVersion();
        $themeData->oc_layouts = $this->getModel('layoutBuilder')->getLayouts();
        $themeData->system_menu_pages = $this->getSystemMenuPages();
        $themeData->system_pages = $this->getModel('layoutBuilder')->getSystemPages();
    }

    public function getCategoriesLevel1()
    {
        return $this->getModel('category')->getCategoriesByParent(0);
    }

    public function getCategoryName($category_id)
    {
        $category = $this->getModel('category')->getCategory($category_id);

        return $category['name'];
    }

    public function getSystemMenuPages()
    {
        $lang_file = $this->context->getCatalogLanguageDir() . '/english/' . $this->context->getBasename() . '/theme.lang.php';
        if (!is_file($lang_file)) {
            throw new Exception('A file required by ' . ucfirst($this->manager->getThemeMachineName()) . ' theme is missing. Filepath: ' . $lang_file);
        }

        $_ = array();
        /** @noinspection PhpIncludeInspection */
        require tb_modification($lang_file);

        $default = array();
        foreach ($this->getModel('layoutBuilder')->getSystemPages() as $pages) {
            foreach ($pages as $page) {
                if (isset($_['text_' . str_replace('/', '_', $page['route'])])) {
                    $default[str_replace('/', '_', $page['route'])] = $_['text_' . str_replace('/', '_', $page['route'])];
                }
            }
        }

        $result = array();
        foreach ($this->manager->getEnabledLanguages() as $language) {
            $lang_file = $this->context->getCatalogLanguageDir() . '/' . $language['directory'] . '/' . $this->context->getBasename() . '/theme.lang.php';
            if (is_file($lang_file) && $language['directory'] != 'english') {
                $_ = array();
                /** @noinspection PhpIncludeInspection */
                require tb_modification($lang_file);

                foreach ($this->getModel('layoutBuilder')->getSystemPages() as $pages) {
                    foreach ($pages as $page) {
                        if (isset($_['text_' . str_replace('/', '_', $page['route'])])) {
                            $result[$language['id']][str_replace('/', '_', $page['route'])] = $_['text_' . str_replace('/', '_', $page['route'])];
                        } else
                        if (isset($default[str_replace('/', '_', $page['route'])])){
                            $result[$language['id']][str_replace('/', '_', $page['route'])] = $default[str_replace('/', '_', $page['route'])];
                        }
                    }
                }
            } else {
                $result[$language['id']] = $default;
            }
        }

        return $result;
    }

    public function saveData($post_data)
    {
        return array(
            $this->getConfigKey() => $post_data[$this->getConfigKey()]
        );
    }
}