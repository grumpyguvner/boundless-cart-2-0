<?php

require_once DIR_SYSTEM . 'vendor/stories/model.php';

class ModelStoriesSystem extends ModelStoriesModel
{
    public function install()
    {
        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "story` (
              `story_id` int(11) NOT NULL AUTO_INCREMENT,
              `image` varchar(255) NOT NULL,
              `status` tinyint(1) NOT NULL,
              `sticky` tinyint(1) NOT NULL,
              `views` int(11) NOT NULL,
              `date_added` datetime NOT NULL,
              `date_updated` datetime NOT NULL,
              PRIMARY KEY (`story_id`)
		    ) ENGINE=MyISAM COLLATE=utf8_general_ci;
		");

        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "story_description` (
              `story_id` int(11) NOT NULL,
              `language_id` int(11) NOT NULL,
              `title` varchar(255) NOT NULL,
              `teaser` text NOT NULL,
              `description` text NOT NULL,
              `meta_title` text NOT NULL,
              `meta_description` text NOT NULL,
              PRIMARY KEY (`story_id`, `language_id`)
            ) ENGINE=MyISAM COLLATE=utf8_general_ci;
		");

        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "story_to_store` (
              `story_id` int(11) NOT NULL,
              `store_id` int(11) NOT NULL,
              PRIMARY KEY (`story_id`, `store_id`)
            )
		");

        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "story_to_layout` (
              `story_id` int(11) NOT NULL,
              `store_id` int(11) NOT NULL,
              `layout_id` int(11) NOT NULL,
              PRIMARY KEY (`story_id`, `store_id`)
            )
		");

        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "story_tag` (
              `tag_id` int(11) NOT NULL AUTO_INCREMENT,
              `language_id` int(11) NOT NULL,
              `name` varchar(255) NOT NULL,
              `description` text NOT NULL,
              `meta_title` text NOT NULL,
              `meta_description` text NOT NULL,
              `status` tinyint(1) NOT NULL,
              `date_added` datetime NOT NULL,
              `date_updated` datetime NOT NULL,
              PRIMARY KEY (`tag_id`)
            )
		");

        $this->db->query("
            CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "story_to_tag` (
              `story_id` int(11) NOT NULL,
              `tag_id` int(11) NOT NULL,
              PRIMARY KEY (`story_id`, `tag_id`)
            )
		");

        foreach ($this->getModel()->getAllStores() as $store) {
            $default_settings = $this->getDefaultSettings();
            $default_settings['lang'] = array();
            foreach ($this->getModel('localisation/language')->getLanguages() as $language) {
                $default_settings['lang'][$language['language_id']] = array(
                    'page_title'       => '',
                    'meta_title'       => '',
                    'meta_description' => ''
                );
            }

            $this->getModel()->editSetting('stories_settings', $default_settings, $store['store_id']);
        }

        $this->getModel('user/user_group')->addPermission($this->user->getId(), 'access', 'stories/index');
        $this->getModel('user/user_group')->addPermission($this->user->getId(), 'access', 'stories/tag');
        $this->getModel('user/user_group')->addPermission($this->user->getId(), 'access', 'stories/module');

        $this->getModel('user/user_group')->addPermission($this->user->getId(), 'modify', 'stories/index');
        $this->getModel('user/user_group')->addPermission($this->user->getId(), 'modify', 'stories/tag');
        $this->getModel('user/user_group')->addPermission($this->user->getId(), 'modify', 'stories/module');
    }

    public function getDefaultSettings()
    {
        return array(
            'keyword'                  => 'articles',
            'stories_per_page'         => 10,
            'auto_seo_url'             => 1,
            'thumbnail_position'       => 'top',
            'text_limit'               => 400,
            'image_list_width'         => 800,
            'image_list_height'        => 320,
            'image_description_width'  => 800,
            'image_description_height' => 480,
            'comments'                 => 'disabled',
            'disqus_shortname'         => '',
            'social_share'             => ''
        );
    }

    public function uninstall()
    {
        $this->dbHelper->dropTable(array('story', 'story_description', 'story_to_store', 'story_to_layout', 'story_tag', 'story_to_tag'));
        $this->dbHelper->delete('setting', array('group' => 'stories'));

        $this->getModel('user/user_group')->removePermission($this->user->getId(), 'access', 'stories/index');
        $this->getModel('user/user_group')->removePermission($this->user->getId(), 'access', 'stories/tag');
        $this->getModel('user/user_group')->removePermission($this->user->getId(), 'access', 'stories/module');

        $this->getModel('user/user_group')->removePermission($this->user->getId(), 'modify', 'stories/index');
        $this->getModel('user/user_group')->removePermission($this->user->getId(), 'modify', 'stories/tag');
        $this->getModel('user/user_group')->removePermission($this->user->getId(), 'modify', 'stories/module');
    }
}