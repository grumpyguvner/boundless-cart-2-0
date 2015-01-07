<?php

return array(
    'label'   => 'Information page',
    'route'   => 'information/information',
    'display' => false,
    'widgets' => array(
        0  => array(
            'label' => 'Breadcrumbs',
            'slot'  => 'breadcrumbs',
            'areas' => 'intro, content',
            'locked' => false
        ),
        1 => array(
            'label' => 'Page title',
            'slot'  => 'page_title',
            'areas' => 'intro, content',
            'locked' => false
        ),
        2 => array(
            'label' => 'Page content',
            'slot'  => 'page_content',
            'areas' => 'content',
            'class'  => 'Theme_PageContentInformationSystemWidget',
            'locked' => true
        )
    ),
    'default' => array(
        'content' => array(
            'respect_global_record' => 1,
            'rows' => array(
                0 => array(
                    'id' => 'tbR1xLq',
                    'columns' => array(
                        0 => array(
                            'grid_proportion' => '1_1',
                            'widgets' => array(
                                0 => array(
                                    'id'       => 'tbW1yaX2pc',
                                    'label'    => 'Page content',
                                    'slot'     => 'page_content',
                                    'class'    => 'Theme_PageContentInformationSystemWidget'
                                )
                            )
                        )
                    ),
                    'settings' => array(
                        'layout' => array(
                            'type'            => 'full',
                            'margin_bottom'   => 0,
                        )
                    )
                )
            )
        )
    )
);