<?php

return array(
    'label'   => 'Product',
    'route'   => 'product/product',
    'display' => false,
    'widgets' => array(
        0  => array(
            'label' => 'Breadcrumbs',
            'slot'  => 'breadcrumbs',
            'areas' => 'intro, content'
        ),
        1 => array(
            'label' => 'Page title',
            'slot'  => 'page_title',
            'areas' => 'intro, content'
        ),
        2 => array(
            'label' => 'Page content',
            'slot'  => 'page_content',
            'areas' => 'content',
            'class'  => 'Theme_PageContentProductSystemWidget',
            'locked' => true
        ),
        3 => array(
            'label'  => 'Related Products',
            'slot'   => 'related_products',
            'areas'  => 'content',
            'class'  => 'Theme_RelatedProductsSystemWidget',
            'locked' => true
        )
    ),
    'default' => array(
        'content' => array(
            'respect_global_record' => 0,
            'global_widgets' => array(
                0 => array(
                    'label'    => 'Breadcrumbs',
                    'slot'     => 'breadcrumbs',
                    'locked'   => false,
                    'settings' => array()
                ),
                1 => array(
                    'label'    => 'Page title',
                    'slot'     => 'page_title',
                    'locked'   => false,
                    'settings' => array()
                ),
                2 => array(
                    'label'    => 'Page Content',
                    'slot'     => 'page_content',
                    'locked'   => true,
                    'settings' => array()
                )
            ),
            'rows' => array(
                0 => array(
                    'id' => 'tbR0g7vz',
                    'columns' => array(
                        0 => array(
                            'grid_proportion' => '1_1',
                            'widgets'         => array(
                                0 => array(
                                    'id'       => 'tbW0yqLP2t',
                                    'label'    => 'Page Content',
                                    'slot'     => 'page_content',
                                    'class'    => 'Theme_PageContentProductSystemWidget',
                                    'settings' => array(
                                        'common' => array(
                                            'colors' => array(
                                                'forms' => array(
                                                    'input_bg' => array(
                                                        'color'   => '#ffffff',
                                                        'inherit' => 0
                                                    ),
                                                    'input_bg_hover' => array(
                                                        'color'   => '#ffffff',
                                                        'inherit' => 0
                                                    ),
                                                    'input_bg_focus' => array(
                                                        'color'   => '#ffffff',
                                                        'inherit' => 0
                                                    ),
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    ),
                    'settings' => array(
                        'layout' => array(
                            'margin_bottom'   => 0,
                        )
                    )
                ),
                1 => array(
                    'id' => 'tbR1g7wa',
                    'columns' => array(
                        0 => array(
                            'grid_proportion' => '1_1',
                            'widgets'         => array(
                                0 => array(
                                    'id'     => 'tbW0sqLZ4f',
                                    'label'  => 'Related Products',
                                    'slot'   => 'related_products',
                                    'class'  => 'Theme_RelatedProductsSystemWidget',
                                    'settings' => array(
                                        'slider'              => 1,
                                        'slider_step'         => 1,
                                        'slider_speed'        => 500,
                                        'slider_pagination'   => 0,
                                        'slider_nav_position' => 'top'
                                    )
                                )
                            )
                        )
                    ),
                    'settings' => array(
                        'layout' => array(
                            'margin_top'   => 30,
                        )
                    )
                )
            )
        )
    )
);