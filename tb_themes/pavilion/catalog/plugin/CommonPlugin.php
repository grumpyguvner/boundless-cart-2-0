<?php

class Theme_Catalog_CommonPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        $this->setStoreCommon($themeData);
        $this->setProductListingType($themeData, $request);
        $this->addJavascriptVars($themeData);
        $this->setCategorySettings($themeData);
        $this->setPaymentImages($themeData);
        $this->setTemplateVars($themeData);

        $themeData->theme_config   = $this->manager->getThemeConfig();
        $themeData->theme_version  = $this->manager->getThemeVersion();
        $themeData->presentation   = $this->getModel()->getPresentationConfig();
        $themeData->meta_generator = $this->context->getThemeConfig('name') . ' ' . $this->manager->getThemeVersion();

        $oc_lang = $this->manager->loadOcTranslation();
        $tbPrice = new TB_PriceFormatter($this->manager->getOcCurrency(), $oc_lang['decimal_point']);

        $themeData->addCallable(array($this, 'extractCartText'));
        $themeData->addCallable(array($tbPrice, 'format'), 'priceFormat');
        $themeData->addCallable(array($this->getModel('category'), 'getCategoryTreeWithTotalProductsMaxLevel2'));
        $themeData->addCallable(array($this->getModel('category'), 'getCategoriesTree'));

        $this->eventDispatcher->connect('account/order.page_content.filter',   array($this, 'filterAccountOrder'));
        $this->eventDispatcher->connect('account/return.page_content.filter',  array($this, 'filterAccountReturn'));
        $this->eventDispatcher->connect('account/address.page_content.filter', array($this, 'filterAccountAddress'));
        $this->eventDispatcher->connect('common/header.scripts.filter',        array($this, 'filterScripts'));
        $this->eventDispatcher->connect('common/header.styles.filter',         array($this, 'filterStyles'));

        $themeData->common    = $this->getSetting('common');
        $themeData->product   = $this->getSetting('product');
        $themeData->twitter   = $this->getSetting('twitter');
        $themeData->system    = $this->getSetting('system');
        $themeData->config    = $this->manager->getOcConfig();
        $themeData->url       = $this->manager->getOcUrl();
        $themeData->customer  = $this->manager->getOcCustomer();
        $themeData->affiliate = $this->manager->getOcAffiliate();

        $facebook = $this->getSetting('facebook');
        if (isset($facebook[$this->language_id])) {
            $themeData->facebook = $facebook[$this->language_id];
        } else {
            $themeData->facebook = reset($facebook);
        }

        if (!$themeData->system['compatibility_jquery']) {
            $themeData->registerJavascriptResource('jquery-migrate-1.2.1.min.js');
        }
        $themeData->registerJavascriptResource($themeData->theme_config['catalog_external_js'] ? '//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js' : 'jquery-ui-1.10.4.min.js', null, true);
    }

    public function extractCartText($text, $type)
    {
        static $types;

        if (null === $types) {
            $oc_lang = $this->manager->loadOcTranslation($this->manager->gteOc2() ? 'common/cart' : 'module/cart');
            $parts = explode('%s', $oc_lang['text_items']);
            if (isset($parts[2])) {
                $pattern = '/(' . preg_quote($parts[0]) . ')(.*)(' . preg_quote($parts[1]) . ')(.*)(' . preg_quote($parts[2]) . ')/';
                preg_match($pattern, $text, $matches);

                if (isset($matches[5])) {
                    $types['count'] = $matches[2];
                    $types['total'] = $this->manager->getThemeData()->priceFormat($matches[4]);
                }
            }
        }

        return isset($types[$type]) ? $types[$type] : $text;
    }

    public function filterAccountReturn(sfEvent $event, array $data)
    {
        $this->addCollectionClearClass($data['returns']);
    }

    public function filterAccountOrder(sfEvent $event, array $data)
    {
        $this->addCollectionClearClass($data['orders']);
    }

    public function filterAccountAddress(sfEvent $event, array $data)
    {
        $this->addCollectionClearClass($data['addresses']);
    }

    public function filterStyles(sfEvent $event, $styles)
    {
        foreach ($styles as $key => $style) {
            if ($this->manager->gteOc2()) {
                if (stripos($key, 'magnific-popup.css') !== false) {
                    unset($styles[$key]);
                }
            }
        }

        return $styles;
    }

    public function filterScripts(sfEvent $event, $scripts)
    {
        foreach ($scripts as $key => $script) {
            if (basename($script) == 'tabs.js') {
                unset($scripts[$key]);
            }

            $system = $this->getThemeData()->system;

            if (!$this->manager->gteOc2() && isset($system['compatibility_colorbox']) &&  !$system['compatibility_colorbox'] && stripos($script, 'colorbox') !== false) {
                unset($scripts[$key]);
            }

            if ($this->manager->gteOc2()) {
                if (isset($system['compatibility_moment_js']) && !$system['compatibility_moment_js'] && stripos($script, 'moment.min.js') !== false) {
                    unset($scripts[$key]);
                }

                if (stripos($script, 'jquery.magnific-popup.min.js') !== false) {
                    unset($scripts[$key]);
                }
            }
        }

        return $scripts;
    }

    protected function addCollectionClearClass(&$collection)
    {
        $i = 1;
        foreach ($collection as &$item) {
            $clear_class = '';
            if (is_int(($i-1)/2)) $clear_class .= ' clear2';
            if (is_int(($i-1)/3)) $clear_class .= ' clear3';
            if (is_int(($i-1)/4)) $clear_class .= ' clear4';
            if (is_int(($i-1)/5)) $clear_class .= ' clear5';
            if (is_int(($i-1)/6)) $clear_class .= ' clear6';
            if (is_int(($i-1)/7)) $clear_class .= ' clear7';
            if (is_int(($i-1)/8)) $clear_class .= ' clear8';

            $item['tb_css_classes'] = $clear_class;
            $i++;
        }
    }

    protected function setStoreCommon(TB_ViewDataBag $themeData)
    {
        $store = $this->getSetting('store');
        $store_common = $store['common'];
        $stock_statuses = $this->getModel()->getStockStatuses();

        $store_common['preorder_stock_status_name'] = '';
        $store_common['backorder_stock_status_name'] = '';
        $store_common['disable_checkout_stock_status_name'] = '';

        foreach ($stock_statuses as $status) {
            if ($status['stock_status_id'] == $store_common['preorder_stock_status_id']) {
                $store_common['preorder_stock_status_name'] = $status['name'];
            }
            if ($status['stock_status_id'] == $store_common['backorder_stock_status_id']) {
                $store_common['backorder_stock_status_name'] = $status['name'];
            }
            if ($status['stock_status_id'] == $store_common['disable_checkout_stock_status_id']) {
                $store_common['disable_checkout_stock_status_name'] = $status['name'];
            }
        }

        $themeData->store_common = $store_common;
    }

    public function setProductListingType(TB_ViewDataBag $themeData, Request $request)
    {
        if (isset($_COOKIE['listingType']) && ($_COOKIE['listingType'] == 'grid' || $_COOKIE['listingType'] == 'list')) {
            $listingType = $_COOKIE['listingType'];
        } else {
            $store = $this->getSetting('store');
            $listingType = $store['common']['product_listing_view_mode'];
        }

        $themeData->product_listing_type = $listingType;
    }

    public function setCategorySettings(TB_ViewDataBag $themeData)
    {
        $store = $this->getSetting('store');
        $view_mode = $themeData->product_listing_type;

        $this->getModel('category')->initCategoryProductsSettings($store['category']['products'][$view_mode], $view_mode);

        $themeData->category = $store['category'];
        $themeData->category_products_current = $store['category']['products'][$view_mode];
    }

    public function setPaymentImages(TB_ViewDataBag $themeData)
    {
        $payment_images = $this->getSetting('payment_images');

        if (isset($payment_images['rows']) && !empty($payment_images['rows'])) {
            foreach($payment_images['rows'] as $key => &$image) {
                if (!isset($image['file']) || empty($image['file']) || !is_file(DIR_IMAGE . $image['file'])) {
                    unset($payment_images['rows'][$key]);
                    continue;
                }

                $image['http_file'] = $this->context->getImageUrl() . $image['file'];
                if ($this->context->getThemeConfig('catalog_set_image_dimensions')) {
                    list($image['width'], $image['height']) = getimagesize(DIR_IMAGE . $image['file']);
                }
            }
        } else {
            $payment_images = array();
        }

        $themeData->payment_images = $payment_images;
    }

    protected function setTemplateVars(TB_ViewDataBag $themeData)
    {
        $url = $this->manager->getOcUrl();

        if ($this->manager->gteOc2()) {
            $themeData['text_welcome'] = sprintf($themeData['text_welcome'], $url->link('account/login', '', 'SSL'), $url->link('account/register', '', 'SSL'));
            $themeData['text_logged'] = sprintf($themeData['text_logged'], $url->link('account/account', '', 'SSL'), $this->manager->getOcCustomer()->getFirstName(), $url->link('account/logout', '', 'SSL'));
        }

        $themeData->gteOc2 = $this->manager->gteOc2();
    }


    protected function addJavascriptVars(TB_ViewDataBag $themeData)
    {
        $themeData->addJavascriptVar('tb/category_path',              $themeData->category_path, false);
        $themeData->addJavascriptVar('tb/is_touch',                   $themeData->is_touch, false);
        $themeData->addJavascriptVar('tb/basename',                   $themeData->basename);
        $themeData->addJavascriptVar('tb/theme_stylesheet_url',       $themeData->theme_stylesheet_url);
        $themeData->addJavascriptVar('tb/theme_catalog_resource_url', $themeData->theme_catalog_resource_url);
        $themeData->addJavascriptVar('tb/image_url',                  $this->context->getImageUrl());
        $themeData->addJavascriptVar('tb/shopping_cart_url',          $this->manager->getOcUrl()->link('checkout/cart'));
        $themeData->addJavascriptVar('tb/wishlist_url',               $this->manager->getOcUrl()->link('account/wishlist'));
        $themeData->addJavascriptVar('tb/compare_url',                $this->manager->getOcUrl()->link('product/compare'));
        $themeData->addJavascriptVar('tb/is_customer_logged',         (int) $this->manager->getOcCustomer()->isLogged(), false);

        $style = $this->getSetting('style');
        $themeData->addJavascriptVar('tb/msg_position', $style['msg_position']);
        $themeData->addJavascriptVar('tb/msg_stack',    $style['msg_stack']);
        $themeData->addJavascriptVar('tb/msg_timeout',  $style['msg_timeout']);

        $themeData->addJavascriptVar('lang/text_failure',            $themeData->text_failure);
        $themeData->addJavascriptVar('lang/text_continue',           $themeData->text_continue);
        $themeData->addJavascriptVar('lang/text_continue_shopping',  $themeData->text_continue_shopping);
        $themeData->addJavascriptVar('lang/text_shopping_cart',      $themeData->text_shopping_cart);
        $themeData->addJavascriptVar('lang/text_wishlist',           $themeData->text_wishlist);
        $themeData->addJavascriptVar('lang/text_cart_updated',       $themeData->text_cart_updated);
        $themeData->addJavascriptVar('lang/text_wishlist_updated',   $themeData->text_wishlist_updated);
        $themeData->addJavascriptVar('lang/text_compare_updated',    $themeData->text_compare_updated);
        $themeData->addJavascriptVar('lang/text_product_comparison', $themeData->text_product_comparison);
        $themeData->addJavascriptVar('lang/text_previous',           $themeData->text_previous);
        $themeData->addJavascriptVar('lang/text_next',               $themeData->text_next);
    }
}