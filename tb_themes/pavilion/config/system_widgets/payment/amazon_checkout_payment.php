<?php

return array(
    'label'   => 'Amazon Payments - Payment Method',
    'route' => 'payment/amazon_checkout',
    'display' => true,
    'widgets' => array(
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