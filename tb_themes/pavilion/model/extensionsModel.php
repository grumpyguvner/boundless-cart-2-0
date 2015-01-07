<?php

class Theme_ExtensionsModel extends TB_ExtensionModel
{
    public function isExtensionInstalled($name)
    {
        return isset($this->settingsModel['extensions'][$name]);
    }
}