<?php $scroll = 6; ?>
<?php if($scroll >= count($banners)): ?>
<style scoped>
#{{widget_dom_id}} .tb_carousel > a {
  float: left;
  width: <?php echo 100/count($banners); ?>%;
}
</style>
<?php endif; ?>

<div class="tb_carousel tb_listing tb_style_1 tb_size_<?php echo $scroll; ?> tb_slider tb_side_nav clearfix">
  <?php foreach ($banners as $banner): ?>
  <?php if ($banner['link']): ?>
  <a href="<?php echo $banner['link']; ?>">
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" />
  </a>
  <?php else: ?>
  <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" />
  <?php endif; ?>
  <?php endforeach; ?>
</div>

<script type="text/javascript">
tbApp.init{{widget_dom_id}} = function() {
    tbApp.onScriptLoaded(function() {
        <?php // ITEM SLIDER ?>
        tbApp.itemSlider{{widget_dom_id}} = createItemSlider('#{{widget_dom_id}}', <?php echo count($banners); ?>, 1, 500, '#{{widget_dom_id}} .tb_slider_pagination', {"1200":{"items_per_row":<?php echo $scroll; ?>,"items_spacing":30},"767":{"items_per_row":3,"items_spacing":30},"480":{"items_per_row":2,"items_spacing":30},"300":{"items_per_row":1,"items_spacing":30}});
    });
}
tbApp.exec{{widget_dom_id}} = function() {
    tbApp.onScriptLoaded(function() {
        <?php // REFRESH SLIDER ?>
        tbApp.itemSlider{{widget_dom_id}}.refresh();
    });
}

if ({{within_group}}) {
  tbApp.init{{widget_dom_id}}();
  tbApp.exec{{widget_dom_id}}();
}

</script>