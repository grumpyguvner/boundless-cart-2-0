<?php
$classes = '';

if ($color_item['can_inherit']) {
  $classes .= $color_item['inherit'] ? ' tb_inherit tb_disabled' : ' tb_no_inherit';
}
if (isset($color_item['children'])) {
  $classes .= ' tbHasChildren';
}

$attributes = '';
if (!empty($color_item['parent_id'])) {
  $attributes .= ' parent_id="color_item_' . $color_item['parent_id'] . '"';
}
if (!empty($color_item['parent_color'])) {
  $attributes .= ' parent_color="' . $color_item['parent_color'] . '"';
}
?>
<div id="color_item_<?php echo $color_item['id']; ?>" class="s_row_2 tb_col tb_1_<?php echo $cols_num; ?><?php echo $classes; ?> tb_live_row_1 tb_live_1_1 tbColorItem"<?php echo ($attributes) ?>>
  <label<?php if ($color_item['can_inherit']): ?> class="tbColorToggleInherit" title="<?php echo $color_item['inherit_title']; ?>"<?php endif; ?>><?php echo $color_item['label']; ?></label>
  <div class="colorSelector<?php if ($color_item['property'] == 'background-color' || $color_item['property'] == 'border-color'): ?> tbBackgroundColor<?php endif; ?>" name="main">
    <div style="background-color: <?php echo $color_item['color']; ?>;"></div>
  </div>
  <input type="text" name="<?php echo $input_property; ?>[color]" value="<?php echo $color_item['color']; ?>" />
  <input type="hidden" name="<?php echo $input_property; ?>[important]" value="<?php echo $color_item['important']; ?>" />
  <input type="hidden" name="<?php echo $input_property; ?>[property]" value="<?php echo $color_item['property']; ?>" />
  <input type="hidden" name="<?php echo $input_property; ?>[inherit]" value="<?php echo $color_item['inherit']; ?>" />
  <input type="hidden" name="<?php echo $input_property; ?>[force_print]" value="<?php echo $color_item['force_print']; ?>" />
  <textarea name="<?php echo $input_property; ?>[elements]" style="display: none;"><?php echo $color_item['elements']; ?></textarea>
</div>
