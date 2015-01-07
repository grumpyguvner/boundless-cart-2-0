<?php

class Theme_LayoutBuilderModel extends TB_ExtensionModel
{
    public function getSystemPages()
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $result = array();

        $dirs = sfFinder::type('dir')
            ->sort_by_name()
            ->in($this->manager->getContext()->getConfigDir() . '/system_widgets');

        $gteOc2 = $this->manager->gteOc2();

        foreach ($dirs as $dir) {
            $files = sfFinder::type('file')
                ->name('*.php')
                ->sort_by_name()
                ->in($dir);

            foreach ($files as $filename) {
                $settings = require $filename;
                if (isset($settings['label']) && isset($settings['route'])) {
                    $result[basename($dir)][basename($filename, '.php')] = $settings;
                }
            }
        }

        foreach ($result as &$items) {
            ksort($items);
        }

        $system_settings = $this->getSetting('system');
        $custom = array();
        if (isset($system_settings['pages'])) {
            foreach ($system_settings['pages'] as $page) {
                $page['display'] = true;
                $widgets = array();
                foreach ($page['widgets'] as $slot => $is_active) {
                    if ($is_active) {
                        switch ($slot) {
                            case 'breadcrumbs':
                                $label  = 'Breadcrumbs';
                                $areas  = 'intro, content';
                                $locked = false;
                                break;
                            case 'page_title':
                                $label  = 'Page title';
                                $areas  = 'intro, content';
                                $locked = false;
                                break;
                            case 'page_content':
                                $label  = 'Page content';
                                $areas  = 'content';
                                $locked = true;
                                break;
                            default:
                                $slot = false;
                        }
                        if (false !== $slot) {
                            $widgets[] = array(
                                'label'  => $label,
                                'slot'   => $slot,
                                'areas'  => $areas,
                                'locked' => $locked,
                            );
                        }
                    }
                }

                if (!empty($widgets)) {
                    $page['widgets'] = $widgets;
                    $custom[str_replace('-', '_', TB_Utils::slugify($page['route']))] = $page;
                }
            }
        }

        if (!empty($custom)) {
            $result['custom'] = $custom;
        }

        return $result;
    }

    public function getSystemPageForRoute($route)
    {
        foreach ($this->getSystemPages() as $group_items) {
            foreach ($group_items as $page) {
                if ($page['route'] == $route) {
                    return $page;
                }
            }
        }

        return false;
    }

    public function cleanSettingsDataBeforePersist(array &$settings)
    {
        if (isset($settings['box_shadow']) && !isset($settings['box_shadow']['rows']) || empty($settings['box_shadow']['rows'])) {
            unset($settings['box_shadow']);
        }

        if (isset($settings['border'])) {
            foreach (array('top', 'right', 'bottom', 'left') as $side) {
                if (empty($settings['border'][$side]['width'])) {
                    unset($settings['border'][$side]);
                }
            }

            if (empty($settings['border'])) {
                unset($settings['border']);
            }
        }

        if (isset($settings['border_radius'])) {
            foreach (array('top_left', 'top_right', 'bottom_left', 'bottom_right') as $side) {
                if (empty($settings['border_radius'][$side])) {
                    unset($settings['border_radius'][$side]);
                }
            }

            if (empty($settings['border_radius'])) {
                unset($settings['border_radius']);
            }
        }

        if (isset($settings['colors'])) {
            $this->cleanSettingsColorsBeforePersist($settings['colors']);

            if (empty($settings['colors'])) {
                unset($settings['colors']);
            }
        }

        if (isset($settings['font'])) {
            $this->cleanFontDataBeforePersist($settings['font']);

            if (empty($settings['font'])) {
                unset($settings['font']);
            }
        }
    }

    public function cleanSettingsColorsBeforePersist(array &$colors)
    {
        foreach ($colors as $group_key => &$sections) {
            foreach ($sections as $section_key => &$section_values) {

                if (0 === strpos($section_key, '_')) {
                    unset($sections[$section_key]);
                } else {
                    if ($section_values['inherit'] && (!isset($section_values['force_print']) || !$section_values['force_print'])) {
                        unset($colors[$group_key][$section_key]);
                    } else {
                        unset($section_values['label']);
                        unset($section_values['force_print']);
                        unset($section_values['can_inherit']);
                        unset($section_values['inherit_key']);
                        unset($section_values['id']);
                        unset($section_values['parent_id']);
                        unset($section_values['parent_color']);
                        unset($section_values['inherit_title']);

                        if (empty($section_values['elements'])) {
                            unset($section_values['elements']);
                        }

                        if (empty($section_values['important'])) {
                            unset($section_values['important']);
                        }
                    }
                }
            }

            if (empty($sections)) {
                unset($colors[$group_key]);
            }
        }
    }

    public function cleanFontDataBeforePersist(&$font_settings)
    {
        foreach ($this->manager->getEnabledLanguages() as $language) {
            if (isset($font_settings[$language['id']])) {
                foreach ($font_settings[$language['id']] as $section_key => $section) {
                    if ($section['family'] == 'inherit') {
                        unset($font_settings[$language['id']][$section_key]);
                        // We can't just unset the color item. If the default value is not inherit and the user change it to inherit on the next refresh it will be re-initialized if it is missing in the database
                        $font_settings[$language['id']][$section_key] = array(
                            'family' => 'inherit'
                        );
                    } else {
                        unset($font_settings[$language['id']][$section_key]['inherit']);
                        unset($font_settings[$language['id']][$section_key]['can_inherit']);
                        unset($font_settings[$language['id']][$section_key]['built-in']);
                        unset($font_settings[$language['id']][$section_key]['show_built_styles']);

                        $font = $font_settings[$language['id']][$section_key];

                        if (isset($font['multiple_variants']) && empty($font['multiple_variants'])) {
                            unset($font_settings[$language['id']][$section_key]['multiple_variants']);
                        }

                        if (isset($font['elements']) && empty($font['elements'])) {
                            unset($font_settings[$language['id']][$section_key]['elements']);
                        }

                        if (isset($font['variant']) && empty($font['variant'])) {
                            unset($font_settings[$language['id']][$section_key]['variant']);
                        }

                        if (isset($font['subsets']) && empty($font['subsets'])) {
                            unset($font_settings[$language['id']][$section_key]['subsets']);
                        }

                        if (isset($font['has_size'])) {
                            unset($font_settings[$language['id']][$section_key]['has_size']);
                        }

                        if (isset($font['size']) && empty($font['size'])) {
                            unset($font_settings[$language['id']][$section_key]['size']);
                        }

                        if (isset($font['has_line_height'])) {
                            unset($font_settings[$language['id']][$section_key]['has_line_height']);
                        }

                        if (isset($font['line-height']) && empty($font['line-height'])) {
                            unset($font_settings[$language['id']][$section_key]['line-height']);
                        }

                        if (isset($font['has_spacing'])) {
                            unset($font_settings[$language['id']][$section_key]['has_spacing']);
                        }

                        if (isset($font['word-spacing']) && !strlen($font['word-spacing'])) {
                            unset($font_settings[$language['id']][$section_key]['word-spacing']);
                        }

                        if (isset($font['letter-spacing']) && !strlen($font['letter-spacing'])) {
                            unset($font_settings[$language['id']][$section_key]['letter-spacing']);
                        }

                        if (isset($font['has_effects'])) {
                            unset($font_settings[$language['id']][$section_key]['has_effects']);
                        }

                        if (isset($font['transform']) && empty($font['transform'])) {
                            unset($font_settings[$language['id']][$section_key]['transform']);
                        }
                    }
                }

                if (empty($font_settings[$language['id']])) {
                    unset($font_settings[$language['id']]);
                }
            }
        }
    }

    public function filterSettings(array &$data, $section, $default_colors = null)
    {
        $default_vars = array(
            'layout' => array(
                'type'            => 'full',
                'margin_top'      => 0,
                'margin_bottom'   => 30,
                'margin_right'    => 0,
                'padding_top'     => 0,
                'padding_right'   => 0,
                'padding_bottom'  => 0,
                'inner_padding'   => 30,
                'columns_gutter'  => 30,
                'extra_class'     => '',
                'merge_columns'   => true
            ),
            'box_shadow'            => array(
                'rows' => array()
            ),
            'background' => array(
                'solid_color' => '',
                'solid_color_opacity' => 100,
                'rows' => array()
            ),
            'border' => array(
                'top'    => array(),
                'right'  => array(),
                'bottom' => array(),
                'left'   => array()
            ),
            'border_radius' => array(
                'top_left'     => 0,
                'top_right'    => 0,
                'bottom_right' => 0,
                'bottom_left'  => 0
            ),
            'colors' => array(),
            'font' => array(
                'body' => array(
                    'section_name'      => 'Body',
                    'elements'          => '',
                    'type'              => '',
                    'family'            => 'inherit',
                    'subsets'           => '',
                    'variant'           => '',
                    'size'              => 13,
                    'line-height'       => 20,
                    'letter-spacing'    => 0,
                    'word-spacing'      => 0,
                    'transform'         => '',
                    'has_size'          => true,
                    'has_line_height'   => true,
                    'has_spacing'       => false,
                    'has_effects'       => false,
                    'show_built_styles' => false,
                    'multiple_variants' => true,
                    'built-in'          => true,
                    'can_inherit'       => true,
                    'css_weight'        => '',
                    'css_style'         => ''
                ),
                'h1' => array(
                    'section_name'      => 'H1',
                    'elements'          => 'h1, .h1',
                    'type'              => '',
                    'family'            => 'inherit',
                    'subsets'           => '',
                    'variant'           => '',
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
                        .tb_slider_controls .tb_prev,
                        .tb_slider_controls .tb_next
                    ',
                    'type'              => '',
                    'family'            => 'inherit',
                    'subsets'           => '',
                    'variant'           => '',
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
                    'type'              => '',
                    'family'            => 'inherit',
                    'subsets'           => '',
                    'variant'           => '',
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
                    'type'              => '',
                    'family'            => 'inherit',
                    'subsets'           => '',
                    'variant'           => '',
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
                )
            )
        );

        if (empty($data)) {
            $result = $default_vars;
        } else {
            $result = TB_FormHelper::initFlatVarsSimple($default_vars, $data);
        }

        // Layout
        if ($section == 'area_content') {
            $default_vars['layout']['left_column_width']   = 160;
            $default_vars['layout']['right_column_width']  = 240;
            $default_vars['layout']['inner_padding']       = 30;
            $default_vars['layout']['columns_gutter']      = 30;
        }

        $result['layout'] = TB_FormHelper::initFlatVarsSimple($default_vars['layout'], $result['layout']);

        // Box Shadows
        $result['box_shadow'] = TB_FormHelper::initFlatVarsSimple($default_vars['box_shadow'], $result['box_shadow']);
        foreach ($result['box_shadow']['rows'] as &$row) {
            $vars = array(
                'size_x'   => 0,
                'size_y'   => 0,
                'angle'    => 0,
                'distance' => 0,
                'inner'    => 0,
                'blur'     => 0,
                'spread'   => 0,
                'color'    => '#000000',
                'opacity'  => 1
            );
            $row = TB_FormHelper::initFlatVarsSimple($vars, $row);
        }

        // Background
        $gradient_vars = array(
            'background_type'     => 'gradient',
            'type'                => 'linear',
            'angle'               => 0,
            'container'           => 'row',
            'position'            => 'center',
            'position_x_metric'   => 'px',
            'position_y_metric'   => 'px',
            'position_x'          => 0,
            'position_y'          => 0,
            'repeat'              => 'no-repeat',
            'size'                => 'auto',
            'size_x_metric'       => 'px',
            'size_y_metric'       => 'px',
            'size_x'              => 0,
            'size_y'              => 0,
            'attachment'          => 'scroll',
            'colors'              => array()
        );

        $color_vars = array(
            'color'       => '#000000',
            'offset_auto' => 1,
            'offset'      => 100,
            'opacity'     => 100
        );

        $image_vars = array(
            'background_type'     => 'image',
            'image'               => '',
            'container'           => 'row',
            'position'            => 'center',
            'position_x_metric'   => 'px',
            'position_y_metric'   => 'px',
            'position_x'          => 0,
            'position_y'          => 0,
            'repeat'              => 'no-repeat',
            'size'                => 'auto',
            'size_x_metric'       => 'px',
            'size_y_metric'       => 'px',
            'size_x'              => 0,
            'size_y'              => 0,
            'attachment'          => 'scroll'
        );

        $result['background'] = TB_FormHelper::initFlatVarsSimple($default_vars['background'], $result['background']);

        foreach ($result['background']['rows'] as &$bg_row) {
            switch ($bg_row['background_type']) {
                case 'gradient':
                    $bg_row = TB_FormHelper::initFlatVarsSimple($gradient_vars, $bg_row);
                    foreach ($bg_row['colors'] as &$color_row) {
                        $color_row = TB_FormHelper::initFlatVarsSimple($color_vars, $color_row);
                    }
                    break;
                case 'image':
                    $bg_row = TB_FormHelper::initFlatVarsSimple($image_vars, $bg_row);
                    break;
            }
        }

        // Border
        $result['border'] = TB_FormHelper::initFlatVarsSimple($default_vars['border'], $result['border']);
        $border_vars = array(
            'width'   => 0,
            'style'   => 'solid',
            'color'   => '#000000',
            'opacity' => 100
        );

        foreach (array('top', 'right', 'bottom', 'left') as $side) {
            $result['border'][$side] = TB_FormHelper::initFlatVarsSimple($border_vars, $result['border'][$side]);
        }

        // Border Radius
        $result['border_radius'] = TB_FormHelper::initFlatVarsSimple($default_vars['border_radius'], $result['border_radius']);

        // Font
        $result['font'] = TB_FormHelper::initLangVarsSimple($default_vars['font'], $result['font'], $this->manager->getEnabledLanguages());
        foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
            foreach ($result['font'][$lid] as $name => &$font_section) {
                $font_section = TB_FormHelper::initFlatVarsSimple($default_vars['font'][$name], $font_section);
            }
        }

        //Colors
        if (null !== $default_colors) {
            if (empty($result['colors'])) {
                $result['colors'] = $default_colors;
            } else {
                foreach ($result['colors'] as $group_key => &$sections) {
                    foreach ($sections as $section_key => &$section_values) {
                        if (isset($default_colors[$group_key]['sections'][$section_key]) && 0 !== strpos($section_key, '_')) {
                            $section_values = TB_FormHelper::initFlatVarsSimple($default_colors[$group_key]['sections'][$section_key], $section_values);
                        }
                    }
                }
            }
        }

        $data = $result;

        return $data;
    }

    public function getAreaDefaultColors($area_name)
    {
        $default_colors = array(
            'body' => array(
                '_label' => 'Body',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '.tb_main_color, .tb_main_color_hover:hover, .colorbox, .tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:main.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => 'a.tb_main_color:hover, a.colorbox:hover, .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:main.accent_hover'
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
                    'elements'    => 'a.tb_main_color_bg:hover, .tb_main_color_bg_hover:hover',
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
                    'inherit_key' => 'theme:main.text'
                ),
                'titles' => array(
                    'label'       => 'Titles',
                    'elements'    => 'h1, h2, h3, h4, h5, h6, .h2, .h3, legend, .box-heading, .tb_widget_open_cart .panel-heading',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.text'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => 'a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:main.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:main.links_hover'
                ),
                'column_border' => array(
                    'label'       => 'Column border',
                    'elements'    => '
                        .tb_row_separate > .tb_wrap > [class*="tb_col_"],
                        hr,
                        .tb_listing .tb_order,
                        .tb_listing .tb_return,
                        .tb_listing .tb_order .tb_status,
                        .tb_listing .tb_return .tb_status,
                        .tb_widget_text blockquote
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:main.column_border'
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                    'force_print' => 0,
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
                ),
                'button' => array(
                    'label'       => 'Button',
                    'elements'    => '
                        .tb_button,
                        a.tb_button,
                        .button,
                        button,
                        [type=button],
                        [type=submit],
                        [type=reset],
                        .ui-button.ui-state-default,
                        .ui-widget button.ui-state-default,
                        .ui-slider .ui-slider-handle.ui-state-default
                    ',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.button'
                ),
                'button_text' => array(
                    'label'       => 'Button Text',
                    'elements'    => '
                        .tb_button,
                        a.tb_button,
                        [class] [class] .tb_button,
                        .button,
                        button,
                        [type=button],
                        [type=submit],
                        [type=reset],
                        .ui-button.ui-state-default,
                        .ui-widget button.ui-state-default
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.button_text'
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '
                        .tb_button:hover,
                        a.tb_button:hover,
                        .button:hover, button:hover,
                        [type=button]:hover,
                        [type=submit]:hover,
                        [type=reset]:hover,
                        .ui-button.ui-state-hover,
                        .ui-button.ui-state-active,
                        .ui-widget button.ui-state-hover,
                        .ui-widget button.ui-state-active,
                        .ui-slider .ui-slider-handle.ui-state-hover,
                        .ui-slider .ui-slider-handle.ui-state-active,
                        .options .tb_radio_row.tb_style_2 input.tb_checked + label,
                        .options .tb_checkbox_row.tb_style_2 input.tb_checked + label,
                        .options .tb_image_row.tb_style_2 td.tb_checked + td label
                    ',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.button_hover'
                ),
                'button_text_hover' => array(
                    'label'       => 'Button Text (hover)',
                    'elements'    => '
                        .tb_button:hover,
                        a.tb_button:hover,
                        [class] [class] .tb_button:hover,
                        .button:hover,
                        button:hover,
                        [type=button]:hover,
                        [type=submit]:hover,
                        [type=reset]:hover,
                        .ui-button.ui-state-hover,
                        .ui-button.ui-state-active,
                        .ui-widget button.ui-state-hover,
                        .ui-widget button.ui-state-active,
                        .options .tb_radio_row.tb_style_2 input.tb_checked + label,
                        .options .tb_checkbox_row.tb_style_2 input.tb_checked + label,
                        .options .tb_image_row.tb_style_2 td.tb_checked + td label
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:forms.button_text_hover'
                )
            )
        );

        if ($area_name == 'area_content') {
            array_replace_ref($default_colors['body']['accent'],        array('inherit_key' => 'theme:content.accent'));
            array_replace_ref($default_colors['body']['accent_hover'],  array('inherit_key' => 'theme:content.accent_hover'));
            array_replace_ref($default_colors['body']['text'],          array('inherit_key' => 'theme:content.text'));
            array_replace_ref($default_colors['body']['titles'],        array('inherit_key' => 'theme:content.titles'));
            array_replace_ref($default_colors['body']['links'],         array('inherit_key' => 'theme:content.links'));
            array_replace_ref($default_colors['body']['links_hover'],   array('inherit_key' => 'theme:content.links_hover'));
            array_replace_ref($default_colors['body']['column_border'], array('inherit_key' => 'theme:content.column_border'));
        }

        if ($area_name == 'area_footer') {
            array_replace_ref($default_colors['body']['accent'],        array('inherit_key' => 'theme:footer.accent'));
            array_replace_ref($default_colors['body']['accent_hover'],  array('inherit_key' => 'theme:footer.accent_hover'));
            array_replace_ref($default_colors['body']['text'],          array('inherit_key' => 'theme:footer.text'));
            array_replace_ref($default_colors['body']['titles'],        array('inherit_key' => 'theme:footer.titles'));
            array_replace_ref($default_colors['body']['links'],         array('inherit_key' => 'theme:footer.links'));
            array_replace_ref($default_colors['body']['links_hover'],   array('inherit_key' => 'theme:footer.links_hover'));
            array_replace_ref($default_colors['body']['column_border'], array('inherit_key' => 'theme:footer.column_border'));
        }

        if ($area_name == 'area_intro') {
            array_replace_ref($default_colors['body']['accent'],        array('inherit_key' => 'theme:intro.accent'));
            array_replace_ref($default_colors['body']['accent_hover'],  array('inherit_key' => 'theme:intro.accent_hover'));
            array_replace_ref($default_colors['body']['text'],          array('inherit_key' => 'theme:intro.text'));
            array_replace_ref($default_colors['body']['titles'],        array('inherit_key' => 'theme:intro.titles'));
            array_replace_ref($default_colors['body']['links'],         array('inherit_key' => 'theme:intro.links'));
            array_replace_ref($default_colors['body']['links_hover'],   array('inherit_key' => 'theme:intro.links_hover'));
            array_replace_ref($default_colors['body']['column_border'], array('inherit_key' => 'theme:intro.column_border'));
        }

        return $default_colors;
    }

    public function getRowDefaultColors()
    {
        $default_colors = array(
            'body' => array(
                '_label' => 'Body',
                'accent' => array(
                    'label'       => 'Accent',
                    'elements'    => '.tb_main_color, .tb_main_color_hover:hover, .colorbox, .tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:body.accent'
                ),
                'accent_hover' => array(
                    'label'       => 'Accent (hover)',
                    'elements'    => 'a.tb_main_color:hover, a.colorbox:hover, .tb_main_color_hover:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:body.accent_hover'
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
                    'elements'    => 'a.tb_main_color_bg:hover, .tb_main_color_bg_hover:hover',
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
                    'inherit_key' => 'area:body.text'
                ),
                'titles' => array(
                    'label'       => 'Titles',
                    'elements'    => 'h1, h2, h3, h4, h5, h6, .h2, .h3, legend, .box-heading, .tb_widget_open_cart .panel-heading',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:body.titles'
                ),
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => 'a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:body.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:body.links_hover'
                ),
                'column_border' => array(
                    'label'       => 'Column border',
                    'elements'    => '
                        > .tb_wrap > [class*="tb_col_"],
                        hr,
                        .tb_listing .tb_order,
                        .tb_listing .tb_return,
                        .tb_listing .tb_order .tb_status,
                        .tb_listing .tb_return .tb_status,
                        .tb_widget_text blockquote
                    ',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:body.column_border'
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
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_text'
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
                    'inherit_key' => 'area:forms.input_bg'
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
                    'inherit_key' => 'area:forms.input_border_top_left'
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
                    'inherit_key' => 'area:forms.input_border_bottom_right'
                ),
                'input_text_hover' => array(
                    'label'       => 'Text (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_text_hover'
                ),
                'input_bg_hover' => array(
                    'label'       => 'Background (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_bg_hover'
                ),
                'input_border_top_left_hover' => array(
                    'label'       => 'Top/left border (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_border_top_left_hover'
                ),
                'input_border_bottom_right_hover' => array(
                    'label'       => 'Bottom/right border (hover)',
                    'elements'    => 'input:hover, select:hover, textarea:hover, .ui-spinner.ui-widget-content:hover',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_border_bottom_right_hover'
                ),
                'input_text_focus' => array(
                    'label'       => 'Text (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_text_focus'
                ),
                'input_bg_focus' => array(
                    'label'       => 'Background (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'background-color',
                    'color'       => '#eeeeee',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_bg_focus'
                ),
                'input_border_top_left_focus' => array(
                    'label'       => 'Top/left border (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'border-top-color, border-left-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_border_top_left_focus'
                ),
                'input_border_bottom_right_focus' => array(
                    'label'       => 'Bottom/right border (focus)',
                    'elements'    => 'input:focus, select:focus, textarea:focus, .ui-spinner.ui-widget-content:focus',
                    'property'    => 'border-bottom-color, border-right-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.input_border_bottom_right_focus'
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
                    'inherit_key' => 'area:forms.input_text_error'
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
                    'inherit_key' => 'area:forms.input_bg_error'
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
                    'inherit_key' => 'area:forms.input_border_top_left_error'
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
                    'inherit_key' => 'area:forms.input_border_bottom_right_error'
                ),
                'button' => array(
                    'label'       => 'Button',
                    'elements'    => '
                        .tb_button,
                        a.tb_button,
                        .button,
                        button,
                        [type=button],
                        [type=submit],
                        [type=reset],
                        .ui-button.ui-state-default,
                        .ui-widget button.ui-state-default,
                        .ui-slider .ui-slider-handle.ui-state-default
                    ',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.button'
                ),
                'button_text' => array(
                    'label'       => 'Button Text',
                    'elements'    => '
                        .tb_button,
                        a.tb_button,
                        [class] [class] .tb_button,
                        .button,
                        button,
                        [type=button],
                        [type=submit],
                        [type=reset],
                        .ui-button.ui-state-default,
                        .ui-widget button.ui-state-default
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.button_text'
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '
                        .tb_button:hover,
                        a.tb_button:hover,
                        .button:hover, button:hover,
                        [type=button]:hover,
                        [type=submit]:hover,
                        [type=reset]:hover,
                        .ui-button.ui-state-hover,
                        .ui-button.ui-state-active,
                        .ui-widget button.ui-state-hover,
                        .ui-widget button.ui-state-active,
                        .ui-slider .ui-slider-handle.ui-state-hover,
                        .ui-slider .ui-slider-handle.ui-state-active,
                        .options .tb_radio_row.tb_style_2 input.tb_checked + label,
                        .options .tb_checkbox_row.tb_style_2 input.tb_checked + label,
                        .options .tb_image_row.tb_style_2 td.tb_checked + td label
                    ',
                    'property'    => 'background-color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.button_hover'
                ),
                'button_text_hover' => array(
                    'label'       => 'Button Text (hover)',
                    'elements'    => '
                        .tb_button:hover,
                        a.tb_button:hover,
                        [class] [class] .tb_button:hover,
                        .button:hover,
                        button:hover,
                        [type=button]:hover,
                        [type=submit]:hover,
                        [type=reset]:hover,
                        .ui-button.ui-state-hover,
                        .ui-button.ui-state-active,
                        .ui-widget button.ui-state-hover,
                        .ui-widget button.ui-state-active,
                        .options .tb_radio_row.tb_style_2 input.tb_checked + label,
                        .options .tb_checkbox_row.tb_style_2 input.tb_checked + label,
                        .options .tb_image_row.tb_style_2 td.tb_checked + td label
                    ',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'area:forms.button_text_hover'
                )
            )
        );

        return $default_colors;
    }
}