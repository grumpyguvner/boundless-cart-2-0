<li id="menu_url_<?php echo $menu_item['data']['id']; ?>" class="tb_menu_url<?php echo $menu_classes; ?>">
  <?php $has_submenu = isset($menu_item['children']) && !empty($menu_item['children']); ?>
  <a href="<?php echo $url; ?>"<?php if ($url_title): ?> title="<?php echo $url_title; ?>"<?php endif; ?> target="<?php echo $target; ?>">
    <?php echo $label; ?>
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