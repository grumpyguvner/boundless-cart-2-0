<?php

class Theme_Admin_FontsPlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    protected $default_settings;

    public function getConfigKey()
    {
        return 'font';
    }

    public function filterSettings(array &$font_settings)
    {
        $this->default_settings = array(
            'section_name'      => '{{section_name}}',
            'elements'          => '',
            'type'              => 'google',
            'family'            => 'Open Sans',
            'subsets'           => 'latin',
            'variant'           => 'regular',
            'size'              => 13,
            'line-height'       => 20,
            'letter-spacing'    => 0,
            'word-spacing'      => 0,
            'transform'         => 0,
            'has_size'          => true,
            'has_line_height'   => true,
            'has_spacing'       => true,
            'has_effects'       => true,
            'show_built_styles' => true,
            'multiple_variants' => false,
            'built-in'          => false,
            'can_inherit'       => false,
            'css_weight'        => '',
            'css_style'         => ''
        );

        $default_fonts = array(
            'body' => array(
                'section_name'      => 'Body',
                'elements'          => 'body',
                'type'              => 'google',
                'family'            => 'Open Sans',
                'subsets'           => 'latin',
                'variant'           => '700italic,700,italic,regular',
                'size'              => 13,
                'line-height'       => 20,
                'letter-spacing'    => '',
                'word-spacing'      => '',
                'transform'         => '',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => false,
                'has_effects'       => false,
                'show_built_styles' => false,
                'multiple_variants' => true,
                'built-in'          => true,
                'can_inherit'       => false,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'h1' => array(
                'section_name'      => 'H1',
                'elements'          => 'h1, .h1',
                'type'              => 'google',
                'family'            => 'Montserrat',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 26,
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
            'h2' => array(
                'section_name'      => 'H2 / Block & module title / Tabs & accordion navigation',
                'elements'          => '
                    h2,
                    .h2,
                    .box-heading,
                    .tb_widget_open_cart .panel-heading,
                    .checkout-heading,
                    legend,
                    .tb_tabs_nav > ul,
                    .ui-tabs-nav,
                    .ui-accordion-header,
                    .ui-datepicker .ui-datepicker-title,
                    .ui-dialog .ui-dialog-title,
                    .tb_slider_controls .tb_prev,
                    .tb_slider_controls .tb_next
                ',
                'type'              => 'google',
                'family'            => 'Montserrat',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 16,
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
            'h3' => array(
                'section_name'      => 'H3',
                'elements'          => 'h3, .h3',
                'type'              => 'google',
                'family'            => 'Montserrat',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 15,
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
            'h4' => array(
                'section_name'      => 'H4',
                'elements'          => 'h4, .h4 ',
                'type'              => 'google',
                'family'            => 'Montserrat',
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
            'buttons' => array(
                'section_name'      => 'Buttons',
                'elements'          => '.tb_button, .button, input[type="button"], input[type="submit"], input[type="reset"], button',
                'type'              => 'google',
                'family'            => 'Montserrat',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 13,
                'line-height'       => '',
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => false,
                'has_spacing'       => true,
                'has_effects'       => true,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'main_navigation' => array(
                'section_name'      => 'Main navigation',
                'elements'          => '
                    #main_navigation .tb_nav > ul > li > a,
                    #cart > .heading > h4,
                    #menu > ul > li > a,
                    #main_navigation_row .tb_widget_cart .heading
                ',
                'type'              => 'google',
                'family'            => 'Montserrat',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 14,
                'line-height'       => '',
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => false,
                'has_spacing'       => true,
                'has_effects'       => true,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'main_navigation_submenu' => array(
                'section_name'      => 'Main navigation submenus',
                'elements'          => '
                    #main_navigation .tb_submenu,
                    #menu .tb_submenu,
                    #cart .tb_submenu
                ',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 13,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => true,
                'has_line_height'   => true,
                'has_spacing'       => false,
                'has_effects'       => false,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'product_title' => array(
                'section_name'      => 'Product title',
                'elements'          => '.tb_product h3',
                'type'              => 'google',
                'family'            => 'Montserrat',
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
                'type'              => 'google',
                'family'            => 'Montserrat',
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
            ),
            'text_logo' => array(
                'section_name'      => 'Text logo',
                'elements'          => '#site_logo.tb_text',
                'type'              => 'google',
                'family'            => 'Montserrat',
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
        );

        $fonts = TB_FormHelper::initLangVarsSimple($default_fonts, $font_settings, $this->manager->getEnabledLanguages());
        foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
            if (isset($font_settings[$lid])) {
                foreach ($font_settings[$lid] as $name => $section) {
                    $settings = isset($default_fonts[$name]) ? $default_fonts[$name] : $this->default_settings;
                    $fonts[$lid][$name] = TB_FormHelper::initFlatVarsSimple($settings, $section);
                    if (isset($default_fonts[$name]) && $default_fonts[$name]['built-in'] == true) {
                        // the elements key should be overwritten bu just changing its default value, because it cannot be changed from the UI (it's hidden)
                        $fonts[$lid][$name]['elements'] = $default_fonts[$name]['elements'];
                    }
                }
            }
        }

        $font_settings = $fonts;
    }

    public function setDataForView(&$font_settings, TB_ViewDataBag $themeData)
    {
        $themeData->font_data = array(
            'google_font_list'      => $this->getModel('fonts')->getGoogleFontsList(),
            'built_font_families'   => $this->getModel('fonts')->getBuiltFontsList(),
            'built_font_variants'   => array('regular', 'bold', 'italic', 'bolditalic'),
            'default_font_settings' => $this->default_settings
        );
    }

    public function saveData($post_data)
    {
        if (isset($post_data['font'])) {
            $this->getModel('layoutBuilder')->cleanFontDataBeforePersist($post_data['font']);
        }

        return array(
            $this->getConfigKey() => $post_data['font']
        );
    }
}