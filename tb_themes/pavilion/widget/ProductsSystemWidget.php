<?php

require_once 'SystemWidget.php';

class Theme_ProductsSystemWidget extends Theme_SystemWidget
{
    public function onFilter(array &$settings)
    {
        $theme_settings = $this->manager->getThemeExtension()->getSettings();

        $default_vars = array(
            'inherit_products' => 1,
            'products'         => array()
        );

        $inherit_products = isset($settings['inherit_products']) ? $settings['inherit_products'] : $default_vars['inherit_products'];

        if ($inherit_products) {
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
            }
        }

        foreach ($result['products']['grid']['restrictions'] as $i => $row) {
            if (empty($row['max_width']) || empty($row['items_per_row'])) {
                unset($result['products']['grid']['restrictions'][$i]);
            }
        }

        if (empty($result['products']['grid']['restrictions'])) {
            $result['products']['grid']['restrictions'] = $theme_settings['store']['category']['products']['grid']['restrictions'];
        }

        $settings = array_replace($settings, $result);

        parent::onFilter($settings);
    }

    public function onPersist(array &$settings)
    {
        if (isset($settings['inherit_products']) && $settings['inherit_products']) {
            unset($settings['products']);
        }
    }

    public function configureFrontend()
    {
        $dispatcher = $this->manager->getEventDispatcher();

        $dispatcher->connect('core:pluginsPostBootstrap', array($this, 'setProductsOptions'));
        $dispatcher->connect('oc_system_products_filter', array($this, 'filterProducts'));
    }

    public function setProductsOptions()
    {
        if (!$this->settings['inherit_products']) {
            $products_settings = $this->settings['products'][$this->themeData->product_listing_type];
            $this->getThemeModel('category')->initCategoryProductsSettings($products_settings, $this->themeData->product_listing_type);
        } else {
            $products_settings = $this->themeData->category_products_current;
        }

        $products_settings['listing_classes'] .= ' tb_' . $this->getDomId() . '_classes';

        $this->themeData->products_system = $products_settings;
    }

    public function filterProducts(sfEvent $event, array $data)
    {
        $this->manager->getThemeExtension()->getPlugin('product')->modifyProducts($data['products'], $this->themeData->products_system);
    }

    public function onAreaContentOutput(&$html)
    {
        $sizes = $this->getSettings('sizes');

        if (empty($sizes)) {
            return;
        }

        if ($this->getAttribute('grid_proportion')) {
            $sizes['grid_proportion'] = $this->getAttribute('grid_proportion');
        }

        $restrictions = $this->themeData->products_system['restrictions'];
        $this->manager->getThemeExtension()->getPlugin('product')->calculateProductsPerRow($restrictions, $sizes);

        $classes = 'tb_gut_' . $restrictions['items_spacing'] . ' tb_size_' . $restrictions['items_per_row'];

        $html = str_replace('tb_' . $this->getDomId() . '_classes', $classes, $html);
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {
        $active_elements = $this->themeData->products_system['active_elements'];

        if (!$this->themeData->is_touch && $active_elements && $this->themeData->product_listing_type != 'compact' && $this->themeData->products_system['elements_hover_action'] != 'none') {
            $css = '#' . $this->getDomId() . ' .tb_grid_view .tb_item > .tb_item_info ' . str_replace(', ', ', #' . $this->getDomId() . ' .tb_grid_view .tb_item > .tb_item_info ', $active_elements) . ' {
              display: none;
            }';
            $styleBuilder->addCss($css);
        }
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
            'product_filter' => array(
                '_label' => 'Products Filter',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '.tb_listing_options .tb_main_color, .tb_listing_options .tb_hover_main_color:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => '.tb_listing_options a.tb_main_color:hover, .tb_listing_options .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent_hover'
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '.tb_listing_options .tb_main_color_bg, .tb_listing_options .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'product_filter.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => '.tb_listing_options a.tb_main_color_bg:hover, .tb_listing_options a.tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'product_filter.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '.tb_listing_options',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'bg' => array(
                    'label'       => 'Background',
                    'elements'    => '.tb_listing_options',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_text' => array(
                    'label'       => 'Dropdown text',
                    'elements'    => '.tb_listing_options select',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text'
                ),
                'input_bg' => array(
                    'label'       => 'Dropdown bg',
                    'elements'    => '.tb_listing_options select',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg'
                ),
                'input_border_top_left' => array(
                    'label'       => 'Dropdown top/left border',
                    'elements'    => '.tb_listing_options select',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left'
                ),
                'input_border_bottom_right' => array(
                    'label'       => 'Dropdown bottom/right border',
                    'elements'    => '.tb_listing_options select',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right'
                ),
                'input_text_hover' => array(
                    'label'       => 'Dropdown text (hover)',
                    'elements'    => '.tb_listing_options select:hover',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text_hover'
                ),
                'input_bg_hover' => array(
                    'label'       => 'Dropdown bg (hover)',
                    'elements'    => '.tb_listing_options select:hover',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg_hover'
                ),
                'input_border_top_left_hover' => array(
                    'label'       => 'Dropdown top/left border (hover)',
                    'elements'    => '.tb_listing_options select:hover',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left_hover'
                ),
                'input_border_bottom_right_hover' => array(
                    'label'       => 'Dropdown bottom/right border (hover)',
                    'elements'    => '.tb_listing_options select:hover',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right_hover'
                ),
                'input_text_focus' => array(
                    'label'       => 'Dropdown text (focus)',
                    'elements'    => '.tb_listing_options select:focus',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text_focus'
                ),
                'input_bg_focus' => array(
                    'label'       => 'Dropdown bg (focus)',
                    'elements'    => '.tb_listing_options select:focus',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg_focus'
                ),
                'input_border_top_left_focus' => array(
                    'label'       => 'Dropdown top/left border (focus)',
                    'elements'    => '.tb_listing_options select:focus',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left_focus'
                ),
                'input_border_bottom_right_focus' => array(
                    'label'       => 'Dropdown bottom/right border (focus)',
                    'elements'    => '.tb_listing_options select:focus',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right_focus'
                ),
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
            'pagination' => array(
                '_label' => 'Pagination',
                'links_text' => array(
                    'label'       => 'Links text',
                    'elements'    => '.pagination .links a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links'
                ),
                'links_bg' => array(
                    'label'       => 'Links bg',
                    'elements'    => '.pagination .links a',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links_text_hover' => array(
                    'label'       => 'Links text (hover)',
                    'elements'    => '.pagination .links a:hover',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links_hover'
                ),
                'links_bg_hover' => array(
                    'label'       => 'Links bg (hover)',
                    'elements'    => '.pagination .links a:hover',
                    'property'    => 'background-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links_text_active' => array(
                    'label'       => 'Links text (active)',
                    'elements'    => '.pagination .links b',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links_bg_active' => array(
                    'label'       => 'Links bg (active)',
                    'elements'    => '.pagination .links b',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'results' => array(
                    'label'       => 'Results text',
                    'elements'    => '.pagination .results',
                    'property'    => 'color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
            )
        );

        return $default_colors;
    }
}