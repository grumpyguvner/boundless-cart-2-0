<div class="tb_separator" style="<?php echo $wrap_styles; ?>">
  <?php if ($title): ?>
  <span class="tb_title" style="<?php echo $title_styles; ?>">
    <?php echo $title; ?>
    <span class="tb_position_left <?php echo $separator_classes; ?>" style="<?php echo $separator_styles; ?>"></span>
    <span class="tb_position_right <?php echo $separator_classes; ?>" style="<?php echo $separator_styles; ?>"></span>
  </span>
  <?php else: ?>
  <span class="clear <?php echo $separator_classes; ?>" style="<?php echo $separator_styles; ?>"></span>
  <?php endif; ?>
</div>