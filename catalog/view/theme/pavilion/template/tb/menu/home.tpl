<li id="menu_home_<?php echo $menu_item['data']['id']; ?>" class="tb_menu_home<?php echo $menu_classes; ?>">
  <a href="<?php echo $home_url; ?>"<?php if ($display == 'icon' || $display == 'label_icon'): ?> class="fa-home"<?php endif; ?>><?php if ($display == 'label' || $display =='label_icon') echo $menu_item['data']['settings']['label']; ?></a>
</li>