<div class="tb_banner">
  <div class="tb_text_wrap">
    <?php if ($line_1 || $line_2 || $line_3): ?>
    <div class="tb_text align_<?php echo $text_align; ?> valign_<?php echo $text_valign; ?>">
      <?php if ($line_1): ?>
      <span class="tb_line_1"><?php echo html_entity_decode($line_1); ?></span>
      <?php endif; ?>
      <?php if ($line_2): ?>
      <span class="tb_line_2"><?php echo html_entity_decode($line_2); ?></span>
      <?php endif; ?>
      <?php if ($line_3): ?>
      <span class="tb_line_3"><?php echo html_entity_decode($line_3); ?></span>
      <?php endif; ?>
    </div>
    <?php endif; ?>
  </div>
</div>
<div class="tb_image tb_hover_<?php echo $hover; ?>" style="background-image: url('<?php echo $image; ?>'); transform-origin: <?php echo $zoom_origin; ?>; -ms-transform-origin: <?php echo $zoom_origin; ?>; -webkit-transform-origin: <?php echo $zoom_origin; ?>;"></div>
<a href="<?php echo $url; ?>" target="<?php echo $url_target; ?>"></a>
<img class="tb_ratio<?php if (!$max_height) echo ' tb_no_max_height'; ?>" src="<?php echo $ratio_img; ?>"<?php if ($min_height) echo ' style="min-height: ' . $min_height . 'px;"'; ?> alt="proportion" />
