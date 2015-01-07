<div class="tb_description tb_button_<?php echo $button_position; ?>" style="min-height: <?php echo $button_size; ?>px;">
  <?php echo $text; ?>
</div>

<div class="tb_button_holder">
  <a class="tb_button<?php echo $button_classes; ?>" href="<?php echo $button_url; ?>" target="<?php echo $url_target; ?>"><?php if ($button_icon): ?><span class="<?php echo $button_icon; ?>" style="font-size: <?php echo $button_icon_size; ?>px"></span><?php endif; ?><?php echo $button_text; ?></a>
</div>

<?php if ($button_position == "right" || $button_position == "left"): ?>
<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  var $button_width = $('#<?php echo $widget_dom_id; ?>').find('.tb_button').outerWidth();
  $('#<?php echo $widget_dom_id; ?>').find('.tb_description').css('padding-<?php echo $button_position; ?>', $button_width + 30);
});
</script>
<?php endif; ?>
