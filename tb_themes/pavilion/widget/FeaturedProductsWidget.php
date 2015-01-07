<?php

class Theme_FeaturedProductsWidget extends AbstractProductsListingWidget
{
    protected $areas = array('footer', 'intro', 'content', 'column_left', 'column_right');
    protected $products = null;

    public function onFilter(array &$settings)
    {
        $langVars = array(
            'is_active'   => 1,
            'title'       => 'Featured Products',
            'title_align' => 'left'
        );
        $settings = array_replace($settings, $this->initLangVars($langVars, $settings));

        $default_vars = array(
            'product_ids' => array()
        );
        $settings = array_replace($settings, $this->initFlatVars($default_vars, $settings));
    }

    public function render(array $view_data = array())
    {
        return empty($this->settings['product_ids']) ? '' : parent::render($view_data);
    }

    public function getProductIds()
    {
        return $this->settings['product_ids'];
    }

    protected function getProductsListing(array $options = array())
    {
        if (null === $this->products) {
            if (empty($this->settings['product_ids'])) {
                $this->products = array();

                return array();
            }

            if (empty($options)) {
                $options = array(
                    'product_ids'     => $this->settings['product_ids'],
                    'sort'            => 'p.date_added',
                    'order'           => 'DESC',
                    'secondary_image' => false
                );
            }

            $this->products = parent::getProductsListing($options);
        }

        return $this->products;
    }
}