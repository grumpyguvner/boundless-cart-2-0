<?php

class Theme_SeparatorWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'         => 1,
            'title'             => '',
            'title_align'       => 'left'
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'type'              => 'border',
            'border_size'       => 1,
            'border_style'      => 'solid'
        ), $settings));
    }

    public function render(array $view_data = array())
    {

        $font_base = $this->themeData->fonts['body']['line-height'];
        $t_height  = $this->settings['common']['font'][$this->language_id]['title']['line-height'];
        $b_height  = $this->settings['border_size'];

        $wrap_styles  = $this->getLangTitle() ? 'height: ' . $this->themeData->calculateLineHeight(max($t_height, $b_height), $font_base) . 'px;' : '';
        $title_styles = 'line-height: ' . $this->themeData->calculateLineHeight(max($t_height, $b_height), $font_base) . 'px;';
        
        $separator_classes    = '';
        $separator_classes   .= ' tb_' . $this->settings['type'];

        if ($this->settings['type'] == 'border') {
          $separator_classes .= '_' . $this->settings['border_style'];
        }
        $separator_styles     = '';
        $separator_styles    .= $this->getLangTitle() ? 'margin-top: -' . ceil($b_height / 2) . 'px;' : '';
        $separator_styles    .= 'border-bottom-width: ' . $this->settings['border_size'] . 'px;';
        
        $view_data['wrap_styles']       = $wrap_styles;
        $view_data['title_styles']      = $title_styles;
        $view_data['separator_classes'] = $separator_classes;
        $view_data['separator_styles']  = $separator_styles;

        return parent::render($view_data);
    }

    public function __sleep()
    {
        $t_height = $this->settings['common']['font'][$this->language_id]['title']['line-height'];
        $result = parent::__sleep();

        $this->settings['common']['font'] = array(
            $this->language_id => array(
                'title' => array(
                    'line-height' => $t_height
                )
            )
        );

        return $result;
    }

    public function getFrontendClasses()
    {
        $lang_vars = $this->getLangSettings();

        $classes = parent::getFrontendClasses();
        $classes .= ' align_' . $lang_vars['title_align'];

        return $classes;
    }

    protected function getDefaultFonts()
    {
        return array(
            'title' => array(
                'section_name'      => 'Title',
                'elements'          => '.tb_title',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 11,
                'line-height'       => 20,
                'letter-spacing'    => 1,
                'word-spacing'      => 0,
                'transform'         => 'uppercase',
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
                    'label'       => 'Title',
                    'elements'    => '.tb_title',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.titles'
                ),
                'title_bg' => array(
                    'label'       => 'Title Background',
                    'elements'    => '.tb_title',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'border_color' => array(
                    'label'       => 'Border',
                    'elements'    => 'span[class*="tb_border"]',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
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

    public function getPresentationTitle()
    {
        $title = $this->getName();
        $lang_title = $this->getLangTitle();
        if (!empty($lang_title)) {
            $title = $lang_title . ' <span>(' . $title . ')</span>';
        }

        return $title;
    }

}