<?php

class Theme_MenuWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'   => 1,
            'title'       => 'Menu',
            'title_align' => 'left',
            'menu'        => array(),
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'group_type' => 'tabs',
        ), $settings));
    }

    public function onTransformSettings(array &$settings)
    {
        foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
            if (isset($settings['lang'][$lid]['menu']) && !empty($settings['lang'][$lid]['menu'])) {
                $str = (string) html_entity_decode($settings['lang'][$lid]['menu'], ENT_COMPAT, 'UTF-8');
                $settings['lang'][$lid]['menu'] = json_decode($str, true);
            }
        }
    }

    public function onPersist(array &$settings)
    {
        foreach ($this->manager->getEnabledLanguages() as $lid => $language) {
            if (isset($settings['lang'][$lid]['menu']) && !empty($settings['lang'][$lid]['menu'])) {
                $page_ids = array();

                foreach ($settings['lang'][$lid]['menu'] as $item) {
                    if ($item['data']['type'] == 'page') {
                        $page_ids[] = $item['data']['id'];
                    }
                }

                if (!empty($page_ids)) {
                    $settings['lang'][$lid]['page_ids'] = $page_ids;
                }
            }
        }
    }

    public function render(array $view_data = array())
    {
        if (!empty($this->settings['lang'][$this->language_id]['menu'])) {
            foreach ($this->settings['lang'][$this->language_id]['menu'] as $key => &$item) {
                switch ($item['data']['type']) {
                    case 'page':
                        $page = $this->getThemeModel()->getInformationPages($item['data']['id']);
                        if (false !== $page) {
                            if (!empty($item['data']['settings']['label'])) {
                                $label = $item['data']['settings']['label'];
                            } else {
                                $label = $page['title'];
                            }

                            $item['label']      = $label;
                            $item['url']        = $this->manager->getOcUrl()->link('information/information', 'information_id=' . $item['data']['id']);
                            $item['url_target'] = '_self';
                            $item['url_title']  = $label;
                            $item['css_class']  = isset($item['data']['settings']['class']) && $item['data']['settings']['class'] ? $item['data']['settings']['class'] : '';

                            if ($this->themeData->information_id == $item['data']['id']) {
                                $item['css_class'] = trim($item['css_class'] . ' tb_selected');
                            }
                        } else {
                            unset($this->settings['lang'][$this->language_id]['menu'][$key]);
                        }

                        break;

                    case 'system':
                        $page = $this->getThemeModel()->getSystemMenuPagesLang($item['data']['id']);
                        if (false !== $page) {
                            if (empty($item['data']['settings']['label'])) {
                                $label = $page['title'];
                            } else {
                                $label = $item['data']['settings']['label'];
                            }

                            $ssl = isset($page['ssl']) && $page['ssl'] ? 'SSL' : '';

                            $item['label']      = $label;
                            $item['url']        = $this->manager->getOcUrl()->link($page['route'], '', $ssl);
                            $item['url_target'] = '_self';
                            $item['url_title']  = $label;
                            $item['css_class']  = isset($item['data']['settings']['class']) && $item['data']['settings']['class'] ? $item['data']['settings']['class'] : '';

                            if ($this->themeData->route == $page['route']) {
                                $item['css_class'] = trim($item['css_class'] . ' tb_selected');
                            }
                        } else {
                            unset($this->settings['lang'][$this->language_id]['menu'][$key]);
                        }

                        break;

                    case 'url':
                        if (!empty($item['data']['settings']['url'])) {
                            $item_url = $item['data']['settings']['url'];
                            if (false === strpos($item_url, '://')) {
                                //$item_url = 'http://' . $item_url;
                            }

                            $item['label'] = $item['data']['settings']['label'];
                            $item['url'] = $item_url;
                            $item['url_target'] = !empty($item['data']['settings']['target']) ? $item['data']['settings']['target'] : '_self';
                            $item['url_title'] = !empty($item['data']['settings']['url_title']) ? $item['data']['settings']['url_title'] : $item['data']['settings']['label'];
                            $item['css_class'] = isset($item['data']['settings']['class']) && $item['data']['settings']['class'] ? $item['data']['settings']['class'] : '';
                        } else {
                            unset($this->settings['lang'][$this->language_id]['menu'][$key]);
                        }
                }
            }
        }

        return parent::render($view_data);
    }

    public function getDefaultColors()
    {
        $default_colors = array(
            'body' => array(
                '_label' => '',
                'title' => array(
                    'label'       => 'Block Title',
                    'elements'    => '.tb_title',
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
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links_hover'
                ),
                'links_selected' => array(
                    'label'       => 'Links (selected)',
                    'elements'    => '.tb_selected > a, .tb_selected > a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'body.links_hover'
                ),
                'bullets' => array(
                    'label'       => 'Bullets',
                    'elements'    => '.tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                ),
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