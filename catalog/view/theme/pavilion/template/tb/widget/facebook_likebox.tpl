<?php $profile_border ? $border_offset = 10 : $border_offset = 0; ?>
<?php if ($like_box_style == 'custom'): ?>
<style scoped>
#<?php echo $widget->getDomId(); ?> ul.uiList {
  <?php if ($profile_name): ?>
  height: <?php echo ($tbData->fonts['body']['line-height'] * 1.5 + 50 + $border_offset) * $profiles_rows; ?>px;
  <?php else: ?>
  height: <?php echo ($tbData->fonts['body']['line-height'] * 0.5 + 50 + $border_offset) * $profiles_rows + 1; ?>px;
  <?php endif; ?>
}
</style>
<?php else: ?>
<style scoped>
#<?php echo $widget->getDomId(); ?> .tb_fb_likebox.tb_default {
  padding: <?php echo $default_padding; ?>px;
  height: <?php echo $default_height; ?>px;
}
</style>
<?php endif; ?>

<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>
<?php if ($like_box_style == 'custom'): ?>
<div class="tb_fb_likebox<?php echo $like_box_classes; ?> tb_social_box tb_custom">
  <div class="tb_fb_like tb_social_button">
    <div class="fb-like" data-href="<?php echo $page_url; ?>" data-layout="<?php echo $like_button_style; ?>" data-action="like" data-show-faces="false" data-share="false"></div>
  </div>
  <?php echo $content; ?>
</div>
<?php else: ?>
<div class="tb_fb_likebox tb_social_box tb_default">
  <div class="tb_social_box_wrap">
    <fb:like-box href="<?php echo $page_url; ?>" height="<?php echo $default_height + 20; ?>" colorscheme="light" show_faces="true" header="false" stream="false" show_border="false"></fb:like-box>
  </div>
</div>
<?php endif; ?>