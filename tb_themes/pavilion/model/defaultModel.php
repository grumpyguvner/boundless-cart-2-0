<?php

class Theme_DefaultModel extends TB_ExtensionModel
{
    public function getLayouts()
    {
        $sql = "SELECT * FROM " . DB_PREFIX . "layout";
        $query = $this->db->query($sql);

        $result = array();
        foreach ($query->rows as $row) {
            $result[$row['layout_id']] = $row;
        }

        return $result;
    }

    public function getLayoutIdByName($layout_name)
    {
        static $layouts = array();

        if (isset($layouts[$layout_name])) {
            return $layouts[$layout_name];
        }

        $sql = "SELECT layout_id FROM " . DB_PREFIX . "layout WHERE LOWER(name) = '" . $this->db->escape(strtolower($layout_name)) . "'";
        $query = $this->db->query($sql);

        $layouts[$layout_name] = isset($query->row['layout_id']) ? (int) $query->row['layout_id'] : 0;

        return $layouts[$layout_name];
    }

    public function getLayoutNameById($layout_id)
    {
        static $layouts = array();

        if (!isset($layouts[$layout_id])) {
            $layouts[$layout_id] = $this->db->query('SELECT name FROM ' . DB_PREFIX . 'layout WHERE layout_id = ' . (int) $layout_id)->row['name'];
        }

        return $layouts[$layout_id];
    }

    public function getInformationPages($id = null)
    {
        static $pages = null;

        if (null === $pages) {
            $sql = 'SELECT *
                    FROM ' . DB_PREFIX . 'information i
                    LEFT JOIN ' . DB_PREFIX . 'information_description id ON (i.information_id = id.information_id)
                    LEFT JOIN ' . DB_PREFIX . 'information_to_store i2s ON (i.information_id = i2s.information_id)
                    WHERE id.language_id = ' . $this->context->getCurrentLanguage('id') . '
                          AND i2s.store_id = ' . $this->context->getStoreId() . '
                          AND i.status = 1
                          ORDER BY i.sort_order, LCASE(id.title) ASC';

            $pages = array();
            foreach ($this->db->query($sql)->rows as $page) {
                $page['id'] = $page['information_id'];
                $pages[$page['information_id']] = $page;
            }
        }

        if (null !== $id) {
            return isset($pages[$id]) ? $pages[$id] : false;
        }

        return $pages;
    }

    public function getStockStatuses()
    {
        $stock_status_data = $this->manager->getOcCache()->get('stock_status.' . $this->context->getCurrentLanguage('id'));

        if (!$stock_status_data) {
            $query = $this->db->query("SELECT stock_status_id, name FROM " . DB_PREFIX . "stock_status WHERE language_id = '" . $this->context->getCurrentLanguage('id') . "' ORDER BY name");

            $stock_status_data = $query->rows;

            $this->manager->getOcCache()->set('stock_status.' . $this->context->getCurrentLanguage('id'), $stock_status_data);
        }

        return $stock_status_data;
    }

    public function getInstalledOcModules()
    {
        if ($this->manager->gteOc2()) {
            return $this->getOcModel('extension/extension')->getInstalled('module');
        } else {
            return $this->getOcModel('setting/extension')->getInstalled('module');
        }
    }

    public function getPresentationConfig($key = null)
    {
        if (!isset($this->settings['presentation_config'])) {
            $this->settings['presentation_config'] = array(
                'common' => array(
                    'form'       => ' tb_border_str_1',
                    'submit_row' => ' tb_border_str_2',
                )
            );
        }

        return null === $key ? $this->settings['presentation_config'] : $this->settings['presentation_config'][$key];
    }

    public function getProductOptionStyles()
    {
        return array(
            'style_1' => 'Default',
            'style_2' => 'Button'
        );
    }

    public function getProductDesignOptions()
    {
        return array(
            'design_1' => 'Design 1',
            'design_2' => 'Design 2',
            'design_3' => 'Design 3',
            'design_4' => 'Design 4',
        );
    }

    public function getProductDesign($key, $data)
    {
        $designs = array();

        $designs['design_1'] = array(
            'rows' => array(
                1 => array(
                    'class'   => ' tb_row_fixed tb_sep',
                    'columns' => array(
                        1 => array(
                            'width'   => 'product_column_left',
                            'class'   => '',
                            'rows'    => array(),
                            'slots'   => array('product_images'),
                            'tabs'    => array()
                        ),
                        2 => array(
                            'width'   => 'product_column_right',
                            'class'   => '',
                            'rows'    => array(
                                1 => array(
                                    'class'   => ' tb_row_fixed tb_reverse tb_sep tb_gut_0',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '3_8',
                                            'class'   => '',
                                            'slots'   => array('product_price'),
                                            'tabs'    => array()
                                        ),
                                        2 => array(
                                            'width'   => '5_8',
                                            'class'   => '',
                                            'slots'   => array('product_info', 'product_reviews_summary'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                3 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('product_options', 'product_buy'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                4 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('separator_border'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                5 => array(
                                    'class'   => ' tb_row_fixed',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('product_share'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                            ),
                            'slots'   => array(),
                            'tabs'    => array()
                        ),
                    )
                ),
                2 => array(
                    'class'   => ' tb_row_fixed',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_1',
                            'class'   => '',
                            'rows'    => array(),
                            'slots'   => array(),
                            'tabs_settings' => array('class' => ' tb_style_2 tb_ip_5'),
                            'tabs'    => array(
                                1 => array(
                                    'type'   => 'tab',
                                    'title'  => $data['tab_description'],
                                    'id'     => 'tab_product_description',
                                    'slots'   => array('product_description', 'product_tags')
                                ),
                                2 => array(
                                    'type'   => 'tab',
                                    'title'  => $data['tab_attribute'],
                                    'id'     => 'tab_product_attributes',
                                    'slots'   => array('product_attributes')
                                ),
                                3 => array(
                                    'type'   => 'tab',
                                    'title'  => $this->extension->translate('text_product_tab_reviews'),
                                    'id'     => 'tab_product_reviews',
                                    'slots'   => array('product_reviews')
                                ),
                                4 => array(
                                    'type'   => 'tab',
                                    'title'  => $this->extension->translate('text_product_tab_discounts'),
                                    'id'     => 'tab_product_discounts',
                                    'slots'   => array('product_discounts')
                                ),
                            )
                        )
                    )
                )
            )
        );

        if ($key == 'design_1') {
            return $designs['design_1'];
        }

        $designs['design_2'] = array(
            'rows' => array(
                1 => array(
                    'class'   => ' tb_row_fixed',
                    'columns' => array(
                        1 => array(
                            'width'   => 'product_column_left',
                            'class'   => '',
                            'rows'    => array(),
                            'slots'   => array('product_images'),
                            'tabs'    => array()
                        ),
                        2 => array(
                            'width'   => 'product_column_right',
                            'class'   => '',
                            'rows'    => array(
                                1 => array(
                                    'class'   => ' tb_row_fixed tb_reverse tb_mb_10 tb_gut_0',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '3_8',
                                            'class'   => '',
                                            'slots'   => array('product_price'),
                                            'tabs'    => array()
                                        ),
                                        2 => array(
                                            'width'   => '5_8',
                                            'class'   => '',
                                            'slots'   => array('product_info'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                2 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('product_reviews_summary'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                3 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('product_options', 'product_buy'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                4 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('separator_border'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                5 => array(
                                    'class'   => ' tb_row_fixed',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array(),
                                            'tabs_settings' => array('class' => ' tb_style_2 tb_ip_5'),
                                            'tabs'    => array(
                                                1 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $data['tab_description'],
                                                    'id'     => 'tab_product_description',
                                                    'slots'   => array('product_description', 'separator_plain', 'product_tags', 'separator_plain', 'product_share')
                                                ),
                                                2 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $data['tab_attribute'],
                                                    'id'     => 'tab_product_attributes',
                                                    'slots'   => array('product_attributes')
                                                ),
                                                3 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $this->extension->translate('text_product_tab_reviews'),
                                                    'id'     => 'tab_product_reviews',
                                                    'slots'   => array('product_reviews')
                                                ),
                                                4 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $this->extension->translate('text_product_tab_discounts'),
                                                    'id'     => 'tab_product_discounts',
                                                    'slots'   => array('product_discounts')
                                                ),
                                            )
                                        )
                                    )
                                ),
                            ),
                            'slots'   => array(),
                            'tabs'    => array()
                        ),
                    )
                )
            )
        );

        if ($key == 'design_2') {
            return $designs['design_2'];
        }

        $designs['design_3'] = array(
            'rows' => array(
                1 => array(
                    'class'   => ' tb_row_fixed tb_sep',
                    'columns' => array(
                        1 => array(
                            'width'         => 'product_column_left',
                            'class'         => '',
                            'rows'          => array(),
                            'slots'         => array('product_images'),
                            'tabs_settings' => array(),
                            'tabs'          => array()
                        ),
                        2 => array(
                            'width'   => 'product_column_right',
                            'class'   => '',
                            'rows'    => array(
                                1 => array(
                                    'class'   => ' tb_row_fixed',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_1',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('breadcrumbs', 'page_title', 'product_reviews_summary')
                                        )
                                    )
                                ),
                                2 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('separator_border'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                3 => array(
                                    'class'   => ' tb_row_fixed tb_reverse tb_gut_0 tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_3',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('product_price')
                                        ),
                                        2 => array(
                                            'width'         => '2_3',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('product_info')
                                        )
                                    )
                                ),
                                4 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_1',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('product_options', 'product_buy')
                                        )
                                    )
                                ),
                                5 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('separator_border'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                6 => array(
                                    'class'   => ' tb_row_fixed',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('product_share'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                            ),
                            'tabs_settings' => array(),
                            'tabs'          => array(),
                            'slots'         => array()
                        )
                    )
                ),
                2 => array(
                    'class'   => ' tb_row_fixed',
                    'columns' => array(
                        1 => array(
                            'width'         => '1_1',
                            'class'         => '',
                            'rows'          => array(),
                            'slots'         => array(),
                            'tabs_settings' => array('class' => ' tb_style_2 tb_ip_5'),
                            'tabs'          => array(
                                1 => array(
                                    'type'   => 'tab',
                                    'title'  => $data['tab_description'],
                                    'id'     => 'tab_product_description',
                                    'slots'   => array('product_description', 'product_tags')
                                ),
                                2 => array(
                                    'type'   => 'tab',
                                    'title'  => $data['tab_attribute'],
                                    'id'     => 'tab_product_attributes',
                                    'slots'   => array('product_attributes')
                                ),
                                3 => array(
                                    'type'   => 'tab',
                                    'title'  => $this->extension->translate('text_product_tab_reviews'),
                                    'id'     => 'tab_product_reviews',
                                    'slots'   => array('product_reviews')
                                ),
                                4 => array(
                                    'type'   => 'tab',
                                    'title'  => $this->extension->translate('text_product_tab_discounts'),
                                    'id'     => 'tab_product_discounts',
                                    'slots'   => array('product_discounts')
                                )
                            )
                        )
                    )
                )
            )
        );

        if ($key == 'design_3') {
            return $designs['design_3'];
        }

        $designs['design_4'] = array(
            'rows' => array(
                1 => array(
                    'class'   => ' tb_row_fixed',
                    'columns' => array(
                        1 => array(
                            'width'         => 'product_column_left',
                            'class'         => '',
                            'rows'          => array(),
                            'slots'         => array('product_images'),
                            'tabs_settings' => array(),
                            'tabs'          => array()
                        ),
                        2 => array(
                            'width'   => 'product_column_right',
                            'class'   => '',
                            'rows'    => array(
                                1 => array(
                                    'class'   => ' tb_row_fixed',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_1',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('breadcrumbs', 'page_title', 'product_reviews_summary')
                                        )
                                    )
                                ),
                                2 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('separator_border'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                3 => array(
                                    'class'   => ' tb_row_fixed tb_reverse tb_gut_0 tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_3',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('product_price')
                                        ),
                                        2 => array(
                                            'width'         => '2_3',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('product_info')
                                        )
                                    )
                                ),
                                4 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_1',
                                            'class'         => '',
                                            'tabs_settings' => array(),
                                            'tabs'          => array(),
                                            'slots'         => array('product_options', 'product_buy')
                                        )
                                    )
                                ),
                                5 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('separator_border'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                                6 => array(
                                    'class'   => ' tb_row_fixed tb_sep',
                                    'columns' => array(
                                        1 => array(
                                            'width'         => '1_1',
                                            'class'         => '',
                                            'rows'          => array(),
                                            'slots'         => array(),
                                            'tabs_settings' => array('class' => ' tb_style_2 tb_ip_5'),
                                            'tabs'          => array(
                                                1 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $data['tab_description'],
                                                    'id'     => 'tab_product_description',
                                                    'slots'   => array('product_description', 'product_tags')
                                                ),
                                                2 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $data['tab_attribute'],
                                                    'id'     => 'tab_product_attributes',
                                                    'slots'   => array('product_attributes')
                                                ),
                                                3 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $this->extension->translate('text_product_tab_reviews'),
                                                    'id'     => 'tab_product_reviews',
                                                    'slots'   => array('product_reviews')
                                                ),
                                                4 => array(
                                                    'type'   => 'tab',
                                                    'title'  => $this->extension->translate('text_product_tab_discounts'),
                                                    'id'     => 'tab_product_discounts',
                                                    'slots'   => array('product_discounts')
                                                )
                                            )
                                        )
                                    )
                                ),
                                7 => array(
                                    'class'   => ' tb_row_fixed',
                                    'columns' => array(
                                        1 => array(
                                            'width'   => '1_1',
                                            'class'   => '',
                                            'slots'   => array('product_share'),
                                            'tabs'    => array()
                                        )
                                    )
                                ),
                            ),
                            'tabs_settings' => array(),
                            'tabs'          => array(),
                            'slots'         => array()
                        )
                    )
                )
            )
        );

        if ($key == 'design_4') {
            return $designs['design_4'];
        }

        return $designs;
    }
}