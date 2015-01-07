<?php

class Theme_Admin_StorePlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    public function getConfigKey()
    {
        return 'store';
    }

    public function filterSettings(array &$store_settings)
    {
        $default_settings = array(
            'common' => array(
                'preorder_stock_status_id'         => 0,
                'backorder_stock_status_id'        => 0,
                'disable_checkout_stock_status_id' => 0,
                'product_listing_view_mode'        => 'grid'

            ),
            'category' => array(),
            'menu' => array(
                'tree'     => TB_FormHelper::initLangVarsSimple(array(), array(), $this->manager->getEnabledLanguages()),
                'tree_ids' => array()
            )
        );

        $store_settings = TB_FormHelper::initFlatVarsSimple($default_settings, $store_settings);

        $store_settings['common'] = TB_FormHelper::initFlatVarsSimple($default_settings['common'], $store_settings['common']);

        if  (!isset($store_settings['category'])) {
            $store_settings['category'] = array();
        }

        $default_settings = array(
            'subcategories' => $this->getModel('store')->getSubcategoriesDefaultSettings(),
            'products'      => $this->getModel('store')->getProductsDefaultSettings()
        );

        $cs = &$store_settings['category'];
        $cs = TB_FormHelper::initFlatVarsSimple($default_settings, $cs);
        $cs['subcategories'] = TB_FormHelper::initFlatVarsSimple($default_settings['subcategories'], $cs['subcategories']);
        $cs['products'] = TB_FormHelper::initFlatVarsSimple($default_settings['products'], $cs['products']);
        $cs['products']['grid'] = TB_FormHelper::initFlatVarsSimple($default_settings['products']['grid'], $cs['products']['grid']);
        $cs['products']['list'] = TB_FormHelper::initFlatVarsSimple($default_settings['products']['list'], $cs['products']['list']);
        $cs['products']['compact'] = TB_FormHelper::initFlatVarsSimple($default_settings['products']['compact'], $cs['products']['compact']);
    }

    public function setDataForView(&$store_settings, TB_ViewDataBag $themeData)
    {
        foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
            $contents = array();
            if (isset($store_settings['menu']['tree'][$lid]) && !empty($store_settings['menu']['tree'][$lid])) {
                $contents = $store_settings['menu']['tree'][$lid];
            }
            $store_settings['menu']['tree'][$lid] = json_encode($contents);
        }

        $themeData->store_category_default = $store_settings['category'];
        $themeData->stock_statuses = $this->getOcModel('localisation/stock_status')->getStockStatuses();
    }

    public function saveData($post_data, $theme_settings)
    {
        $store_post = $post_data[$this->getConfigKey()];
        $store_db = $this->getModel()->getSetting('store', array());

        if (isset($store_post['category'])) {
            $store_db['category'] = (array) $store_post['category'];
            $view_mode = $store_post['common']['product_listing_view_mode'];

            $this->manager->getDbSettingsHelper()->persistGroup('config', array(
                'config_image_category_width'  => $store_db['category']['subcategories']['image_width'],
                'config_image_category_height' => $store_db['category']['subcategories']['image_height'],
                'config_image_product_width'   => $store_db['category']['products'][$view_mode]['image_width'],
                'config_image_product_height'  => $store_db['category']['products'][$view_mode]['image_height']
            ), $this->context->getStoreId());

            if (isset($store_db['category']['products']['grid']['restrictions'])) {
                foreach ($store_db['category']['products']['grid']['restrictions'] as $i => &$row) {
                    settype($row['max_width'], 'integer');
                    settype($row['items_per_row'], 'integer');
                    settype($row['items_spacing'], 'integer');

                    if (empty($row['max_width']) || empty($row['items_per_row'])) {
                        unset($store_db['category']['products']['grid']['restrictions'][$i]);
                    }
                }
                if (empty($store_db['category']['products']['grid']['restrictions'])) {
                    $store_db['category']['products']['grid']['restrictions'] = $theme_settings['store']['category']['products']['grid']['restrictions'];
                }
            }

            if (isset($store_db['category']['subcategories']['restrictions'])) {
                foreach ($store_db['category']['subcategories']['restrictions'] as $i => &$row) {
                    settype($row['max_width'], 'integer');
                    settype($row['items_per_row'], 'integer');
                    settype($row['items_spacing'], 'integer');

                    if (empty($row['max_width']) || empty($row['items_per_row'])) {
                        unset($store_db['category']['subcategories']['restrictions'][$i]);
                    }
                }

                if (empty($store_db['category']['subcategories']['restrictions'])) {
                    $store_db['category']['subcategories']['restrictions'] = $theme_settings['store']['category']['subcategories']['restrictions'];
                }
            }
        }

        if (isset($store_post['menu'])) {
            $store_db['menu'] = $store_post['menu'];
            foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
                if (isset($store_post['menu']['tree'][$lid])) {
                    $str = (string) html_entity_decode($store_post['menu']['tree'][$lid], ENT_COMPAT, 'UTF-8');
                    $store_db['menu']['tree'][$lid] = json_decode($str, true);
                    $store_db['menu']['tree_ids'][$lid] = $this->extractMenuTreeIds($store_db['menu']['tree'][$lid]);
                }
            }

            if (isset($store_db['menu']['is_dirty']) && $store_db['menu']['is_dirty']) {
                unset($store_db['menu']['is_dirty']);
                $this->manager->wipeVarsCache('*.menu_html.*');
            }
        }

        if (isset($store_post['common'])) {
            $store_db['common'] = $store_post['common'];
        }

        return array(
            $this->getConfigKey() => $store_db
        );
    }

    protected function extractMenuTreeIds($tree)
    {
        $page_ids = array();
        $category_ids = array();

        foreach ($tree as $item) {
            if ($item['data']['type'] == 'page') {
                $page_ids[] = $item['data']['id'];
            }

            if ($item['data']['type'] == 'category') {
                $category_ids[] = $item['data']['id'];
            }

            if (isset($item['children']) && !empty($item['children'])) {
                $extracted = $this->extractMenuTreeIds($item['children']);
                $page_ids += $extracted['page_ids'];
                $category_ids += $extracted['category_ids'];
            }
        }

        return array('page_ids' => $page_ids, 'category_ids' => $category_ids);
    }
}