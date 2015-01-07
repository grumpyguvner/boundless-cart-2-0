<?php

return array(
    'label'   => 'Products by manufacturer',
    'route'   => 'product/manufacturer/info',
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
                        'id' => 'tbR5xGZ',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW2nkX7Iw',
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
                        'id' => 'tbR5xGZ',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW2nkX7Iw',
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