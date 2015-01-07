<?php

class Theme_BannerWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'   => 1,
            'url'         => '',
            'url_target'  => '_self',
            'line_1'      => '',
            'line_2'      => '',
            'line_3'      => '',
            'text_align'  => 'center',
            'text_valign' => 'middle'
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'ratio_w'     => 240,
            'ratio_h'     => 150,
            'max_height'  => 150,
            'min_height'  => 0,
            'image'       => '',
            'hover'       => 'zoom',
            'zoom_origin' => 'center'
        ), $settings));
    }

    public function onEdit(array &$settings)
    {
        if (!empty($settings['image'])  && file_exists(DIR_IMAGE . $settings['image'])) {
            $settings['image_preview'] = $this->getOcModel('tool/image')->resize($settings['image'], 100, 100);
        } else {
            $settings['image_preview'] = $this->getThemeModel()->getNoImage();
        }
    }

    public function render(array $view_data = array())
    {   
        $settings = $this->settings;
        
        if ($settings['max_height']) {
            $w = ($settings['ratio_w'] * $settings['max_height']) / $settings['ratio_h'];
            $h = $settings['max_height'];
        } else {
            $w = $settings['ratio_w'];
            $h = $settings['ratio_h'];
        }

        ob_start();
        imagegif(imagecreate($w, $h));
        $img = ob_get_clean();

        $view_data['ratio_img'] = 'data:image/gif;base64,' . base64_encode($img);
        $view_data['image']     = $this->manager->getContext()->getImageUrl() . $settings['image'];

        return parent::render($view_data);
    }

    protected function getDefaultFonts()
    {
        return array(
            'line_1' => array(
                'section_name'      => 'Line 1',
                'elements'          => ' .tb_line_1',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 18,
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
            'line_2' => array(
                'section_name'      => 'Line 2',
                'elements'          => ' .tb_line_2',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 18,
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
            'line_3' => array(
                'section_name'      => 'Line 3',
                'elements'          => ' .tb_line_3',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 18,
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
            'banner' => array(
                '_label' => 'Separator',
                'line_1' => array(
                    'label'       => 'Line 1',
                    'elements'    => '.tb_line_1',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'line_2' => array(
                    'label'       => 'Line 2',
                    'elements'    => '.tb_line_2',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'line_3' => array(
                    'label'       => 'Line 3',
                    'elements'    => '.tb_line_3',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'hover_bg' => array(
                    'label'       => 'Hover bg',
                    'elements'    => '.tb_image:before',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                )
            )
        );

        return $default_colors;
    }

}