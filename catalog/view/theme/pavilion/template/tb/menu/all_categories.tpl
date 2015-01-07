<?php // Categories --------------------------------------------------- ?>

<?php $tbData->slotStart('menu_all_categories.categories'); ?>
<ul class="tb_subcategories tb_list_1<?php echo $wrapper_classes; ?> clearfix" data-cols="<?php echo $settings['subcategory_cols']; ?>">
  <?php $i = 1; foreach ($categories as $category): ?>
  <?php if ($category['top']): ?>
  <?php
  $submenu = $tbData->getCategorySubMenu($category, $settings, $max_depth);

  $submenu_classes  = '';
  $submenu_classes .= !empty($submenu) ? ' tb_multiple' : '';
  $submenu_classes .= $is_megamenu ? ' tb_item' : '';
  $submenu_classes .= ' ' . $tbData->buildClearClasses($i);
  ?>
  <li class="tb_menu_category<?php echo $submenu_classes; ?>">
    <a href="<?php echo $category['url']; ?>">
      <?php echo $category['name']; ?>
    </a>
    <?php if ($settings['category_thumb'] && $is_megamenu): ?>
    <span class="tb_thumb">
      <img width="<?php echo $settings['cat_image_size_x']; ?>" height="<?php echo $settings['cat_image_size_y']; ?>" src="<?php echo $toolImage->resizeImage($category['image'] ? $category['image'] : 'no_image.jpg', $settings['cat_image_size_x'], $settings['cat_image_size_y']); ?>" alt="<?php echo $category['name']; ?>" />
    </span>
    <?php endif; ?>
    <?php if (!empty($submenu)): ?>
    <div class="tb_submenu">
      <?php echo $submenu; ?>
    </div>
    <span class="tb_toggle"></span>
    <?php endif; ?>
  </li>
  <?php $i++; ?>
  <?php endif; ?>
  <?php endforeach; ?>
</ul>
<?php $tbData->slotStop(); ?>

<?php // Brands ------------------------------------------------------ ?>

<?php $tbData->slotStart('menu_all_categories.brands'); ?>
<?php if ($manufacturers): ?>
<ul class="tb_category_brands tb_list_1">
  <li class="tb_menu_brands tb_multiple">
    <?php if ($settings['manufacturers_display'] == 'label'): ?>
    <a><?php echo $tbData->text_menu_brands; ?></a>
    <?php endif; ?>
    <div class="tb_submenu">
      <ul class="<?php if ($settings['manufacturers_display'] == 'label'): ?>tb_list_1<?php else: ?>tb_images<?php endif; ?>">
        <?php foreach ($manufacturers as $manufacturer): ?>
        <?php if ($settings['manufacturers_display'] == 'image' && $manufacturer['image']): ?>
        <li>
          <a href="<?php echo $url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']); ?>">
            <img src="<?php echo $manufacturer['image']; ?>" width="<?php echo $settings['image_size_x']; ?>" height="<?php echo $settings['image_size_y']; ?>" title="<?php echo $manufacturer['name']; ?>" alt="<?php echo $manufacturer['name']; ?>" />
          </a>
        </li>
        <?php endif; ?>
        <?php if ($manufacturer['display_name']): ?>
        <li><a href="<?php echo $url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']); ?>"><?php echo $manufacturer['name']; ?></a></li>
        <?php endif; ?>
        <?php endforeach; ?>
      </ul>
    </div>
    <span class="tb_toggle"></span>
  </li>
</ul>
<?php endif; ?>
<?php $tbData->slotStop(); ?>

<?php // Echo slots -------------------------------------------------- ?>

<li id="menu_all_categories_<?php echo $menu_item_id; ?>" class="tb_menu_all_categories<?php echo $menu_classes; ?>">
  <a href="javascript:;">
    <?php echo $settings['label']; ?>
    <?php if (isset($settings['accent_text']) && $settings['accent_text']): ?>
    <span class="tb_accent_label" style="color: <?php echo $settings['accent_color']; ?>; background-color: <?php echo $settings['accent_bg']; ?>;"><?php echo $settings['accent_text']; ?></span>
    <?php endif; ?>
  </a>
  <div class="tb_submenu">
    <?php if ($is_megamenu): ?>
    <div class="tb_row tb_row_fixed tb_row_separate tb_ip_0">
      <div class="tb_wrap">
        <div class="tb_col_<?php echo $categories_width; ?>_5">
          <?php $tbData->slotEcho('menu_all_categories.categories'); ?>
          <?php if(!empty($manufacturers) && $settings['manufacturers_position'] == 'below'): ?>
          <?php $tbData->slotEcho('menu_all_categories.brands'); ?>
          <?php endif; ?>
        </div>
        <?php if(!empty($manufacturers) && $settings['manufacturers_position'] == 'column'): ?>
        <div class="tb_col_1_5">
          <?php $tbData->slotEcho('menu_all_categories.brands'); ?>
        </div>
        <?php endif; ?>
      </div>
    </div>
    <?php else: ?>
    <?php $tbData->slotEcho('menu_all_categories.categories'); ?>
    <?php endif; ?>
  </div>
  <span class="tb_toggle"></span>
</li>

<?php if ($settings['subcategory_hover_thumb'] && $is_megamenu): ?>
<?php $tbData->slotStart('menu_all_categories.js'); ?>
<script type="text/javascript">
  jQuery(document).ready(function($) {
    $("#menu_all_categories_<?php echo $menu_item_id; ?>")
    .on("mouseenter", "li[data-src]", function() {
        var $image = $(this).closest('li[class~="tb_menu_category"]').find("> .tb_thumb img");

        if (!$image.is("[original_src]")) {
          $image.attr("original_src", $image.attr("src"));
        }
        $image.attr("src", $(this).attr("data-src"));
    })
    .on("mouseleave", "li[data-src]", function() {
        var $image = $(this).closest('li[class~="tb_menu_category"]').find("> .tb_thumb img");

        $image.attr("src", $image.attr("original_src"));
    });
  });
</script>
<?php $tbData->slotStopStack(); ?>
<?php endif; ?>