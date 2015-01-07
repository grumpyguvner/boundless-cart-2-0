<?php $tbData->slotStart('menu_category.category_brands'); ?>
<?php if (!empty($manufacturers)): ?>
<ul class="tb_category_brands tb_list_1 clearfix">
  <li class="tb_menu_brands tb_multiple">
    <a><?php echo $category['name']; ?> <?php echo $tbData->text_menu_brands; ?></a>
    <div class="tb_submenu">
      <ul class="<?php if ($settings['manufacturers_display'] == 'label'): ?>tb_list_1<?php else: ?>tb_images<?php endif; ?>">
        <?php foreach ($manufacturers as $manufacturer): ?>
        <?php if ($settings['manufacturers_display'] == 'image' && $manufacturer['image']): ?>
        <li>
          <a href="<?php echo $tbData->link('category/manufacturer', 'c_id=' . $category['category_id'] . '&man_id=' . $manufacturer['manufacturer_id']); ?>">
            <?php if ($manufacturer['image']): ?>
            <img src="<?php echo $manufacturer['image']; ?>" title="<?php echo $manufacturer['name']; ?>" alt="<?php echo $manufacturer['name']; ?>" />
            <?php endif; ?>
          </a>
        </li>
        <?php endif; ?>
        <?php if ($manufacturer['display_name']): ?>
        <li><a href="<?php echo $tbData->link('category/manufacturer', 'c_id=' . $category['category_id'] . '&man_id=' . $manufacturer['manufacturer_id']); ?>"><?php echo $manufacturer['name']; ?></a></li>
        <?php endif; ?>
        <?php endforeach; ?>
      </ul>
    </div>
    <span class="tb_toggle"></span>
  </li>
</ul>
<?php endif; ?>
<?php $tbData->slotStop(); ?>

<li id="menu_category_<?php echo $menu_item_id; ?>" class="tb_menu_category<?php echo $menu_classes; ?>">
  <a href="<?php echo $category['url']; ?>">
    <?php echo $category_label; ?>
    <?php if (isset($menu_item['data']['settings']['accent_text']) && $menu_item['data']['settings']['accent_text']): ?>
    <span class="tb_accent_label" style="color: <?php echo $menu_item['data']['settings']['accent_color']; ?>; background-color: <?php echo $menu_item['data']['settings']['accent_bg']; ?>;"><?php echo $menu_item['data']['settings']['accent_text']; ?></span>
    <?php endif; ?>
  </a>

  <div class="tb_submenu">
    <?php if ($settings['is_megamenu']): ?>
    <div class="tb_row tb_row_fixed tb_row_separate tb_ip_0">
      <div class="tb_wrap">
        <div class="tb_col_<?php echo $submenu_width; ?>_5">
          <?php echo $submenu; ?>
          <?php if(!empty($manufacturers) && $settings['manufacturers_position'] == 'below'): ?>
          <?php $tbData->slotEcho('menu_category.category_brands'); ?>
          <?php endif; ?>
        </div>
        <?php if(!empty($manufacturers) && $settings['manufacturers_position'] == 'column'): ?>
        <div class="tb_col_1_5">
          <?php $tbData->slotEcho('menu_category.category_brands'); ?>
        </div>
        <?php endif; ?>
        <?php if($category_info): ?>
        <div class="tb_col_1_5 valign_<?php echo $settings['information_valign']; ?> tb_category_info_col">
          <div class="tb_category_info">
            <?php if ($settings['show_title']): ?>
            <h3><?php echo $category['name']; ?></h3>
            <?php endif; ?>
            <?php if ($settings['show_main_thumbnail'] && $settings['is_megamenu']): ?>
            <img class="tb_thumb" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" />
            <?php endif; ?>
            <?php if ($settings['description']): ?>
            <p class="tb_desc"><?php echo $settings['description']; ?></p>
            <?php endif; ?>
          </div>
        </div>
        <?php endif; ?>
      </div>
    </div>
    <?php else: ?>
    <?php echo $submenu; ?>
    <?php endif; ?>
  </div>
  <span class="tb_toggle"></span>
</li><?php $tbData->slotStart('menu_category.js'); ?>
<?php if ($settings['category_thumb'] && $settings['is_megamenu']): ?>
<script type="text/javascript">
  tbApp.onScriptLoaded(function() {
    var margin = '<?php echo $tbData->language_direction == 'left' ? 'margin-left' : 'margin-right'; ?>';

    $("#menu_category_<?php echo $category['category_id']; ?>").find("ul.tb_subcategories > li").each(function() {
      var image_source = $(this).is("[data-src]") ? $(this).attr("data-src") : "<?php echo $toolImage->resizeImage('no_image.jpg', $settings['cat_image_size_x'], $settings['cat_image_size_y']); ?>";

      $(this).find("> a").after('<span class="tb_thumb"><img src="' + image_source + '" /></span>');
      $(this).find("> .tb_submenu > ul").css(margin, <?php echo $settings['cat_image_size_x']; ?>);
    });
  });
</script>
<?php endif; ?>
<?php if ($settings['subcategory_hover_thumb'] && $settings['is_megamenu']): ?>
<script type="text/javascript">
  tbApp.onScriptLoaded(function() {
    $("#menu_category_<?php echo $category['category_id']; ?>")
      .on("mouseenter", "li[data-src]", function() {
        var $image = $(this).parent().closest('li[class*="category_"]').find("> .tb_thumb img");

        if ($image.length) {
          if (!$image.is("[original_src]")) {
            $image.attr("original_src", $image.attr("src"));
          }
          $image.attr("src", $(this).attr("data-src"));
        }
      })
      .on("mouseleave", "li[data-src]", function() {
        var $image = $(this).parent().closest('li[class*="category_"]').find("> .tb_thumb img");

        if ($image.length) {
          $image.attr("src", $image.attr("original_src"));
        }
      });
  });
</script>
<?php endif; ?>
<?php $tbData->slotStopStack(); ?>