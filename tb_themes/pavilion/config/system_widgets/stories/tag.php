<?php

return array(
    'label'   => 'Articles by Tag',
    'route'   => 'stories/tag',
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
            'label' => 'Tag description',
            'slot'  => 'tag_description',
            'areas' => 'intro, content',
            'locked' => false
        ),
        3 => array(
            'label' => 'Page content',
            'slot'  => 'page_content',
            'areas' => 'content',
            'class'  => 'Theme_StoriesListPageContentSystemWidget',
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
                                    'id'       => 'tbH1yaZ2pa',
                                    'label'    => 'Page content',
                                    'slot'     => 'page_content',
                                    'class'    => 'Theme_StoriesListPageContentSystemWidget'
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