<?php

require_once dirname(__FILE__) . '/../../model/layoutBuilderModel.php';

class Theme_Catalog_LayoutBuilderModel extends Theme_LayoutBuilderModel
{
    public function filterRowSettings(array &$row_settings)
    {
        $this->filterSettings($row_settings, 'widgets_row');
    }
}