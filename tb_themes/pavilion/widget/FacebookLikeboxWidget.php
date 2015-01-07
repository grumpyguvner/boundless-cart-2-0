<?php

class Theme_FacebookLikeboxWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'      => 1,
            'title'          => 'Facebook Page',
            'title_align'    => 'left',
            'page_url'       => 'http://facebook.com/themeburn'
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'like_box_style'    => 'custom',
            'like_button_style' => 'button',
            // 'user_profile'      => 0,
            'profiles_num'      => 12,
            'profiles_rows'     => 2,
            'profile_name'      => 1,
            'profile_border'    => 1,
            'default_height'    => 200,
            'default_padding'   => 10
        ), $settings));
    }

    public function render(array $view_data = array())
    {   
        if ($this->settings['like_box_style'] == 'custom') {

            $cache_key = $this->getId() . '.' . $this->language_id . '.' . $this->themeData->facebook['locale'];
            $get_remote_content = true;

            if ($cached = $this->manager->getCacheVar($cache_key)) {
                $view_data['content'] = $cached['content'];
                $view_data['likes']   = $cached['likes'];

                $get_remote_content = false;
            }

            if ($get_remote_content) {
                $url = 'https://www.facebook.com/plugins/likebox.php?href=' . $this->settings['lang'][$this->language_id]['page_url'] . '&locale=' . $this->themeData->facebook['locale'] . '&width=' . ($this->settings['profiles_num'] * 50 +  200) . '&height=200&colorscheme=light&show_faces=true&header=false&stream=false';
                $agent= 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)';

                $ch = curl_init();
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_VERBOSE, true);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_USERAGENT, $agent);
                curl_setopt($ch, CURLOPT_URL, $url);

                $result = curl_exec($ch);
                $doc = phpQuery::newDocument($result);
                // $is_liked = $doc->find('#u_0_1')->hasClass('hidden_elem');
                $content = $doc
                    // ->find('head, meta, style, script, .pluginBoxDivider, .pvs.phm, ._8u._42ef > table > tbody > tr + tr')->remove()->end()
                    // ->find('.fsl > a')->addClass('tb_main_color')->end()
                    ->find('head, meta, style, script, .pluginBoxDivider, .pvs.phm, .clearfix.pam')->remove()->end()
                    ->find("body")->html();

                // $view_data['is_liked'] = $is_liked;
                $view_data['content']  = $content;

                $parsedUrl = parse_url($this->settings['lang'][$this->language_id]['page_url']);
                $host = explode('.', $parsedUrl['host']);
                if ($host[0] === 'www') {
                    array_shift($host);
                }
                $parsedUrl['host'] = 'graph.' . implode('.', $host);
                $url = TB_Utils::glueUrl($parsedUrl);

                curl_setopt($ch, CURLOPT_URL, $url . '?fields=likes');
                $result = curl_exec($ch);
                if (!empty($result)) {
                    $result = json_decode($result, true);
                    $view_data['likes'] = isset($result['likes']) ? $result['likes'] : 0;
                }

                $view_data['content'] = str_replace('<img', '<img width="50" height="50"', $view_data['content']);

                if ($this->themeData['system']['cache_enabled'] && isset($this->themeData['system']['cache_widgets']['Theme_FacebookLikeboxWidget']['ttl'])) {
                    $this->manager->setCacheVar($cache_key, array(
                        'content' => $view_data['content'],
                        'likes'   => $view_data['likes']
                    ), (int) $this->themeData['system']['cache_widgets']['Theme_FacebookLikeboxWidget']['ttl'] * 60);
                }
            }

        }

        $like_box_classes = '';
        $like_box_classes .= $this->settings['profile_name'] ? ' tb_show_title' : '';
        $like_box_classes .= $this->settings['profile_border'] ? ' tb_show_border' : '';

        $view_data['like_box_classes'] = $like_box_classes;

        return parent::render($view_data);
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {
        $font_title = $this->settings['common']['font'][$this->language_id]['title'];
        $font_base  = $this->themeData->fonts['body']['line-height'];
        
        if ($font_title['family'] != 'inherit') {
            $css = '
            #' . $this->getDomId() . ' .tb_social_box .tb_social_button {
              margin-top: ' . (($this->themeData->calculateLineHeight($font_title['size'], $font_base) - 20) * 0.5) . 'px;
            }
            ';
            $styleBuilder->addCss($css);
        }
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
            'title' => array(
                'section_name'      => 'Block Title',
                'elements'          => ' h2, .tb_social_button',
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
        return array(
            'facebook_body' => array(
                '_label' => 'Body',
                'title' => array(
                    'label'       => 'Block title',
                    'elements'    => 'h2',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.titles'
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
                'links' => array(
                    'label'       => 'Links',
                    'elements'    => 'a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                ),
                'links_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'a:hover',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent_hover'
                )
            ),
            'facebook_connections' => array(
                '_label' => 'Custom widget',
                'avatar_bg' => array(
                    'label'       => 'Profile image border',
                    'elements'    => '.uiList li img',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'avatar_title' => array(
                    'label'       => 'Profile title',
                    'elements'    => '.uiList li .link:after',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                ),
                'avatar_title_hover' => array(
                    'label'       => 'Profile title (hover)',
                    'elements'    => '.uiList li:hover a.link:after',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                )
            ),
            'facebook_default' => array(
                '_label' => 'Default Widget',
                'widget_bg' => array(
                    'label'       => 'Widget bg',
                    'elements'    => '.tb_fb_likebox.tb_default',
                    'property'    => 'background-color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'widget_border' => array(
                    'label'       => 'Widget border',
                    'elements'    => '.tb_fb_likebox.tb_default',
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
    }
}