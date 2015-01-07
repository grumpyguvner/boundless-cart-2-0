<?php

require_once dirname(__FILE__) . '/../../model/categoryModel.php';

class Theme_Catalog_CategoryModel extends Theme_CategoryModel
{
    public function getCategorySuccessorIds($category_id)
    {
        $category = $this->getCategoryFromFlatTree($category_id);
        if (false === $category) {
            return array();
        }

        return $category['successor_ids'];
    }

    public function initCategoryProductsSettings(&$products, $view_mode)
    {
        $themeData = $this->manager->getThemeData();

        $restrictions_json = array();
        if (isset($products['restrictions'])) {
            foreach ($products['restrictions'] as $restriction) {
                $restrictions_json[$restriction['max_width']] = array(
                    'items_per_row' => $restriction['items_per_row'],
                    'items_spacing' => $restriction['items_spacing']
                );
            }
            krsort($restrictions_json);
        }
        $products['restrictions_json'] = json_encode($restrictions_json);

        $products['listing_classes']  = 'tb_'        . $view_mode . '_view';
        $products['listing_classes'] .= ' tb_style_' . $products['products_style'];
        $products['listing_classes'] .= $themeData->is_touch ? ' tb_hover_none' : ' tb_hover_' . $products['elements_hover_action'];

        if($products['products_style'] != 1 || ($products['products_style'] == 1 && ($products['elements_hover_action'] == 'overlay' || $products['elements_hover_action'] == 'flip'))) {
            $products['listing_classes']  .= ' tb_product_p_' . $products['product_inner_padding'];
        }
        if($products['exclude_thumbnail']) {
            $products['listing_classes']  .= ' tb_exclude_thumb';
        }

        $products['price_classes']  = ' tb_size_' . $products['price_size'];
        $products['price_classes'] .= ' tb_'     . $products['price_design'];

        $products['show_thumb']      = $products['thumb_default']       || (isset($products['thumb_hover'])       && $products['thumb_hover']);
        $products['show_title']      = $products['title_default']       || (isset($products['title_hover'])       && $products['title_hover']);
        $products['show_desc']       = $products['description_default'] || (isset($products['description_hover']) && $products['description_hover']);
        $products['show_price']      = $products['price_default']       || (isset($products['price_hover'])       && $products['price_hover']);
        $products['show_cart']       = $products['cart_default']        || (isset($products['cart_hover'])        && $products['cart_hover']);
        $products['show_compare']    = $products['compare_default']     || (isset($products['compare_hover'])     && $products['compare_hover']);
        $products['show_wishlist']   = $products['wishlist_default']    || (isset($products['wishlist_hover'])    && $products['wishlist_hover']);
        $products['show_rating']     = $products['rating_default']      || (isset($products['rating_hover'])      && $products['rating_hover']);
        $products['show_label_sale'] = $products['label_sale_default']  || (isset($products['label_sale_hover'])  && $products['label_sale_hover']);
        $products['show_label_new']  = $products['label_new_default']   || (isset($products['label_new_hover'])   && $products['label_new_hover']);
        $products['show_stock']      = $products['stock_default']       || (isset($products['stock_hover'])       && $products['stock_hover']);

        // Cart button classes
        $products['cart_button_classes']          = '';
        $products['cart_button_position_classes'] = '';
        $products['cart_button_offset_attr']      = '';

        if ($products['cart_button_type'] == 'button' || $view_mode == 'list') {
            $products['cart_button_classes'] = 'tb_button tb_h_' . $products['cart_button_size'];
        }
        if ($products['cart_button_type'] == 'icon_button' && $view_mode != 'list') {
            $products['cart_button_classes'] = 'tb_button tb_h_' . $products['cart_button_size'] . ' tb_no_text';
        }
        if ($products['cart_button_type'] == 'box' && $view_mode != 'list') {
            $products['cart_button_classes'] = 'tb_button tb_plain tb_h_' . $products['cart_button_size'];
        }
        if ($products['cart_button_type'] == 'icon_box' && $view_mode != 'list') {
            $products['cart_button_classes'] = 'tb_button tb_plain tb_h_' . $products['cart_button_size'] . ' tb_no_text';
        }
        if ($products['cart_button_icon']) {
            $products['cart_button_classes'] .= ' tb_icon_' . $products['cart_button_icon_size'] . ' ' . $products['cart_button_icon'];
        }
        if ($products['cart_button_position'] != '1' && $view_mode != 'list' && $view_mode != 'compact') {
            $products['cart_button_position_classes'] .= ' tb_position_' . $products['cart_button_position'];
            $products['cart_button_position_classes'] .= $products['cart_button_position'] != '2' && $products['cart_button_hover'] ? ' tb_hidden' : '';
            $products['cart_button_position_classes'] .= $products['cart_button_type'] == 'button' ? ' tb_h_' . $products['cart_button_size'] : '';
            $products['cart_button_position_classes'] .= $products['cart_button_type'] == 'icon_button' ? ' tb_h_' . $products['cart_button_size'] . ' tb_no_text' : '';
            $products['cart_button_position_classes'] .= $products['cart_button_type'] == 'box' ? ' tb_h_' . $products['cart_button_size'] : '';
            $products['cart_button_position_classes'] .= $products['cart_button_type'] == 'icon_box' ? ' tb_h_' . $products['cart_button_size'] . ' tb_no_text' : '';
            $products['cart_button_offset_attr']      .= $products['cart_button_offset'] ? ' style="margin: ' . $products['cart_button_offset'] . ';"' : '';
        }

        // Compare button classes
        $products['compare_button_classes']          = '';
        $products['compare_button_position_classes'] = '';
        $products['compare_button_offset_attr']      = '';

        if ($products['compare_button_type'] == 'button' && $view_mode != 'list') {
            $products['compare_button_classes'] = 'tb_button tb_h_' . $products['compare_button_size'];
        }
        if ($products['compare_button_type'] == 'icon_button' && $view_mode != 'list') {
            $products['compare_button_classes'] = 'tb_button tb_h_' . $products['compare_button_size'] . ' tb_no_text';
        }
        if ($products['compare_button_type'] == 'box' && $view_mode != 'list') {
            $products['compare_button_classes'] = 'tb_button tb_plain tb_h_' . $products['compare_button_size'];
        }
        if ($products['compare_button_type'] == 'icon_box' && $view_mode != 'list') {
            $products['compare_button_classes'] = 'tb_button tb_plain tb_h_' . $products['compare_button_size'] . ' tb_no_text';
        }
        if ($view_mode == 'list') {
            $products['compare_button_icon_size'] = 10;
        }
        if ($products['compare_button_icon']) {
            $products['compare_button_classes'] .= ' tb_icon_' . $products['compare_button_icon_size'] . ' ' . $products['compare_button_icon'];
        }
        if ($products['compare_button_position'] != '1' && $view_mode != 'list' && $view_mode != 'compact') {
            $products['compare_button_position_classes'] .= ' tb_position_' . $products['compare_button_position'];
            $products['compare_button_position_classes'] .= $products['compare_button_position'] != '2' && $products['compare_button_hover'] ? ' tb_hidden' : '';
            $products['compare_button_position_classes'] .= $products['compare_button_type'] == 'button' ? ' tb_h_' . $products['compare_button_size'] : '';
            $products['compare_button_position_classes'] .= $products['compare_button_type'] == 'icon_button' ? ' tb_h_' . $products['compare_button_size'] . ' tb_no_text' : '';
            $products['compare_button_position_classes'] .= $products['compare_button_type'] == 'box' ? ' tb_h_' . $products['compare_button_size'] : '';
            $products['compare_button_position_classes'] .= $products['compare_button_type'] == 'icon_box' ? ' tb_h_' . $products['compare_button_size'] . ' tb_no_text' : '';
            $products['compare_button_offset_attr']      .= $products['compare_button_offset'] ? ' style="margin: ' . $products['compare_button_offset'] . ';"' : '';
        }

        // Wishlist button classes
        $products['wishlist_button_classes']          = '';
        $products['wishlist_button_position_classes'] = '';
        $products['wishlist_button_offset_attr']      = '';

        if ($products['wishlist_button_type'] == 'button' && $view_mode != 'list') {
            $products['wishlist_button_classes'] = 'tb_button tb_h_' . $products['wishlist_button_size'];
        }
        if ($products['wishlist_button_type'] == 'icon_button' && $view_mode != 'list') {
            $products['wishlist_button_classes'] = 'tb_button tb_h_' . $products['wishlist_button_size'] . ' tb_no_text';
        }
        if ($products['wishlist_button_type'] == 'box' && $view_mode != 'list') {
            $products['wishlist_button_classes'] = 'tb_button tb_plain tb_h_' . $products['wishlist_button_size'];
        }
        if ($products['wishlist_button_type'] == 'icon_box' && $view_mode != 'list') {
            $products['wishlist_button_classes'] = 'tb_button tb_plain tb_h_' . $products['wishlist_button_size'] . ' tb_no_text';
        }
        if ($view_mode == 'list') {
            $products['wishlist_button_icon_size'] = 10;
        }
        if ($products['wishlist_button_icon']) {
            $products['wishlist_button_classes'] .= ' tb_icon_' . $products['wishlist_button_icon_size'] . ' ' . $products['wishlist_button_icon'];
        }
        if ($products['wishlist_button_position'] != '1' && $view_mode != 'list' && $view_mode != 'compact') {
            $products['wishlist_button_position_classes'] .= ' tb_position_' . $products['wishlist_button_position'];
            $products['wishlist_button_position_classes'] .= $products['wishlist_button_position'] != '2' && $products['wishlist_button_hover'] ? ' tb_hidden' : '';
            $products['wishlist_button_position_classes'] .= $products['wishlist_button_type'] == 'button' ? ' tb_h_' . $products['wishlist_button_size'] : '';
            $products['wishlist_button_position_classes'] .= $products['wishlist_button_type'] == 'icon_button' ? ' tb_h_' . $products['wishlist_button_size'] . ' tb_no_text' : '';
            $products['wishlist_button_position_classes'] .= $products['wishlist_button_type'] == 'box' ? ' tb_h_' . $products['wishlist_button_size'] : '';
            $products['wishlist_button_position_classes'] .= $products['wishlist_button_type'] == 'icon_box' ? ' tb_h_' . $products['wishlist_button_size'] . ' tb_no_text' : '';
            $products['wishlist_button_offset_attr']      .= $products['wishlist_button_offset'] ? ' style="margin: ' . $products['wishlist_button_offset'] . ';"' : '';
        }
        
        if ($products['cart_button_position'] != '1' && $products['cart_button_position'] != '2'
            && $products['compare_button_position'] != '1' && $products['compare_button_position'] != '2'
            && $products['wishlist_button_position'] != '1' && $products['wishlist_button_position'] != '2'
            && $view_mode != 'list' && $view_mode != 'compact')
        {
            $products['listing_classes'] .= ' tb_buttons_2';
        }
        else {
            $products['listing_classes'] .= ' tb_buttons_1';
        }

        // Active & Hover elements
        $products['active_elements'] = '';
        $products['hover_elements']  = '';

        $options = array(
            'thumb'       => '.tb_thumb',
            'title'       => 'h3',
            'description' => '.tb_description',
            'price'       => '.tb_price_holder',
            'cart'        => '.tb_button_add_to_cart',
            'compare'     => '.tb_button_compare',
            'wishlist'    => '.tb_button_wishlist',
            'rating'      => '.tb_rating_holder',
            'label_sale'  => '.tb_label_special',
            'label_new'   => '.tb_label_new',
            'stock'       => '.tb_label_stock_status'
        );

        foreach ($options as $option => $element) {
            if(!$products[$option . '_default'] && isset($products[$option . '_hover']) && $products[$option . '_hover']) {
                $products['active_elements'] .= $element . ', ';
            }
            if($products[$option . '_default'] && (!isset($products[$option . '_hover']) || !$products[$option . '_hover'])) {
                $products['hover_elements'] .= $element . ', ';
            }
        }

        $products['active_elements'] = trim($products['active_elements'], ', ');
        $products['hover_elements']  = trim($products['hover_elements'], ', ');
    }
}