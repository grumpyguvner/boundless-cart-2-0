<?php

return array(
    'label'   => 'Amazon Payments - Payment Failure',
    'route' => 'payment/amazon_checkout/failure',
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