<?php

return array(
    'label'   => 'Maintenance',
    'route'   => 'common/maintenance',
    'display' => true,
    'ssl'     => true,
    'widgets' => array(
        0 => array(
            'label'  => 'Page content',
            'slot'   => 'page_content',
            'areas'  => 'content',
            'locked' => true
        )
    )
);