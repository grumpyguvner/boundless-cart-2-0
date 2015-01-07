<?php

require_once 'SystemWidget.php';

class Theme_PageContentProductSystemWidget extends Theme_SystemWidget
{

    protected function getDefaultFonts()
    {
        return array(
            'product_title' => array(
                'section_name'      => 'Product Title',
                'elements'          => 'h1',
                'type'              => '',
                'family'            => 'inherit',
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
            'product_price' => array(
                'section_name'      => 'Product price',
                'elements'          => '.tb_price_holder .tb_price',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 24,
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
                '_label' => 'Body',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '.tb_main_color, .tb_main_color_hover:hover, .tb_list_1 > li:before',
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
                    'elements'    => 'a.tb_main_color:hover',
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
                    'elements'    => '.tb_main_color_bg',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => 'a.tb_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'title' => array(
                    'label'       => 'Product title',
                    'elements'    => 'h1',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.titles'
                ),
            ),
            'breadcrumbs' => array(
                '_label' => 'Breadcrumbs',
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '.breadcrumbs',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '.breadcrumbs a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '.breadcrumbs a:hover',
                    'property'    => 'color',
                    'color'       => '#ffd200',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links_hover'
                ),
            ),
            'rating' => array(
                '_label' => 'Rating',
                'product_rating_percent' => array(
                    'label'       => 'Rating stars (rate)',
                    'elements'    => '.tb_rating .tb_percent',
                    'property'    => 'color',
                    'color'       => '#ffd200',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'product_rating_base' => array(
                    'label'       => 'Rating stars (base)',
                    'elements'    => '.tb_rating .tb_base',
                    'property'    => 'color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'product_rating_text' => array(
                    'label'       => 'Rating text',
                    'elements'    => '.tb_rating_holder .tb_average',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                )
            ),
            'tabs' => array(
                '_label' => 'Tabs',
                'clickable_text' => array(
                    'label'       => 'Clickable text',
                    'elements'    => '
                            .ui-state-default,
                            .ui-widget-content .ui-state-default,
                            .ui-widget-header .ui-state-default,
                            .ui-state-default a,
                            .ui-state-default a:link,
                            .ui-state-default a:visited,
                            .tb_tabs.tb_style_2 .tb_tabs_nav > ul
                        ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.text'
                ),
                'clickable_text_hover' => array(
                    'label'       => 'Clickable text (hover)',
                    'elements'    => '
                            .ui-state-hover,
                            .ui-widget-content .ui-state-hover,
                            .ui-widget-header .ui-state-hover,
                            .ui-state-focus,
                            .ui-widget-content .ui-state-focus,
                            .ui-widget-header .ui-state-focus,
                            .ui-state-hover a,
                            .ui-state-hover a:hover,
                            .ui-state-hover a:link,
                            .ui-state-hover a:visited
                        ',
                    'property'    => 'color',
                    'color'       => '#111111',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.accent'
                ),
                'clickable_text_active' => array(
                    'label'       => 'Clickable text (active)',
                    'elements'    => '
                            .ui-state-active,
                            .ui-widget-content .ui-state-active,
                            .ui-widget-header .ui-state-active,
                            .ui-state-active a,
                            .ui-state-active a:link,
                            .ui-state-active a:visited,
                            .tb_tabs.tb_style_2 .tb_tabs_nav li.ui-state-active a
                        ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.accent'
                ),
            ),
            'forms' => array(
                '_label' => 'Form elements',
                'input_text' => array(
                    'label'       => 'Text',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text'
                ),
                'input_bg' => array(
                    'label'       => 'Background',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg'
                ),
                'input_border_top_left' => array(
                    'label'       => 'Top/left border',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left'
                ),
                'input_border_bottom_right' => array(
                    'label'       => 'Bottom/right border',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right'
                ),
                'input_text_hover' => array(
                    'label'       => 'Text (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text_hover'
                ),
                'input_bg_hover' => array(
                    'label'       => 'Background (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg_hover'
                ),
                'input_border_top_left_hover' => array(
                    'label'       => 'Top/left border (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left_hover'
                ),
                'input_border_bottom_right_hover' => array(
                    'label'       => 'Bottom/right border (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right_hover'
                ),
                'input_text_focus' => array(
                    'label'       => 'Text (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text_focus'
                ),
                'input_bg_focus' => array(
                    'label'       => 'Background (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg_focus'
                ),
                'input_border_top_left_focus' => array(
                    'label'       => 'Top/left border (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left_focus'
                ),
                'input_border_bottom_right_focus' => array(
                    'label'       => 'Bottom/right border (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right_focus'
                ),
                'input_text_error' => array(
                    'label'       => 'Text (error)',
                    'elements'    => '.tb_error_row input, .tb_error_row select, .tb_error_row textarea, .tb_error_row .ui-spinner.ui-widget-content',
                    'property'    => 'color',
                    'color'       => '#84290a',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_text_error'
                ),
                'input_bg_error' => array(
                    'label'       => 'Background (error)',
                    'elements'    => '.tb_error_row input, .tb_error_row select, .tb_error_row textarea, .tb_error_row .ui-spinner.ui-widget-content',
                    'property'    => 'background-color',
                    'color'       => '#ffe7df',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_bg_error'
                ),
                'input_border_top_left_error' => array(
                    'label'       => 'Top/left border (error)',
                    'elements'    => '.tb_error_row input, .tb_error_row select, .tb_error_row textarea, .tb_error_row .ui-spinner.ui-widget-content',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#ffcdbc',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_top_left_error'
                ),
                'input_border_bottom_right_error' => array(
                    'label'       => 'Bottom/right border (error)',
                    'elements'    => '.tb_error_row input, .tb_error_row select, .tb_error_row textarea, .tb_error_row .ui-spinner.ui-widget-content',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#ffe7df',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.input_border_bottom_right_error'
                )
            )
        );

        if (method_exists($this, 'getAdditionalColors')) {
            $default_colors = array_merge($default_colors, $this->getAdditionalColors());
        }

        return $default_colors;
    }
}