<?php

class Theme_GroupWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    /**
     * @var TB_Widget[]
     */
    protected $widgets = array();

    public function getName()
    {
        return 'Tabs/Accordion';
    }

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'   => 1,
            'title'       => '',
            'title_align' => 'left',
            'tabs'        => array()
        ), $settings));

        foreach ($this->manager->getEnabledLanguages() as $lang) {
            $tabs = array();
            foreach ($settings['lang'][$lang['id']]['tabs'] as $tab) {
                $tabs[] = $tab;
            }
            $settings['lang'][$lang['id']]['tabs'] = $tabs;
        }

        $settings = array_replace($settings, $this->initFlatVars(array(
            'group_type'      => 'tabs',
            'tabs_direction'  => 'horizontal',
            'tabs_position'   => 'left',
            'tabs_width'      => 140,
            'tabs_style'      => 2,
            'tabs_transition' => 'none',
            'accordion_style' => 1,
            'inner_padding'   => 20,
            'auto_height'     => 0,
            'subwidgets'      => array()
        ), $settings));
    }

    public function render(array $view_data = array())
    {
        $subwidgets_content = array();
        foreach ($this->getSubWidgets() as $widget) {
            $widget_content = $widget->render();
            if ($widget->hasContent()) {
                if ($widget->getAttribute('renderPlaceHolder')) {
                    $subwidgets_content[$widget->getId()] = '{{' . $widget->getId() . '}}';
                } else
                    $subwidgets_content[$widget->getId()] = $widget_content;
            }
        }

        if (empty($subwidgets_content)) {
            return parent::renderContent('');
        }

        $view_data['subwidgets_content'] = $subwidgets_content;

        $group_classes  = 'tb_' . $this->settings['group_type'];
        $group_classes .= ' tb_ip_' . $this->settings['inner_padding'];

        if ($this->settings['group_type'] == 'tabs') {
            if ($this->settings['tabs_direction'] == 'horizontal') {
                $group_classes .= ' tb_htabs';
            }
            if ($this->settings['tabs_direction'] == 'vertical') {
                $group_classes .= ' tb_vtabs';
                $group_classes .= ' tb_tabs_' . $this->settings['tabs_position'];
            }
            $group_classes .= ' tb_style_' . $this->settings['tabs_style'];
            $group_classes .= ' tbWidgetTabs';
        }

        if ($this->settings['group_type'] == 'accordion') {
            $group_classes .= ' tb_style_' . $this->settings['accordion_style'];
            $group_classes .= ' tbWidgetAccordion';
        }

        $tabs_nav_style = '';

        if ($this->settings['tabs_direction'] == 'vertical') {
            $tabs_nav_style .= 'width: ' . ($this->settings['tabs_width'] - 1) . 'px;';
            $tabs_nav_style .= ' min-width: ' . ($this->settings['tabs_width'] - 1) . 'px;';
        }

        $tabs_transition  = '';
        if ($this->settings['tabs_transition'] == 'fade') {
            $tabs_transition  = ', show: { effect: \'fade\', duration: 200 }, hide: { effect: \'fade\', duration: 200 }';
        }

        $view_data['group_classes']   = $group_classes;
        $view_data['tabs_nav_style']  = $tabs_nav_style;
        $view_data['tabs_transition'] = $tabs_transition;

        return parent::render($view_data);
    }

    public function getFrontendClasses()
    {
        $classes = parent::getFrontendClasses();
        $settings = $this->settings;

        if ($this->settings['group_type'] == 'tabs') {
            $classes .= ' tb_tabs_'       . $settings['tabs_direction'];
            $classes .= ' tb_tabs_style_' . $settings['tabs_style'];
            $classes .= $settings['tabs_direction'] == 'vertical' ? ' tb_tabs_' . $settings['tabs_position'] : '';
            $classes = rtrim($classes);
        }

        return $classes;
    }

    public function setSubWidgets(array $widgets)
    {
        foreach ($widgets as $widget) {
            $this->addSubWidget($widget);
        }
    }

    public function addSubWidget(TB_Widget $widget)
    {
        $this->widgets[$widget->getId()] = $widget;
    }

    public function getSubWidgets()
    {
        return $this->widgets;
    }

    public function __sleep()
    {
        return array_merge(parent::__sleep(), array('widgets'));
    }

    protected function getAdditionalFonts()
    {
        return array(
            'tabs_navigation' => array(
                'section_name'      => 'Tabs / Accordion Navigation',
                'elements'          => '
                    .tb_tabs_nav > ul,
                    .ui-tabs-nav,
                    .tb_accordion .tb_title,
                    .ui-accordion-header,
                    .tb_slider_controls .tb_prev,
                    .tb_slider_controls .tb_next
                ',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 18,
                'line-height'       => 20,
                'letter-spacing'    => 0.5,
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
            'toolbar' => array(
                '_label' => 'Tabs / Accordion',
                'header_bg' => array(
                    'label'       => 'Header/toolbar bg',
                    'elements'    => '.ui-widget-header, .tb_tabs.tb_style_1 .tb_tabs_nav',
                    'property'    => 'background-color',
                    'color'       => '#e3e3e3',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.header_bg'
                ),
                'header_border' => array(
                    'label'       => 'Header/toolbar border',
                    'elements'    => '.ui-widget-header, .tb_vtabs .tb_tabs_nav',
                    'property'    => 'border-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.header_border'
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
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.content_border'
                ),
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
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_text'
                ),
                'clickable_bg' => array(
                    'label'       => 'Clickable bg',
                    'elements'    => '
                            .ui-state-default,
                            .ui-widget-content .ui-state-default,
                            .ui-widget-header .ui-state-default
                        ',
                    'property'    => 'background-color',
                    'color'       => '#e3e3e3',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_bg'
                ),
                'clickable_border' => array(
                    'label'       => 'Clickable border',
                    'elements'    => '
                            .ui-state-default,
                            .ui-widget-content .ui-state-default,
                            .ui-widget-header .ui-state-default
                        ',
                    'property'    => 'border-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_border'
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
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_icon'
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
                    'inherit_key' => 'theme:ui.clickable_text_hover'
                ),
                'clickable_bg_hover' => array(
                    'label'       => 'Clickable bg (hover)',
                    'elements'    => '
                            .ui-state-hover,
                            .ui-widget-content .ui-state-hover,
                            .ui-widget-header .ui-state-hover,
                            .ui-state-focus,
                            .ui-widget-content .ui-state-focus,
                            .ui-widget-header .ui-state-focus
                        ',
                    'property'    => 'background-color',
                    'color'       => '#d3d3d3',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_bg_hover'
                ),
                'clickable_border_hover' => array(
                    'label'       => 'Clickable border (hover)',
                    'elements'    => '
                            .ui-state-hover,
                            .ui-widget-content .ui-state-hover,
                            .ui-widget-header .ui-state-hover,
                            .ui-state-focus,
                            .ui-widget-content .ui-state-focus,
                            .ui-widget-header .ui-state-focus
                        ',
                    'property'    => 'border-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_border_hover'
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
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_icon_hover'
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
                    'inherit_key' => 'theme:ui.clickable_text_active'
                ),
                'clickable_bg_active' => array(
                    'label'       => 'Clickable bg (active)',
                    'elements'    => '
                            .ui-state-active,
                            .ui-widget-content .ui-state-active,
                            .ui-widget-header .ui-state-active
                        ',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_bg_active'
                ),
                'clickable_border_active' => array(
                    'label'       => 'Clickable border (active)',
                    'elements'    => '
                            .ui-state-active,
                            .ui-widget-content .ui-state-active,
                            .ui-widget-header .ui-state-active
                        ',
                    'property'    => 'border-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_border_active'
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
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:ui.clickable_icon_active'
                )
            )
        );

        return $default_colors;
    }
}