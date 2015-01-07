<?php

require_once dirname(__FILE__) . '/lib/controller.php';

class ControllerStoriesIndex extends ControllerStoriesAdmin
{
    public function index()
    {
        $this->mergeLanguage('stories/index');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->setBreadcrumbs();

        $this->data['success'] = '';
        if (isset($this->session->data['success'])) {
          $this->data['success'] = $this->session->data['success'];
          unset($this->session->data['success']);
        }

        $options = array();
        $options['limit'] = (int) $this->getArrayKey('limit', $this->request->get, $this->config->get('config_admin_limit'));
        $options['page']  = (int) $this->getArrayKey('page', $this->request->get, 1);
        $options['sort']  = $this->getArrayKey('sort', $this->request->get, 's.date_added');
        $options['order'] = $this->getArrayKey('order', $this->request->get, 'ASC');
        $options['start'] = ($options['page'] - 1) * $options['limit'];

        $filter_data = $this->initFlatVarsSimple(array(
            'filter_tags'      => null,
            'filter_text'      => null,
            'filter_status'    => '',
            'filter_sticky'    => null,
            'filter_date_to'   => null,
            'filter_date_from' => null,
        ), $this->request->get);
        $this->data = array_merge($this->data, $filter_data);

        $stories = $this->getModel()->getStories(array_merge($options, $filter_data));

        foreach ($stories as &$story) {
            $story['date_added'] = date($this->language->get('date_format_short'), strtotime($story['date_added']));
            $story['edit_link'] = $this->link('stories/index/edit', 'story_id=' . $story['story_id']);
        }

        $this->data['stories'] = $stories;
        $this->data['stories_total'] = $this->getModel()->getFoundRows();

        $filter_url = $this->buildUrl($filter_data, array_keys($filter_data));
        $current_url = $this->link('stories/index') . (!empty($filter_url) ? '&' . $filter_url : '');
        $sorts_url = $current_url . '&page=' . $options['page'] . '&order=' . ($options['order'] == 'ASC' ? 'DESC' : 'ASC') . '&sort=';

        $this->data['url_sort_title']      = $sorts_url . 'sd.title';
        $this->data['url_sort_status']     = $sorts_url . 's.status';
        $this->data['url_sort_language']   = $sorts_url . 's.language_id';
        $this->data['url_sort_date_added'] = $sorts_url . 's.date_added';

        $pagination = new Pagination();
        $pagination->total = $this->data['stories_total'];
        $pagination->page  = $options['page'];
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text  = $this->data['text_pagination'];
        $pagination->url   = $current_url . '&page={page}&sort=' . $options['sort'] . '&order=' . $options['order'];

        $this->data['pagination']    = $pagination->render();
        $this->data['sort']          = $options['sort'];
        $this->data['order']         = strtolower($options['order']);
        $this->data['request_url']   = $this->getRequestUrl();
        $this->data['index_url']     = $this->link('stories/index');
        $this->data['action_insert'] = $this->link('stories/index/edit');
        $this->data['action_delete'] = $this->link('stories/index/delete');

        $this->renderOutput('stories/index.tpl');
  }

    public function edit()
    {
        $this->mergeLanguage('stories/index');

        $action = isset($this->request->get['story_id']) && !empty($this->request->get['story_id']) ? 'update' : 'insert';

        if ($this->isPost() && isset($this->request->post['story']) && $this->validate()) {
            if ($action == 'update') {
                $this->getModel()->update((int) $this->request->get['story_id'], $this->request->post['story']);
            } else {
                $this->getModel()->insert($this->request->post['story']);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->link('stories/index'));
        }

        $this->document->setTitle($this->language->get('heading_title'));

        $this->setBreadcrumbs();

        if (isset($this->request->post['story'])) {
            $story = $this->request->post['story'];
        } else
        if ($action == 'update' && $story = $this->getModel()->getOne((int) $this->request->get['story_id'])) {
            $story['lang'] = $this->getModel()->getLang(($story['story_id']));
        } else {
            $story = array(
                'image'   => '',
                'keyword' => '',
                'status'  => 1,
                'sticky'  => 0,
                'stores'  => array(0),
                'lang'    => array(),
                'tags'    => ''
            );
        }

        $image =  !empty($story['image']) && file_exists(DIR_IMAGE . $story['image']) ? $story['image'] : 'no_image.jpg';
        $story['thumb'] = $this->getModel('tool/image')->resize($image, 100, 100);

        $all_tags = array();
        foreach ($this->getModel('tag')->getAll() as $tag) {
            $all_tags[$tag['language_id']][] = $tag['name'];
        }
        foreach ($all_tags as &$tags) {
            $tags = '"' . implode('","', $tags) . '"';
        }

        $this->data['story']     = $story;
        $this->data['error']     = $this->getArrayKey('warning', $this->error);
        $this->data['action']    = $this->link('stories/index/edit', $action == 'update' ? 'story_id=' . (int) $this->request->get['story_id'] : '');
        $this->data['cancel']    = $this->link('stories/index');
        $this->data['token']     = $this->getToken();
        $this->data['languages'] = $this->getModel('localisation/language')->getLanguages();
        $this->data['no_image']  = $this->getModel('tool/image')->resize('no_image.jpg', 100, 100);
        $this->data['stores']    = $this->getModel('setting/store')->getStores();
        $this->data['layouts']   = $this->getModel('design/layout')->getLayouts();
        $this->data['all_tags']  = $all_tags;

        $this->renderOutput('stories/form.tpl');
  }

    public function delete()
    {
        if (isset($this->request->post['selected']) && $this->validate()) {
            foreach ($this->request->post['selected'] as $id) {
                $this->getModel()->deleteOne($id);
            }

            $this->language->load('stories/index');
            $this->session->data['success'] = $this->language->get('text_success');
        }

        $this->redirect($this->link('stories/index'));
    }

    public function settings()
    {
        $this->mergeLanguage('stories/index');

        if ($this->isPost() && isset($this->request->post['settings']) && $this->validate()) {

            $general_settings = $this->request->post['settings']['general'];
            unset($this->request->post['settings']['general']);

            foreach ($this->request->post['settings'] as $store_id => $settings) {
                $this->getModel()->editSetting('stories_settings', array(
                    'lang'                     => (array) $settings['lang'],
                    'stories_per_page'         => (int) $settings['stories_per_page'],
                    'keyword'                  => trim((string) $general_settings['keyword']),
                    'auto_seo_url'             => (int) $general_settings['auto_seo_url'],
                    'thumbnail_position'       => (string) $settings['thumbnail_position'],
                    'text_limit'               => (int) $settings['text_limit'],
                    'image_list_width'         => (int) $settings['image_list_width'],
                    'image_list_height'        => (int) $settings['image_list_height'],
                    'image_description_width'  => (int) $settings['image_description_width'],
                    'image_description_height' => (int) $settings['image_description_height'],
                    'comments'                 => (string) $settings['comments'],
                    'disqus_shortname'         => (string) $settings['disqus_shortname'],
                    'social_share'             => (string) $settings['social_share']
                ), $store_id);

                $this->getModel()->insertStoriesKeyword(trim((string) $general_settings['keyword']));
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->link('stories/index/settings'));
        }

        $this->document->setTitle($this->language->get('heading_title'));

        $this->setBreadcrumbs();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_settings'),
            'href'      => $this->link('stories/index/settings'),
            'separator' => ' :: '
        );

        $this->data['success'] = '';
        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        $this->data['error']      = $this->getArrayKey('warning', $this->error);
        $this->data['action']     = $this->link('stories/index/settings');
        $this->data['languages']  = $this->getModel('localisation/language')->getLanguages();
        $this->data['stores']     = $this->getModel()->getAllStores();
        $this->data['settings']   = $this->getSettings();

        $this->renderOutput('stories/settings.tpl');
    }

    protected function getSettings()
    {
        $default_settings = $this->getModel('system')->getDefaultSettings();

        $keyword = $this->getModel()->getStoriesKeyword();
        if ($keyword) {
            $default_settings['keyword'] = $keyword;
        }

        $default_lang_settings = array(
            'page_title'       => '',
            'meta_title'       => '',
            'meta_description' => ''
        );

        $settings = array();

        foreach ($this->getModel()->getAllStores() as $store) {
            if (!($settings[$store['store_id']] = $this->getModel()->getSettings($store['store_id']))) {
                $settings[$store['store_id']] = $default_settings;
            } else {
                $settings[$store['store_id']] = array_merge($default_settings, $settings[$store['store_id']]);
            }
        }

        foreach ($this->getModel('localisation/language')->getLanguages() as $language) {
            foreach ($settings as &$values) {
                if (!isset($values['lang'])) {
                    $values['lang'] = array();
                }
                if (!isset($values['lang'][$language['language_id']])) {
                    $values['lang'][$language['language_id']] = array();
                }
                $values['lang'][$language['language_id']] = array_merge($default_lang_settings, $values['lang'][$language['language_id']]);
            }
        }

        return $settings;
    }

    protected function validate()
    {
        return parent::validatePermission('stories/index');
    }
}
