<?php

class Theme_Catalog_HeaderPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_ViewDataBag $themeData, Request $request)
    {
        $this->bootstrap('common');

        // Layout 1
        $layout1 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_middle tb_mb_30 tb_pt_5 tb_pb_5 tb_pl_30 tb_pr_30 tbSystemRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_2',
                            'class'   => '',
                            'slots'   => array('welcome')
                        ),
                        2 => array(
                            'width'   => '1_2',
                            'class'   => ' align_right',
                            'slots'   => array('currency', 'language')
                        )
                    )
                ),
                2 => array(
                    'class' => ' tb_row_full tb_row_table tb_gut_40 tb_mb_30 tb_pl_30 tb_pr_30 tbLogoRow tbMenuRow',
                    'columns' => array(
                        1 => array(
                            'width'   => 'auto',
                            'class'   => ' valign_middle',
                            'slots'   => array('logo')
                        ),
                        2 => array(
                            'width'   => '1_1',
                            'class'   => ' valign_middle',
                            'slots'   => array('user_navigation', 'separator_border', 'main_navigation')
                        ),
                        3 => array(
                            'width'   => '1_5',
                            'class'   => ' valign_middle',
                            'slots'   => array('search', 'cart_menu')
                        )
                    )
                ),
            )
        );

        // Layout 2
        $layout2 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_middle tb_mb_30 tb_pt_5 tb_pb_5 tb_pl_30 tb_pr_30 tbSystemRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_2',
                            'class'   => '',
                            'slots'   => array('welcome')
                        ),
                        2 => array(
                            'width'   => '1_2',
                            'class'   => ' align_right',
                            'slots'   => array('currency', 'language')
                        )
                    )
                ),
                2 => array(
                    'class' => ' tb_row_full tb_row_separate tb_plain tb_mb_30 tb_pl_30 tb_pr_30 tb_gut_0 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => ' valign_middle',
                            'slots'   => array('user_navigation')
                        ),
                        2 => array(
                            'width'   => '1_3',
                            'class'   => ' align_center valign_middle',
                            'slots'   => array('logo')
                        ),
                        3 => array(
                            'width'   => '1_3',
                            'class'   => ' align_right valign_middle',
                            'slots'   => array('search')
                        )
                    )
                ),
                3 => array(
                    'class' => ' tb_row_fixed',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_1',
                            'class'   => '',
                            'slots'   => array('separator_border')
                        )
                    )
                ),
                4 => array(
                    'class' => ' tb_row_full tb_pt_15 tb_pb_15 tbMenuRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_1',
                            'class'   => ' align_center',
                            'slots'   => array('main_navigation', 'cart_menu')
                        )
                    )
                )
            )
        );

        // Layout 3
        $layout3 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_row_separate tb_plain tb_mb_30 tb_pt_30 tb_pl_30 tb_pr_30 tb_gut_0 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => ' valign_middle',
                            'slots'   => array('welcome', 'user_navigation')
                        ),
                        2 => array(
                            'width'   => '1_3',
                            'class'   => ' align_center valign_middle',
                            'slots'   => array('logo')
                        ),
                        3 => array(
                            'width'   => '1_3',
                            'class'   => ' align_right valign_middle',
                            'slots'   => array('currency', 'language', 'search')
                        )
                    )
                ),
                2 => array(
                    'class' => ' tb_row_fixed',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_1',
                            'class'   => '',
                            'slots'   => array('separator_border')
                        )
                    )
                ),
                3 => array(
                    'class' => ' tb_row_full tb_pt_15 tb_pb_15 tbMenuRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_1',
                            'class'   => ' align_center',
                            'slots'   => array('main_navigation', 'cart_menu')
                        )
                    )
                )
            )
        );

        // Layout 4
        $layout2_1 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_gut_40 tb_pl_30 tb_pr_30 tb_pt_30 tb_pb_30 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => '',
                            'slots'   => array('logo')
                        ),
                        2 => array(
                            'width'   => '2_3',
                            'class'   => ' align_right',
                            'slots'   => array('currency', 'language', 'search', 'separator_plain', 'cart_menu', 'welcome', 'user_navigation')
                        )
                    )
                )
            )
        );

        // Layout 5
        $layout2_2 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_gut_40 tb_pl_30 tb_pr_30 tb_pt_30 tb_pb_30 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => '',
                            'slots'   => array('logo')
                        ),
                        2 => array(
                            'width'   => '2_3',
                            'class'   => ' align_right',
                            'slots'   => array('currency', 'language', 'search', 'separator_plain', 'welcome', 'separator_plain', 'user_navigation')
                        )
                    )
                )
            )
        );

        // Layout 6
        $layout2_3 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_gut_40 tb_pl_30 tb_pr_30 tb_pt_30 tb_pb_30 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => '',
                            'slots'   => array('logo')
                        ),
                        2 => array(
                            'width'   => '2_3',
                            'class'   => ' align_right',
                            'slots'   => array('welcome', 'user_navigation', 'separator_plain', 'currency', 'language', 'cart_menu')
                        )
                    )
                )
            )
        );

        // Layout 7
        $layout2_4 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_row_separate tb_plain tb_pt_30 tb_pl_30 tb_pr_30 tb_gut_0 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => ' valign_middle',
                            'slots'   => array('welcome', 'user_navigation')
                        ),
                        2 => array(
                            'width'   => '1_3',
                            'class'   => ' align_center valign_middle',
                            'slots'   => array('logo')
                        ),
                        3 => array(
                            'width'   => '1_3',
                            'class'   => ' align_right valign_middle',
                            'slots'   => array('currency', 'language', 'search')
                        )
                    )
                )
            )
        );

        // Layout 8
        $layout2_5 = array(
            'rows' => array(
                1 => array(
                    'class' => ' tb_row_full tb_middle tb_mb_30 tb_pt_5 tb_pb_5 tb_pl_30 tb_pr_30 tbSystemRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_2',
                            'class'   => '',
                            'slots'   => array('welcome')
                        ),
                        2 => array(
                            'width'   => '1_2',
                            'class'   => ' align_right',
                            'slots'   => array('currency', 'language')
                        )
                    )
                ),
                2 => array(
                    'class' => ' tb_row_full tb_row_separate tb_plain tb_pl_30 tb_pr_30 tb_gut_0 tbLogoRow',
                    'columns' => array(
                        1 => array(
                            'width'   => '1_3',
                            'class'   => ' valign_middle',
                            'slots'   => array('logo')
                        ),
                        2 => array(
                            'width'   => '1_3',
                            'class'   => ' align_center valign_middle',
                            'slots'   => array('search')
                        ),
                        3 => array(
                            'width'   => '1_3',
                            'class'   => ' align_right valign_middle',
                            'slots'   => array('user_navigation')
                        )
                    )
                )
            )
        );

        $style = $this->getSetting('style');

        $themeData->header_layout = ${'layout' . $style['header_layout']};

        $themeData->menu_row_hide =
            $style['header_layout']    == '1'
            || $style['header_layout'] == '2'
            || $style['header_layout'] == '3';

        $themeData->menu_row_cart_show =
            $style['header_layout']    == '2_2'
            || $style['header_layout'] == '2_4'
            || $style['header_layout'] == '2_5';

        $themeData->menu_row_search_show =
            $style['header_layout']    == '2_3';
    }
}