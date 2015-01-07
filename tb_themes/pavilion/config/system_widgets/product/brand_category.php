<?php

return array(
    'label'   => 'Products by category and manufacturer',
    'route'   => 'category/manufacturer',
    'display' => true,
    'widgets' => array(
        0  => array(
            'label'  => 'Breadcrumbs',
            'slot'   => 'breadcrumbs',
            'areas'  => 'intro, content',
            'locked' => false
        ),
        1 => array(
            'label'  => 'Page title',
            'slot'   => 'page_title',
            'areas'  => 'intro, content',
            'locked' => false
        ),
        2 => array(
            'label'  => 'Brand thumb',
            'slot'   => 'brand_thumb',
            'areas'  => 'content, intro',
            'locked' => false
        ),
        3 => array(
            'label'  => 'Products',
            'slot'   => 'products',
            'areas'  => 'content',
            'class'  => 'Theme_ProductsSystemWidget',
            'locked' => true
        )
    ),
    'default' => array(

/////////////////////////////////////
//   FULL  WIDTH
/////////////////////////////////////

        'full'  => array(
            // CONTENT AREA
            'content' => array(
                'respect_global_record' => 0,
                'settings' => array(
                    'layout' => array(
                        'type'           => 'full',
                        'margin_bottom'  => 30
                    )
                ),
                'rows' => array(
                    0 => array(
                        'id' => 'tbR0w9xs',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW0qpX6Ra',
                                        'label'    => 'Products',
                                        'slot'     => 'products',
                                        'class'    => 'Theme_ProductsSystemWidget'
                                    )
                                )
                            )
                        ),
                        'settings' => array(
                            'layout' => array(
                                'margin_bottom'  => 0,
                            )
                        )
                    )
                )
            )
        ),

/////////////////////////////////////
//   FIXED  WIDTH
/////////////////////////////////////

        'fixed' => array(
            // CONTENT AREA
            'content' => array(
                'respect_global_record' => 0,
                'settings' => array(
                    'layout' => array(
                        'type'           => 'full',
                        'margin_bottom'  => 30
                    )
                ),
                'rows' => array(
                    0 => array(
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW0qpX6Ra',
                                        'label'    => 'Products',
                                        'slot'     => 'products',
                                        'class'    => 'Theme_ProductsSystemWidget'
                                    )
                                )
                            )
                        ),
                        'settings' => array(
                            'layout' => array(
                                'margin_bottom'  => 0,
                            )
                        )
                    )
                )
            )
        )
    )
);