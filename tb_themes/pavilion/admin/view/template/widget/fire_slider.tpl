<div id="fireslider_widget_content" class="s_widget_options_holder">

  <h1 class="sm_title"><span>FireSlider</span></h1>

  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <div<?php if ($widget->hasCommonOptions()) echo ' class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs"'; ?>>

      <?php if ($widget->hasCommonOptions()): ?>
      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_settings_holder">Edit</a></li>
          <li><a href="#widget_box_styles_holder">Styles</a></li>
        </ul>
      </div>
      <?php endif; ?>

      <div id="widget_settings_holder" class="tb_subpanel">

        <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>

          <div class="tb_cp">
          <h2>Edit FireSlider</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#text_widget_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="text_widget_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">
            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <p class="s_help">Enables the Text content block for the current language.</p>
            </div>
          </div>
          <?php endforeach; ?>

          <div class="s_row_1">
            <label><strong>Slider</strong></label>
            <div class="s_select">
              <select name="widget_data[slider_id]">
                <option value="0">None</option>
                <?php foreach ($tbData->getSliders() as $slider): ?>
                <option value="<?php echo $slider['id']; ?>"<?php if($settings['slider_id'] == $slider['id']) echo ' selected="selected"';?>><?php echo $slider['name']; ?></option>
                <?php endforeach; ?>
              </select>
            </div>
          </div>

          <div class="s_row_1">
            <label><strong>Navigation size</strong></label>
            <div class="s_select">
              <select name="widget_data[navigation_size]">
                <option value="3"<?php if($settings['navigation_size'] == '3') echo ' selected="selected"';?>>Large</option>
                <option value="2"<?php if($settings['navigation_size'] == '2') echo ' selected="selected"';?>>Medium</option>
                <option value="1"<?php if($settings['navigation_size'] == '1') echo ' selected="selected"';?>>Small</option>
              </select>
            </div>
          </div>

        </div>

      </div>

      <?php if ($widget->hasCommonOptions()): ?>
      <div id="widget_box_styles_holder" class="tb_subpanel tb_has_sidebar tb_cp clearfix tbWidgetCommonOptions">
        <?php require_once 'common_options.tpl'; ?>
      </div>
      <?php endif; ?>

    </div>

    <div class="s_submit clearfix">
      <a class="s_button s_red s_h_40 tbWidgetUpdate" href="javascript:;">Update Settings</a>
    </div>

  </form>

</div>

<script type="text/javascript">
$(document).ready(function() {
  $("#widget_settings_holder").find(".tbLanguageTabs").first().tabs();
});
</script>