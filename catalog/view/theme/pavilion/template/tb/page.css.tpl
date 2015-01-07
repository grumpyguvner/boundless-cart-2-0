<?php
$lang_dir = $tbData->language_direction;
?>

/*****************************************************/
/******   P A G E    S T Y L E S   *******************/
/*****************************************************/

<?php if ($tbData->body_background): ?>
body {
  background-image: url("<?php echo $tbData->base_httpsIf . 'image/' . $tbData->body_background['image']; ?>");
  background-repeat: <?php echo $tbData->body_background['repeat']; ?>;
  <?php if ($tbData->body_background['position'] == 'custom'): ?>
  background-position: <?php echo $tbData->body_background['position_x']; ?><?php echo $tbData->body_background['position_x_metric']; ?> <?php echo $tbData->body_background['position_y']; ?><?php echo $tbData->body_background['position_y_metric']; ?>;
  <?php else: ?>
  background-position: <?php echo $tbData->body_background['position']; ?>;
  <?php endif; ?>
  background-attachment: <?php echo $tbData->body_background['attachment']; ?>;
  <?php if ($tbData->body_background['size'] == 'custom'): ?>
  background-size: <?php echo $tbData->body_background['size_x']; ?><?php echo $tbData->body_background['size_x_metric']; ?> <?php echo $tbData->body_background['size_y']; ?><?php echo $tbData->body_background['size_y_metric']; ?>;
  <?php else: ?>
  background-size: <?php echo $tbData->body_background['size']; ?>;
  <?php endif; ?>
}
<?php endif; ?>
<?php echo $scoped_colors_css; ?>
<?php echo $fonts_css; ?>
<?php echo $plugins_css; ?>

#content.tb_sidebar_left > .tb_wrap {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $tbData->content_layout_settings['left_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  <?php else: ?>
  padding-right: <?php echo $tbData->content_layout_settings['left_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  <?php endif; ?>
}
#content.tb_sidebar_right > .tb_wrap {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $tbData->content_layout_settings['right_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  <?php else: ?>
  padding-left: <?php echo $tbData->content_layout_settings['right_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  <?php endif; ?>
}
#left_col {
  width: <?php echo $tbData->content_layout_settings['left_column_width']; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  left: -<?php echo $tbData->content_layout_settings['left_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  float: left;
  margin-left: -100%;
  <?php else: ?>
  right: -<?php echo $tbData->content_layout_settings['left_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  float: right;
  margin-right: -100%;
  <?php endif; ?>
}
#right_col {
  width: <?php echo $tbData->content_layout_settings['right_column_width']; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  margin-right: -<?php echo $tbData->content_layout_settings['right_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  <?php else: ?>
  float: left;
  margin-left: -<?php echo $tbData->content_layout_settings['right_column_width'] + $tbData->content_layout_settings['columns_gutter']; ?>px;
  <?php endif; ?>
}
#content.tb_row_content_separate.tb_sidebar_left > .tb_wrap {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $tbData->content_layout_settings['left_column_width'] - 1; ?>px;
  <?php else: ?>
  padding-right: <?php echo $tbData->content_layout_settings['left_column_width'] - 1; ?>px;
  <?php endif; ?>
}
#content.tb_row_content_separate.tb_sidebar_right > .tb_wrap {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $tbData->content_layout_settings['right_column_width'] - 1; ?>px;
  <?php else: ?>
  padding-left: <?php echo $tbData->content_layout_settings['right_column_width'] - 1; ?>px;
  <?php endif; ?>
}
#content.tb_row_content_separate.tb_sidebar_left .tb_main_col {
  <?php if ($lang_dir == 'ltr'): ?>
  border-left-width: 1px;
  <?php else: ?>
  border-right-width: 1px;
  <?php endif; ?>
}
#content.tb_row_content_separate.tb_sidebar_right .tb_main_col {
  <?php if ($lang_dir == 'ltr'): ?>
  border-right-width: 1px;
  <?php else: ?>
  border-left-width: 1px;
  <?php endif; ?>
}
#content.tb_row_content_separate > .tb_wrap > [class*="tb_col"] {
  padding: <?php echo $tbData->content_layout_settings['inner_padding']; ?>px !important;
}
#content.tb_row_content_separate #left_col {
  width: <?php echo $tbData->content_layout_settings['left_column_width']; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  left: -<?php echo $tbData->content_layout_settings['left_column_width'] - 1; ?>px;
  border-right: 1px solid #ddd;
  <?php else: ?>
  right: -<?php echo $tbData->content_layout_settings['left_column_width'] - 1; ?>px;
  border-left: 1px solid #ddd;
  <?php endif; ?>
}
#content.tb_row_content_separate #right_col {
  width: <?php echo $tbData->content_layout_settings['right_column_width']; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: -<?php echo $tbData->content_layout_settings['right_column_width'] - 1; ?>px;
  margin-left: -1px;
  border-left-width: 1px;
  <?php else: ?>
  margin-left: -<?php echo $tbData->content_layout_settings['right_column_width'] - 1; ?>px;
  margin-right: -1px;
  border-right-width: 1px;
  <?php endif; ?>
}

<?php if ($tbData->common['custom_css']): ?>

/*****************************************************/
/******   C U S T O M    S T Y L E S   ***************/
/*****************************************************/

<?php echo html_entity_decode($tbData->common['custom_css'], ENT_COMPAT, 'UTF-8'); ?>

<?php endif; ?>