<?php if ($manufacturers): ?>

<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<div class="tb_manufacturers tb_listing tb_grid_view tb_style_1 <?php echo $listing_classes; ?> tb_gut_30 clearfix">

  <?php foreach ($manufacturers as $manufacturer):  ?>
  <div class="tb_manufacturer tb_item<?php echo $manufacturer['tb_classes']; ?>">
    <a class="tb_thumb" href="<?php echo $url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']); ?>">
      <img src="<?php echo $manufacturer['thumb']; ?>" width="<?php echo $manufacturer['thumb_width']; ?>" height="<?php echo $manufacturer['thumb_height']; ?>" title="<?php echo $manufacturer['name']; ?>" alt="<?php echo $manufacturer['name']; ?>" />
    </a>
  </div>
  <?php endforeach; ?>

</div>

<script type="text/javascript">
<?php if ($slider): ?>
tbApp.init<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
        <?php // ITEM SLIDER ?>
        tbApp.itemSlider<?php echo $widget->getDomId(); ?> = createItemSlider('#<?php echo $widget->getDomId(); ?>', <?php echo count($manufacturers); ?>, <?php echo $slider_step; ?>, <?php echo $slider_speed; ?>, <?php $slider_pagination ? print '\'#' . $widget->getDomId() . ' .tb_slider_pagination\'' : print 'false' ; ?>, <?php echo $restrictions_json; ?>);
    });
}
<?php endif; ?>
tbApp.exec<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
        <?php // REFRESH SLIDER ?>
        <?php if ($slider): ?>
        tbApp.itemSlider<?php echo $widget->getDomId(); ?>.refresh();
        <?php endif; ?>

        <?php // ADJUST ITEM SIZE ?>
        adjustItemSize('#<?php echo $widget->getDomId(); ?>', <?php echo $restrictions_json; ?>)
    });
}
<?php if (!isset($within_group) || !$within_group): ?>
<?php if ($slider): ?>
tbApp.init<?php echo $widget->getDomId(); ?>();
<?php endif; ?>
tbApp.exec<?php echo $widget->getDomId(); ?>();
<?php endif; ?>
</script>
<?php endif; ?>
