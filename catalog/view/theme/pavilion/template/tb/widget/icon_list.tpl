<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<ul class="tb_icon_list<?php echo $listing_classes; ?> clearfix">
  <?php foreach ($rows as $row): ?><li<?php echo $row['css_classes']; ?>>
    <div class="tb_icon_wrap" style="<?php echo $widget->generateIconWrapStyles($row); ?>">
      <<?php echo $row['tag'] . $row['url_html']; ?> class="tb_icon tb_style_<?php echo $row['icon_style']; ?> <?php echo $row['glyph_value']; ?>" style="<?php echo $widget->generateIconStyles($row); ?>"></<?php echo $row['tag']; ?>>
    </div><?php if ($row['text']): ?><div class="tb_description_wrap<?php echo $description_classes; ?>" style="<?php echo $widget->generateDescStyles($row); ?>">
      <div class="tb_description"><?php echo $row['text']; ?></div>
    </div>
    <?php endif; ?>
  </li><?php if ($icons_align == 'justify') echo ' '; ?><?php endforeach; ?>
</ul>

<script type="text/javascript">
<?php if ($description_position == 'tooltip'): ?>
tbApp.onScriptLoaded(function() {
  $('#<?php echo $widget_dom_id; ?> .tb_icon_wrap').each(function() {
      if ($(this).next('.tb_description_wrap').length) {
          $(this).tooltip({
              items:   $(this).find('.tb_icon'),
              content: $(this).next('.tb_description_wrap').find('.tb_description').html(),
              position: {
                  my: 'bottom',
                  at: 'top-10'
              },
              show: {effect: 'fadeIn', duration: 500, easing: 'easeInQuart'}
          });
      }
  });
});
<?php endif; ?>
<?php if ($display == 'grid'): ?>
tbApp.exec<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
        <?php // ADJUST PRODUCT SIZE ?>
        adjustItemSize('#<?php echo $widget->getDomId(); ?>', <?php echo $restrictions_json; ?>);
    });
}
<?php if (!isset($within_group) || !$within_group): ?>
tbApp.exec<?php echo $widget->getDomId(); ?>();
<?php endif; ?>
<?php endif; ?>
</script>
