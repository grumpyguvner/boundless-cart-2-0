<?php

class Theme_Catalog_MenuPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        $this->bootstrap('common');
        $this->bootstrap('style');

        if ($themeData->system['compatibility_menu']) {
            return;
        }

        $themeData->addCallable(array($this, 'getCategorySubMenu'));
        $themeData->addCallable(array($this, 'fetchMenuItems'));
        $themeData->addCallable(array($this, 'buildClearClasses'));

        if ($themeData['system']['cache_menu']) {
            $cache_key = 'menu_html.' . $this->context->getStoreId() . '.' . (TB_RequestHelper::isRequestHTTPS() ? 'https.': '') . $this->language_id;
            $themeData->menuHTML = $this->manager->getCacheVar($cache_key, array($this, 'fetchMenu'));
        } else {
            $themeData->menuHTML = $this->fetchMenu();
        }
    }

    public function buildStyles(TB_StyleBuilder $styleBuilder)
    {
        $store = $this->getSetting('store');
        if (!isset($store['menu']['tree'][$this->language_id])) {
            return;
        }

        $menu_tree = $store['menu']['tree'][$this->language_id];
        foreach ($menu_tree as $item) {
            $settings = $item['data']['settings'];

            if ($item['data']['type'] == 'category' && isset($settings['category_custom_bg']) && !empty($settings['category_custom_bg'])) {
                $css = '#menu_category_' . $item['data']['id'] . ' .tb_wrap > .tb_category_info_col {
                  background: url("' . $this->context->getImageUrl() .  $settings['category_custom_bg'] . '") no-repeat top center / cover;
                }';
                $styleBuilder->addCss($css);
            }

            if ($item['data']['type'] == 'manufacturers' && !$settings['is_megamenu']) {
                $css = '#main_navigation #menu_brands > .tb_submenu {
                  width: ' . $settings['width'] . 'px;
                }';
                $styleBuilder->addCss($css);
            }
        }
    }

    public function fetchMenu()
    {
        $store = $this->getSetting('store');

        if (!isset($store['menu']['tree'][$this->language_id]) || empty($store['menu']['tree'][$this->language_id])) {
            if ($this->manager->getThemeConfig('menu_fallback_first_language')) {
                $menu_tree = reset($store['menu']['tree']);
            } else {
                return '';
            }
        } else {
            $menu_tree = $store['menu']['tree'][$this->language_id];
        }

        $menuHTML = $this->fetchMenuItems($menu_tree);
        $lang_vars = $this->manager->loadOcTranslation('common/footer');

        $menu = $this->extension->fetchTemplate('menu/menu', array(
                'informations' => $this->getModel('default')->getInformationPages(),
                'menu_items'   => $menuHTML
            ) + $lang_vars
        );

        return $menu;
    }

    public function fetchMenuItems($tree)
    {
        $html = '';

        foreach ($tree as $item) {
            switch ($item['data']['type']) {
                case 'page':
                    $html .= $this->fetchMenuPage($item);
                    break;
                case 'category':
                    if ($category = $this->getCategoryInfo($item)) {
                        $html .= $this->fetchMenuCategory($category, $item);
                    }
                    break;
                case 'categories';
                    $html .= $this->fetchMenuAllCategories($item);
                    break;
                case 'manufacturers';
                    $html .= $this->fetchMenuManufacturers($item);
                    break;
                case 'url';
                    $html .= $this->fetchMenuUrl($item);
                    break;
                case 'home';
                    $html .= $this->fetchMenuHome($item);
                    break;
                case 'html':
                    $html .= $this->fetchMenuHtml($item);
                    break;
                case 'system':
                    $html .= $this->fetchMenuSystem($item);
                    break;
            }
        }

        return $html;
    }

    public function buildClearClasses($i)
    {
        $classes = ' ';

        if (is_int(($i-1)/2)) $classes .= ' clear2';
        if (is_int(($i-1)/3)) $classes .= ' clear3';
        if (is_int(($i-1)/4)) $classes .= ' clear4';
        if (is_int(($i-1)/5)) $classes .= ' clear5';
        if (is_int(($i-1)/6)) $classes .= ' clear6';
        if (is_int(($i-1)/7)) $classes .= ' clear7';
        if (is_int(($i-1)/8)) $classes .= ' clear8';

        return $classes;
    }

    public function getCategorySubMenu($category, array $menu_item_settings, $max_depth = null)
    {
        if (!empty($category['children']) && (null === $max_depth || $category['level'] < $max_depth)) {
            $i = 1;
            foreach ($category['children'] as &$child) {
                $menu_classes = ' ';

                if ($child['level'] == 2) {
                    $menu_classes = $this->buildClearClasses($i);
                    $menu_classes .= $menu_item_settings['is_megamenu'] ? ' tb_item' : '';
                }

                $menu_classes .= !empty($child['children']) && (null === $max_depth || ($child['level'] + 1) <= $max_depth) ? ' tb_multiple ' : '';
                $menu_classes .= ' category_' . $child['category_id'];
                $menu_classes  = trim($menu_classes);

                $child['menu_classes'] = $menu_classes;

                $i++;
            }

            return trim($this->extension->fetchTemplate('menu/category_item', array(
                'category'     => $category,
                'settings'     => $menu_item_settings,
                'max_depth'    => $max_depth,
                'menu_classes' => $category['level'] == 1 ? ' tb_subcategories' . $menu_item_settings['wrapper_classes'] : '',
                'toolImage'    => $this->getModel()
            )));
        }

        return '';
    }

    protected function fetchMenuCategory($category, $menu_item)
    {
        $lang_vars = $this->manager->loadOcTranslation('common/footer');
        $item_settings = $menu_item['data']['settings'];

        $item_settings['description'] = isset($item_settings['description']) ? trim($item_settings['description']) : '';
        $item_settings['category_custom_bg'] = isset($item_settings['category_custom_bg']) ? trim($item_settings['category_custom_bg']) : '';

        $max_depth = (int) $item_settings['depth'];
        if (empty($max_depth) || $max_depth < 0) {
            $max_depth = 99;
        }

        $item_settings['wrapper_classes']  = '';
        $item_settings['wrapper_classes'] .= $item_settings['is_megamenu'] ? ' tb_listing tb_grid_view tb_style_1 tb_size_' . $item_settings['subcategory_cols'] : '';
        $item_settings['max_level_thumb'] = 0;
        if ($item_settings['category_thumb']) {
            $item_settings['max_level_thumb'] = $item_settings['subcategory_hover_thumb'] ? 2 : 1;
        }

        $submenu = $this->getCategorySubMenu($category, $item_settings, $max_depth + 1);

        $menu_classes  = isset($item_settings['class'])  ? $item_settings['class'] . ' ' : '';
        $menu_classes .= $item_settings['is_megamenu'] ? ' tb_megamenu' : '';
        $menu_classes .= $item_settings['show_main_thumbnail'] ? ' tb_thumbnail_menu' : '';
        $menu_classes .= !empty($submenu) ? ' tb_multiple' : '';
        $menu_classes = trim($menu_classes);

        $category_label = isset($item_settings['label']) && !empty($item_settings['label'] ) ? $item_settings['label'] : $category['name'];

        $manufacturers =  array();
        if ($item_settings['manufacturers_type'] != 'none') {
            $category_ids = array_merge((array) $category['category_id'], $category['successor_ids']);
            $manufacturers =  $this->getModel('manufacturer')->getManufacturersByCategoryIds($category_ids);
            $manufacturers = $this->modifyMenuItemManufacturers($manufacturers, $item_settings);

        }

        $category_info = ($item_settings['show_main_thumbnail'] && $category['thumb'])
                         || $item_settings['category_custom_bg']
                         || $item_settings['description']
                         || $item_settings['show_title'];
        $submenu_width = 5 - ($category_info ? 1 : 0) - (!empty($manufacturers) && $item_settings['manufacturers_position'] == 'column' ? 1 : 0);

        return $this->extension->fetchTemplate('menu/category', array(
            'category'       => $category,
            'category_info'  => $category_info,
            'settings'       => $item_settings,
            'menu_item_id'   => $menu_item['data']['id'],
            'submenu'        => $submenu,
            'submenu_width'  => $submenu_width,
            'manufacturers'  => $manufacturers,
            'category_label' => $category_label,
            'toolImage'      => $this->getModel(),
            'url'            => $this->manager->getOcUrl(),
            'menu_classes'   => empty($menu_classes) ? '' : ' ' . $menu_classes
        ) + $lang_vars);
    }

    protected function fetchMenuAllCategories($menu_item)
    {
        $lang_vars = $this->manager->loadOcTranslation('common/footer');
        $item_settings = $menu_item['data']['settings'];
        $item_settings['max_level_thumb'] = 0;

        $categories = $this->getModel('category')->getCategoriesTree();

        $menu_classes = '';

        if (isset($item_settings['class'])) {
            $menu_classes .= $item_settings['class'] . ' ';
        }

        $menu_classes .= $item_settings['is_megamenu'] ? ' tb_megamenu' : '';
        $menu_classes .= !empty($categories) ? ' tb_multiple' : '';

        $is_megamenu = $menu_item['data']['settings']['is_megamenu'];


        $item_settings['wrapper_classes'] = '';
        $wrapper_classes = $item_settings['is_megamenu'] ? ' tb_listing tb_grid_view tb_style_1 tb_size_' . $item_settings['subcategory_cols'] : '';

        $item_settings['is_megamenu'] = false; // make it false for getCategorySubMenu

        $max_depth = (int) $item_settings['depth'];
        if (empty($max_depth) || $max_depth < 0) {
            $max_depth = 99;
        }

        $manufacturers = array();
        if ($item_settings['manufacturers_type'] != 'none') {
            $manufacturers = $this->getMenuItemManufacturers($item_settings);
        }

        return $this->extension->fetchTemplate('menu/all_categories', array(
            'categories'       => $categories,
            'manufacturers'    => $manufacturers,
            'max_depth'        => $max_depth,
            'settings'         => $item_settings,
            'menu_item_id'     => $menu_item['data']['id'],
            'is_megamenu'      => $is_megamenu,
            'menu_classes'     => ' ' . trim($menu_classes),
            'wrapper_classes'  => ' ' . trim($wrapper_classes),
            'categories_width' => 5 - (!empty($manufacturers) && $item_settings['manufacturers_position'] == 'column' ? 1 : 0),
            'toolImage'        => $this->getModel(),
            'url'              => $this->manager->getOcUrl()
        ) + $lang_vars);
    }

    protected function getCategoryInfo($menu_item)
    {
        $category = $this->getModel('category')->getTreeById($menu_item['data']['id']);
        if (false === $category) {
            return null;
        }

        $category['thumb'] = '';
        if ($menu_item['data']['settings']['show_main_thumbnail']) {
            $category['image'] ? $image = $category['image'] : $image = 'no_image.jpg';
            $category['thumb'] = (string) $this->getModel()->resizeImage($image, $this->manager->getOcConfig()->get('config_image_category_width'), $this->manager->getOcConfig()->get('config_image_category_height'));
        }

        return $category;
    }

    protected function fetchMenuPage($menu_item)
    {
        $page = $this->getModel('default')->getInformationPages($menu_item['data']['id']);

        if (false === $page) {
            return '';
        }

        return $this->extension->fetchTemplate('menu/page', array(
                'menu_item'        => $menu_item,
                'information_page' => $page,
                'url'              => $this->manager->getOcUrl())
        );
    }

    protected function fetchMenuManufacturers($menu_item)
    {
        $settings = $menu_item['data']['settings'];

        $manufacturers = $this->getMenuItemManufacturers($menu_item['data']['settings']);
        $sorted_manufacturers = array();
        foreach ($manufacturers as $brand) {
            $first_letter = substr($brand['name'], 0, 1);
            if (!isset($sorted_manufacturers[$first_letter])) {
                $sorted_manufacturers[$first_letter] = array();
            }

            $sorted_manufacturers[$first_letter][] = $brand;
        }

        $max_columns = (int) $settings['max_columns'];
        $per_column = round((count($manufacturers) + count($sorted_manufacturers)) / $max_columns);
        $columns = array();
        $i = 0;
        $column_items_cnt = 0;
        $distribution_type = 2;

        foreach ($sorted_manufacturers as $letter => $items) {
            if ($distribution_type == 1 && isset($columns[$i]) && $i != $max_columns-1 && ($column_items_cnt + count($items)+1 > $per_column)) {
                $i++;
                $column_items_cnt = 0;
            }

            $columns[$i][$letter] = $items;
            $column_items_cnt += count($items)+1;

            if ($distribution_type == 2 && $i != $max_columns-1 && ($column_items_cnt >= $per_column)) {
                $i++;
                $column_items_cnt = 0;
            }
        }

        return $this->extension->fetchTemplate('menu/manufacturers', array(
            'manufacturers' => $columns,
            'settings'      => $settings,
            'is_megamenu'   => isset($settings['is_megamenu']) && $settings['is_megamenu'],
            'url'           => $this->manager->getOcUrl()
        ));
    }

    protected function getMenuItemManufacturers($item_settings)
    {
        $options = array();

        if ($item_settings['manufacturers_type'] == 'custom' && isset($item_settings['manufacturers'])) {
            $options['manufacturer_ids'] = (array) $item_settings['manufacturers'];
        }

        $manufacturers = $this->getModel('manufacturer')->getManufacturers($options);

        return $this->modifyMenuItemManufacturers($manufacturers, $item_settings);
    }

    protected function modifyMenuItemManufacturers($manufacturers, $item_settings)
    {
        foreach ($manufacturers as &$manufacturer) {
            if ($item_settings['manufacturers_display'] != 'label' && $manufacturer['image']) {
                $manufacturer['image'] = (string) $this->getModel()->resizeImage($manufacturer['image'], $item_settings['image_size_x'], $item_settings['image_size_y']);
            } else {
                $manufacturer['image'] = false;
            }

            $manufacturer['display_name'] = ($item_settings['manufacturers_display'] != 'image');
        }

        return $manufacturers;
    }

    protected function fetchMenuUrl($menu_item)
    {
        $settings = $menu_item['data']['settings'];
        $menu_classes = isset($settings['class']) ? trim($settings['class']) : '';

        if (isset($menu_item['children']) && !empty($menu_item['children'])) {
            $menu_classes .= ' tb_multiple';
        }

        $url = isset($settings['url']) ? trim($settings['url']) : '';

        return $this->extension->fetchTemplate('menu/url', array(
            'menu_classes' => empty($menu_classes) ? '' : ' ' . $menu_classes,
            'menu_item'    => $menu_item,
            'url'          => !empty($url) ? $url : 'javascript:;',
            'url_title'    => isset($settings['url_title']) ? trim($settings['url_title']) : '',
            'target'       => $settings['target'],
            'label'        => $settings['label']
        ));
    }

    protected function fetchMenuHome($menu_item)
    {
        $menu_classes = isset($menu_item['data']['settings']['class']) ? trim($menu_item['data']['settings']['class']) : '';

        return $this->extension->fetchTemplate('menu/home', array(
            'menu_classes' => empty($menu_classes) ? '' : ' ' . $menu_classes,
            'menu_item'    => $menu_item,
            'home_url'     => $this->manager->getOcUrl()->link('common/home'),
            'display'      => $menu_item['data']['settings']['display']
        ));
    }

    protected function fetchMenuHtml($menu_item)
    {
        return str_replace('&', '&amp;', $this->extension->fetchTemplate('menu/html', array('menu_item' => $menu_item)));
    }

    protected function fetchMenuSystem($menu_item)
    {
        $page = $this->getModel()->getSystemMenuPagesLang($menu_item['data']['id']);

        if (false !== $page) {

            $settings = $menu_item['data']['settings'];
            $menu_classes = isset($settings['class']) ? trim($settings['class']) : '';

            if (isset($menu_item['children']) && !empty($menu_item['children'])) {
                $menu_classes .= ' tb_multiple';
            }

            $ssl = isset($page['ssl']) && $page['ssl'] ? 'SSL' : '';
            $menu_item['data']['url'] = $this->manager->getOcUrl()->link($page['route'], '', $ssl);

            return $this->extension->fetchTemplate('menu/system_page', array(
                'menu_item'    => $menu_item,
                'menu_classes' => empty($menu_classes) ? '' : ' ' . $menu_classes,
                'label'        => !empty($settings['label']) ? $settings['label'] : $page['title']
            ));
        }

        return '';
    }
}