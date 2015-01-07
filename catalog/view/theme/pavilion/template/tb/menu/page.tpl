<?php
$has_submenu   = isset($menu_item['children']) && !empty($menu_item['children']);
$menu_label    = isset($menu_item['data']['settings']['label']) && $menu_item['data']['settings']['label'] ? $menu_item['data']['settings']['label'] : $information_page['title'];
$menu_classes  = '';
$menu_classes .= isset($menu_item['data']['settings']['class']) && $menu_item['data']['settings']['class'] ? $menu_item['data']['settings']['class'] : '';
$menu_classes .= $has_submenu ? ' tb_multiple' : '';
?>
<li id="menu_page_<?php echo $information_page['id']; ?>" class="tb_menu_page<?php echo $menu_classes; ?>">
  <a href="<?php echo $url->link('information/information', 'information_id=' . $information_page['id']); ?>">
    <?php echo $menu_label; ?>
    <?php if (isset($menu_item['data']['settings']['accent_text']) && $menu_item['data']['settings']['accent_text']): ?>
    <span class="tb_accent_label" style="color: <?php echo $menu_item['data']['settings']['accent_color']; ?>; background-color: <?php echo $menu_item['data']['settings']['accent_bg']; ?>;"><?php echo $menu_item['data']['settings']['accent_text']; ?></span>
    <?php endif; ?>
  </a>
  <?php if ($has_submenu): ?>
  <div class="tb_submenu">
    <ul class="tb_list_1">
      <?php echo $tbData->fetchMenuItems($menu_item['children']); ?>
    </ul>
  </div>
  <span class="tb_toggle"></span>
  <?php endif; ?>
</li>