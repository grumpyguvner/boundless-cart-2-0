<?php

class Theme_GalleryWidget extends TB_Widget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');

    public function onFilter(array &$settings)
    {
        $settings = array_replace($settings, $this->initLangVars(array(
            'is_active'   => 1,
            'title'       => 'Gallery',
            'title_align' => 'left'
        ), $settings));

        $settings = array_replace($settings, $this->initFlatVars(array(
            'images'            => array(),
            'gallery_type'      => 'slide',
            'gallery_nav'       => 'dots',
            'gallery_height'    => 300,
            'navigation_size'   => '2',
            'thumb_gutter'      => 1,
            'filter_randomize'  => 0,
            'fullscreen'        => 1,
            'thumb_size_x'      => 100,
            'thumb_size_y'      => 100,
            'preview_size_x'    => 300,
            'preview_size_y'    => 300,
            'full_size_x'       => 1200,
            'full_size_y'       => 800,
            'crop_thumbs'       => 1
        ), $settings));
    }

    public function onEdit(array &$settings)
    {
        if (isset($settings['images']) && !empty($settings['images'])) {
            foreach ($settings['images'] as &$image) {
                if (!empty($image['file'])  && file_exists(DIR_IMAGE . $image['file'])) {
                    $image['preview'] = $this->getOcModel('tool/image')->resize($image['file'], 100, 100);
                } else {
                    $image['preview'] = $this->getThemeModel()->getNoImage();
                }
            }
        }
    }

    public function onTransformSettings(array &$settings)
    {
        if (isset($settings['images']) && !empty($settings['images'])) {
            foreach ($settings['images'] as $key => &$image) {
                if (empty($image['file'])  || !file_exists(DIR_IMAGE . $image['file'])) {
                    unset($settings['images'][$key]);
                } else {
                    list($width, $height) = getimagesize(DIR_IMAGE . $image['file']);
                    $image['width'] = $width;
                    $image['height'] = $height;
                }
            }
        }
    }

    public function initFrontend()
    {
        $this->themeData->registerJavascriptResource('fotorama/fotorama.min.js');
        $this->themeData->registerStylesheetResource('fotorama.css');
    }

    public function render(array $view_data = array())
    {
        $settings = $this->settings;
        $images = array();
        $images_js_array = '';
        $method = $this->settings['crop_thumbs'] ? 'crop' : 'fit';
        $img_url = $this->manager->getContext()->getImageUrl();

        $i = 0;
        foreach ($settings['images'] as $image) {

            $preview_attr = '';
            $thumb_attr   = '';

            $thumb   = $this->getThemeModel()->resizeImageAdvanced($image['file'], $this->settings['crop_thumbs'] ? $settings['thumb_size_x'] : 'auto', $settings['thumb_size_y'], $method);

            if (empty($thumb)) {
                continue;
            }

            $preview = $this->getThemeModel()->resizeImageAdvanced($image['file'], $this->settings['crop_thumbs'] ? $settings['preview_size_x'] : 'auto', $settings['preview_size_y'], $method);
            $full    = $this->getThemeModel()->resizeImageAdvanced($image['file'], $settings['full_size_x'], $settings['full_size_y']);

            list($thumb_x) = getimagesize(DIR_IMAGE . $thumb);
            list($preview_x, $preview_y) = getimagesize(DIR_IMAGE . $preview);

            $preview_attr .= ' data-index="' . $i . '"';
            if ($preview_x < $settings['preview_size_x'] && $preview_y < $settings['preview_size_y']) {
                $preview_attr .= ' data-fit="scaledown"';
            } else 
            if ($preview_x < $settings['preview_size_x'] || $preview_y < $settings['preview_size_y']) {
                $preview_attr .= ' data-fit="contain"';
            }
            $preview_attr .= ' onlick="javascript: return false;"';
            $thumb_attr   .= !$settings['crop_thumbs'] ? ' width="' .  $thumb_x . '" height="' . $settings['thumb_size_y'] . '"' : ' width="' .  $settings['thumb_size_x'] . '" height="' . $settings['thumb_size_y'] . '"';

            $images[] = array(
                'thumb'        => $img_url . $thumb,
                'thumb_x'      => $thumb_x,
                'preview'      => $img_url . $preview,
                'preview_x'    => $preview_x,
                'full'         => $img_url . $full,
                'thumb_attr'   => $thumb_attr,
                'preview_attr' => $preview_attr,
            );

            $images_js_array .= '{img: "' . $img_url . $full . '", thumb: "' . $img_url . $thumb . '"}, ';

            $i++;
        }

        if (empty($images)) {
            return '';
        }

        $view_data['images']       = $images;
        $view_data['images_array'] = '[ ' . trim($images_js_array, ', ') . ' ]';
        $view_data['url']          = $this->manager->getOcUrl();

        return parent::render($view_data);
    }

    public function getDefaultColors()
    {
        $default_colors = array(
            'body' => array(
                '_label' => 'Body',
                'title' => array(
                    'label'       => 'Block Title',
                    'elements'    => 'h2',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.text'
                )
            ),
            'navigation' => array(
                '_label' => 'Navigation',
                'button_default' => array(
                    'label'       => 'Prev/next buttons',
                    'elements'    => '.fotorama__arr:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.button_default'
                ),
                'button_bg_default' => array(
                    'label'       => 'Prev/next buttons bg',
                    'elements'    => '.fotorama__arr:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.button_bg_default'
                ),
                'button_hover' => array(
                    'label'       => 'Prev/next buttons (hover)',
                    'elements'    => '.fotorama__arr:hover:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.button_hover'
                ),
                'button_bg_hover' => array(
                    'label'       => 'Prev/next buttons bg (hover)',
                    'elements'    => '.fotorama__arr:hover:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.button_bg_hover'
                ),
                'fbutton_default' => array(
                    'label'       => 'Go fullscreen button',
                    'elements'    => '.tb_fullscreen_button',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.fbutton_default'
                ),
                'fbutton_bg_default' => array(
                    'label'       => 'Go fullscreen button bg',
                    'elements'    => '.tb_fullscreen_button',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.fbutton_bg_default'
                ),
                'fbutton_hover' => array(
                    'label'       => 'Go fullscreen button (hover)',
                    'elements'    => '.tb_fullscreen_button:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.fbutton_hover'
                ),
                'fbutton_bg_hover' => array(
                    'label'       => 'Fullscreen button bg (hover)',
                    'elements'    => '.tb_fullscreen_button:hover',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.fbutton_bg_hover'
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.pagination_default'
                ),
                'pagination_hover' => array(
                    'label'       => 'Pagination (hover)',
                    'elements'    => '.fotorama__nav__frame--dot:hover .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.pagination_hover'
                ),
                'pagination_active' => array(
                    'label'       => 'Pagination (active)',
                    'elements'    => '.fotorama__active .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.pagination_active'
                ),
                'thumb_border' => array(
                    'label'       => 'Active thumb border',
                    'elements'    => '.fotorama__thumb-border',
                    'property'    => 'border-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_nav.thumb_border'
                )
            ),
            'fullscreen_navigation' => array(
                '_label' => 'Navigation (Fullscreen)',
                'button_default' => array(
                    'label'       => 'Button',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:before',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.button_default'
                ),
                'button_bg_default' => array(
                    'label'       => 'Button bg',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:after',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.button_bg_default'
                ),
                'button_hover' => array(
                    'label'       => 'Button (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:hover:before',
                    'property'    => 'color',
                    'color'       => '#cccccc',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.button_hover'
                ),
                'button_bg_hover' => array(
                    'label'       => 'Button bg (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__arr:hover:after',
                    'property'    => 'background-color',
                    'color'       => '',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.button_bg_hover'
                ),
                'fbutton_default' => array(
                    'label'       => 'Close button',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.fbutton_default'
                ),
                'fbutton_bg_default' => array(
                    'label'       => 'Close button bg',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close',
                    'property'    => 'background-color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.fbutton_bg_default'
                ),
                'fbutton_hover' => array(
                    'label'       => 'Close button (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close:hover',
                    'property'    => 'color',
                    'color'       => '#ffffff',
                    'important'   => 1,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.fbutton_hover'
                ),
                'fbutton_bg_hover' => array(
                    'label'       => 'Close button bg (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .tb_close:hover',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.fbutton_bg_hover'
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#555555',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.pagination_default'
                ),
                'pagination_hover' => array(
                    'label'       => 'Pagination (hover)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__nav__frame--dot:hover .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.pagination_hover'
                ),
                'pagination_active' => array(
                    'label'       => 'Pagination (active)',
                    'elements'    => '.tb_gallery.tb_fullscreen .fotorama__active .fotorama__dot',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.pagination_active'
                ),
                'overlay' => array(
                    'label'       => 'Overlay',
                    'elements'    => '.tb_gallery.tb_fullscreen:after',
                    'property'    => 'background-color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'theme:gallery_fullscreen_nav.overlay'
                )
            )
        );

        return $default_colors;
    }

}