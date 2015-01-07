<?php

require_once dirname(__FILE__) . '/lib/controller.php';

class ControllerStoriesIndex extends ControllerStoriesCatalog
{
    public function index()
    {
        $this->language->load('module/stories');

        $settings = $this->config->get('stories_settings');
        $lang_id  = $this->config->get('config_language_id');

        $settings_lang = isset($settings['lang'][$lang_id]) ? $settings['lang'][$lang_id] : reset($settings['lang']);

        $page_title        = $settings_lang['page_title'] ? $settings_lang['meta_title'] : $this->language->get('text_articles');
        $meta_title        = $settings_lang['meta_title'] ? $settings_lang['meta_title'] : $this->language->get('text_articles');
        $meta_description  = $settings_lang['meta_title'] ? $settings_lang['meta_description'] : '';

        $this->document->setTitle($meta_title);
        $this->document->setDescription($meta_description);

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $page_title,
            'href'      => $this->url->link('stories/index'),
            'separator' => $this->language->get('text_separator')
        );

        $url = '';

        $page = 1;
        if (isset($this->request->get['page']) && !empty($this->request->get['page']) && is_numeric($this->request->get['page'])) {
            $page = (int) $this->request->get['page'];
            $url .= '&page=' . $page;
        }

        $options = array(
            'page'                => $page,
            'limit'               => $settings['stories_per_page'],
            'start'               => $settings['stories_per_page'] * ($page - 1),
            'filter_sticky_first' => true
        );

        //fb($this->url->link('stories/index'));
        //fb($this->url->link('stories/index', $url . '&page={pagesssss}'));

        $stories = $this->getModel()->getStories($options);
        $total = $this->getModel()->getFoundRows();

        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page  = $page;
        $pagination->limit = $settings['stories_per_page'];
        $pagination->text  = $this->language->get('text_pagination');
        $pagination->url   = $this->url->link('stories/index', $url . '&page={page}');

        $this->data['pagination']       = $pagination->render();
        $this->data['settings']         = $settings;
        $this->data['heading_title']    = $page_title;
        $this->data['text_read_more']   = $this->language->get('text_read_more');
        $this->data['text_no_articles'] = $this->language->get('text_no_articles');
        $this->data['stories']          = array();

        foreach ($stories as $story) {
            
            if (!empty($story['teaser'])) {
                $description = strip_tags(html_entity_decode($story['teaser'], ENT_COMPAT, 'UTF-8'));
            } else {
                $description = strip_tags(html_entity_decode($story['description'], ENT_COMPAT, 'UTF-8'));
                $description = strlen($description) > $settings['text_limit'] ? substr($description, 0, $settings['text_limit']) . '...' : $description;
            }

            $thumb = '';
            if ($story['image']) {
                $thumb = $this->getModel()->resizeImageAdvanced($story['image'], $settings['image_list_width'], $settings['image_list_height'], 'crop');
            }

            $tags = array();
            if (trim($story['tags'])) {
                foreach (explode('!*!', $story['tags']) as $tag) {
                    list($name, $tag_id) = explode('<=>', $tag);
                    $tags[] = array(
                        'name' => $name,
                        'url'   => $this->url->link('stories/tag', 'story_tag_id=' . $tag_id)
                    );
                }
            }

            $this->data['stories'][] = array (
                'title'       => $story['title'],
                'description' => $description,
                'tags'        => $tags,
                'thumb'       => $thumb,
                'url'         => $this->url->link('stories/show', 'story_id=' . $story['story_id']),
                'date_added'  => date($this->language->get('date_format_short'), strtotime($story['date_added']))
            );
        }

        $this->renderOutput('stories/index.tpl');
    }
}
