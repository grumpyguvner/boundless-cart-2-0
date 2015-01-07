<?php

require_once TB_THEME_ROOT . '/library/WidgetBase.php';

abstract class TB_Widget extends TB_WidgetBase
{
    /**
     * @var TB_Widget
     */
    protected $parent;

    public function setParent(TB_Widget $parent)
    {
        $this->parent = $parent;
    }

    public function onFilterSystem(array &$settings)
    {
        if (!isset($settings['widget_name'])) {
            $settings['widget_name'] = $this->getName();
        }

        if ($this->hasCommonOptions()) {
            $settings = array_replace($settings, $this->filterCommonSettingsData($settings));
        }

        if ($this->manager->getContext()->getArea() == 'catalog' && $this->manager->getThemeConfig('widgets_fallback_first_language') && isset($settings['lang']) && !isset($settings['lang'][$this->language_id])) {
            $settings['lang'][$this->language_id] = reset($settings['lang']);
        }
    }

    public function onEditSystem(array &$settings)
    {
        if (isset($settings['common']['colors'])) {
            TB_ColorSchemer::getInstance()->filterWidgetColors($settings['common']['colors'], $this->getDefaultColors());
        }

        if (isset($settings['common']['background']['rows']) && !empty($settings['common']['background']['rows'])) {
            foreach ($settings['common']['background']['rows'] as &$bg_row) {
                if ($bg_row['background_type'] == 'image') {
                    if (!empty($bg_row['image'])  && file_exists(DIR_IMAGE . $bg_row['image'])) {
                        $bg_row['preview'] = $this->getOcModel('tool/image')->resize($bg_row['image'], 100, 100);
                    } else {
                        $bg_row['image'] = '';
                        $bg_row['preview'] = $this->getThemeModel()->getNoImage();
                    }
                }
            }
        }

        $settings['widget_admin_title'] = $this->getName();
        $settings['widget_admin_prefix'] = TB_Utils::underscore($this->getName());
    }

    public function onPersistSystem(array &$settings)
    {
        $this->getThemeModel('layoutBuilder')->cleanSettingsDataBeforePersist($settings['common']);
    }

    public function allowAddToAreaContentCache()
    {
        return true;
    }

    protected function filterCommonSettingsData($data = array())
    {
        $default_vars = array(
            'layout' => array(
                'extra_class'     => '',
                'margin_top'      => 0,
                'margin_bottom'   => 30,
                'margin_right'    => 0,
                'padding_top'     => 0,
                'padding_right'   => 0,
                'padding_bottom'  => 0
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
            'font' => $this->getDefaultFonts()
        );

        if (method_exists($this, 'modifyDefaultCommonVars')) {
            $this->modifyDefaultCommonVars($default_vars);
        }

        if (method_exists($this, 'getAdditionalFonts')) {
            $default_vars['font'] = array_merge($default_vars['font'], $this->getAdditionalFonts());
        }

        if (!isset($data['common'])) {
            $data['common'] = $default_vars;
        }

        $result = TB_FormHelper::initFlatVarsSimple($default_vars, $data['common']);

        // Layout
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
            'position'            => 'center',
            'position_x_metric'   => 'px',
            'position_y_metric'   => 'px',
            'position_x'          => 0,
            'position_y'          => 0,
            'repeat'              => 'no-repeat',
            'size'                => 'auto',
            'size_x_metric'       => 'px',
            'size_y_metric'       => 'px',
            'size_x'              => 1,
            'size_y'              => 1,
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
            'position'            => 'center',
            'position_x_metric'   => 'px',
            'position_y_metric'   => 'px',
            'position_x'          => 0,
            'position_y'          => 0,
            'repeat'              => 'no-repeat',
            'size'                => 'auto',
            'size_x_metric'       => 'px',
            'size_y_metric'       => 'px',
            'size_x'              => 1,
            'size_y'              => 1,
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

        // Colors
        $default_colors = $this->getDefaultColors();
        if (!empty($result['colors'])) {
            foreach ($result['colors'] as $group_key => &$sections) {
                foreach ($sections as $section_key => &$section_values) {
                    if (0 === strpos($section_key, '_')) {
                        continue;
                    }
                    if (isset($default_colors[$group_key][$section_key])) {
                        unset($section_values['elements']);
                        unset($section_values['important']);
                        unset($section_values['property']);
                        unset($section_values['inherit_key']);
                        $section_values = TB_FormHelper::initFlatVarsSimple($default_colors[$group_key][$section_key], $section_values);
                    } else {
                        unset($result['colors'][$group_key]);
                    }
                }
            }
        } else {
            $result['colors'] = $default_colors;
        }

        // Font
        $result['font'] = TB_FormHelper::initLangVarsSimple($default_vars['font'], $result['font'], $this->manager->getEnabledLanguages());
        foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
            foreach ($result['font'][$lid] as $name => &$section) {
                unset($section['section_name']);
                unset($section['elements']);
                unset($section['show_built_styles']);
                unset($section['multiple_variants']);
                $section = TB_FormHelper::initFlatVarsSimple($default_vars['font'][$name], $section);
            }
        }

        return array('common' => $result);
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
                'can_inherit'       => true
            ),
            'title' => array(
                'section_name'      => 'Block Title',
                'elements'          => ' h2, .tb_slider_controls .tb_prev, .tb_slider_controls .tb_next, .tb_widget_text blockquote:before',
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
                'can_inherit'       => true
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
                    'elements'    => '.tb_main_color, .tb_main_color_hover:hover, .colorbox, .tb_list_1 > li:before',
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
                    'elements'    => 'a.tb_main_color:hover, a.colorbox:hover',
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
                'system_links' => array(
                    'label'       => 'System links',
                    'elements'    => '.tb_widget_system .tb_text_wrap a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.accent'
                ),
                'system_links_hover' => array(
                    'label'       => 'System links (hover)',
                    'elements'    => '.tb_widget_system .tb_text_wrap a:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
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
                    'label'       => 'Titles',
                    'elements'    => 'h1, h2',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.titles'
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
                    'inherit_key' => 'row:body.links'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links_hover'
                )
            )
        );

        if (method_exists($this, 'getAdditionalColors')) {
            $default_colors = array_merge($default_colors, $this->getAdditionalColors());
        }

        return $default_colors;
    }

    public function getFrontendClasses()
    {
        $common = $this->getSettings('common');

        $classes  = 'tb_widget_' . $this->getTemplateName();

        if (isset($common['layout'])) {
            $classes .= ' '       . $common['layout']['extra_class'];
            $classes .= ' tb_mt_' . $common['layout']['margin_top'];
            $classes .= ' tb_mb_' . $common['layout']['margin_bottom'];
            $classes .= ' tb_ml_' . $common['layout']['margin_right'];
            $classes .= ' tb_mr_' . $common['layout']['margin_right'];
            $classes .= ' tb_pt_' . $common['layout']['padding_top'];
            $classes .= ' tb_pr_' . $common['layout']['padding_right'];
            $classes .= ' tb_pb_' . $common['layout']['padding_bottom'];
            $classes .= ' tb_pl_' . $common['layout']['padding_right'];
        }

        if (isset($common['layout']['display'])) {
            $classes .= ' tb_display_' . $common['layout']['display'];
        }

        return $classes;
    }

    public function getLangSettings($key = null)
    {
        if (!isset($this->settings['lang'])) {
            return array();
        }

        if (isset($this->settings['lang'][$this->language_id])) {
            $lang_data = $this->settings['lang'][$this->language_id];
        } else {
            $lang_data = reset($this->settings['lang']);
        }

        if (null !== $key) {
            return isset($lang_data[$key]) ? $lang_data[$key] : false;
        }

        return $lang_data;
    }

    public function getLangTitle()
    {
        $lang_settings = $this->getLangSettings();

        if (isset($lang_settings['title']) && !empty($lang_settings['title'])) {
            return $lang_settings['title'];
        }

        return '';
    }

    public function getPresentationTitle()
    {
        return $this->getName();
    }

    public function isActive()
    {
        if (isset($this->settings['lang'][$this->language_id])) {
            $result = $this->settings['lang'][$this->language_id]['is_active'];
        } else
        if (isset($this->settings['is_active'])) {
            $result = $this->settings['is_active'];
        } else {
            $result = true;
        }

        return (bool) $result;
    }

    public function render(array $view_data = array())
    {
        $view_data = array_merge($this->getSettings(), $this->getLangSettings(), $view_data);
        $view_data['within_group'] = $this->parent !== null;

        return $this->renderContent(parent::render($view_data));
    }

    protected function renderContent($content)
    {
        $this->has_content = !empty($content);

        $this->addAttribute('js', $this->has_content ? $this->extractJs($content) : '');
        $this->is_rendered = true;

        if (!$this->has_content) {
            return '';
        }

        $content = '<div id="' . $this->getDomId() . '" class="' . $this->getFrontendClasses() . '">' . $content . '</div>';
        $this->addAttribute('content', $content);

        return $content;
    }

    protected function extractJs(&$content)
    {
        $js = '';

        if (!empty($content) && false !== preg_match_all('/(<script type="text\/javascript".*?>.*?<\/script>)/s', $content, $matches)) {
            foreach ($matches[1] as $match) {
                $js .= $match;
            }
            if (!empty($js)) {
                $content = preg_replace('/(<script type="text\/javascript".*?>.*?<\/script>)/s', '', $content);
            }
        }

        return $js;
    }
}