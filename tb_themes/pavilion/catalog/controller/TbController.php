<?php

class Theme_Catalog_TbController extends TB_CatalogController
{
    public function getProductPrice()
    {
        $product_id = (int) $this->getArrayKey('product_id', $this->request->post, 0);
        $result = array();

        if ($product = $this->getOcModel('catalog/product')->getProduct($product_id)) {

            $cart = $this->manager->getOcCart();
            $profile_id = (int) $this->getArrayKey('profile_id', $this->request->post, 0);
            $cart_session = $this->session->data['cart'];

            $cart->clear();

            $quantity = (int) $this->getArrayKey('quantity', $this->request->post, 1);
            $option = array_filter($this->getArrayKey('option', $this->request->post, array()));

            $cart->add($product_id, $quantity, $option, $profile_id);

            $price = $product['special'] ? $this->tax->calculate($cart->getSubTotal() + ($product['price'] - $product['special']), $product['tax_class_id'], $this->config->get('config_tax')) : $cart->getTotal();

            $result['price']    = $this->themeData->priceFormat($this->currency->format($price));
            $result['special']  = $this->themeData->priceFormat($this->currency->format($cart->getTotal()));
            $result['subtotal'] = $this->currency->format($cart->getSubTotal());

            $cart->clear();

            $this->session->data['cart'] = $cart_session;
        } else {
            $result['error'] = 'Invalid product';
        }

        $this->response->setOutput(json_encode($result));
    }

    public function getAreaCss()
    {
        $this->response->setOutput($this->themeData->theme_css_text);
    }
}