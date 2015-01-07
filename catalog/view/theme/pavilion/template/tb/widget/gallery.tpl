<?php if ($gallery_type == 'grid'): ?>
<style scoped>
#<?php echo $widget->getDomId(); ?> .tb_gallery.tb_grid_view {
   margin-left: -<?php echo $thumb_gutter; ?>px;
   margin-top: -<?php echo $thumb_gutter; ?>px;
}
#<?php echo $widget->getDomId(); ?> .tb_gallery.tb_grid_view a {
   margin-left: <?php echo $thumb_gutter; ?>px;
   margin-top: <?php echo $thumb_gutter; ?>px;
}
</style>
<?php endif; ?>

<div class="tb_gallery tb_<?php echo $gallery_type; ?>_view tb_nav_size_<?php echo $navigation_size; ?> tb_inline">
  <div class="fotorama" data-auto="false">
    <?php foreach ($images as $image): ?>
    <a href="<?php echo $image['preview']; ?>"<?php echo $image['preview_attr']; ?>>
      <img src="<?php echo $image['thumb']; ?>"<?php echo $image['thumb_attr']; ?> alt="" />
      <?php if ($gallery_type == 'grid'): ?>
      <span class="fa-camera"></span>
      <?php endif; ?>
    </a>
    <?php endforeach; ?>
  </div>
  <?php if ($gallery_type == 'slide' && $fullscreen): ?>
  <a href="javascript:;" class="tb_fullscreen_button ent-resize-full tbGoFullscreen"></a>
  <?php endif; ?>
</div>

<script type="text/javascript">
function exec<?php echo $widget->getDomId(); ?>() {
  tbApp.onScriptLoaded(function() {

    <?php if ($gallery_type == 'slide'): ?>
    var fotorama = $('#<?php echo $widget->getDomId(); ?> .fotorama').fotorama({
        width:       '100%',
        maxheight:   <?php echo $gallery_height; ?>,
        <?php if ($crop_thumbs): ?>
        ratio:       '<?php echo $preview_size_x . '/' . $preview_size_y; ?>',
        <?php endif; ?>
        fit:         'cover',
        nav:         '<?php echo $gallery_nav; ?>',
        thumbheight: <?php echo $thumb_size_y; ?>,
        loop:        true,
        keyboard:    true,
        shadows:     false
    }).data('fotorama');

    <?php if ($fullscreen): ?>
    $('#<?php echo $widget->getDomId(); ?> .tbGoFullscreen').bind('click', function() {
        if (!$(this).hasClass('tbKeyPressed')) {
            lightbox_gallery('<?php echo $widget->getDomId(); ?>', <?php echo $images_array; ?>, fotorama.activeIndex);
        }
        $(this).addClass('tbKeyPressed');
    });
    <?php endif; ?>
    <?php endif; ?>

    <?php if ($gallery_type == 'grid'): ?>
    $('#<?php echo $widget->getDomId(); ?> .tb_gallery.tb_grid_view a').bind('click', function(){
        lightbox_gallery('<?php echo $widget->getDomId(); ?>', <?php echo $images_array; ?>, $(this).attr('data-index'));

        return false;
    });
    <?php endif; ?>

  });
}

<?php if (!isset($within_group) || !$within_group): ?>
exec<?php echo $widget->getDomId(); ?>();
<?php else: ?>
tbApp.exec<?php echo $widget->getDomId(); ?> = exec<?php echo $widget->getDomId(); ?>;
<?php endif; ?>
</script>