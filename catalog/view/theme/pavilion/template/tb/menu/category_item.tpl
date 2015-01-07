<ul class="tb_list_1<?php echo $menu_classes; ?> clearfix" data-cols="<?php echo $settings['subcategory_cols']; ?>">
  <?php foreach ($category['children'] as $category): ?>
  <?php $submenu = $tbData->getCategorySubMenu($category, $settings, $max_depth); ?>
  <li<?php if ($category['menu_classes']): ?> class="<?php echo $category['menu_classes']; ?>"<?php endif; ?><?php if ($settings['max_level_thumb'] <= $category['level'] && $category['image']): ?> data-src="<?php echo $toolImage->resizeImage($category['image'], $settings['cat_image_size_x'], $settings['cat_image_size_y']); ?>"<?php endif; ?>>
    <a href="<?php echo $category['url']; ?>"><?php echo $category['name']; ?></a>
    <?php if($submenu): ?>
    <div class="tb_submenu">
      <?php echo $submenu; ?>
    </div>
    <span class="tb_toggle"></span>
    <?php endif; ?>
  </li>
  <?php endforeach; ?>
</ul>