<?php if (!in_array($settings['widget_admin_prefix'], array('latest_reviews', 'manufacturers', 'stories_list','stories_featured'))): ?>
<div class="tb_wrap tb_gut_30">
  <div class="s_row_2 tb_col tb_1_5">
    <label class="s_pt_5"><strong>List type</strong></label>
  </div>
  <div class="s_row_2 tb_col tb_1_4 tb_live_row_1 tb_live_1_1">
    <div class="s_full clearfix">
      <div class="s_select">
        <select name="widget_data[view_mode]">
          <option value="grid"<?php if ($settings['view_mode'] == 'grid'): ?> selected="selected"<?php endif; ?>>Grid</option>
          <option value="list"<?php if ($settings['view_mode'] == 'list'): ?> selected="selected"<?php endif; ?>>List</option>
          <option value="compact"<?php if ($settings['view_mode'] == 'compact'): ?> selected="selected"<?php endif; ?>>Compact</option>
        </select>
      </div>
    </div>
  </div>
</div>

<span class="s_mb_15 s_pt_15 clear border_eee"></span>
<?php endif; ?>

<div class="tb_wrap tb_gut_30 s_mb_20 tbProductOptionsSliderWrap">
  <div class="s_row_2 tb_col tb_1_5">
    <label><strong>Slider</strong></label>
  </div>
  <div class="s_row_2 tb_col tb_1_5 tbSettingsRow">
    <label>Enabled</label>
    <span class="clear"></span>
    <input type="hidden" name="widget_data[slider]" value="0" />
    <label class="tb_toggle"><input type="checkbox" name="widget_data[slider]" value="1"<?php if ($settings['slider'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
  </div>
  <div class="s_row_2 tb_col tb_1_5 tbSettingsRow tbSliderSettingsStep">
    <label>Slide step</label>
    <input class="s_spinner" type="text" name="widget_data[slider_step]" value="<?php echo $settings['slider_step']; ?>" size="5" min="1" max="8" />
  </div>
  <div class="s_row_2 tb_col tb_1_5 tbSettingsRow">
    <label>Slide speed</label>
    <input class="s_spinner" type="text" name="widget_data[slider_speed]" value="<?php echo $settings['slider_speed']; ?>" size="7" min="100" step="100" />
    <span class="s_metric">ms</span>
  </div>
  <div class="s_row_2 tb_col tb_1_5 tbSettingsRow">
    <label>Show pagination</label>
    <span class="clear"></span>
    <input type="hidden" name="widget_data[slider_pagination]" value="0" />
    <label class="tb_toggle"><input type="checkbox" name="widget_data[slider_pagination]" value="1"<?php if ($settings['slider_pagination'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
  </div>
</div>
<div class="tb_wrap tb_gut_30 tbSettingsRow">
  <div class="s_row_2 tb_col tb_1_5">
    &nbsp;
  </div>
  <div class="s_row_2 tb_col tb_1_5">
    <label>Navigation position</label>
    <span class="clear"></span>
    <div class="s_full clearfix">
      <div class="s_select">
        <select name="widget_data[slider_nav_position]">
          <option value="top"<?php if ($settings['slider_nav_position'] == 'top'): ?> selected="selected"<?php endif; ?>>Top</option>
          <option value="side"<?php if ($settings['slider_nav_position'] == 'side'): ?> selected="selected"<?php endif; ?>>Side</option>
        </select>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $(document).ready(function() {
    $("#widget_settings_holder").find(':checkbox[name="widget_data[slider]"]').bind("change", function() {
      var $wrapper = $(this).closest(".tbProductOptionsSliderWrap");

      $wrapper
        .find(".tbSettingsRow").add($wrapper.next(".tbSettingsRow")).not($(this).closest(".tbSettingsRow"))
        .toggleClass("tb_disabled", !$(this).is(":checked"));
    }).trigger("change");
  });
</script>