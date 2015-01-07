<?php

class Theme_TwitterBoxWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'          => 1,
            'title'              => 'Twitter Followers',
            'title_align'        => 'left',
            'follow_button_lang' => 'en',
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'profiles_type'     => 'followers',
            'user_profile'      => 0,
            'profiles_num'      => 12,
            'profiles_rows'     => 2,
            'profile_name'      => 1,
            'profile_border'    => 1,
        ), $settings));
    }

    public function render(array $view_data = array())
    {
        $cache_key = $this->getId() . '.' . $this->language_id;
        $get_remote_content = true;

        if ($twitter_data = $this->manager->getCacheVar($cache_key)) {
            $view_data['twitter_data'] = $twitter_data;
            $get_remote_content = false;
        }

        if (isset($this->themeData['twitter'][$this->language_id])) {
            $twitter_settings = $this->themeData['twitter'][$this->language_id];
        } else {
            $first_element = array_slice($this->themeData['twitter'], 0, 1);
            $twitter_settings = reset($first_element);
        }

        if ($get_remote_content) {
            $view_data['twitter_data'] = $this->getTwitterData($twitter_settings);
            if ($this->themeData['system']['cache_enabled'] && isset($this->themeData['system']['cache_widgets']['Theme_TwitterBoxWidget']['ttl'])) {
                $this->manager->setCacheVar($cache_key, $view_data['twitter_data'], (int) $this->themeData['system']['cache_widgets']['Theme_TwitterBoxWidget']['ttl'] * 60);
            }
        }

        $like_box_classes     = '';
        $like_box_classes    .= $this->settings['profile_name'] ? ' tb_show_title' : '';
        $like_box_classes    .= $this->settings['profile_border'] ? ' tb_show_border' : '';

        $view_data['like_box_classes'] = $like_box_classes;
        $view_data['twitter_username'] = $twitter_settings['username'];

        return parent::render($view_data);
    }

    protected function getTwitterData($twitter)
    {
        $url = "https://api.twitter.com/1.1/users/lookup.json";
        $json = $this->doRequest($url, array('screen_name' => $twitter['username']), $twitter);
        $errors = $this->checkErrors($json);
        if (false !== $errors) {
            return $errors;
        }


        $data = array(
            'name'              => $json[0]->name,
            'screen_name'       => $json[0]->screen_name,
            'followers_count'   => $json[0]->followers_count,
            'profile_image_url' => str_replace('_normal.', '_bigger.', $json[0]->profile_image_url),
            'friends_count'     => $json[0]->friends_count
        );
        
        if ($this->settings['profiles_type'] == 'followers') {
            $url = "https://api.twitter.com/1.1/followers/ids.json";
            $json = $this->doRequest($url, array('screen_name' => $twitter['username']), $twitter);
        } else {
            $url = "https://api.twitter.com/1.1/friends/ids.json";
            $json = $this->doRequest($url, array('screen_name' => $twitter['username']), $twitter);
        }

        $errors = $this->checkErrors($json);
        if (false !== $errors) {
            return $errors;
        }

        $profiles_num = abs((int) $this->settings['profiles_num']);
        if (!$profiles_num) {
            $profiles_num = 1;
        }
        if (!$profiles_num > 100) {
            $profiles_num = 100;
        }

        $ids = array_slice($json->ids, 0, $profiles_num);

        $url = "https://api.twitter.com/1.1/users/lookup.json";
        $json = $this->doRequest($url, array('user_id' => implode(',', $ids), 'include_entities' => 0), $twitter);

        $errors = $this->checkErrors($json);
        if (false !== $errors) {
            return $errors;
        }

        $data['users'] = array();
        foreach ($json as $user) {
            $data['users'][] = array(
                'name'              => $user->name,
                'screen_name'       => $user->screen_name,
                'profile_image_url' => str_replace('_normal.', '_bigger.', $user->profile_image_url)
            );
        }

        return $data;
    }

    protected function doRequest($url, array $url_param, $twitter)
    {
        $default_timezone = date_default_timezone_get();
        date_default_timezone_set('Pacific/Easter');
        $utc_time = strtotime(gmdate("M d Y H:i:s", time()));
        date_default_timezone_set($default_timezone);

        $oauth = array(
            'oauth_consumer_key'     => $twitter['consumer_key'],
            'oauth_nonce'            => $utc_time,
            'oauth_signature_method' => 'HMAC-SHA1',
            'oauth_token'            => $twitter['access_token'],
            'oauth_timestamp'        => $utc_time,
            'oauth_version'          => '1.0'
        ) + $url_param;

        $composite_key = rawurlencode($twitter['consumer_secret']) . '&' . rawurlencode($twitter['access_secret']);
        $oauth_signature = base64_encode(hash_hmac('sha1', $this->buildBaseString($url, 'GET', $oauth), $composite_key, true));
        $oauth['oauth_signature'] = $oauth_signature;

        $options = array(
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => false,
            CURLOPT_HTTPHEADER     => array($this->buildAuthorizationHeader($oauth), 'Content-Type: application/json', 'Expect:'),
            CURLOPT_HEADER         => false,
            CURLOPT_URL            => $url . '?' . http_build_query($url_param),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_SSL_VERIFYPEER => false
        );
        $feed = curl_init();
        curl_setopt_array($feed, $options);
        $json = curl_exec($feed);
        curl_close($feed);

        return json_decode($json);
    }

    protected function checkErrors($json)
    {
        if (isset($json->errors)) {
            $errors = array();
            foreach ($json->errors as $error) {
                $errors[] = $error->message;
            }

            return array ('errors' => $errors);
        } else {
            return false;
        }
    }


    protected function buildBaseString($baseURI, $method, $params) {
        $r = array();
        ksort($params);

        foreach($params as $key => $value){
            $r[] = "$key=" . rawurlencode($value);
        }

        return $method."&" . rawurlencode($baseURI) . '&' . rawurlencode(implode('&', $r));
    }

    protected function buildAuthorizationHeader($oauth) {
        $r = 'Authorization: OAuth ';
        $values = array();

        foreach($oauth as $key => $value)
            $values[] = "$key=\"" . rawurlencode($value) . "\"";
        $r .= implode(', ', $values);

        return $r;
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
            )
        );
    }
}