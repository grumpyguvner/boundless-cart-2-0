<?php

class Theme_Catalog_ProductPlugin extends TB_ExtensionPlugin
{
    public function configure(TB_ViewDataBag $themeData)
    {
        $dispatcher = $this->eventDispatcher;

        $dispatcher->connect('product/product.product_buy.filter', array($this, 'filterProduct'));
        $dispatcher->connect('product/product_options.filter',     array($this, 'filterProductOptions'));
        $dispatcher->connect('oc_module_products.filter',          array($this, 'filterOcModuleProducts'));
    }

    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        $this->bootstrap('common');

        $themeData->registerStylesheetResource('fotorama.css');
        $themeData->registerStylesheetResource('swiper.css');

        if ($themeData->route == 'product/product' && isset($this->manager->getOcRequest()->get['product_id'])) {

            $this->setFacebookMeta($themeData);

            $themeData->registerJavascriptResource('fotorama/fotorama.min.js');

            if ($themeData->product['gallery_zoom']) {
                $themeData->registerJavascriptResource('jquery.zoom.min.js');
            }

            $themeData->addCallable(array($this, 'getProductDesign'));

            $product_layout_design_id = 'design_1';
            $product_layout_column_ratio_left = '1_2';
            $product_layout_column_ratio_right = '1_2';
            $product = $this->getSetting('product');

            if (isset($product['designs']['layout'][$themeData->layout_id])) {
                $product_layout_design_id = $product['designs']['layout'][$themeData->layout_id]['design'];
                $ratios = explode('+', $product['designs']['layout'][$themeData->layout_id]['column_ratio']);
                $product_layout_column_ratio_left = $ratios[0];
                $product_layout_column_ratio_right = $ratios[1];
            };

            $themeData->product_layout_design_id = $product_layout_design_id;
            $themeData->product_layout_column_ratio_left = $product_layout_column_ratio_left;
            $themeData->product_layout_column_ratio_right = $product_layout_column_ratio_right;
            $themeData->currency_code = $this->manager->getOcCurrency()->getCode();
        }
    }

    public function setFacebookMeta(TB_ViewDataBag $themeData)
    {
        $fb_meta = '';
        $product_id = (int) $this->manager->getOcRequest()->get['product_id'];
        $product_info = $this->getOcModel('catalog/product')->getProduct($product_id);
        if ($product_info) {
            if ($product_info['image']) {
                $width = $this->manager->getOcConfig()->get('config_image_thumb_width');
                $height = $this->manager->getOcConfig()->get('config_image_thumb_height');
                $thumb = $this->getModel()->resizeImage($product_info['image'], $width, $height);
            } else {
                $thumb = $themeData->res_url . '/image/no_image.jpg';
            }
            $fb_meta = '<meta property="og:image" content="' . $thumb . '" />';
        }

        $themeData->fbMeta = $fb_meta;
    }

    public function calculateProductsPerRow(array &$restrictions, array $sizes)
    {
        $style = $this->getThemeData()->style;
        $current_area_name = $sizes['area_name'];

        $has_left_column = ($current_area_name == 'column_left' || $this->getThemeData()->areaExists('column_left'));
        $has_right_column = ($current_area_name == 'column_right' || $this->getThemeData()->areaExists('column_right'));
        $content_wrap_layout = $this->getThemeData()->getAreaSettings('content', 'layout');
        
        if (in_array($current_area_name, array('content', 'column_left', 'column_right'))) {
            $current_area_layout = $this->getThemeData()->getAreaSettings('content', 'layout');
        } else {
            $current_area_layout = $this->getThemeData()->getAreaSettings($current_area_name, 'layout');
        }

        $width = $style['maximum_width'];
        $fixed = false;

        if ($style['wrapper']['layout']['type'] == 'fixed') {
            $width -= (int) $style['wrapper']['layout']['padding_right'] * 2;
            $width -= (int) $current_area_layout['margin_right'] * 2;
            $fixed  = true;
        }

        if ($current_area_layout['type'] == 'fixed' || $fixed) {
            $width -= (int) $current_area_layout['padding_right'] * 2;
        }

        if (in_array($current_area_name, array('content', 'column_left', 'column_right'))) {
            if ($current_area_name == 'column_left') {
                $width = $content_wrap_layout['left_column_width'];
            }

            if ($current_area_name == 'column_right') {
                $width = $content_wrap_layout['right_column_width'];
            }

            if ($current_area_name == 'content' && $has_left_column) {
                $width -= $content_wrap_layout['left_column_width'];
                if ($content_wrap_layout['type'] != 'content_separate') {
                    $width -= $content_wrap_layout['columns_gutter'];
                }
            }
            if ($current_area_name == 'content' && $has_right_column) {
                $width -= $content_wrap_layout['right_column_width'];
                if ($content_wrap_layout['type'] != 'content_separate') {
                    $width -= $content_wrap_layout['columns_gutter'];
                }
            }
            if ($content_wrap_layout['type'] == 'content_separate') {
                $width -= $content_wrap_layout['inner_padding'] * 2;
            }
        }

        if ($current_area_layout['type'] == 'fixed' || $fixed) {
            $width -= $sizes['row_margin'];
        }

        if ($current_area_layout['type'] == 'fixed' || $sizes['row_layout'] == 'fixed' || $fixed) {
            $width -= $sizes['row_padding'];
        }

        if ($sizes['columns_num'] > 1 && $sizes['row_layout'] != 'separate') {
            $width -= ($sizes['columns_num'] - 1) * $sizes['column_spacing'];
            list($numerator, $denominator) = explode('_', $sizes['grid_proportion']);
            $width = round($width * ($numerator / $denominator));
        }

        if ($sizes['columns_num'] > 1 && $sizes['row_layout'] == 'separate') {
            list($numerator, $denominator) = explode('_', $sizes['grid_proportion']);
            $width = round($width * ($numerator / $denominator)) - $sizes['column_padding'];
        }

        $width -= $sizes['group_margin'];
        $width -= $sizes['group_padding'];
        $width -= $sizes['widget_margin'];
        $width -= $sizes['widget_padding'];

        $items_per_row = 0;
        $items_spacing = 0;
        $restriction = reset($restrictions);

        foreach ($restrictions as $current_restriction) {
            if ($current_restriction['max_width'] >= $width) {
                $restriction = $current_restriction;
            }
        }

        if ($restriction) {
            $items_per_row = (int) $restriction['items_per_row'];
            $items_spacing = (int) $restriction['items_spacing'];
        }

        $restrictions = array(
            'items_per_row' => $items_per_row,
            'items_spacing' => $items_spacing
        );
    }

    public function getProductDesign($data)
    {
        $design_id = $this->manager->getThemeData()->product_layout_design_id;
        $design = $this->getModel()->getProductDesign($design_id, $data);

        return $design['rows'];
    }

    public function filterOcModuleProducts(sfEvent $event, array $data)
    {
        $this->modifyProducts($data['products'], $this->getThemeData()->category_products_current);
    }

    public function filterProduct(sfEvent $event, array $data)
    {
        $product_info = $this->getModel('products')->getProductInfo($event['data']['product_id']);
        if ($product_info['quantity'] < 1) {

            if (!$this->getThemeData()->common['checkout_enabled'] || !$this->manager->getOcConfig()->get('config_stock_checkout') ||  $this->getThemeData()->store_common['disable_checkout_stock_status_name'] == $event['data']['stock']) {
                $data['button_cart'] = false;

                return;
            }

            if ($this->getThemeData()->store_common['preorder_stock_status_name'] == $event['data']['stock']) {
                $data['button_cart'] = $this->extension->translate('text_status_preorder');
            }

            if ($this->getThemeData()->store_common['backorder_stock_status_name'] == $event['data']['stock']) {
                $data['button_cart'] = $this->extension->translate('text_status_backorder');
            }
        }
    }

    public function filterProductOptions(sfEvent $event, $options)
    {
        if ($options) {
            $themeData = $this->getThemeData();

            foreach ($options as &$option) {
                $option['tb_css_classes'] = '';
                if (isset($themeData['product']['designs']['option'][$option['option_id']])) {
                    $option_settings = $themeData['product']['designs']['option'][$option['option_id']];
                    $option['tb_css_classes'] = $option_settings['style_id'];
                    if ($option['type'] == 'image') {
                        $option['image_width'] = $option_settings['image_width'];
                        $option['image_height'] = $option_settings['image_height'];
                    }
                }
            }
        }

        return $options;
    }


    public function modifyProducts(array &$products, $settings)
    {
        $options = array(
            'secondary_image' => false
        );

        if (in_array($settings['thumbs_hover_action'], array('overlay', 'flip'))) {
            $options['secondary_image'] = true;
        }

        $this->getModel('products')->mergeProducts($products, $options);
        $this->addProductData($products, $settings);
    }

    public function addProductData(array &$products, $settings)
    {
        $config = $this->manager->getOcConfig();
        $themeData = $this->getThemeData();

        $resize_images = false;
        $img_width = $settings['image_width'];
        $img_height = $settings['image_height'];
        if ($config->get('config_image_product_width') != $img_width || $config->get('config_image_product_height') != $img_height) {
            $resize_images = true;
        }

        $last_products_indexes = array();
        if (count($products) > 0) {
            foreach (range(2, 8) as $key) {
                $last_products_indexes[$key] = (ceil(count($products) / $key) - 1) * $key;
            }
        }

        $time = time();
        $label_new_days = $themeData->common['label_new_days'];
        $i = 1;

        foreach ($products as &$product) {

            $clear_class = '';
            if (is_int(($i-1)/2)) $clear_class .= ' clear2';
            if (is_int(($i-1)/3)) $clear_class .= ' clear3';
            if (is_int(($i-1)/4)) $clear_class .= ' clear4';
            if (is_int(($i-1)/5)) $clear_class .= ' clear5';
            if (is_int(($i-1)/6)) $clear_class .= ' clear6';
            if (is_int(($i-1)/7)) $clear_class .= ' clear7';
            if (is_int(($i-1)/8)) $clear_class .= ' clear8';

            $product['tb_classes']  = 'tb_id_' . $product['product_id'];
            $product['tb_classes'] .= $clear_class;

            foreach ($last_products_indexes as $key => $index) {
                if ($i > $index) {
                    $product['tb_classes'] .= ' tb_size_' . $key . '_last';
                }
            }

            if (($config->get('config_customer_price') && $this->manager->getOcCustomer()->isLogged()) || !$config->get('config_customer_price')) {
                $product['price_num'] = $this->manager->getOcTax()->calculate($product['price_num'], $product['tax_class_id'], $config->get('config_tax'));
            } else {
                $product['price_num'] = false;
            }
            if ((float) $product['special_num']) {
                $product['special_num'] = $this->manager->getOcTax()->calculate($product['special_num'], $product['tax_class_id'], $config->get('config_tax'));
            } else {
                $product['special_num'] = false;
            }

            if ($product['special_num'] && $product['price_num']) {
                $product['savings_num'] = round((1 - $product['special_num'] / $product['price_num'] ) * 100);
            } else {
                $product['savings_num'] = false;
            }

            $product['thumb_width'] = $img_width;
            $product['thumb_height'] = $img_height;
            if ((!isset($product['thumb']) || $resize_images) && $product['image']) {
                $product['thumb'] = $this->getModel()->resizeImage($product['image'], $img_width, $img_height);
            } else
            if (!isset($product['thumb'])) {
                $product['thumb'] = false;
            } else
            if ($product['image']) {
                list($product['thumb_width'], $product['thumb_height']) = getimagesize(DIR_IMAGE . 'cache/' . dirname($product['image']) . '/' . basename($product['thumb']));
            }

            if ($settings['thumbs_hover_action'] == 'zoom') {
                $product['thumb_zoom'] = $this->getModel()->resizeImage($product['image'], $config->get('config_image_thumb_width'), $config->get('config_image_thumb_height'));
            } else {
                $product['thumb_zoom'] = false;
            }

            if (($settings['thumbs_hover_action'] == 'overlay' || $settings['thumbs_hover_action'] == 'flip') && !empty($product['secondary_image'])) {
                $product['thumb_hover'] = $this->getModel()->resizeImage($product['secondary_image'], $img_width, $img_height);
            } else {
                $product['thumb_hover'] = false;
            }

            if (isset($product['description'])) {
                $product['description'] = tb_trim($product['description'], '.');
                if ($product['description']) {
                    $product['description'] = html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8');
                    $product['description'] = utf8_substr(strip_tags($product['description']), 0, $settings['description_limit']) . '...';
                }
            }

            $date1 = strtotime($product['date_available']);
            $date2 = strtotime($product['date_added']);

            $is_new = $label_new_days > ($time - ($date1 > $date2 ? $date1 : $date2)) / 86400;
            $product['is_new'] = $is_new ? 1 : 0;
            $product['rating'] = $config->get('config_review_status') ? round($product['rating'], 1) : false;

            $lang = $this->manager->loadOcTranslation();
            $text_button_cart = $lang['button_cart'];

            if (isset($product['quantity']) && $product['quantity'] < 1) {
                if ($themeData->store_common['preorder_stock_status_name'] == $product['stock_status']) {
                    $text_button_cart = $this->extension->translate('text_status_preorder');
                }

                if ($themeData->store_common['backorder_stock_status_name'] == $product['stock_status']) {
                    $text_button_cart = $this->extension->translate('text_status_backorder');
                }
            }

            $product['text_button_cart'] = $text_button_cart;
            $product['show_stock'] = $settings['show_stock'];
            $product['show_cart'] = isset($product['quantity']) && ($product['quantity'] > 0 || $this->manager->getOcConfig()->get('config_stock_checkout')) && $themeData->common['checkout_enabled'] && $settings['show_cart'] && $product['price'] && (!$themeData->store_common['disable_checkout_stock_status_name'] || $themeData->store_common['disable_checkout_stock_status_name'] != $product['stock_status']);

            $i++;
        }
    }
}