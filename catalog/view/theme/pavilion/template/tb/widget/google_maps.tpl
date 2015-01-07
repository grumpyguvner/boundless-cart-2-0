<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<div class="tb_map_wrap" style="height: <?php echo $height; ?>px;">
  <?php if ($map_code === false): ?>
  <span class="tb_loading_wrap"><i class="fa fa-circle-o-notch fa-spin"></i></span>
  <?php endif; ?>
  <div class="tb_map_holder">
    <div class="tb_map">
      <?php if ($map_code !== false): ?>
      <?php echo $map_code; ?>
      <?php endif; ?>
    </div>
  </div>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  <?php if ($map_code === false): ?>
  var iframeEl = document.createElement("iframe");

  <?php foreach ($iframe_attributes as $key => $value): ?>
  <?php if ($key == 'style' && TB_RequestHelper::lteIe9()) continue; ?>
  iframeEl.<?php echo $key; ?> = "<?php echo $value; ?>";
  <?php endforeach; ?>
  iframeEl.onload = function () {
    $("#<?php echo $widget->getDomId(); ?> .tb_map_wrap").find("> .tb_loading_wrap").remove();
  };
  $("#<?php echo $widget->getDomId(); ?> .tb_map").append(iframeEl);
  <?php endif; ?>
  onSizeChange(function() {
    var map_iframe = document.getElementById('<?php echo $widget->getDomId(); ?>').getElementsByTagName('iframe');
    map_iframe[0].src = map_iframe[0].src;
  });
});
</script>
