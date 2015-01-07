<?php

abstract class AbstractProductsListingWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');
    protected $frontend_data = array();

    public function onFilterSystem(array &$settings)
    {
        $default_vars = array(
            'filter_randomize'    => 0,
            'slider'              => 0,
            'slider_step'         => 1,
            'slider_speed'        => 500,
            'slider_pagination'   => 0,
            'slider_nav_position' => 'top',
            'inherit_products'    => 1,
            'view_mode'           => 'grid',
            'products'  => array(
                'image_width'  => 200,
                'image_height' => 200
            )
        );

        $inherit_products = isset($settings['inherit_products']) ? $settings['inherit_products'] : $default_vars['inherit_products'];

        if ($inherit_products) {
            $theme_settings = $this->manager->getThemeExtension()->getSettings();
            $result = $this->initFlatVars($default_vars, $settings);

            if (isset($settings['products'])) {
                $result['products'] = $this->initFlatVars($default_vars['products'], $settings['products']);
            }

            if (isset($theme_settings['store']['category']['products'])) {
                $result['products'] = array_replace($result['products'], $theme_settings['store']['category']['products']);
            } else {
                $result['products'] = array_replace($this->getThemeModel('store')->getProductsDefaultSettings(), $result['products']);
            }
        } else {
            $default_vars['products'] = array_replace($this->getThemeModel('store')->getProductsDefaultSettings(), $default_vars['products']);
            $result = $this->initFlatVars($default_vars, $settings);
            if (isset($settings['products'])) {
                $result['products'] = $this->initFlatVars($default_vars['products'], $settings['products']);
                $result['products']['grid'] = TB_FormHelper::initFlatVarsSimple($default_vars['products']['grid'], $result['products']['grid']);
                $result['products']['list'] = TB_FormHelper::initFlatVarsSimple($default_vars['products']['list'], $result['products']['list']);
                $result['products']['compact'] = TB_FormHelper::initFlatVarsSimple($default_vars['products']['compact'], $result['products']['compact']);
            }
        }

        if  ($result['view_mode'] == 'grid') {
            foreach ($result['products']['grid']['restrictions'] as $i => $row) {
                if (empty($row['max_width']) || empty($row['items_per_row'])) {
                    unset($result['products']['grid']['restrictions'][$i]);
                }
            }

            if (empty($result['products']['grid']['restrictions'])) {
                $theme_settings = $this->manager->getThemeExtension()->getSettings();
                $result['products']['grid']['restrictions'] = $theme_settings['store']['category']['products']['grid']['restrictions'];
            }
        }

        $settings = array_replace($settings, $result);

        parent::onFilterSystem($settings);
    }

    public function onPersist(array &$settings)
    {
        if (isset($settings['inherit_products']) && $settings['inherit_products']) {
            unset($settings['products']);
        } else {
            $settings['products'] = array(
                $settings['view_mode'] => $settings['products'][$settings['view_mode']]
            );
        }
    }

    public function initFrontend()
    {
        $this->manager->getEventDispatcher()->connect('core:assignAssets', array($this, 'assignAssets'));
    }

    public function configureFrontend()
    {
        $this->manager->getEventDispatcher()->connect('core:pluginsPostBootstrap', array($this, 'setProductsOptions'));
    }

    public function assignAssets()
    {
        if ($this->settings['slider']) {
            $this->themeData->registerJavascriptResource('swiper.min.js');
        }
    }

    public function setProductsOptions()
    {
        if ($this->settings['inherit_products']) {
            $product_settings = $this->themeData->category['products'][$this->settings['view_mode']];
        } else {
            $product_settings = $this->settings['products'][$this->settings['view_mode']];
        }

        if (isset($this->settings['filter_category']) && (int) $this->settings['filter_category'] == -1) {
            $cache_key = $this->getId() . '.' . $this->themeData->category_id . '.' . $this->language_id;
        } else {
            $cache_key = $this->getId() . '.' . $this->language_id;
        }

        $cache_key .= '.' . $this->themeData->currency_code;

        $get_product_listing = true;
        if ($products = $this->manager->getCacheVar($cache_key)) {
            $get_product_listing = false;
        }

        if ($get_product_listing) {
            $products = $this->getProductsListing();
            if ($this->themeData['system']['cache_enabled']
                && $this->themeData['system']['cache_content']
                && isset($this->themeData['system']['cache_widgets'][get_class($this)]['ttl'])
                && $this->themeData['system']['cache_widgets'][get_class($this)]['enabled']
            ) {
                $this->manager->setCacheVar($cache_key, $products, (int) $this->themeData['system']['cache_widgets'][get_class($this)]['ttl'] * 60);
            }
        }


        if ($this->settings['view_mode'] == 'compact') {
            $this->settings['slider'] = 0;
        }
        if ($this->settings['view_mode'] == 'list' && count($products) <= 1) {
            $this->settings['slider'] = 0;
        }
        if ($this->settings['view_mode'] == 'compact') {
            $product_settings['products_style'] = 1;
        }
        if ($product_settings['products_style'] == 2) {
            $product_settings['products_spacing'] = 0;
        }

        $this->getThemeModel('category')->initCategoryProductsSettings($product_settings, $this->settings['view_mode']);
        $this->manager->getThemeExtension()->getPlugin('product')->addProductData($products, $product_settings);

        $product_settings['listing_classes'] .= $this->settings['slider'] && $this->settings['slider_nav_position'] == 'side' ? ' tb_side_nav' : '';

        $this->settings['products'] = array(
            $this->settings['view_mode'] => $product_settings
        );

        $this->frontend_data['products'] = $products;
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {   
        $active_elements = $this->settings['products'][$this->settings['view_mode']]['active_elements'];
        
        if (!$this->themeData->is_touch
            && $active_elements
            && $this->settings['view_mode'] != 'compact'
            && $this->settings['products'][$this->settings['view_mode']]['elements_hover_action'] != 'none'
            && !($this->settings['slider'] && $this->settings['products'][$this->settings['view_mode']]['elements_hover_action'] == 'append'))
        {
            $css = '#' . $this->getDomId() . ' .tb_grid_view .tb_item > .tb_item_info ' . str_replace(', ', ', #' . $this->getDomId() . ' .tb_grid_view .tb_item > .tb_item_info ', $active_elements) . ' {
              display: none;
            }';
            $styleBuilder->addCss($css);
        }
    }

    public function allowAddToAreaContentCache()
    {
        /*
        if (isset($this->settings['filter_category'])
            && (int) $this->settings['filter_category'] == -1
            && $this->themeData->system['cache_enabled']
            && $this->themeData->system['cache_content']
            && isset($this->themeData->system['cache_widgets'][get_class($this)])
            && $this->themeData->system['cache_widgets'][get_class($this)]['enabled']) {

            $this->local_cache = (int) $this->themeData->system['cache_widgets'][get_class($this)]['ttl'];

            return false;
        }
        */

        return true;
    }

    public function onAreaContentOutput(&$html)
    {
        if (!isset($this->settings['products'][$this->settings['view_mode']]['restrictions'])) {
            return;
        }

        $sizes = $this->getSettings('sizes');

        if ($this->getAttribute('grid_proportion')) {
            $sizes['grid_proportion'] = $this->getAttribute('grid_proportion');
        }

        $restrictions = $this->settings['products'][$this->settings['view_mode']]['restrictions'];
        $this->manager->getThemeExtension()->getPlugin('product')->calculateProductsPerRow($restrictions, $sizes);

        $classes = 'tb_gut_' . $restrictions['items_spacing'] . ' tb_size_' . $restrictions['items_per_row'];
        
        if ($this->settings['slider'] &&
           (($this->settings['view_mode'] == 'list' && count($this->frontend_data['products']) > 1)
           || (!$this->themeData->is_touch && count($this->frontend_data['products']) > $restrictions['items_per_row'])))
        {
            $classes .= ' tb_slider_load';
        }

        $html = str_replace('tb_' . $this->getDomId() . '_classes', $classes, $html);
    }

    public function render(array $view_data = array())
    {
        /*
        $cache_key = $this->getId() . '.' . $this->themeData->category_id . '.' . $this->language_id;

        if (!$this->allowAddToAreaContentCache() && $this->local_cache > 0) {
            if ($html = $this->manager->getCacheVar($cache_key)) {
                return $html;
            }
        }
        */

        if (empty($this->frontend_data['products'])) {
            return '';
        }

        $this->settings['products'][$this->settings['view_mode']]['listing_classes'] .= ' tb_' . $this->getDomId() . '_classes';

        $view_data['slider']                = $this->settings['slider'];
        $view_data['slider_step']           = $this->settings['slider_step'];
        $view_data['restrictions_json']     = $this->settings['products'][$this->settings['view_mode']]['restrictions_json'];
        $view_data['config_stock_checkout'] = $this->manager->getOcConfig()->get('config_stock_checkout');

        $view_data = array_merge($view_data, $this->frontend_data);
        $view_data += $this->settings['products'][$this->settings['view_mode']];

        $html = parent::render($view_data);

        /*
        if ($this->local_cache > 0) {
            $this->manager->setCacheVar($cache_key, $html, $this->local_cache);
        }
        */

        return $html;
    }

    protected function getProductsListing(array $options = array())
    {
        $config = $this->manager->getOcConfig();
        $latest_lang = $this->manager->loadOcTranslation('product/product');

        if (in_array($this->settings['products'][$this->settings['view_mode']]['thumbs_hover_action'], array('overlay', 'flip'))) {
            $options['secondary_image'] = true;
        }

        if (isset($this->settings['filter_category']) && $this->settings['filter_category'] != 0) {
            if ($this->settings['filter_category'] == -1) {
                $category_id = $this->themeData->category_id ? $this->themeData->category_id : 0;
            } else {
                $category_id = (int) $this->settings['filter_category'];
            }

            if ($category_id) {
                if ($this->settings['filter_category_children']) {
                    $category = $this->getThemeModel('category')->getCategoryFromFlatTree($category_id);
                    if ($category) {
                        $options['category_ids'] = array($category_id) + $category['successor_ids'];
                    }
                } else {
                    $options['category_ids'] = array($category_id);
                }
            }
        }

        if ($this->settings['filter_randomize']) {
            $options['order'] = 'RAND()';
            $options['sort'] = '';
        }

        $products = $this->getThemeModel('products')->getProducts($options);

        foreach ($products as &$product) {

            $price = ($product['discount'] ? $product['discount'] : $product['price']);
            $product['price_num'] = $price;

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

            $product['secondary_image'] = $options['secondary_image'] ? $product['secondary_image'] : false;
            $product['reviews'] = sprintf($latest_lang['text_reviews'], (int) $product['reviews']);
            $product['href'] = $this->manager->getOcUrl()->link('product/product', 'product_id=' . $product['product_id']);
        }

        if ($this->settings['filter_randomize']) {
            shuffle($products);
        }

        return $products;
    }

    public function getFrontendClasses()
    {
        $classes = parent::getFrontendClasses();
        $slider  = $this->settings['slider'];
        $title = $this->getLangTitle();

        $classes .= ' tb_products_style_' . $this->settings['products'][$this->settings['view_mode']]['products_style'];
        $classes .= !$title ? ' no_title' : '';
        $classes .= $slider ? ' has_slider' : '';
        $classes .= $slider && $this->settings['slider_nav_position'] != 'side' ? ' tb_top_nav' : '';

        return $classes;
    }

    protected function getAdditionalFonts()
    {
        return array(
            'product_title' => array(
                'section_name'      => 'Product Title',
                'elements'          => '.tb_product h3',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 14,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => true,
                'has_effects'       => true,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'product_price' => array(
                'section_name'      => 'Product price',
                'elements'          => '.tb_price_holder .tb_price',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 18,
                'line-height'       => 30,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => true,
                'has_effects'       => true,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'product_add_to_cart' => array(
                'section_name'      => 'Product add to cart',
                'elements'          => '.tb_product .tb_button_add_to_cart > a',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 13,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => true,
                'has_effects'       => true,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            )
        );
    }

    public function getDefaultColors()
    {
        $default_colors = array(
            'body' => array(
                '_label' => '',
                'title' => array(
                    'label'       => 'Block title',
                    'elements'    => 'h2',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.titles'
                )
            ),
            'product_listing' => array(
                '_label' => 'Product listing',
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
                'product_add_to_cart_bg' => array(
                    'label'       => 'Cart button/box',
                    'elements'    => '.tb_product .tb_button_add_to_cart .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_add_to_cart_bg'
                ),
                'product_add_to_cart_text' => array(
                    'label'       => 'Cart button text',
                    'elements'    => '.tb_product .tb_button_add_to_cart a, .tb_product .tb_button_add_to_cart a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_add_to_cart_text'
                ),
                'product_add_to_cart_bg_hover' => array(
                    'label'       => 'Cart button/box (hover)',
                    'elements'    => '.tb_product .tb_button_add_to_cart .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_add_to_cart_bg_hover'
                ),
                'product_add_to_cart_text_hover' => array(
                    'label'       => 'Cart button text (hover)',
                    'elements'    => '.tb_product .tb_button_add_to_cart a:hover, .tb_product .tb_button_add_to_cart a.tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_add_to_cart_text_hover'
                ),
                'product_compare_bg' => array(
                    'label'       => 'Compare button/box',
                    'elements'    => '.tb_product .tb_button_compare .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_compare_bg'
                ),
                'product_compare_text' => array(
                    'label'       => 'Compare button text',
                    'elements'    => '.tb_product .tb_button_compare a, .tb_product .tb_button_compare a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_compare_text'
                ),
                'product_compare_bg_hover' => array(
                    'label'       => 'Compare button/box (hover)',
                    'elements'    => '.tb_product .tb_button_compare .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_compare_bg_hover'
                ),
                'product_compare_text_hover' => array(
                    'label'       => 'Compare button text (hover)',
                    'elements'    => '.tb_product .tb_button_compare a:hover, .tb_product .tb_button_compare a.tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_compare_text_hover'
                ),
                'product_wishlist_bg' => array(
                    'label'       => 'Wishlist button/box',
                    'elements'    => '.tb_product .tb_button_wishlist .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_wishlist_bg'
                ),
                'product_wishlist_text' => array(
                    'label'       => 'Wishlist button text',
                    'elements'    => '.tb_product .tb_button_wishlist a, .tb_product .tb_button_wishlist a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_wishlist_text'
                ),
                'product_wishlist_bg_hover' => array(
                    'label'       => 'Wishlist button/box (hover)',
                    'elements'    => '.tb_product .tb_button_wishlist .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_wishlist_bg_hover'
                ),
                'product_wishlist_text_hover' => array(
                    'label'       => 'Wishlist button text (hover)',
                    'elements'    => '.tb_product .tb_button_wishlist a:hover, .tb_product .tb_button_wishlist a.tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_wishlist_text_hover'
                ),
                'product_list_view_button_bg' => array(
                    'label'       => 'List view button',
                    'elements'    => '.tb_list_view .tb_product .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_list_view_button_bg'
                ),
                'product_list_view_button_text' => array(
                    'label'       => 'List view button text',
                    'elements'    => '.tb_list_view .tb_product [class] .tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_list_view_button_text'
                ),
                'product_list_view_button_bg_hover' => array(
                    'label'       => 'List view button (hover)',
                    'elements'    => '.tb_list_view .tb_product .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_list_view_button_bg_hover'
                ),
                'product_list_view_button_text_hover' => array(
                    'label'       => 'List view button text (hover)',
                    'elements'    => '.tb_list_view .tb_product [class] .tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_list_view_button_text_hover'
                ),
                'product_list_view_links' => array(
                    'label'       => 'List view wishlist/compare',
                    'elements'    => '.tb_list_view .tb_product .tb_button_wishlist a, .tb_list_view .tb_product .tb_button_compare a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_list_view_links'
                ),
                'product_list_view_links_hover' => array(
                    'label'       => 'List view wishlist/compare',
                    'elements'    => '.tb_list_view .tb_product .tb_button_wishlist a:hover, .tb_list_view .tb_product .tb_button_compare a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_list_view_links_hover'
                ),
                'product_sale_label_bg' => array(
                    'label'       => 'Sale label',
                    'elements'    => '.tb_product .tb_label_special',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_sale_label_bg'
                ),
                'product_sale_label_text' => array(
                    'label'       => 'Sale label text',
                    'elements'    => '.tb_product .tb_label_special',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_sale_label_text'
                ),
                'product_separator' => array(
                    'label'       => 'Product border (bordered style)',
                    'elements'    => '
                        .tb_listing.tb_style_2,
                        .tb_listing.tb_style_2 .tb_item,
                        .tb_tabs.tb_vtabs.tb_tabs_left.tb_style_2 [class*="tb_widget"].tb_products_style_2,
                        .tb_tabs.tb_vtabs.tb_tabs_left.tb_style_3 [class*="tb_widget"].tb_products_style_2,
                        .tb_tabs.tb_vtabs.tb_tabs_right.tb_style_2 [class*="tb_widget"] .tb_listing.tb_grid_view.tb_style_2:first-child,
                        .tb_tabs.tb_vtabs.tb_tabs_right.tb_style_3 [class*="tb_widget"] .tb_listing.tb_grid_view.tb_style_2:first-child,
                        .tb_listing.tb_style_2.tb_slider .swiper-container .swiper-wrapper,
                        .tb_listing.tb_style_2.tb_slider ~ .tb_slider_pagination,
                        .tb_listing_options.tb_style_2,
                        .tb_listing.tb_style_2 + .pagination
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_separator'
                ),
                'product_separator_hidden' => array(
                    'label'       => 'Product border (bordered style)',
                    'elements'    => '
                        .tb_listing.tb_grid_view.tb_style_2 .tb_item:after,
                        .tb_listing.tb_style_2.tb_slider:before
                    ',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'product_listing.product_separator'
                ),
                'product_bg' => array(
                    'label'       => 'Product bg',
                    'elements'    => '.tb_products .tb_product, .tb_products .tb_product .tb_front, .tb_listing_options.tb_style_3',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_bg'
                ),
                'product_old_price' => array(
                    'label'       => 'Old price',
                    'elements'    => '.tb_product .tb_old_price',
                    'property'    => 'color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing.product_old_price'
                )
            ),
            'product_listing_hover' => array(
                '_label' => 'Product listing (flip/overlay)',
                'product_title' => array(
                    'label'       => 'Product title',
                    'elements'    => '.tb_listing .tb_product .tb_back h3, .tb_product .tb_back h3 a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_title'
                ),
                'product_title_hover' => array(
                    'label'       => 'Product title (hover)',
                    'elements'    => '.tb_product .tb_back h3 a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_title_hover'
                ),
                'product_price' => array(
                    'label'       => 'Price',
                    'elements'    => '.tb_product .tb_back .tb_price',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_price'
                ),
                'product_promo_price' => array(
                    'label'       => 'Promo price',
                    'elements'    => '.tb_product .tb_back .tb_promo_price',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_promo_price'
                ),
                'product_text' => array(
                    'label'       => 'Text',
                    'elements'    => '.tb_product .tb_back',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_text'
                ),
                'product_rating_percent' => array(
                    'label'       => 'Rating stars (rate)',
                    'elements'    => '.tb_product .tb_back .tb_rating .tb_percent',
                    'property'    => 'color',
                    'color'       => '#ffd200',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_rating_percent'
                ),
                'product_rating_base' => array(
                    'label'       => 'Rating stars (base)',
                    'elements'    => '.tb_product .tb_back .tb_rating .tb_base',
                    'property'    => 'color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_rating_base'
                ),
                'product_rating_text' => array(
                    'label'       => 'Rating text',
                    'elements'    => '.tb_product .tb_back .tb_rating_holder .tb_average',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'product_listing_hover.product_text'
                ),
                'product_add_to_cart_bg' => array(
                    'label'       => 'Cart button/box',
                    'elements'    => '.tb_product .tb_back .tb_button_add_to_cart .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_add_to_cart_bg'
                ),
                'product_add_to_cart_text' => array(
                    'label'       => 'Cart button text',
                    'elements'    => '.tb_product .tb_back .tb_button_add_to_cart a, .tb_product .tb_back .tb_button_add_to_cart a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_add_to_cart_text'
                ),
                'product_add_to_cart_bg_hover' => array(
                    'label'       => 'Cart button/box (hover)',
                    'elements'    => '.tb_product .tb_back .tb_button_add_to_cart .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_add_to_cart_bg_hover'
                ),
                'product_add_to_cart_text_hover' => array(
                    'label'       => 'Cart button text (hover)',
                    'elements'    => '.tb_product .tb_back .tb_button_add_to_cart a:hover, .tb_product .tb_back .tb_button_add_to_cart a.tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_add_to_cart_text_hover'
                ),
                'product_compare_bg' => array(
                    'label'       => 'Compare button/box',
                    'elements'    => '.tb_product .tb_back .tb_button_compare .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_compare_bg'
                ),
                'product_compare_text' => array(
                    'label'       => 'Compare button text',
                    'elements'    => '.tb_product .tb_back .tb_button_compare a, .tb_product .tb_back .tb_button_compare a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_compare_text'
                ),
                'product_compare_bg_hover' => array(
                    'label'       => 'Compare button/box (hover)',
                    'elements'    => '.tb_product .tb_back .tb_button_compare .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_compare_bg_hover'
                ),
                'product_compare_text_hover' => array(
                    'label'       => 'Compare button text (hover)',
                    'elements'    => '.tb_product .tb_back .tb_button_compare a:hover, .tb_product .tb_back .tb_button_compare a.tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_compare_text_hover'
                ),
                'product_wishlist_bg' => array(
                    'label'       => 'Wishlist button/box',
                    'elements'    => '.tb_product .tb_back .tb_button_wishlist .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_wishlist_bg'
                ),
                'product_wishlist_text' => array(
                    'label'       => 'Wishlist button text',
                    'elements'    => '.tb_product .tb_back .tb_button_wishlist a, .tb_product .tb_back .tb_button_wishlist a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_wishlist_text'
                ),
                'product_wishlist_bg_hover' => array(
                    'label'       => 'Wishlist button/box (hover)',
                    'elements'    => '.tb_product .tb_back .tb_button_wishlist .tb_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_wishlist_bg_hover'
                ),
                'product_wishlist_text_hover' => array(
                    'label'       => 'Wishlist button text (hover)',
                    'elements'    => '.tb_product .tb_back .tb_button_wishlist a:hover, .tb_product .tb_back .tb_button_wishlist a.tb_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_wishlist_text_hover'
                ),
                'product_sale_label_bg' => array(
                    'label'       => 'Sale label',
                    'elements'    => '.tb_product .tb_back .tb_label_special',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_sale_label_bg'
                ),
                'product_sale_label_text' => array(
                    'label'       => 'Sale label text',
                    'elements'    => '.tb_product .tb_back .tb_label_special',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_sale_label_text'
                ),
                'product_bg_hover' => array(
                    'label'       => 'Product bg',
                    'elements'    => '.tb_products .tb_product .tb_item_hovered, .tb_products .tb_product .tb_back',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_bg_hover'
                ),
                'product_old_price' => array(
                    'label'       => 'Old price',
                    'elements'    => '.tb_product .tb_back .tb_old_price',
                    'property'    => 'color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:product_listing_hover.product_old_price'
                )
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
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
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