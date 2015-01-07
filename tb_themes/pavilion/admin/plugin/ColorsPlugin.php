<?php

class Theme_Admin_ColorsPlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    protected $default_colors;

    public function getConfigKey()
    {
        return 'colors';
    }

    public function filterSettings(array &$color_settings)
    {
        $this->default_colors = array(
            'main' => array(
                '_label' => 'Main',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '.tb_main_color, .tb_hover_main_color:hover, .colorbox, .agree, .tb_list_1 > li:before, #menu div > ul > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => 'a.tb_main_color:hover, a.colorbox:hover, a.agree:hover, .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '.tb_main_color_bg, .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => 'a.tb_main_color_bg:hover, .tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => 'body',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => 'a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'column_border' => array(
                    'label'       => 'Column border',
                    'elements'    => '.tb_row_separate > .tb_wrap > [class*="tb_col_"]',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'body' => array(
                    'label'       => 'Body background',
                    'elements'    => 'body',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'header' => array(
                '_label' => 'Header',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '#header .tb_main_color, #header .tb_hover_main_color:hover, #header .colorbox, #header .tb_list_1 > li:before, #menu div > ul > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => '#header a.tb_main_color:hover, #header .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '#header .tb_main_color_bg, #header .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => '#header a.tb_main_color_bg:hover, #header a.tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '#header',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '#header a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '#header a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links_hover'
                ),
                'site_logo' => array(
                    'label'       => 'Site logo',
                    'elements'    => '#site_logo.tb_text',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent'
                ),
                'welcome_text' => array(
                    'label'       => 'Welcome text',
                    'elements'    => '#welcome_message',
                    'property'    => 'color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'welcome_links' => array(
                    'label'       => 'Welcome links',
                    'elements'    => '#welcome_message a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent'
                ),
                'welcome_links_hover' => array(
                    'label'       => 'Welcome links (hover)',
                    'elements'    => '#welcome_message a:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent_hover'
                ),
                'top_bar_bg' => array(
                    'label'       => 'Top bar bg',
                    'elements'    => '#header .tbSystemRow',
                    'property'    => 'background-color',
                    'color'       => '#444444',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'top_bar_text' => array(
                    'label'       => 'Top bar text',
                    'elements'    => '#header .tbSystemRow, #header .tbSystemRow #welcome_message',
                    'property'    => 'color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'top_bar_links' => array(
                    'label'       => 'Top bar links',
                    'elements'    => '#header .tbSystemRow a, #header .tbSystemRow #welcome_message a',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'top_bar_links_hover' => array(
                    'label'       => 'Top bar links (hover)',
                    'elements'    => '#header .tbSystemRow a:hover, #header .tbSystemRow #welcome_message a:hover',
                    'property'    => 'color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.top_bar_text'
                ),
                'button' => array(
                    'label'       => 'Button',
                    'elements'    => '
                        #header .tb_button:not([class*="tb_bg_str_"]),
                        #main_navigation_row .tb_button:not([class*="tb_bg_str_"])'
                    ,
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button'
                ),
                'button_text' => array(
                    'label'       => 'Button Text',
                    'elements'    => '
                        #header .tb_button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        #main_navigation_row .tb_button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default)
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text'
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '
                        #header .tb_button:not([class*="tb_bg_hover_str_"]):hover,
                        #main_navigation_row .tb_button:hover
                    ',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_hover'
                ),
                'button_text_hover' => array(
                    'label'       => 'Button Text (hover)',
                    'elements'    => '
                        #header .tb_button:not([class*="tb_text_hover_str_"]):hover,
                        #main_navigation_row .tb_button:hover
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text_hover'
                )
            ),
            'search' => array(
                '_label' => 'Search',
                'input_text' => array(
                    'label'       => 'Text',
                    'elements'    => '.tb_widget_site_search input',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_text'
                ),
                'input_bg' => array(
                    'label'       => 'Background',
                    'elements'    => '.tb_widget_site_search input',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_bg'
                ),
                'input_border_top_left' => array(
                    'label'       => 'Top/left border',
                    'elements'    => '.tb_widget_site_search input',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_border_top_left'
                ),
                'input_border_bottom_right' => array(
                    'label'       => 'Bottom/right border',
                    'elements'    => '.tb_widget_site_search input',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_border_bottom_right'
                ),
                'input_text_focus' => array(
                    'label'       => 'Text (hover/focus)',
                    'elements'    => '.tb_widget_site_search input:hover, .tb_widget_site_search input:focus',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_text_focus'
                ),
                'input_bg_focus' => array(
                    'label'       => 'Background (hover/focus)',
                    'elements'    => '.tb_widget_site_search input:hover, .tb_widget_site_search input:focus',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_bg_focus'
                ),
                'input_border_top_left_focus' => array(
                    'label'       => 'Top/left border (hover/focus)',
                    'elements'    => '.tb_widget_site_search input:hover, .tb_widget_site_search input:focus',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_border_top_left_focus'
                ),
                'input_border_bottom_right_focus' => array(
                    'label'       => 'Bottom/right border (hover/focus)',
                    'elements'    => '.tb_widget_site_search input:hover, .tb_widget_site_search input:focus',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.input_border_bottom_right_focus'
                ),
            ),
            'main_navigation_menu' => array(
                '_label' => 'Main navigation',
                'text' => array(
                    'label'       => 'Menu',
                    'elements'    => '
                        #main_navigation .tb_nav > ul > li > a,
                        #menu > ul > li > a
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.links'
                ),
                'text_hover' => array(
                    'label'       => 'Menu (hover)',
                    'elements'    => '
                        #main_navigation .tb_nav > ul > li.tb_hovered > a,
                        #main_navigation .tb_nav > ul > li:hover > a,
                        #main_navigation .tb_nav > ul > li > a:hover,
                        #menu > ul > li.tb_hovered > a,
                        #menu > ul > li:hover > a,
                        #menu > ul > li > a:hover
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.links_hover'
                ),
                'bg_hover' => array(
                    'label'       => 'Menu bg (hover)',
                    'elements'    => '
                        #main_navigation .tb_nav > ul > li:hover > a,
                        #main_navigation .tb_nav > ul > li > a:hover,
                        #main_navigation .tb_nav > ul > li.tb_hovered > a,
                        #menu > ul > li > a:hover,
                        #menu > ul > li:hover > a,
                        #menu > ul > li.tb_hovered > a
                    ',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'text_selected' => array(
                    'label'       => 'Menu (selected)',
                    'elements'    => '#main_navigation .tb_nav > ul > li.tb_selected > a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent'
                ),
                'bg_selected' => array(
                    'label'       => 'Menu bg (selected)',
                    'elements'    => '#main_navigation .tb_nav > ul > li.tb_selected > a',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'cart_text' => array(
                    'label'       => 'Cart text',
                    'elements'    => '
                        #cart a
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.links'
                ),
                'cart_icon' => array(
                    'label'       => 'Cart icon',
                    'elements'    => '#cart .heading .tb_main_color',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.accent'
                ),
                'cart_text_hover' => array(
                    'label'       => 'Cart text (hover)',
                    'elements'    => '
                        #cart.tb_hovered .heading a,
                        #cart.tb_hovered .heading a > *,
                        #cart.tb_hovered .heading .tb_main_color,
                        #cart:hover .heading a,
                        #cart:hover .heading a > *,
                        #cart:hover .heading .tb_main_color
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'header.links_hover'
                ),
                'cart_bg_hover' => array(
                    'label'       => 'Cart bg (hover)',
                    'elements'    => '#cart:hover, #cart.tb_hovered',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
            ),
            'main_navigation_submenu' => array(
                '_label' => 'Navigation submenus',
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '
                        #main_navigation .tb_nav .tb_submenu,
                        #cart .tb_submenu,
                        #header .tb_nav .tb_submenu,
                        #menu > ul > li > div
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'separator' => array(
                    'label'       => 'Text',
                    'elements'    => '#main_navigation .tb_nav > ul > li:before',
                    'property'    => 'background-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_submenu.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '
                        #main_navigation .tb_nav .tb_submenu a,
                        #cart .tb_submenu a,
                        #header .tb_submenu a,
                        #menu > ul > li > div a,
                        #main_navigation .tb_nav.tb_active > ul > li > a,
                        #main_navigation .tb_nav.tb_active > ul > li > .tb_toggle
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '
                        #main_navigation .tb_nav .tb_submenu a:hover,
                        #cart .tb_submenu a:hover,
                        #header .tb_submenu a:hover,
                        #menu > ul > li > div a:hover,
                        #main_navigation .tb_nav.tb_active > ul > li > a:hover
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links_hover'
                ),
                'bullets' => array(
                    'label'       => 'List bullets',
                    'elements'    => '#main_navigation .tb_list_1 > li:before, #menu div > ul > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'megamenu_title' => array(
                    'label'       => 'Megamenu column title',
                    'elements'    => '
                        #main_navigation .tb_submenu h3,
                        #main_navigation .tb_submenu h4,
                        #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > a,
                        #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > strong,
                        #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_letter > strong
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'megamenu_title_hover' => array(
                    'label'       => 'Megamenu column title (hover)',
                    'elements'    => '
                        #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > a:hover
                    ',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'megamenu_separator' => array(
                    'label'       => 'Megamenu borders',
                    'elements'    => '
                        #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"],
                        #main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_category_brands
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'category_desc_text' => array(
                    'label'       => 'Category description',
                    'elements'    => '#main_navigation .tb_category_info p',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'category_desc_title' => array(
                    'label'       => 'Category description title',
                    'elements'    => '#main_navigation .tb_category_info h3',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'submenu_bg' => array(
                    'label'       => 'Background',
                    'elements'    => '
                        #main_navigation .tb_nav .tb_submenu,
                        #cart .tb_submenu,
                        #header .tb_submenu,
                        #menu > ul > li > div,
                        .tb_nav > ul > li > .tb_submenu:before,
                        .tb_nav .tb_megamenu.tb_multiple:hover:after,
                        #cart .tb_submenu:before
                    ',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
            ),
            'sticky' => array(
                '_label' => 'Sticky header',
                'input_text' => array(
                    'label'       => 'Search text',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_text'
                ),
                'input_bg' => array(
                    'label'       => 'Search bg',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_bg'
                ),
                'input_border_top_left' => array(
                    'label'       => 'Search top/left border',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_border_top_left'
                ),
                'input_border_bottom_right' => array(
                    'label'       => 'Search bottom/right border',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_border_bottom_right'
                ),
                'input_text_focus' => array(
                    'label'       => 'Search text (hover/focus)',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input:hover, .tb_sticky_container .tb_widget_site_search input:focus',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_text_focus'
                ),
                'input_bg_focus' => array(
                    'label'       => 'Search bg (hover/focus)',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input:hover, .tb_sticky_container .tb_widget_site_search input:focus',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_bg_focus'
                ),
                'input_border_top_left_focus' => array(
                    'label'       => 'Search top/left border (hover/focus)',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input:hover, .tb_sticky_container .tb_widget_site_search input:focus',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_border_top_left_focus'
                ),
                'input_border_bottom_right_focus' => array(
                    'label'       => 'Search bottom/right border (hover/focus)',
                    'elements'    => '.tb_sticky_container .tb_widget_site_search input:hover, .tb_sticky_container .tb_widget_site_search input:focus',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'search.input_border_bottom_right_focus'
                ),
                'menu_text' => array(
                    'label'       => 'Menu text',
                    'elements'    => '
                        .tb_sticky_container #main_navigation .tb_nav > ul > li > a:link,
                        .tb_sticky_container #main_navigation .tb_nav > ul > li > a:visited,
                        .tb_sticky_container #menu > ul > li > a:link,
                        .tb_sticky_container #menu > ul > li > a:visited,
                        .tb_sticky_container #cart a:link,
                        .tb_sticky_container #cart a:visited
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_menu.text'
                ),
                'menu_text_hover' => array(
                    'label'       => 'Menu text (hover)',
                    'elements'    => '
                        .tb_sticky_container #main_navigation .tb_nav > ul > li:hover > a,
                        .tb_sticky_container #main_navigation .tb_nav > ul > li > a:hover,
                        .tb_sticky_container #menu > ul > li:hover > a,
                        .tb_sticky_container #menu > ul > li > a:hover,
                        .tb_sticky_container #cart:hover .heading a,
                        .tb_sticky_container #cart:hover .heading a > *,
                        .tb_sticky_container #cart:hover .heading .tb_main_color
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_menu.text_hover'
                ),
                'menu_bg_hover' => array(
                    'label'       => 'Menu bg (hover)',
                    'elements'    => '
                        .tb_sticky_container #main_navigation .tb_nav > ul > li:hover > a,
                        .tb_sticky_container #main_navigation .tb_nav > ul > li > a:hover,
                        .tb_sticky_container #menu > ul > li > a:hover,
                        .tb_sticky_container #menu > ul > li:hover > a,
                        .tb_sticky_container #cart:hover
                    ',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_menu.bg_hover'
                ),
                'menu_text_selected' => array(
                    'label'       => 'Menu (selected)',
                    'elements'    => '.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_selected > a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_menu.text_selected'
                ),
                'menu_bg_selected' => array(
                    'label'       => 'Menu bg (selected)',
                    'elements'    => '.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_selected > a',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_menu.bg_selected'
                ),
                'sticky_background' => array(
                    'label'       => 'Sticky header bg',
                    'elements'    => '.tb_sticky_container',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'intro' => array(
                '_label' => 'Intro',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '#intro .tb_main_color, #intro .tb_hover_main_color:hover, #intro .colorbox, #intro .tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => '#intro a.tb_main_color:hover, #intro a.colorbox:hover, #intro .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '#intro .tb_main_color_bg, #intro .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'intro.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => '#intro a.tb_main_color_bg:hover, #intro .tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'intro.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '#intro',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '#intro a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '#intro a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links_hover'
                ),
                'titles' => array(
                    'label'       => 'Titles',
                    'elements'    => '#intro h1, #intro h2, #intro h3, #intro h4, #intro h5, #intro h6, #intro .h2, #intro .h3, #intro legend, #intro .box-heading, #intro .tb_widget_open_cart .panel-heading',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'intro.text'
                ),
                'column_border' => array(
                    'label'       => 'Column border',
                    'elements'    => '.tb_row_separate > .tb_wrap > [class*="tb_col_"]',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.column_border'
                )
            ),
            'content' => array(
                '_label' => 'Content',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '#content .tb_main_color, #content .tb_hover_main_color:hover, #content .colorbox, #content .agree, #content .tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => '#content a.tb_main_color:hover, #content a.colorbox:hover, #content .agree:hover, #content .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '#content .tb_main_color_bg, #content .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => '#content a.tb_main_color_bg:hover, #content .tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.accent_hover'
                ),
                'system_links' => array(
                    'label'       => 'System links',
                    'elements'    => '#content .tb_widget_system .tb_text_wrap a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.accent'
                ),
                'system_links_hover' => array(
                    'label'       => 'System links (hover)',
                    'elements'    => '#content .tb_widget_system .tb_text_wrap a:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '#content',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '#content a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '#content a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links_hover'
                ),
                'titles' => array(
                    'label'       => 'Titles',
                    'elements'    => '#content h1, #content h2, #content h3, #content h4, #content h5, #content h6, #content .h2, #content .h3, #content legend, #content .box-heading, #content .tb_widget_open_cart .panel-heading',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.text'
                ),
                'column_border' => array(
                    'label'       => 'Column border',
                    'elements'    => '.tb_row_separate > .tb_wrap > [class*="tb_col_"]',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.column_border'
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
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.text'
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
                    'inherit_key' => 'content.accent'
                ),
                'product_price' => array(
                    'label'       => 'Price',
                    'elements'    => '.tb_product .tb_price',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.accent'
                ),
                'product_promo_price' => array(
                    'label'       => 'Promo price',
                    'elements'    => '.tb_product .tb_promo_price',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'content.accent'
                ),
                'product_old_price' => array(
                    'label'       => 'Old price',
                    'elements'    => '.tb_product .tb_old_price',
                    'property'    => 'color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
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
                    'inherit_key' => 'content.text'
                ),
                'product_rating_percent' => array(
                    'label'       => 'Rating stars (rate)',
                    'elements'    => '.tb_product .tb_rating .tb_percent',
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
                    'elements'    => '.tb_product .tb_rating .tb_base',
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
                    'elements'    => '.tb_product .tb_rating_holder .tb_average',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'product_listing.product_text'
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
                    'inherit_key' => 'forms.button'
                ),
                'product_add_to_cart_text' => array(
                    'label'       => 'Cart button text',
                    'elements'    => '.tb_product .tb_button_add_to_cart a, .tb_product .tb_button_add_to_cart a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text'
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
                    'inherit_key' => 'forms.button_hover'
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
                    'inherit_key' => 'forms.button_text_hover'
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
                    'inherit_key' => 'forms.button'
                ),
                'product_compare_text' => array(
                    'label'       => 'Compare button text',
                    'elements'    => '.tb_product .tb_button_compare a, .tb_product .tb_button_compare a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text'
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
                    'inherit_key' => 'forms.button_hover'
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
                    'inherit_key' => 'forms.button_text_hover'
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
                    'inherit_key' => 'forms.button'
                ),
                'product_wishlist_text' => array(
                    'label'       => 'Wishlist button text',
                    'elements'    => '.tb_product .tb_button_wishlist a, .tb_product .tb_button_wishlist a.tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text'
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
                    'inherit_key' => 'forms.button_hover'
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
                    'inherit_key' => 'forms.button_text_hover'
                ),
                'product_list_view_button_bg' => array(
                    'label'       => 'List view button',
                    'elements'    => '.tb_list_view .tb_product .tb_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button'
                ),
                'product_list_view_button_text' => array(
                    'label'       => 'List view button text',
                    'elements'    => '.tb_list_view .tb_product [class] .tb_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text'
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
                    'inherit_key' => 'forms.button_hover'
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
                    'inherit_key' => 'forms.button_text_hover'
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
                    'inherit_key' => 'main.links'
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
                    'inherit_key' => 'main.links_hover'
                ),
                'product_sale_label_bg' => array(
                    'label'       => 'Sale label',
                    'elements'    => '.tb_product .tb_label_special',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'product_sale_label_text' => array(
                    'label'       => 'Sale label text',
                    'elements'    => '.tb_product .tb_label_special',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
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
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.column_border'
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
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
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
                    'inherit_key' => 'product_listing.product_title'
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
                    'inherit_key' => 'product_listing.product_title_hover'
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
                    'inherit_key' => 'product_listing.product_price'
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
                    'inherit_key' => 'product_listing.product_promo_price'
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
                    'inherit_key' => 'product_listing.product_old_price'
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
                    'inherit_key' => 'product_listing.product_text'
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
                    'inherit_key' => 'product_listing.product_rating_percent'
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
                    'inherit_key' => 'product_listing.product_rating_base'
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
                    'inherit_key' => 'product_listing.product_add_to_cart_bg'
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
                    'inherit_key' => 'product_listing.product_add_to_cart_text'
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
                    'inherit_key' => 'product_listing.product_add_to_cart_bg_hover'
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
                    'inherit_key' => 'product_listing.product_add_to_cart_text_hover'
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
                    'inherit_key' => 'product_listing.product_compare_bg'
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
                    'inherit_key' => 'product_listing.product_compare_text'
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
                    'inherit_key' => 'product_listing.product_compare_bg_hover'
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
                    'inherit_key' => 'product_listing.product_compare_text_hover'
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
                    'inherit_key' => 'product_listing.product_wishlist_bg'
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
                    'inherit_key' => 'product_listing.product_wishlist_text'
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
                    'inherit_key' => 'product_listing.product_wishlist_bg_hover'
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
                    'inherit_key' => 'product_listing.product_wishlist_text_hover'
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
                    'inherit_key' => 'product_listing.product_sale_label_bg'
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
                    'inherit_key' => 'product_listing.product_sale_label_text'
                ),
                'product_bg_hover' => array(
                    'label'       => 'Product bg',
                    'elements'    => '.tb_products .tb_product .tb_item_hovered, .tb_products .tb_product .tb_back',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'footer' => array(
                '_label' => 'Footer',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '#footer .tb_main_color, #footer .tb_hover_main_color:hover, #footer .colorbox, #footer .tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => '#footer a.tb_main_color:hover, #footer a.colorbox:hover, #footer .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '#footer .tb_main_color_bg, #footer .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'footer.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => '#footer a.tb_main_color_bg:hover, #footer .tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'footer.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '#footer',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '#footer a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '#footer a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.links_hover'
                ),
                'titles' => array(
                    'label'       => 'Titles',
                    'elements'    => '#footer h1, #footer h2, #footer h3, #footer h4, #footer h5, #footer h6, #footer .h2, #footer .h3, #footer legend, #footer .box-heading, #footer .tb_widget_open_cart .panel-heading',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'footer.text'
                ),
                'column_border' => array(
                    'label'       => 'Column border',
                    'elements'    => '.tb_row_separate > .tb_wrap > [class*="tb_col_"]',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.column_border'
                )
            ),
            'bottom' => array(
                '_label' => 'Bottom',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '#bottom .tb_main_color, #bottom .tb_hover_main_color:hover, #bottom .colorbox, #bottom .tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => '#bottom a.tb_main_color:hover, #bottom .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'accent_bg' => array(
                    'label'       => 'Accent bg',
                    'elements'    => '#bottom .tb_main_color_bg, #bottom .tb_hover_main_color_bg:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'bottom.accent'
                ),
                'accent_bg_hover' => array(
                    'label'       => 'Accent bg (hover)',
                    'elements'    => '#bottom a.tb_main_color_bg:hover, #bottom .tb_main_color_bg_hover:hover',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'bottom.accent_hover'
                ),
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '#bottom',
                    'property'    => 'color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '#bottom a',
                    'property'    => 'color',
                    'color'       => '#666666',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '#bottom a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'bottom.accent'
                )
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
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_bg' => array(
                    'label'       => 'Background',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_top_left' => array(
                    'label'       => 'Top/left border',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_bottom_right' => array(
                    'label'       => 'Bottom/right border',
                    'elements'    => 'input, select, textarea, .ui-spinner.ui-widget-content',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_text_hover' => array(
                    'label'       => 'Text (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_bg_hover' => array(
                    'label'       => 'Background (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_top_left_hover' => array(
                    'label'       => 'Top/left border (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_bottom_right_hover' => array(
                    'label'       => 'Bottom/right border (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_text_focus' => array(
                    'label'       => 'Text (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_bg_focus' => array(
                    'label'       => 'Background (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_top_left_focus' => array(
                    'label'       => 'Top/left border (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_bottom_right_focus' => array(
                    'label'       => 'Bottom/right border (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_text_error' => array(
                    'label'       => 'Text (error)',
                    'elements'    => '
                        .tb_error_row input,
                        .tb_error_row select,
                        .tb_error_row textarea,
                        .tb_error_row .ui-spinner.ui-widget-content,
                        .has-error input,
                        .has-error select,
                        .has-error textarea,
                        .has-error .ui-spinner.ui-widget-content
                    ',
                    'property'    => 'color',
                    'color'       => '#84290a',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_bg_error' => array(
                    'label'       => 'Background (error)',
                    'elements'    => '
                        .tb_error_row input,
                        .tb_error_row select,
                        .tb_error_row textarea,
                        .tb_error_row .ui-spinner.ui-widget-content,
                        .has-error input,
                        .has-error select,
                        .has-error textarea,
                        .has-error .ui-spinner.ui-widget-content
                    ',
                    'property'    => 'background-color',
                    'color'       => '#ffe7df',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_top_left_error' => array(
                    'label'       => 'Top/left border (error)',
                    'elements'    => '
                        .tb_error_row input,
                        .tb_error_row select,
                        .tb_error_row textarea,
                        .tb_error_row .ui-spinner.ui-widget-content,
                        .has-error input,
                        .has-error select,
                        .has-error textarea,
                        .has-error .ui-spinner.ui-widget-content
                    ',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#ffcdbc',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'input_border_bottom_right_error' => array(
                    'label'       => 'Bottom/right border (error)',
                    'elements'    => '
                        .tb_error_row input,
                        .tb_error_row select,
                        .tb_error_row textarea,
                        .tb_error_row .ui-spinner.ui-widget-content,
                        .has-error input,
                        .has-error select,
                        .has-error textarea,
                        .has-error .ui-spinner.ui-widget-content
                    ',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#ffe7df',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button' => array(
                    'label'       => 'Button',
                    'elements'    => '
                        .tb_button:not([class*="tb_bg_str_"]),
                        a.tb_button:not([class*="tb_bg_str_"]),
                        .button:not([class*="tb_bg_str_"]),
                        button:not([class*="tb_bg_str_"]),
                        [type=button]:not([class*="tb_bg_str_"]),
                        [type=submit]:not([class*="tb_bg_str_"]),
                        [type=reset]:not([class*="tb_bg_str_"]),
                        .ui-button.ui-state-default,
                        .ui-widget button.ui-state-default,
                        .ui-slider .ui-slider-handle.ui-state-default
                    ',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'button_text' => array(
                    'label'       => 'Button Text',
                    'elements'    => '
                        .tb_button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        a.tb_button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        [class] [class] .tb_button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        .button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        button:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        [type=button]:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        [type=submit]:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        [type=reset]:not([class*="tb_text_str_"]):not(.tb_button_default):not(.btn-default),
                        .ui-button.ui-state-default,
                        .ui-widget button.ui-state-default
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '
                        .tb_button:not([class*="tb_bg_hover_str_"]):hover,
                        .tb_button_hover:hover,
                        a.tb_button:not([class*="tb_bg_hover_str_"]):hover,
                        .button:not([class*="tb_bg_hover_str_"]):hover,
                        button:not([class*="tb_bg_hover_str_"]):hover,
                        [type=button]:not([class*="tb_bg_hover_str_"]):hover,
                        [type=submit]:not([class*="tb_bg_hover_str_"]):hover,
                        [type=reset]:not([class*="tb_bg_hover_str_"]):hover,
                        .ui-button.ui-state-hover,
                        .ui-button.ui-state-active,
                        .ui-widget button.ui-state-hover,
                        .ui-widget button.ui-state-active,
                        .ui-slider .ui-slider-handle.ui-state-hover,
                        .ui-slider .ui-slider-handle.ui-state-active,
                    ' . ($this->manager->gteOc2() ? '
                        .form-group.tb_style_2 label.tb_checked
                    ' : '
                        .options .tb_radio_row.tb_style_2 input.tb_checked + label,
                        .options .tb_checkbox_row.tb_style_2 input.tb_checked + label,
                        .options .tb_image_row.tb_style_2 td.tb_checked + td label
                    '),
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'button_text_hover' => array(
                    'label'       => 'Button Text (hover)',
                    'elements'    => '
                        .tb_button:not([class*="tb_text_hover_str_"]):hover,
                        .tb_button_hover:hover,
                        a.tb_button:not([class*="tb_text_hover_str_"]):hover,
                        [class] [class] .tb_button:not([class*="tb_text_hover_str_"]):hover,
                        .button:not([class*="tb_text_hover_str_"]):hover,
                        button:not([class*="tb_text_hover_str_"]):hover,
                        [type=button]:not([class*="tb_text_hover_str_"]):hover,
                        [type=submit]:not([class*="tb_text_hover_str_"]):hover,
                        [type=reset]:not([class*="tb_text_hover_str_"]):hover,
                        .ui-button.ui-state-hover,
                        .ui-button.ui-state-active,
                        .ui-widget button.ui-state-hover,
                        .ui-widget button.ui-state-active,
                    ' . ($this->manager->gteOc2() ? '
                        .form-group.tb_style_2 label.tb_checked
                    ' : '
                        .options .tb_radio_row.tb_style_2 input.tb_checked + label,
                        .options .tb_checkbox_row.tb_style_2 input.tb_checked + label,
                        .options .tb_image_row.tb_style_2 td.tb_checked + td label
                    '),
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'gallery_nav' => array(
                '_label' => 'Image gallery',
                'button_default' => array(
                    'label'       => 'Prev/next buttons',
                    'elements'    => '.fotorama__arr:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_bg_default' => array(
                    'label'       => 'Prev/next buttons bg',
                    'elements'    => '.fotorama__arr:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_hover' => array(
                    'label'       => 'Prev/next buttons (hover)',
                    'elements'    => '.fotorama__arr:hover:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_bg_hover' => array(
                    'label'       => 'Prev/next buttons bg (hover)',
                    'elements'    => '.fotorama__arr:hover:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'fbutton_default' => array(
                    'label'       => 'Go fullscreen button',
                    'elements'    => '.tb_fullscreen_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'fbutton_bg_default' => array(
                    'label'       => 'Go fullscreen button bg',
                    'elements'    => '.tb_fullscreen_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'fbutton_hover' => array(
                    'label'       => 'Go fullscreen button (hover)',
                    'elements'    => '.tb_fullscreen_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'fbutton_bg_hover' => array(
                    'label'       => 'Go fullscreen button bg (hover)',
                    'elements'    => '.tb_fullscreen_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.fotorama__dot',
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
                    'elements'    => '.fotorama__nav__frame--dot:hover .fotorama__dot',
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
                    'elements'    => '.fotorama__active .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'thumb_border' => array(
                    'label'       => 'Active thumb border',
                    'elements'    => '.fotorama__thumb-border',
                    'property'    => 'border-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
            ),
            'gallery_fullscreen_nav' => array(
                '_label' => 'Image gallery (Fullscreen)',
                'button_default' => array(
                    'label'       => 'Button',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_bg_default' => array(
                    'label'       => 'Button bg',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:after',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:hover:before',
                    'property'    => 'color',
                    'color'       => '#cccccc',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_bg_hover' => array(
                    'label'       => 'Button bg (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:hover:after',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'fbutton_default' => array(
                    'label'       => 'Close button',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'fbutton_bg_default' => array(
                    'label'       => 'Close button bg',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'fbutton_hover' => array(
                    'label'       => 'Close button (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'fbutton_bg_hover' => array(
                    'label'       => 'Close button bg (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close:hover',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_hover'
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#555555',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_hover' => array(
                    'label'       => 'Pagination (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__nav__frame--dot:hover .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_active' => array(
                    'label'       => 'Pagination (active)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__active .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'overlay' => array(
                    'label'       => 'Overlay',
                    'elements'    => '.tb_gallery.tb_fullscreen:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'ui' => array(
                '_label' => 'Tabs / Accordion',
                'header_bg' => array(
                    'label'       => 'Header/toolbar bg',
                    'elements'    => '.ui-widget-header, .tb_tabs.tb_style_1 .tb_tabs_nav',
                    'property'    => 'background-color',
                    'color'       => '#e6e6e6',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'header_border' => array(
                    'label'       => 'Header/toolbar border',
                    'elements'    => '.ui-widget-header, .tb_vtabs .tb_tabs_nav',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'content_border' => array(
                    'label'       => 'Content border',
                    'elements'    => '
                        .tb_tabs.tb_style_1 .tb_tabs_content,
                        .tb_accordion.tb_style_1 .tb_title + div,
                        .ui-accordion .ui-widget-content
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_text' => array(
                    'label'       => 'Clickable text',
                    'elements'    => '
                        .ui-state-default:not([class*="tb_text_str_"]),
                        .ui-widget-content .ui-state-default:not([class*="tb_text_str_"]),
                        .ui-widget-header .ui-state-default:not([class*="tb_text_str_"]),
                        .ui-state-default a:not([class*="tb_text_str_"]),
                        .ui-state-default a:link,
                        .ui-state-default a:visited,
                        .tb_tabs .tb_tabs_nav > ul > li > a,
                        .tb_tabs.tb_style_2 .tb_tabs_nav > ul
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_bg' => array(
                    'label'       => 'Clickable bg',
                    'elements'    => '
                        .ui-state-default:not([class*="tb_bg_str_"]),
                        .ui-widget-content .ui-state-default:not([class*="tb_bg_str_"]),
                        .ui-widget-header .ui-state-default:not([class*="tb_bg_str_"])
                    ',
                    'property'    => 'background-color',
                    'color'       => '#e6e6e6',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_border' => array(
                    'label'       => 'Clickable border',
                    'elements'    => '
                        .ui-state-default:not([class*="tb_border_str_"]),
                        .ui-widget-content .ui-state-default:not([class*="tb_border_str_"]),
                        .ui-widget-header .ui-state-default:not([class*="tb_border_str_"])
                    ',
                    'property'    => 'border-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_icon' => array(
                    'label'       => 'Clickable icon',
                    'elements'    => '
                        .ui-icon,
                        .ui-state-default .ui-icon,
                        .ui-widget-content .ui-state-default .ui-icon,
                        .ui-widget-header .ui-state-default .ui-icon
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_text_hover' => array(
                    'label'       => 'Clickable text (hover)',
                    'elements'    => '
                        .ui-state-hover:not([class*="tb_text_hover_str_"]),
                        .ui-widget-content .ui-state-hover:not([class*="tb_text_hover_str_"]),
                        .ui-widget-header .ui-state-hover:not([class*="tb_text_hover_str_"]),
                        .ui-state-focus:not([class*="tb_text_hover_str_"]),
                        .ui-widget-content .ui-state-focus:not([class*="tb_text_hover_str_"]),
                        .ui-widget-header .ui-state-focus:not([class*="tb_text_hover_str_"]),
                        .ui-state-hover a:not([class*="tb_text_hover_str_"]),
                        .ui-state-hover a:not([class*="tb_text_hover_str_"]):hover,
                        .ui-state-hover a:link,
                        .ui-state-hover a:visited
                    ',
                    'property'    => 'color',
                    'color'       => '#111111',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_bg_hover' => array(
                    'label'       => 'Clickable bg (hover)',
                    'elements'    => '
                        .ui-state-hover:not([class*="tb_bg_hover_str_"]),
                        .ui-widget-content .ui-state-hover:not([class*="tb_bg_hover_str_"]),
                        .ui-widget-header .ui-state-hover:not([class*="tb_bg_hover_str_"]),
                        .ui-state-focus:not([class*="tb_bg_hover_str_"]),
                        .ui-widget-content .ui-state-focus:not([class*="tb_bg_hover_str_"]),
                        .ui-widget-header .ui-state-focus:not([class*="tb_bg_hover_str_"])
                    ',
                    'property'    => 'background-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_border_hover' => array(
                    'label'       => 'Clickable border (hover)',
                    'elements'    => '
                        .ui-state-hover:not([class*="tb_border_hover_str_"]),
                        .ui-widget-content .ui-state-hover:not([class*="tb_border_hover_str_"]),
                        .ui-widget-header .ui-state-hover:not([class*="tb_border_hover_str_"]),
                        .ui-state-focus:not([class*="tb_border_hover_str_"]),
                        .ui-widget-content .ui-state-focus:not([class*="tb_border_hover_str_"]),
                        .ui-widget-header .ui-state-focus:not([class*="tb_border_hover_str_"])
                    ',
                    'property'    => 'border-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_icon_hover' => array(
                    'label'       => 'Clickable icon (hover)',
                    'elements'    => '
                        .ui-state-hover .ui-icon,
                        .ui-widget-content .ui-state-hover .ui-icon,
                        .ui-widget-header .ui-state-hover .ui-icon,
                        .ui-state-focus .ui-icon,
                        .ui-widget-content .ui-state-focus .ui-icon,
                        .ui-widget-header .ui-state-focus .ui-icon
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_text_active' => array(
                    'label'       => 'Clickable text (active)',
                    'elements'    => '
                        .ui-state-active:not([class*="tb_text_str_"]):not([class*="tb_text_hover_str_"]),
                        .ui-widget-content .ui-state-active:not([class*="tb_text_str_"]):not([class*="tb_text_hover_str_"]),
                        .ui-widget-header .ui-state-active:not([class*="tb_text_str_"]):not([class*="tb_text_hover_str_"]),
                        .ui-state-active a:not([class*="tb_text_str_"]):not([class*="tb_text_hover_str_"]),
                        .ui-state-active a:not([class*="tb_text_str_"]):not([class*="tb_text_hover_str_"]):link,
                        .ui-state-active a:not([class*="tb_text_str_"]):not([class*="tb_text_hover_str_"]):visited,
                        .tb_tabs.tb_style_2 .tb_tabs_nav li.ui-state-active a
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_bg_active' => array(
                    'label'       => 'Clickable bg (active)',
                    'elements'    => '
                        .ui-state-active:not([class*="tb_bg_str_"]):not([class*="tb_bg_hover_str_"]),
                        .ui-widget-content .ui-state-active:not([class*="tb_bg_str_"]):not([class*="tb_bg_hover_str_"]),
                        .ui-widget-header .ui-state-active:not([class*="tb_bg_str_"]):not([class*="tb_bg_hover_str_"])
                    ',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_border_active' => array(
                    'label'       => 'Clickable border (active)',
                    'elements'    => '
                        .ui-state-active:not([class*="tb_border_str_"]):not([class*="tb_border_hover_str_"]),
                        .ui-widget-content .ui-state-active:not([class*="tb_border_str_"]):not([class*="tb_border_hover_str_"]),
                        .ui-widget-header .ui-state-active:not([class*="tb_border_str_"]):not([class*="tb_border_hover_str_"])
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_icon_active' => array(
                    'label'       => 'Clickable icon (active)',
                    'elements'    => '
                        .ui-state-active .ui-icon,
                        .ui-widget-content .ui-state-active .ui-icon,
                        .ui-widget-header .ui-state-active .ui-icon
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'dialog_ui' => array(
                '_label' => 'Dialog / Datepicker / Timepicker / Tooltip / Autocomplete',
                'header_text' => array(
                    'label'       => 'Header/toolbar text',
                    'elements'    => '
                        .ui-dialog .ui-widget-header,
                        .ui-dialog .ui-widget-header a,
                        .ui-dialog.ui-widget-content .ui-widget-header a,
                        .ui-datepicker .ui-widget-header,
                        .ui-datepicker .ui-widget-header a,
                        .ui-datepicker.ui-widget-content .ui-widget-header a
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'header_bg' => array(
                    'label'       => 'Header/toolbar bg',
                    'elements'    => '
                        .ui-dialog .ui-widget-header,
                        .ui-datepicker .ui-widget-header
                    ',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_bg'
                ),
                'header_border' => array(
                    'label'       => 'Header/toolbar border',
                    'elements'    => '
                        .ui-dialog .ui-widget-header,
                        .ui-datepicker .ui-widget-header
                    ',
                    'property'    => 'border-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent_bg'
                ),
                'content_text' => array(
                    'label'       => 'Content text',
                    'elements'    => '
                        .ui-dialog.ui-widget-content,
                        .ui-dialog.ui-widget-content a,
                        .ui-datepicker.ui-widget-content,
                        .ui-datepicker.ui-widget-content a,
                        .ui-tooltip.ui-widget-content,
                        .ui-tooltip.ui-widget-content a,
                        .ui-autocomplete.ui-widget-content,
                        .ui-autocomplete.ui-widget-content a
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'content_bg' => array(
                    'label'       => 'Content bg',
                    'elements'    => '
                        .ui-dialog.ui-widget-content,
                        .ui-datepicker.ui-widget-content,
                        .ui-tooltip.ui-widget-content,
                        .ui-autocomplete.ui-widget-content
                    ',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'content_border' => array(
                    'label'       => 'Content border',
                    'elements'    => '
                        .ui-dialog.ui-widget-content,
                        .ui-datepicker.ui-widget-content,
                        .ui-tooltip.ui-widget-content,
                        .ui-autocomplete.ui-widget-content
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_text' => array(
                    'label'       => 'Clickable text',
                    'elements'    => '
                        .ui-dialog .ui-state-default,
                        .ui-dialog .ui-state-default a,
                        .ui-datepicker .ui-state-default,
                        .ui-datepicker .ui-state-default a,
                        .ui-tooltip .ui-state-default,
                        .ui-tooltip .ui-state-default a,
                        .ui-autocomplete .ui-state-default,
                        .ui-autocomplete .ui-state-default a
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_bg' => array(
                    'label'       => 'Clickable bg',
                    'elements'    => '
                        .ui-dialog .ui-state-default,
                        .ui-datepicker .ui-state-default,
                        .ui-tooltip .ui-state-default,
                        .ui-autocomplete .ui-state-default
                    ',
                    'property'    => 'background-color',
                    'color'       => '#e3e3e3',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_border' => array(
                    'label'       => 'Clickable border',
                    'elements'    => '
                        .ui-dialog .ui-state-default,
                        .ui-datepicker .ui-state-default,
                        .ui-tooltip .ui-state-default,
                        .ui-autocomplete .ui-state-default
                    ',
                    'property'    => 'border-color',
                    'color'       => '#d3d3d3',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_icon' => array(
                    'label'       => 'Clickable icon',
                    'elements'    => '
                        .ui-dialog .ui-state-default .ui-icon,
                        .ui-datepicker .ui-state-default .ui-icon,
                        .ui-tooltip .ui-state-default .ui-icon,
                        .ui-autocomplete .ui-state-default .ui-icon
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_text_hover' => array(
                    'label'       => 'Clickable text (hover)',
                    'elements'    => '
                        .ui-dialog .ui-state-hover,
                        .ui-dialog .ui-state-focus,
                        .ui-dialog .ui-state-hover a,
                        .ui-dialog .ui-state-hover a:hover,
                        .ui-datepicker .ui-state-hover,
                        .ui-datepicker .ui-state-focus,
                        .ui-datepicker .ui-state-hover a,
                        .ui-datepicker .ui-state-hover a:hover,
                        .ui-tooltip .ui-state-hover,
                        .ui-tooltip .ui-state-focus,
                        .ui-tooltip .ui-state-hover a,
                        .ui-tooltip .ui-state-hover a:hover,
                        .ui-autocomplete .ui-state-hover,
                        .ui-autocomplete .ui-state-focus,
                        .ui-autocomplete .ui-state-hover a,
                        .ui-autocomplete .ui-state-hover a:hover
                    ',
                    'property'    => 'color',
                    'color'       => '#111111',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_bg_hover' => array(
                    'label'       => 'Clickable bg (hover)',
                    'elements'    => '
                        .ui-dialog .ui-state-hover,
                        .ui-dialog .ui-state-focus,
                        .ui-datepicker .ui-state-hover,
                        .ui-datepicker .ui-state-focus,
                        .ui-tooltip .ui-state-hover,
                        .ui-tooltip .ui-state-focus,
                        .ui-autocomplete .ui-state-hover,
                        .ui-autocomplete .ui-state-focus
                    ',
                    'property'    => 'background-color',
                    'color'       => '#d3d3d3',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_border_hover' => array(
                    'label'       => 'Clickable border (hover)',
                    'elements'    => '
                        .ui-dialog .ui-state-hover,
                        .ui-dialog .ui-state-focus,
                        .ui-datepicker .ui-state-hover,
                        .ui-datepicker .ui-state-focus,
                        .ui-tooltip .ui-state-hover,
                        .ui-tooltip .ui-state-focus,
                        .ui-autocomplete .ui-state-hover,
                        .ui-autocomplete .ui-state-focus
                    ',
                    'property'    => 'border-color',
                    'color'       => '#c3c3c3',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_icon_hover' => array(
                    'label'       => 'Clickable icon (hover)',
                    'elements'    => '
                        .ui-dialog .ui-state-hover .ui-icon,
                        .ui-dialog .ui-state-focus .ui-icon,
                        .ui-datepicker .ui-state-hover .ui-icon,
                        .ui-datepicker .ui-state-focus .ui-icon,
                        .ui-tooltip .ui-state-hover .ui-icon,
                        .ui-tooltip .ui-state-focus .ui-icon,
                        .ui-autocomplete .ui-state-hover .ui-icon,
                        .ui-autocomplete .ui-state-focus .ui-icon
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_text_active' => array(
                    'label'       => 'Clickable text (active)',
                    'elements'    => '
                        .ui-dialog .ui-state-active,
                        .ui-dialog .ui-state-active a,
                        .ui-dialog.ui-widget-content .ui-state-active,
                        .ui-dialog.ui-widget-content .ui-state-active a,
                        .ui-datepicker .ui-state-active,
                        .ui-datepicker .ui-state-active a,
                        .ui-datepicker.ui-widget-content .ui-state-active,
                        .ui-datepicker.ui-widget-content .ui-state-active a,
                        .ui-tooltip .ui-state-active,
                        .ui-tooltip .ui-state-active a,
                        .ui-tooltip.ui-widget-content .ui-state-active,
                        .ui-tooltip.ui-widget-content .ui-state-active a,
                        .ui-autocomplete .ui-state-active,
                        .ui-autocomplete .ui-state-active a,
                        .ui-autocomplete.ui-widget-content .ui-state-active,
                        .ui-autocomplete.ui-widget-content .ui-state-active a
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_bg_active' => array(
                    'label'       => 'Clickable bg (active)',
                    'elements'    => '
                        .ui-dialog .ui-state-active,
                        .ui-datepicker .ui-state-active,
                        .ui-tooltip .ui-state-active,
                        .ui-autocomplete .ui-state-active
                    ',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_border_active' => array(
                    'label'       => 'Clickable border (active)',
                    'elements'    => '
                        .ui-dialog .ui-state-active,
                        .ui-datepicker .ui-state-active,
                        .ui-tooltip .ui-state-active,
                        .ui-autocomplete .ui-state-active
                    ',
                    'property'    => 'border-color',
                    'color'       => '#222222',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'clickable_icon_active' => array(
                    'label'       => 'Clickable icon (active)',
                    'elements'    => '
                        .ui-dialog .ui-state-active .ui-icon,
                        .ui-datepicker .ui-state-active .ui-icon,
                        .ui-tooltip .ui-state-active .ui-icon,
                        .ui-autocomplete .ui-state-active .ui-icon
                    ',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'highlight_text' => array(
                    'label'       => 'Highlight text',
                    'elements'    => '
                        .ui-dialog .ui-state-highlight,
                        .ui-dialog .ui-state-highlight a
                        .ui-datepicker .ui-state-highlight,
                        .ui-datepicker .ui-state-highlight a
                        .ui-tooltip .ui-state-highlight,
                        .ui-tooltip .ui-state-highlight a
                        .ui-autocomplete .ui-state-highlight,
                        .ui-autocomplete .ui-state-highlight a
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'highlight_bg' => array(
                    'label'       => 'Highlight bg',
                    'elements'    => '
                        .ui-dialog .ui-state-highlight,
                        .ui-datepicker .ui-state-highlight,
                        .ui-tooltip .ui-state-highlight,
                        .ui-autocomplete .ui-state-highlight
                    ',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'highlight_border' => array(
                    'label'       => 'Highlight border',
                    'elements'    => '
                        .ui-dialog .ui-state-highlight,
                        .ui-datepicker .ui-state-highlight,
                        .ui-tooltip .ui-state-highlight,
                        .ui-autocomplete .ui-state-highlight
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'error_text' => array(
                    'label'       => 'Error text',
                    'elements'    => '
                        .ui-dialog .ui-state-error,
                        .ui-dialog .ui-state-error a,
                        .ui-dialog .ui-state-error-text,
                        .ui-datepicker .ui-state-error,
                        .ui-datepicker .ui-state-error a,
                        .ui-datepicker .ui-state-error-text,
                        .ui-tooltip .ui-state-error,
                        .ui-tooltip .ui-state-error a,
                        .ui-tooltip .ui-state-error-text,
                        .ui-autocomplete .ui-state-error,
                        .ui-autocomplete .ui-state-error a,
                        .ui-autocomplete .ui-state-error-text
                    ',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main.accent'
                ),
                'error_bg' => array(
                    'label'       => 'Error bg',
                    'elements'    => '
                        .ui-dialog .ui-state-error,
                        .ui-datepicker .ui-state-error,
                        .ui-tooltip .ui-state-error,
                        .ui-autocomplete .ui-state-error
                    ',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'error_border' => array(
                    'label'       => 'Error border',
                    'elements'    => '
                        .ui-dialog .ui-state-error,
                        .ui-datepicker .ui-state-error,
                        .ui-tooltip .ui-state-error,
                        .ui-autocomplete .ui-state-error
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            ),
            'system_messages' => array(
                '_label' => 'System messages',
                'text' => array(
                    'label'       => 'Text',
                    'elements'    => '.noty_message',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_submenu.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => '.noty_message a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_submenu.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => '.noty_message a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_submenu.links_hover'
                ),
                'title' => array(
                    'label'       => 'Title',
                    'elements'    => '.noty_message h3',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'system_messages.text'
                ),
                'button' => array(
                    'label'       => 'Button',
                    'elements'    => '
                        .noty_message .tb_button:not([class*="tb_bg_str_"]),
                        .noty_message .tb_icon
                    ',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button'
                ),
                'button_text' => array(
                    'label'       => 'Button Text',
                    'elements'    => '
                        .noty_message .tb_button:not([class*="tb_text_str_"]),
                        .noty_message .tb_icon
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text'
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '
                        .noty_message .tb_button:not([class*="tb_bg_hover_str_"]):hover,
                        .noty_message .tb_button_hover:hover
                    ',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_hover'
                ),
                'button_text_hover' => array(
                    'label'       => 'Button Text (hover)',
                    'elements'    => '
                        .noty_message .tb_button:not([class*="tb_text_hover_str_"]):hover,
                        .noty_message .tb_button_hover:hover
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'forms.button_text_hover'
                ),
                'submenu_bg' => array(
                    'label'       => 'Background',
                    'elements'    => '.noty_message',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'main_navigation_submenu.submenu_bg'
                ),
            ),
            'custom' => array(
                '_label' => 'Custom'
            )
        );
    }

    public function setDataForView(&$color_settings, TB_ViewDataBag $themeData)
    {
        if (isset($color_settings['custom'])) {
            $this->default_colors['custom'] = array_merge($this->default_colors['custom'], $color_settings['custom']);
        }

        TB_ColorSchemer::getInstance()->filterThemeColors($color_settings, $this->default_colors);
        $themeData->colors = $color_settings;
    }

    public function saveData($post_data)
    {
        if (!isset($post_data[$this->getConfigKey()]['custom'])) {
            $post_data[$this->getConfigKey()]['custom'] = array();
        }

        return array(
            $this->getConfigKey() => $post_data[$this->getConfigKey()]
        );
    }
}