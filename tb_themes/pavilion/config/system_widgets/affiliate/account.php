<?php

return array(
    'label'   => 'Affiliate account',
    'route'   => 'affiliate/account',
    'display' => true,
    'ssl'     => true,
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
            'locked' => true
        )
    )
);