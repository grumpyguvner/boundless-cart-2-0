<?php

class Theme_Catalog_StylePlugin extends TB_ExtensionPlugin
{
    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        $this->bootstrap('common');

        $themeData->style  = $this->getSetting('style');
        $themeData->colors = $this->getSetting('colors');

        $this->buildLayoutClass($themeData);
        $this->buildBodyClass($themeData);
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {
        $style = $this->getThemeData()->style;

        $sections = array(
            'header'  => '#header',
            'menu'    => '#main_navigation_row',
            'wrapper' => '#wrapper',
            'bottom'  => '#bottom'
        );

        foreach ($sections as $item => $selector) {
            if (isset($style[$item])) {
                $styleBuilder->buildEffectsCss($style[$item], $selector);
            }
        }

        foreach ($this->extension->getSetting('colors') as $group) {
            foreach ($group as $color_rule) {
                $styleBuilder->addGlobalColorRule($color_rule);
            }
        }

        $css_images_url = $this->context->getThemeConfig('css_images_url');
        if (empty($css_images_url) || $css_images_url == 'auto_relative') {
            $css_replace = array('../font/' => '../../../catalog/view/theme/' . $this->context->getBasename() . '/font/');
        } else
        if ($css_images_url == 'auto_full') {
            $css_replace = array('../font/' => '{path}font/');
        } else {
            $css_replace = array('../font/' => str_replace('{{basename}}', $this->context->getBasename(), $css_images_url));
        }

        $this->getThemeData()->registerStylesheetResource('font-awesome.css', null, $css_replace);
        $this->getThemeData()->registerStylesheetResource('entypo.css', null, $css_replace);
        $this->getThemeData()->registerStylesheetResource('jquery_ui/jquery-ui.custom.css');

        $css = '';
        foreach($this->getThemeData()->getStylesheetResources('merged') as $resource) {
            if (!is_file($resource['dir'])) {
                continue;
            }

            $contents = file_get_contents($resource['dir']);

            if (isset($resource['path_replace'])) {
                foreach ($resource['path_replace'] as $search => $replace) {
                    $contents = str_replace($search, $replace, $contents);
                }
            }

            $css .= $contents;
        }

        $styleBuilder->prependExternalCss($css);

        $this->setSiteBackground($this->getThemeData());
    }

    protected function setSiteBackground(TB_ViewDataBag $themeData)
    {
        $settings  = $this->getSetting('background');
        $background = null;

        if ($themeData->category_id) {
            if (isset($settings['category'][$themeData->category_id])) {
                $background = $settings['category'][$themeData->category_id];
            } else
            if ($settings['options']['category_inherit'] == 'parent' && isset($settings['category'][$themeData->category_parent_id])) {
                $background = $settings['category'][$themeData->category_parent_id];
            } else
            if (isset($settings['category'][0])) {
                $background = $settings['category'][0];
            } else
            if ($settings['options']['category_inherit'] == 'none') {
                $background = false;
            }
        } else
        if ($themeData->information_id) {
            if (isset($settings['page'][$themeData->information_id])) {
                $background = $settings['page'][$themeData->information_id];
            } else
            if ($settings['options']['page_inherit'] == 'none') {
                $background = false;
            }
        }

        if (null === $background && isset($settings['global']) && $settings['global']['type'] != 'none') {
            $background = $settings['global'];
        }

        if (null !== $background) {
            $themeData->body_background = $background;
        }
    }

    protected function buildLayoutClass(TB_ViewDataBag $themeData)
    {
        $style = $themeData->style;

        foreach (array('header', 'menu', 'wrapper', 'bottom') as $item) {
            if (isset($style[$item])) {
                $el_class  = '';
                $el_class .= ' tb_row_' . $style[$item]['layout']['type'];
                $el_class .= ' tb_mt_'  . $style[$item]['layout']['margin_top'];
                $el_class .= ' tb_mb_'  . $style[$item]['layout']['margin_bottom'];
                $el_class .= ' tb_ml_'  . $style[$item]['layout']['margin_right'];
                $el_class .= ' tb_mr_'  . $style[$item]['layout']['margin_right'];
                $el_class .= ' tb_pt_'  . $style[$item]['layout']['padding_top'];
                $el_class .= ' tb_pb_'  . $style[$item]['layout']['padding_bottom'];
                $el_class .= ' tb_pr_'  . $style[$item]['layout']['padding_right'];
                $el_class .= ' tb_pl_'  . $style[$item]['layout']['padding_right'];

                $themeData[$item . '_class']  = $el_class;
            }
        }
    }

    protected function buildBodyClass(TB_ViewDataBag $themeData)
    {
        $body_class = 'tb_width_' . $themeData->style['maximum_width'];
        $body_class .= ' tb_lang_' . $themeData->language_direction;
        $body_class .= ' tb_page_' . str_replace('/', '_', $themeData->route);

        if ($themeData->layout_id != $themeData->route_layout_id) {
            $layout_name = TB_Utils::slugify($this->getModel()->getLayoutNameById($themeData->layout_id));
            $body_class .= ' tb_layout_' . str_replace('-', '_', $layout_name);
        }

        $themeData->body_class = $body_class . ' ' . str_replace('.', '_', $this->extension->getStylesFileHash() . ' ' . $this->manager->getThemeMachineName() . '_v' . $this->manager->getThemeVersion());
    }
}