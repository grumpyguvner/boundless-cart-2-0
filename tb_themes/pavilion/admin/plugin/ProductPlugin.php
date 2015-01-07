<?php

class Theme_Admin_ProductPlugin extends TB_ExtensionPlugin implements TB_AdminDataPlugin
{
    public function getConfigKey()
    {
        return 'product';
    }

    public function filterSettings(array &$product_settings)
    {
        $default_vars = array(
            'gallery_zoom'        => 1,
            'gallery_zoom_action' => 'click',
            'fullscreen_gallery'  => 1,
            'button_facebook'     => 1,
            'button_twitter'      => 1,
            'button_google'       => 1,
            'button_pinterest'    => 0,
            'button_stumbleupon'  => 0,
            'button_linkedin'     => 0,
            'button_custom'       => '',
            'designs'             => array(
                'layout' => array(),
                'option' => array()
            )
        );

        foreach ($this->getProductOptions() as $option_id => $option) {
            if (!isset($default_vars['designs']['option'][$option_id])) {
                $default_vars['designs']['option'][$option_id] = array(
                    'style_id' => 'style_1'
                );
                if ($option['type'] == 'image') {
                    $default_vars['designs']['option'][$option_id]['image_width']  = 22;
                    $default_vars['designs']['option'][$option_id]['image_height'] = 22;
                }
            }
        }

        $product_settings = TB_FormHelper::initFlatVarsSimple($default_vars, $product_settings);
        $product_settings['designs'] = TB_FormHelper::initFlatVarsSimple($default_vars['designs'], $product_settings['designs']);
    }

    public function setDataForView(&$plugin_settings, TB_ViewDataBag $themeData)
    {
        $themeData->product_designs = $this->getModel()->getProductDesignOptions();
        $themeData->product_options = $this->getProductOptions();
        $themeData->product_option_styles = $this->getModel()->getProductOptionStyles();

        foreach ($themeData->product_options as $option_id => $option) {
            if (!isset($plugin_settings['designs']['option'][$option_id])) {
                $plugin_settings['designs']['option'][$option_id]['style_id'] = 'style_1';
                if ($option['type'] == 'image') {
                    $plugin_settings['designs']['option'][$option_id]['image_width']  = 22;
                    $plugin_settings['designs']['option'][$option_id]['image_height'] = 22;
                }
            }
        }
    }

    protected function getProductOptions()
    {
        return $this->getModel()->getProductOptions((array('checkbox', 'radio', 'image')));
    }

    public function saveData($post_data)
    {
        return array(
            $this->getConfigKey() => $post_data[$this->getConfigKey()]
        );
    }
}