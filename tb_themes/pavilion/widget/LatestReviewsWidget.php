<?php

class Theme_LatestReviewsWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');
    protected $reviews;

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'   => 1,
            'title'       => 'Latest Reviews',
            'title_align' => 'left'
        ), $settings));

        $config = $this->manager->getOcConfig();

        $settings = array_replace($settings, $this->initFlatVars(array(
            'show_thumb'               => 1,
            'show_price'               => 0,
            'show_text'                => 1,
            'rating_type'              => 'review',
            'tooltip_review'           => 0,
            'slider'                   => 0,
            'slider_step'              => 1,
            'slider_speed'             => 500,
            'slider_pagination'        => 0,
            'slider_nav_position'      => 'top',
            'filter_randomize'         => 0,
            'filter_category'          => 0,
            'filter_category_children' => 0,
            'filter_limit'             => 4,
            'image_size_x'             => $config->get('config_image_product_width'),
            'image_size_y'             => $config->get('config_image_product_height')
        ), $settings));
    }

    public function initFrontend()
    {
        $this->manager->getEventDispatcher()->connect('core:assignAssets', array($this, 'assignAssets'));
    }

    public function assignAssets()
    {
        if ($this->settings['slider']) {
            $this->themeData->registerJavascriptResource('swiper.min.js');
            $this->themeData->registerStylesheetResource('swiper.css');
        }
    }

    public function render(array $view_data = array())
    {
        $view_data['reviews'] = $this->getReviews();

        $settings = $this->settings;

        $slider = $settings['slider'];

        if (count($view_data['reviews']) <= 1) {
            $slider = 0;
        }

        $view_data['show_text']        = $settings['show_text'];
        $view_data['slider']           = $slider;
        $view_data['slider_step']      = 1;
        $view_data['listing_classes']  = $slider ? ' tb_slider' : ' tb_no_slider';
        $view_data['listing_classes'] .= $settings['tooltip_review'] && $settings['show_text'] ? ' tb_listing tb_compact_view tb_review_tooltip' : ' tb_list_view';

        return parent::render($view_data);
    }

    protected function getReviews()
    {
        if (null === $this->reviews) {
            $options = array();

            if (isset($this->settings['filter_category']) && $this->settings['filter_category'] != 0) {
                if ($this->settings['filter_category'] == -1) {
                    $category_id = $this->themeData->category_id ? $this->themeData->category_id : 0;
                } else {
                    $category_id = (int) $this->settings['filter_category'];
                }

                if ($category_id) {
                    if ($this->settings['filter_category_children']) {
                        $category = $this->getThemeModel('category')->getCategoryFromFlatTree($category_id);
                        $options['category_ids'] = array($category_id) + $category['successor_ids'];
                    } else {
                        $options['category_ids'] = array($category_id);
                    }
                }
            }

            $options['filter_limit'] = (int) $this->settings['filter_limit'];
            $options['show_price'] = $this->settings['show_price'];
            $options['show_average'] = $this->settings['rating_type'] == 'average';

            $reviews = $this->getThemeModel('products')->getLatestReviews($options);
            $config = $this->manager->getOcConfig();
            $translation = $this->manager->loadOcTranslation();

            foreach ($reviews as &$product) {
                if ($this->settings['show_thumb'] && $product['image']) {
                    $product['thumb'] = $this->getThemeModel()->resizeImage($product['image'], $this->settings['image_size_x'], $this->settings['image_size_y']);
                    $product['thumb_width'] = $this->settings['image_size_x'];
                    $product['thumb_height'] = $this->settings['image_size_y'];
                } else {
                    $product['thumb'] = false;
                }

                if ($this->settings['show_price']) {
                    $price = ($product['discount'] ? $product['discount'] : $product['price']);

                    if (($config->get('config_customer_price') && $this->manager->getOcCustomer()->isLogged()) || !$config->get('config_customer_price')) {
                        $tax = $this->manager->getOcTax()->calculate($price, $product['tax_class_id'], $config->get('config_tax'));
                        $product['price'] = $this->manager->getOcCurrency()->format($tax);
                    } else {
                        $product['price'] = false;
                    }

                    $product['special_num'] = (float) $product['special'];

                    if ($product['special_num']) {
                        $tax = $this->manager->getOcTax()->calculate($product['special'], $product['tax_class_id'], $config->get('config_tax'));
                        $product['special'] = $this->manager->getOcCurrency()->format($tax);
                    } else {
                        $product['special'] = false;
                    }
                } else {
                    $product['price'] = false;
                }

                $product['href'] = $this->manager->getOcUrl()->link('product/product', 'product_id=' . $product['product_id']);
                $product['rating'] = $this->settings['rating_type'] == 'review' ? $product['rating'] : $product['avg_rating'];
                $product['date_added'] = date($translation['date_format_short'], strtotime($product['date_added']));
            }

            if ($this->settings['filter_randomize']) {
                shuffle($reviews);
            }

            $this->reviews = $reviews;
        }

        return $this->reviews;
    }

    public function getDefaultColors()
    {
        $default_colors = array(
            'product_listing' => array(
                '_label' => 'Product Listing',
                'product_title' => array(
                    'label'       => 'Product title',
                    'elements'    => '.tb_listing .tb_product h3, .tb_product h3 a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_title'
                ),
                'product_title_hover' => array(
                    'label'       => 'Product title (hover)',
                    'elements'    => '.tb_product h3 a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_title_hover'
                ),
                'product_price' => array(
                    'label'       => 'Price',
                    'elements'    => '.tb_product .tb_price',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_price'
                ),
                'product_promo_price' => array(
                    'label'       => 'Promo price',
                    'elements'    => '.tb_product .tb_promo_price',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_promo_price'
                ),
                'product_text' => array(
                    'label'       => 'Product text',
                    'elements'    => '.tb_product',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_text'
                ),
                'product_rating_percent' => array(
                    'label'       => 'Rating stars (rate)',
                    'elements'    => '.tb_product .tb_rating .tb_percent',
                    'property'    => 'color',
                    'color'       => '#ffd200',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_rating_percent'
                ),
                'product_rating_base' => array(
                    'label'       => 'Rating stars (base)',
                    'elements'    => '.tb_product .tb_rating .tb_base',
                    'property'    => 'color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_rating_base'
                ),
                'product_rating_text' => array(
                    'label'       => 'Rating text',
                    'elements'    => '.tb_product .tb_rating_holder .tb_average',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_text'
                ),
            ),
            'slider' => array(
                '_label' => 'Slider',
                'button_default' => array(
                    'label'       => 'Prev/Next button',
                    'elements'    => '.tb_slider_controls a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                ),
                'button_hover' => array(
                    'label'       => 'Prev/Next button (hover)',
                    'elements'    => '.tb_slider_controls a:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent_hover'
                ),
                'button_inactive' => array(
                    'label'       => 'Prev/Next button (inactive)',
                    'elements'    => '.tb_slider_controls a.tb_disabled, .tb_slider_controls a.tb_disabled:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'slider.button_hover'
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.tb_slider_pagination span',
                    'property'    => 'background-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_hover' => array(
                    'label'       => 'Pagination (hover)',
                    'elements'    => '.tb_slider_pagination span:hover',
                    'property'    => 'background-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_active' => array(
                    'label'       => 'Pagination (active)',
                    'elements'    => '.tb_slider_pagination span.tb_active, .tb_slider_pagination span.tb_active:hover',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            )
        );

        return $default_colors;
    }


}