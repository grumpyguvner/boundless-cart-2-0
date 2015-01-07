<?php

require_once 'SystemWidget.php';

class Theme_SubcategoriesSystemWidget extends Theme_SystemWidget
{
    protected $subcategory_count = null;

    public function onFilter(array &$settings)
    {
        $default_vars = array(
            'show_title'            => 0,
            'inherit_subcategories' => 1,
            'subcategories'         => array()
        );

        $inherit_subcategories = isset($settings['inherit_subcategories']) ? $settings['inherit_subcategories'] : $default_vars['inherit_subcategories'];

        if ($inherit_subcategories) {
            $theme_settings = $this->manager->getThemeExtension()->getSettings();
            $result = $this->initFlatVars($default_vars, $settings);

            if (isset($settings['subcategories'])) {
                $result['subcategories'] = $this->initFlatVars($default_vars['subcategories'], $settings['subcategories']);
            }

            if (isset($theme_settings['store']['category']['subcategories'])) {
                $result['subcategories'] = array_replace($result['subcategories'], $theme_settings['store']['category']['subcategories']);
            } else {
                $result['subcategories'] = array_replace($this->getThemeModel('store')->getSubcategoriesDefaultSettings(), $result['subcategories']);
            }
        } else {
            $default_vars['subcategories'] = array_replace($this->getThemeModel('store')->getSubcategoriesDefaultSettings(), $default_vars['subcategories']);
            $result = $this->initFlatVars($default_vars, $settings);
            if (isset($settings['subcategories'])) {
                $result['subcategories'] = $this->initFlatVars($default_vars['subcategories'], $settings['subcategories']);
            }
        }

        foreach ($result['subcategories']['restrictions'] as $i => $row) {
            if (empty($row['max_width']) || empty($row['items_per_row'])) {
                unset($result['subcategories']['restrictions'][$i]);
            }
        }

        if (empty($result['subcategories']['restrictions'])) {
            $theme_settings = $this->manager->getThemeExtension()->getSettings();
            $result['subcategories']['restrictions'] = $theme_settings['store']['category']['subcategories']['restrictions'];
        }

        $settings = array_replace($settings, $result);

        parent::onFilter($settings);
    }

    public function initFrontend()
    {
        $this->manager->getEventDispatcher()->connect('core:assignAssets', array($this, 'assignAssets'));
    }

    public function assignAssets()
    {
        if ($this->settings['subcategories']['is_slider']) {
            $this->themeData->registerJavascriptResource('swiper.min.js');
            $this->themeData->registerStylesheetResource('swiper.css');
        }
    }

    public function configureFrontend()
    {
        $this->manager->getEventDispatcher()->connect('product/category.subcategory_listing.filter', array($this, 'filterSubcategories'));
    }

    public function filterSubcategories(sfEvent $event, array $data)
    {
        $settings = $this->settings['subcategories'];

        if ($settings['product_count']) {
            $subcategories = $this->getThemeModel('category')->getCategoriesByParentWithTotalProducts($this->themeData->category_id);
        } else {
            $subcategories = $this->getThemeModel('category')->getCategoriesByParent($this->themeData->category_id);
        }

        if ($settings['style'] != 6) {
            $settings['listing_classes']  = 'tb_cstyle_' . $settings['style'];
            $settings['listing_classes'] .= ' align_' . $settings['text_align'];
            $settings['listing_classes'] .= $settings['style'] == 1 ? ' tb_image_' . $settings['image_position'] : '';
            $settings['listing_classes'] .= $settings['show_next_level'] ? ' tb_complex' : '';
            $settings['listing_classes'] .= ' tb_' . $this->getDomId() . '_classes';
            $settings['show_thumb']       = $settings['style'] != 3;
            $settings['show_title']       = $settings['style'] != 2;
            $settings['show_children']    = $settings['style'] != 4 && $settings['style'] != 5;
        } else {
            $settings['listing_classes'] = '';
            $settings['show_thumb']      = 0;
            $settings['is_slider']       = 0;
        }


        $restrictions_json = array();
        foreach ($settings['restrictions'] as $restriction) {
            $restrictions_json[$restriction['max_width']] = array(
                'items_per_row' => $restriction['items_per_row'],
                'items_spacing' => $restriction['items_spacing']
            );
        }
        krsort($restrictions_json);
        $settings['restrictions_json'] = json_encode($restrictions_json);

        $this->themeData->subcategories = $settings;

        $parent_category = null;
        if ($settings['show_next_level']) {
            $parent_category = $this->getThemeModel('category')->getTreeById($this->themeData->category_id);
        }

        $config = $this->manager->getOcConfig();
        $resize_images = !$this->settings['inherit_subcategories'] && ($settings['image_width'] != $config->get('config_image_category_width') || $settings['image_height'] != $config->get('config_image_category_height'));

        $i = 1;
        foreach ($subcategories as &$category) {
            $clear_class = '';

            if (is_int(($i-1)/2)) $clear_class .= ' clear2';
            if (is_int(($i-1)/3)) $clear_class .= ' clear3';
            if (is_int(($i-1)/4)) $clear_class .= ' clear4';
            if (is_int(($i-1)/5)) $clear_class .= ' clear5';
            if (is_int(($i-1)/6)) $clear_class .= ' clear6';
            if (is_int(($i-1)/7)) $clear_class .= ' clear7';
            if (is_int(($i-1)/8)) $clear_class .= ' clear8';

            $category['tb_css_classes'] = $clear_class;

            if ($settings['show_thumb']) {
                $category['image'] ? $image = $category['image'] : $image = 'no_image.jpg';
                $category['thumb'] = (string) $this->getThemeModel()->resizeImage($image, $this->manager->getOcConfig()->get('config_image_category_width'), $this->manager->getOcConfig()->get('config_image_category_height'));
            }

            if (!$settings['product_count']) {
                $category['products_count'] = null;
            }

            $category_from_tree = $this->getThemeModel('category')->getCategoryFromFlatTree($category['category_id']);
            $category['url'] = $category_from_tree['url'];

            $category['description'] = html_entity_decode($category['description'], ENT_QUOTES, 'UTF-8');
            $category['path']  = $this->themeData->category_path . '_' . $category['category_id'];

            if (null !== $parent_category) {
                $category['children'] = $parent_category['children'][$category['category_id']]['children'];
            }

            if ($resize_images && $category['image']) {
                $category['thumb'] = $this->manager->getOcModel('tool/image')->resize($category['image'], $settings['image_width'], $settings['image_height']);
            }

            $i++;
        }

        $data['categories'] = $subcategories;
        $this->subcategory_count = count($subcategories);
    }

    public function onAreaContentOutput(&$html)
    {
        $sizes = $this->getSettings('sizes');

        if ($this->getAttribute('grid_proportion')) {
            $sizes['grid_proportion'] = $this->getAttribute('grid_proportion');
        }

        $restrictions = $this->settings['subcategories']['restrictions'];
        $this->manager->getThemeExtension()->getPlugin('product')->calculateProductsPerRow($restrictions, $sizes);

        $classes = 'tb_gut_' . $restrictions['items_spacing'] . ' tb_size_' . $restrictions['items_per_row'];

        if ($this->settings['subcategories']['is_slider'] && !$this->themeData->is_touch && $this->subcategory_count > $restrictions['items_per_row']) {
            $classes .= ' tb_slider_load';
        }

        $html = str_replace('tb_' . $this->getDomId() . '_classes', $classes, $html);
    }

    public function getFrontendClasses()
    {

        $classes = parent::getFrontendClasses();

        if ($this->settings['subcategories']['is_slider']) {
            $classes .= ' has_slider';
        }

        return $classes;
    }

    protected function getDefaultFonts()
    {
        return array(
            'title' => array(
                'section_name'      => 'Block Title',
                'elements'          => ' h2',
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
                'can_inherit'       => true
            ),
            'categories_level_1' => array(
                'section_name'      => 'Level 1',
                'elements'          => 'h3, .tb_subcategories > ul.tb_list_1 > li > a',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 14,
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
                'can_inherit'       => true
            ),
            'categories_level_2' => array(
                'section_name'      => 'Level 2',
                'elements'          => 'h3 + ul > li > a, ul ul > li > a',
                'type'              => '',
                'family'            => 'inherit',
                'subsets'           => '',
                'variant'           => '',
                'size'              => 14,
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
                'can_inherit'       => true
            )
        );
    }

    public function getDefaultColors()
    {
        $default_colors = array(
            'categories_level_1' => array(
                '_label' => 'Level 1',
                'text' => array(
                    'label'       => 'Links',
                    'elements'    => 'h3 > a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links'
                ),
                'text_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'h3 > a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links_hover'
                ),
                'bullets' => array(
                    'label'       => 'Bullets',
                    'elements'    => '.tb_subcategories > ul.tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                )
            ),
            'categories_level_2' => array(
                '_label' => 'Level 2',
                'text' => array(
                    'label'       => 'Links',
                    'elements'    => 'h3 + ul > li > a, ul ul > li > a',
                    'property'    => 'color',
                    'color'       => '#333333',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links'
                ),
                'text_hover' => array(
                    'label'       => 'Links (hover)',
                    'elements'    => 'h3 + ul > li > a:hover, ul ul > li > a:hover',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.links_hover'
                ),
                'bullets' => array(
                    'label'       => 'Bullets',
                    'elements'    => 'ul ul.tb_list_1 > li:before',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 1,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                )
            ),
            'slider' => array(
                '_label' => 'Slider',
                'button_default' => array(
                    'label'       => 'Prev/Next button',
                    'elements'    => '.tb_slider_controls a',
                    'property'    => 'color',
                    'color'       => '#b92616',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent'
                ),
                'button_hover' => array(
                    'label'       => 'Prev/Next button (hover)',
                    'elements'    => '.tb_slider_controls a:hover',
                    'property'    => 'color',
                    'color'       => '#000000',
                    'important'   => 0,
                    'force_print' => 1,
                    'can_inherit' => 1,
                    'inherit'     => 1,
                    'inherit_key' => 'row:body.accent_hover'
                ),
                'button_inactive' => array(
                    'label'       => 'Prev/Next button (inactive)',
                    'elements'    => '.tb_slider_controls a.tb_disabled, .tb_slider_controls a.tb_disabled:hover',
                    'property'    => 'color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_default' => array(
                    'label'       => 'Pagination',
                    'elements'    => '.tb_slider_pagination span',
                    'property'    => 'background-color',
                    'color'       => '#dddddd',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_hover' => array(
                    'label'       => 'Pagination (hover)',
                    'elements'    => '.tb_slider_pagination span:hover',
                    'property'    => 'background-color',
                    'color'       => '#cccccc',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                ),
                'pagination_active' => array(
                    'label'       => 'Pagination (active)',
                    'elements'    => '.tb_slider_pagination span.tb_active, .tb_slider_pagination span.tb_active:hover',
                    'property'    => 'background-color',
                    'color'       => '#999999',
                    'important'   => 0,
                    'force_print' => 0,
                    'can_inherit' => 0,
                    'inherit'     => 0,
                    'inherit_key' => ''
                )
            )
        );

        return $default_colors;
    }
}