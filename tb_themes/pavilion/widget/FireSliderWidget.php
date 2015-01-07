<?php

class Theme_FireSliderWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');
    protected $slider;

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'         => 1
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'slider_id'       => '0',
            'navigation_size' => '3'
        ), $settings));
    }

    public function allowAddToAreaContentCache()
    {
        return false;
    }

    public function initFrontend()
    {
        $this->manager->getExtension('fire_slider')->registerResources();
    }

    public function configureFrontend()
    {
        if (empty($this->settings['slider_id'])) {
            return;
        }

        $cache_key = 'fireslider_' . $this->settings['slider_id'] . '.' . (TB_RequestHelper::isRequestHTTPS() ? 'https.': '') . $this->getId();

        if ($this->themeData['system']['cache_content'] && ($slider = $this->manager->getCacheVar($cache_key))) {
            $this->slider = $slider;
        } else {
            $slider = $this->manager->getTbSettingsModelInstance('slider')->getScopeSettings('slider_' . $this->settings['slider_id'], false, 0);
            $this->slider = $this->manager->getExtension('fire_slider')->getModel()->generateSliderMarkup($slider, $this->getDomId());

            $this->manager->setCacheVar($cache_key, $this->slider);
        }
    }

    public function render(array $view_data = array())
    {
        $view_data['slider'] = $this->slider;

        return parent::render($view_data);
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {
        if (empty($this->settings['slider_id'])) {
            return;
        }

        $key = 'slider_' . $this->settings['slider_id'];
        $slider = $this->manager->getTbSettingsModelInstance('slider')->getScopeSettings($key, false, 0);

        $css = $this->manager->getExtension('fire_slider')->getModel()->generateSliderStyles($slider, $this->getDomId());

        $styleBuilder->addCss($css);

    }

    public function getFrontendClasses()
    {
        $classes  = parent::getFrontendClasses();
        $classes .= ' tb_nav_size_' . $this->settings['navigation_size'];

        return $classes;
    }

    protected function getDefaultFonts()
    {
        return array(
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
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 26,
                'line-height'       => 30,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => false,
                'has_line_height'   => false,
                'has_spacing'       => true,
                'has_effects'       => false,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            ),
            'h2' => array(
                'section_name'      => 'H2',
                'elements'          => '
                    h2,
                    .h2
                ',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 16,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => false,
                'has_line_height'   => false,
                'has_spacing'       => true,
                'has_effects'       => false,
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
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 15,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => false,
                'has_line_height'   => false,
                'has_spacing'       => true,
                'has_effects'       => false,
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
                'subsets'           => 'latin',
                'variant'           => 'regular',
                'size'              => 14,
                'line-height'       => 20,
                'letter-spacing'    => 0,
                'word-spacing'      => 0,
                'transform'         => 'none',
                'has_size'          => false,
                'has_line_height'   => false,
                'has_spacing'       => true,
                'has_effects'       => false,
                'show_built_styles' => true,
                'multiple_variants' => false,
                'built-in'          => true,
                'can_inherit'       => true,
                'css_weight'        => '',
                'css_style'         => ''
            )
        );
    }

    protected function getAdditionalColors()
    {
        return array(
            'slider' => array(
                '_label' => 'Slider',
                'button_text' => array(
                    'label'       => 'Prev/Next buttons',
                    'elements'    => '.mSButtons:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_bg' => array(
                    'label'       => 'Prev/Next buttons bg',
                    'elements'    => '.mSButtons:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_text_hover' => array(
                    'label'       => 'Prev/Next buttons (hover)',
                    'elements'    => '.mSButtons:hover:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'button_bg_hover' => array(
                    'label'       => 'Prev/Next buttons bg (hover)',
                    'elements'    => '.mSButtons:hover:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.mSPages li',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_hover' => array(
                    'label'       => 'Pagination (hover)',
                    'elements'    => '.mSPages li:hover',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_active' => array(
                    'label'       => 'Pagination (active)',
                    'elements'    => '.mSPages li.active, .mSPages li.active:hover',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            )
        );
    }
}