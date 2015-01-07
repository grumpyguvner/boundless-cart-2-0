<li id="menu_brands" class="tb_menu_brands tb_multiple<?php if ($is_megamenu) echo ' tb_megamenu'; ?>">
  <a href="<?php echo $url->link('product/manufacturer'); ?>">
    <?php echo $settings['label']; ?>
    <?php if (isset($settings['accent_text']) && $settings['accent_text']): ?>
    <span class="tb_accent_label" style="color: <?php echo $settings['accent_color']; ?>; background-color: <?php echo $settings['accent_bg']; ?>;"><?php echo $settings['accent_text']; ?></span>
    <?php endif; ?>
  </a>
  <?php if (!empty($manufacturers)): ?>
  <div class="tb_submenu">
    <?php if ($is_megamenu): ?>
    <div class="tb_listing tb_grid_view tb_size_<?php echo count($manufacturers); ?> tb_gut_0">
      <?php foreach ($manufacturers as $columns): ?>
      <div class="tb_item">
        <?php foreach ($columns as $first_letter => $brands): ?>
        <div class="tb_letter">
          <strong><?php echo $first_letter; ?></strong>
          <ul class="tb_list_1">
            <?php foreach ($brands as $manufacturer): ?>
            <li><a href="<?php echo $url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']); ?>"><?php if ($manufacturer['display_name']) echo $manufacturer['name']; ?></a></li>
            <?php endforeach; ?>
          </ul>
        </div>
        <?php endforeach; ?>
      </div>
      <?php endforeach; ?>
    </div>
    <?php else: ?>
    <ul class="<?php if ($settings['manufacturers_display'] == 'label'): ?>tb_list_1<?php else: ?>tb_images<?php endif; ?>">
      <?php foreach ($manufacturers as $columns): ?>
      <?php foreach ($columns as $first_letter => $brands): ?>
      <?php foreach ($brands as $manufacturer): ?>
      <?php if ($manufacturer['display_name'] || $manufacturer['image']): ?>
      <li>
        <a href="<?php echo $url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']); ?>">
          <?php if ($manufacturer['display_name']) echo $manufacturer['name']; ?>
          <?php if ($manufacturer['image']): ?>
          <img src="<?php echo $manufacturer['image']; ?>" title="<?php echo $manufacturer['name']; ?>" alt="<?php echo $manufacturer['name']; ?>" />
          <?php endif; ?>
        </a>
      </li>
      <?php endif; ?>
      <?php endforeach; ?>
      <?php endforeach; ?>
      <?php endforeach; ?>
    </ul>
    <?php endif; ?>
  </div>
  <span class="tb_toggle"></span>
  <?php endif; ?>
</li>