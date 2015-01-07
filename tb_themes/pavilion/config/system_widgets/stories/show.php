<?php

return array(
    'label'   => 'Article Page',
    'route'   => 'stories/show',
    'display' => true,
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
            'class'  => 'Theme_StoriesInfoPageContentSystemWidget',
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
                                    'id'       => 'tbK1yaB2ba',
                                    'label'    => 'Page content',
                                    'slot'     => 'page_content',
                                    'class'    => 'Theme_StoriesInfoPageContentSystemWidget'
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