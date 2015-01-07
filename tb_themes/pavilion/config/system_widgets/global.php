<?php

$common = array(
    'intro_global_widgets' => array(
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
        )
    ),
    'content_global_widgets' => array(
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
    )
);

$result = array();

$result['full'] = array(
    'intro' => array(
        'global_widgets' => $common['intro_global_widgets'],
        'settings' => array(
            'layout' => array(
                'type'            => 'full',
                'margin_bottom'   => 30,
                'padding_top'     => 0,
                'padding_bottom'  => 0,
                'padding_right'   => 0
            )
        ),
        'rows' => array(
            0 => array(
                'columns' => array(
                    0 => array(
                        'grid_proportion' => '1_1',
                        'widgets'         => array(
                            0 => array(
                                'label'    => 'Breadcrumbs',
                                'slot'     => 'breadcrumbs',
                                'settings' => array(
                                    'common' => array(
                                        'layout' => array(
                                            'type'            => 'fixed',
                                            'margin_bottom'   => 0
                                        )
                                    )
                                )
                            ),
                            1 => array(
                                'label'    => 'Page title',
                                'slot'     => 'page_title',
                                'settings' => array(
                                    'common' => array(
                                        'layout' => array(
                                            'type'            => 'fixed',
                                            'margin_bottom'   => 0
                                        )
                                    )
                                )
                            )
                        )
                    )
                ),
                'settings' => array(
                    'layout' => array(
                        'type'          => 'full',
                        'margin_bottom' => 0
                    )
                )
            )
        )
    ),
    'content' => array(
        'global_widgets' => $common['content_global_widgets'],
        'settings' => array(
            'layout' => array(
                'type'            => 'full',
                'margin_bottom'   => 30,
                'padding_top'     => 0,
                'padding_bottom'  => 0,
                'padding_right'   => 0
            )
        ),
        'rows' => array(
            0 => array(
                'columns' => array(
                    0 => array(
                        'grid_proportion' => '1_1',
                        'widgets'         => array(
                            0 => array(
                                'label'    => 'Page Content',
                                'slot'     => 'page_content',
                                'settings' => array()
                            )
                        )
                    )
                ),
                'settings' => array(
                    'layout' => array(
                        'type'            => 'fixed',
                        'margin_bottom'   => 0,
                    ),
                )
            )
        )
    )
);

$result['fixed'] = array(
    'intro' => array(
        'global_widgets' => $common['intro_global_widgets'],
        'settings' => array(
            'layout' => array(
                'type'            => 'full',
                'margin_bottom'   => 30,
                'padding_top'     => 0,
                'padding_bottom'  => 0,
                'padding_right'   => 0
            )
        ),
        'rows' => array(
            0 => array(
                'columns' => array(
                    0 => array(
                        'grid_proportion' => '1_1',
                        'widgets'         => array(
                            0 => array(
                                'label'    => 'Breadcrumbs',
                                'slot'     => 'breadcrumbs',
                                'settings' => array(
                                    'common' => array(
                                        'layout' => array(
                                            'type'            => 'fixed',
                                            'margin_bottom'   => 0
                                        )
                                    )
                                )
                            ),
                            1 => array(
                                'label'    => 'Page title',
                                'slot'     => 'page_title',
                                'settings' => array(
                                    'common' => array(
                                        'layout' => array(
                                            'type'            => 'fixed',
                                            'margin_bottom'   => 0
                                        )
                                    )
                                )
                            )
                        )
                    )
                ),
                'settings' => array(
                    'layout' => array(
                        'type'          => 'full',
                        'margin_bottom' => 0
                    )
                )
            )
        )
    ),
    'content' => array(
        'global_widgets' => $common['content_global_widgets'],
        'settings' => array(
            'layout' => array(
                'type'            => 'full',
                'margin_bottom'   => 30,
                'padding_top'     => 30,
                'padding_bottom'  => 30,
                'padding_right'   => 30
            )
        ),
        'rows' => array(
            0 => array(
                'columns' => array(
                    0 => array(
                        'grid_proportion' => '1_1',
                        'widgets'         => array(
                            0 => array(
                                'label'    => 'Page Content',
                                'slot'     => 'page_content',
                                'settings' => array()
                            )
                        )
                    )
                ),
                'settings' => array(
                    'layout' => array(
                        'type'            => 'full',
                        'margin_bottom'   => 0,
                    ),
                )
            )
        )
    )
);

return $result;