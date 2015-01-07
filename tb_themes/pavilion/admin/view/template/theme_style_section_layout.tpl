<div class="s_row_1 tb_live_row_1">
  <label>Layout</label>
  <div class="s_select">
    <select name="<?php echo $input_property; ?>[layout][type]">
      <option value="full"<?php if($layout['type'] == 'full') echo ' selected="selected"';?>>Full</option>
      <?php if ($section == 'intro' || $section == 'content' || $section == 'footer'): ?>
      <option value="no_max_width"<?php if($layout['type'] == 'no_max_width') echo ' selected="selected"';?>>Full width</option>
      <?php endif; ?>
      <?php if ($section == 'widgets_row'): ?>
      <option value="no_max_width"<?php if($layout['type'] == 'no_max_width') echo ' selected="selected"';?>>Full width</option>
      <option value="no_max_width tb_row_separate"<?php if($layout['type'] == 'no_max_width tb_row_separate') echo ' selected="selected"';?>>Full width (separate columns)</option>
      <?php endif; ?>
      <option value="fixed"<?php if($layout['type'] == 'fixed') echo ' selected="selected"';?>>Fixed</option>
      <?php if ($section == 'widgets_row'): ?>
      <option value="separate"<?php if($layout['type'] == 'separate') echo ' selected="selected"';?>>Fixed (separate columns)</option>
      <?php endif; ?>
      <?php if ($section == 'content'): ?>
      <option value="content_separate"<?php if($layout['type'] == 'content_separate') echo ' selected="selected"';?>>Fixed (separate columns)</option>
      <?php endif; ?>
    </select>
  </div>
</div>
<?php if ($section == 'widgets_row'): ?>
<div class="s_row_1">
  <label>Extra class</label>
  <input type="text" name="<?php echo $input_property; ?>[layout][extra_class]" value="<?php echo $layout['extra_class']; ?>" />
</div>
<div class="s_row_1">
  <label>Merge empty columns</label>
  <input type="hidden" name="<?php echo $input_property; ?>[layout][merge_columns]" value="0" />
  <label class="tb_toggle"><input type="checkbox" name="<?php echo $input_property; ?>[layout][merge_columns]" value="1"<?php if($layout['merge_columns'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
</div>
<?php endif; ?>
<fieldset>
  <legend>Margin</legend>
  <div class="tb_wrap">
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Top</label>
      <input class="s_spinner" type="text" min="-50" max="50" step="5" name="<?php echo $input_property; ?>[layout][margin_top]" value="<?php echo $layout['margin_top']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Bottom</label>
      <input class="s_spinner" type="text" min="-50" max="50" step="5" name="<?php echo $input_property; ?>[layout][margin_bottom]" value="<?php echo $layout['margin_bottom']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1 tbStyleMarginLeftWrap">
      <label>Left/Right</label>
      <input class="s_spinner" type="text" min="-50" max="50" step="5" name="<?php echo $input_property; ?>[layout][margin_right]" value="<?php echo $layout['margin_right']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
  </div>
</fieldset>
<fieldset>
  <legend>Padding</legend>
  <div class="tb_wrap tbPaddingWrap">
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Top</label>
      <input class="s_spinner" type="text" min="0" max="50" step="5" name="<?php echo $input_property; ?>[layout][padding_top]" value="<?php echo $layout['padding_top']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Bottom</label>
      <input class="s_spinner" type="text" min="0" max="50" step="5" name="<?php echo $input_property; ?>[layout][padding_bottom]" value="<?php echo $layout['padding_bottom']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Right/Left</label>
      <input class="s_spinner" type="text" min="0" max="50" step="5" name="<?php echo $input_property; ?>[layout][padding_right]" value="<?php echo $layout['padding_right']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <?php if ($section == 'widgets_row'): ?>
    <div class="s_row_2 tb_col tb_1_4">
      <label>Inner</label>
      <input class="s_spinner" type="text" min="0" max="50" step="5" name="<?php echo $input_property; ?>[layout][inner_padding]" value="<?php echo $layout['inner_padding']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4">
      <label>Columns spacing</label>
      <input class="s_spinner" type="text" min="0" max="50" step="10" name="<?php echo $input_property; ?>[layout][columns_gutter]" value="<?php echo $layout['columns_gutter']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <?php endif; ?>
  </div>
</fieldset>
<?php if ($section == 'content'): ?>
<fieldset>
  <legend>Sidebars</legend>
  <div class="tb_wrap tbSidebarsWrap">
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Left column width</label>
      <input class="s_spinner" type="text" min="100" name="<?php echo $input_property; ?>[layout][left_column_width]" value="<?php echo $layout['left_column_width']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1">
      <label>Right column width</label>
      <input class="s_spinner" type="text" min="100" name="<?php echo $input_property; ?>[layout][right_column_width]" value="<?php echo $layout['right_column_width']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tbSettingsRow">
      <label>Inner padding</label>
      <input class="s_spinner" type="text" min="0" max="50" step="5" name="<?php echo $input_property; ?>[layout][inner_padding]" value="<?php echo $layout['inner_padding']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_1_1 tb_live_row_1 tbSettingsRow">
      <label>Columns spacing</label>
      <input class="s_spinner" type="text" min="0" max="50" step="10" name="<?php echo $input_property; ?>[layout][columns_gutter]" value="<?php echo $layout['columns_gutter']; ?>" size="6" />
      <span class="s_metric">px</span>
    </div>
  </div>
</fieldset>
<?php endif; ?>