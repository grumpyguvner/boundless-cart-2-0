<?php

return array(
    'label'   => 'Product Category',
    'route'   => 'product/category',
    'display' => false,
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
            'label'  => 'Category thumb',
            'slot'   => 'category_thumb',
            'areas'  => 'content, intro',
            'locked' => false
        ),
        3 => array(
            'label'  => 'Category description',
            'slot'   => 'category_description',
            'areas'  => 'content, intro',
            'locked' => false
        ),
        4 => array(
            'label'  => 'Subcategories',
            'slot'   => 'subcategory_listing',
            'areas'  => 'content',
            'class'  => 'Theme_SubcategoriesSystemWidget',
            'locked' => true
        ),
        5 => array(
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
                        'id' => 'tbR0xGV',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW0nkX5Gu',
                                        'label'    => 'Category description',
                                        'slot'     => 'category_description',
                                        'settings' => array(
                                            'common' => array(
                                                'layout' => array(
                                                    'margin_bottom' => 30
                                                )
                                            )
                                        )
                                    ),
                                    1 => array(
                                        'id'       => 'tbW1nkX6Hv',
                                        'label'    => 'Subcategories',
                                        'slot'     => 'subcategory_listing',
                                        'class'    => 'Theme_SubcategoriesSystemWidget',
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
                                    2 => array(
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
                        'id' => 'tbR0xG4V',
                        'columns' => array(
                            0 => array(
                                'grid_proportion' => '1_1',
                                'widgets' => array(
                                    0 => array(
                                        'id'       => 'tbW0nkX5Gu',
                                        'label'    => 'Category description',
                                        'slot'     => 'category_description',
                                        'settings' => array(
                                            'common' => array(
                                                'layout' => array(
                                                    'margin_bottom' => 30
                                                )
                                            )
                                        )
                                    ),
                                    1 => array(
                                        'id'       => 'tbW1nkX6Hv',
                                        'label'    => 'Subcategories',
                                        'slot'     => 'subcategory_listing',
                                        'class'    => 'Theme_SubcategoriesSystemWidget',
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
                                    2 => array(
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