<?php

require_once DIR_SYSTEM . 'vendor/stories/controller.php';

class ControllerStoriesCatalog extends ControllerStories
{
    protected $error = array();
    protected $data = array();

    protected function renderOutput($template)
    {
        $children = array(
            'column_left',
            'column_right',
            'content_top',
            'content_bottom',
            'footer',
            'header'
        );

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $template)) {
            $template = $this->config->get('config_template') . '/template/' . $template;
        } else {
            $template = 'default/template/' . $template;
        }

        $this->data['gteOc2'] = $this->gteOc2();

        if ($this->gteOc2()) {
            foreach ($children as $name) {
                $this->data[$name] = $this->load->controller('common/' . $name);
            }
            $this->response->setOutput($this->load->view($template, $this->data));
        } else {
            foreach ($children as &$child) {
                $child = 'common/' . $child;
            }
            $this->children = $children;
            $this->template = $template;
            $this->response->setOutput($this->render());
        }
    }

    protected function notFound($breadcrumb_url)
    {
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_error'),
            'href'      => $breadcrumb_url,
            'separator' => $this->language->get('text_separator')
        );

        $this->document->setTitle($this->language->get('text_error'));

        $this->data['heading_title'] = $this->language->get('text_error');
        $this->data['text_error'] = $this->language->get('text_error');
        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['continue'] = $this->url->link('common/home');

        $this->renderOutput('error/not_found.tpl');
    }

    protected function addStyle($style)
    {
        if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/slideshow.css')) {
            $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/' . $style);
        } else {
            $this->document->addStyle('catalog/view/theme/default/stylesheet/' . $style);
        }
    }
}