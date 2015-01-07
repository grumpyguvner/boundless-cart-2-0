<?php

class Theme_Admin_ExtensionsPlugin extends TB_ExtensionPlugin
{
    public function setDataForView($theme_settings, TB_ViewDataBag $themeData)
    {
        $themeData->importVars(array(
            'not_installed_extensions' => $this->manager->getNotInstalledExtensions(),
            'installed_extensions'     => $this->manager->getExtensions()
        ));
    }
}