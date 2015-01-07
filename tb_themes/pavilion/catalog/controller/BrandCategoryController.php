<?php

class Theme_Catalog_BrandCategoryController extends TB_CatalogController
{
    public function index()
    {
        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/category');

        $category_id = (int) $this->getArrayKey('c_id', $this->request->get, 0);
        $category_info = $this->model_catalog_category->getCategory($category_id);

        $manufacturer_id = (int) $this->getArrayKey('man_id', $this->request->get, 0);
        $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);

        if (!$category_info || !$manufacturer_info || $category_id == 0 || $manufacturer_id == 0) {
            return false;
        }

        $this->document->setTitle($category_info['name'] . ' / ' . $manufacturer_info['name']);
        $this->document->setDescription($category_info['meta_description']);
        $this->document->setKeywords($category_info['meta_keyword']);

        $this->data = array_merge(
            $this->data,
            $this->language->load('product/category'),
            $this->language->load('product/manufacturer'),
            $this->language->load('product/compare')
        );

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'href'      => $this->url->link('common/home'),
            'text'      => $this->language->get('text_home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'href'      => $this->url->link('product/category', 'path=' . $category_id),
            'text'      => $category_info['name'],
            'separator' => $this->language->get('text_separator')
        );

        $this->data['category_name']     = $category_info['name'];
        $this->data['manufacturer_name'] = $manufacturer_info['name'];
        $this->data['text_compare']      = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));

        $this->data['breadcrumbs'][] = array(
            'href'      => html_entity_decode($_SERVER['REQUEST_URI']),
            'text'      => $manufacturer_info['name'],
            'separator' => $this->language->get('text_separator')
        );

        $this->data['thumb'] = '';
        if ($manufacturer_info['image']) {
            $this->data['thumb'] = $this->getOcModel('tool/image')->resize($manufacturer_info['image'], 80, 80);
        }

        $options = array();

        $options['limit'] = $this->getArrayKey('limit', $this->request->get, $this->config->get($this->manager->gteOc2() ? 'config_product_limit' : 'config_catalog_limit'));
        $options['page']  = $this->getArrayKey('page', $this->request->get, 1);
        $options['sort']  = $this->getArrayKey('sort', $this->request->get, 'p.sort_order');
        $options['order'] = $this->getArrayKey('order', $this->request->get, 'ASC');
        $options['start'] = ($options['page'] - 1) * $options['limit'];
        $options['manufacturer_id'] = $manufacturer_id;
        $options['category_id'] = $category_id;
        $options['secondary_image'] = in_array($this->manager->getThemeData()->category_products_current['thumbs_hover_action'], array('overlay', 'flip'));

        $product_total = $this->getModel('products')->getTotalProductsByManufacturerAndCategory($manufacturer_id, $category_id);
        $products = $this->getModel('products')->getProductsByManufacturerAndCategory($options);

        foreach ($products as &$product) {

            $price = ($product['discount'] ? $product['discount'] : $product['price']);
            $product['price_num'] = $price;

            if (($this->config->get('config_customer_price') && $this->manager->getOcCustomer()->isLogged()) || !$this->config->get('config_customer_price')) {
                $tax = $this->manager->getOcTax()->calculate($price, $product['tax_class_id'], $this->config->get('config_tax'));
                $product['price'] = $this->manager->getOcCurrency()->format($tax);
            } else {
                $product['price'] = false;
            }

            $product['special_num'] = (float) $product['special'];

            if ($product['special_num']) {
                $tax = $this->manager->getOcTax()->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax'));
                $product['special'] = $this->manager->getOcCurrency()->format($tax);
            } else {
                $product['special'] = false;
            }

            $product['secondary_image'] = $options['secondary_image'] ? $product['secondary_image'] : false;
            $product['reviews'] = sprintf($this->data['text_reviews'], (int) $product['reviews']);
            $product['href'] = $this->url->link('product/product', 'product_id=' . $product['product_id']);
        }

        $this->manager->getThemeExtension()->getPlugin('product')->addProductData($products, $this->themeData->category_products_current);
        $this->data['products'] = $products;

        $current_url = $this->themeData->link($this->getRouteByName('category_manufacturer'), 'c_id=' . $category_id . '&man_id=' . $manufacturer_id);

        $sorts_url = $current_url;
        if (isset($this->request->get['limit'])) {
            $sorts_url .= '&limit=' . (int) $this->request->get['limit'];
        }
        $this->data['sorts'] = $this->getModel('products')->getSorts($sorts_url);

        $limits_url = $current_url;
        if (isset($this->request->get['sort'])) {
            $limits_url .= '&sort=' . (string) $this->request->get['sort'];
        }
        if (isset($this->request->get['order'])) {
            $limits_url .= '&order=' . (string) $this->request->get['order'];
        }
        $this->data['limits'] = $this->getModel('products')->getLimits($limits_url);


        $pagination_url = $limits_url;
        if (isset($this->request->get['limit'])) {
            $pagination_url .= '&limit=' . (int) $this->request->get['limit'];
        }

        $pagination = new Pagination();
        $pagination->total = $product_total;
        $pagination->page  = $options['page'];
        $pagination->limit = $options['limit'];
        $pagination->text  = $this->language->get('text_pagination');
        $pagination->url   = $pagination_url . '&page={page}';

        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $options['sort'];
        $this->data['order'] = $options['order'];
        $this->data['limit'] = $options['limit'];
        $this->data['url_list_listing_type'] = $pagination_url . '&setProductListingType=list&page=' . $options['page'];
        $this->data['url_grid_listing_type'] = $pagination_url . '&setProductListingType=grid&page=' . $options['page'];
        $this->data['url_product_compare'] = $this->url->link('product/compare');

        $heading_title = $this->translate('text_manufacturer_products');
        $heading_title = str_replace('{{manufacturer}}', $manufacturer_info['name'], $heading_title);
        $heading_title = str_replace('{{category}}', $category_info['name'], $heading_title);
        $this->data['heading_title'] = $heading_title;

        $this->renderTemplate('tb/brand_category');
    }
}