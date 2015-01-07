<?php

class FireSlider_Catalog_Extension extends TB_CatalogExtension
{
    public function configure()
    {
        $this->themeData->registerStylesheetResource('mightyslider.css', $this, array(
            '../img/' => '../../../tb_themes/' . $this->context->getBasename() . '/extension/fire_slider/catalog/view/img/'
        ));
    }

    public function registerResources()
    {
        //$this->themeData->registerJavascriptResource('tweenlite.js', $this);
        $this->themeData->registerJavascriptResource('mightyslider.min.js', $this);
        //$this->themeData->registerJavascriptResource('mightyslider.js', $this);
    }

    public function isCoreExtension()
    {
        return true;
    }
}