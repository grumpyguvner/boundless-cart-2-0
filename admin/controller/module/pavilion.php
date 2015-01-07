<?php

$basename = basename(basename(__FILE__), '.php');

if (isset($_GET['route'])) {
    $route_parts = explode('/', $_GET['route']);
    if (count($route_parts) == 2 && $route_parts[0] == 'module' && $route_parts[1] != $basename) {
        return;
    }
} elseif (!defined('TB_BASENAME')) {
    return;
}

require_once realpath(DIR_SYSTEM . '../') . '/tb_themes/' . $basename . '/admin/boot.php';
require_once realpath(DIR_SYSTEM . '../') . '/tb_themes/' . $basename . '/admin/controller/ModuleController.php';

class ControllerModulePavilion extends Theme_Admin_ModuleController {}