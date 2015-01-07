<?php

return array(
    'label'   => 'Search page',
    'route'   => 'product/search',
    'display' => true,
    'ssl'     => false,
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
            'label'  => 'Search form',
            'slot'   => 'search_box',
            'areas'  => 'content',
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
                        'id' => 'tbR0aV9P',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW0laM1tu',
                                        'label'    => 'Search form',
                                        'slot'     => 'search_box',
                                        'settings' => array(
                                            'common' => array(
                                                'layout' => array(
                                                    'margin_bottom'  => 30,
                                                    'padding_bottom' => 30,
                                                ),
                                                'border' => array(
                                                    'bottom' => array(
                                                        'width'   => 1,
                                                        'style'   => 'solid',
                                                        'color'   => '#dddddd',
                                                        'opacity' => 100
                                                    )
                                                )
                                            )
                                        )
                                    ),
                                    1 => array(
                                        'id'       => 'tbW1laM2uv',
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
                        'id' => 'tbR0aV9P',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW0laM1tu',
                                        'label'    => 'Search form',
                                        'slot'     => 'search_box',
                                        'settings' => array(
                                            'common' => array(
                                                'layout' => array(
                                                    'margin_bottom'  => 30,
                                                    'padding_bottom' => 30,
                                                ),
                                                'border' => array(
                                                    'bottom' => array(
                                                        'width'   => 1,
                                                        'style'   => 'solid',
                                                        'color'   => '#dddddd',
                                                        'opacity' => 100
                                                    )
                                                )
                                            )
                                        )
                                    ),
                                    1 => array(
                                        'id'       => 'tbW1laM2uv',
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