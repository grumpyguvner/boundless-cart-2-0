<div id="<?php echo $settings['widget_admin_prefix']; ?>_widget_content" class="s_widget_options_holder">

  <h1 class="sm_title"><span><?php echo $settings['widget_admin_title']; ?></span></h1>

  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <div<?php if ($widget->hasCommonOptions()) echo ' class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs"'; ?>>

      <?php if ($widget->hasCommonOptions()): ?>
      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_<?php echo $settings['widget_admin_prefix']; ?>_settings_holder">Common</a></li>
          <li><a href="#widget_box_styles_holder">Styles</a></li>
        </ul>
      </div>
      <?php endif; ?>

      <div id="widget_<?php echo $settings['widget_admin_prefix']; ?>_settings_holder" class="tb_subpanel">

        <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>

          <div class="tb_cp">
          <h2><?php echo $settings['widget_admin_title']; ?> common settings</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#<?php echo $settings['widget_admin_prefix']; ?>_widget_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="<?php echo $settings['widget_admin_prefix']; ?>_widget_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">

            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <p class="s_help">Enables the <?php echo $settings['widget_admin_title']; ?> content block for the current language.</p>
            </div>

            <div class="s_row_1">
              <label><strong>Title</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full">
                <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][title]" value="<?php echo $settings['lang'][$language_id]['title']; ?>" />
                <div class="s_text_align s_buttons_group">
                  <input id="text_title_align_left_<?php echo $language_id; ?>" class="tb_nostyle" type="radio" name="widget_data[lang][<?php echo $language_id; ?>][title_align]" value="left"<?php if ($settings['lang'][$language_id]['title_align'] == 'left') echo ' checked="checked"'; ?> />
                  <label class="s_button s_h_30 s_white s_icon_16 fa-align-left" for="text_title_align_left_<?php echo $language_id; ?>"></label>
                  <input id="text_title_align_center_<?php echo $language_id; ?>" class="tb_nostyle" type="radio" name="widget_data[lang][<?php echo $language_id; ?>][title_align]" value="center"<?php if ($settings['lang'][$language_id]['title_align'] == 'center') echo ' checked="checked"'; ?> />
                  <label class="s_button s_h_30 s_white s_icon_16 fa-align-center" for="text_title_align_center_<?php echo $language_id; ?>"></label>
                  <input id="text_title_align_right_<?php echo $language_id; ?>" class="tb_nostyle" type="radio" name="widget_data[lang][<?php echo $language_id; ?>][title_align]" value="right"<?php if ($settings['lang'][$language_id]['title_align'] == 'right') echo ' checked="checked"'; ?> />
                  <label class="s_button s_h_30 s_white s_icon_16 fa-align-right" for="text_title_align_right_<?php echo $language_id; ?>"></label>
                </div>
              </div>
            </div>

            <div class="s_row_1">
              <label><strong>Page url</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full">
                <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][page_url]" value="<?php echo $settings['lang'][$language_id]['page_url']; ?>" />
              </div>
            </div>
          </div>
          <?php endforeach; ?>
        </div>

        <div class="s_row_1">
          <label><strong>Likebox style</strong></label>
          <div class="s_select">
            <select name="widget_data[like_box_style]">
              <option value="default"<?php if($settings['like_box_style'] == 'default') echo ' selected="selected"';?>>Default</option>
              <option value="custom"<?php if($settings['like_box_style'] == 'custom')   echo ' selected="selected"';?>><?php echo $tbManager->getThemeConfig('name'); ?></option>
            </select>
          </div>
        </div>
        <div class="s_row_1 tbOptCustom">
          <label><strong>Like button</strong></label>
          <div class="s_select">
            <select name="widget_data[like_button_style]">
              <option value="button"<?php if($settings['like_button_style'] == 'button')             echo ' selected="selected"';?>>Standard</option>
              <option value="button_count"<?php if($settings['like_button_style'] == 'button_count') echo ' selected="selected"';?>>Button count</option>
            </select>
          </div>
        </div>
        
        <?php /*
        <div class="s_row_1">
          <label><strong>Show user profile</strong></label>
          <input type="hidden" name="widget_data[user_profile]" value="0" />
          <input class="tb_toggle" type="checkbox" name="widget_data[user_profile]" value="1"<?php if($settings['user_profile'] == '1') echo ' checked="checked"';?> />
        </div>
        */ ?>

        <div class="s_row_1 tbOptCustom">
          <label><strong>Profiles number</strong></label>
          <input class="s_spinner" type="text" size="6" min="3" name="widget_data[profiles_num]" value="<?php echo $settings['profiles_num']; ?>" />
        </div>

        <div class="s_row_1 tbOptCustom">
          <label><strong>Profiles max rows</strong></label>
          <input class="s_spinner" type="text" size="6" min="1" name="widget_data[profiles_rows]" value="<?php echo $settings['profiles_rows']; ?>" />
        </div>

        <div class="s_row_1 tbOptCustom">
          <label><strong>Put border on profile</strong></label>
          <input type="hidden" name="widget_data[profile_border]" value="0" />
          <label class="tb_toggle"><input type="checkbox" name="widget_data[profile_border]" value="1"<?php if($settings['profile_border'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
        </div>

        <div class="s_row_1 tbOptCustom">
          <label><strong>Show profile name</strong></label>
          <input type="hidden" name="widget_data[profile_name]" value="0" />
          <label class="tb_toggle"><input type="checkbox" name="widget_data[profile_name]" value="1"<?php if($settings['profile_name'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
        </div>

        <div class="s_row_1 tbOptDefault">
          <label><strong>Height</strong></label>
          <input class="s_spinner" type="text" size="6" min="1" name="widget_data[default_height]" value="<?php echo $settings['default_height']; ?>" />
          <span class="s_metric">px</span>
        </div>

        <div class="s_row_1 tbOptDefault">
          <label><strong>Inner Padding</strong></label>
          <input class="s_spinner" type="text" size="6" min="0" step="5" name="widget_data[default_padding]" value="<?php echo $settings['default_padding']; ?>" />
          <span class="s_metric">px</span>
        </div>
      </div>

      <?php if ($widget->hasCommonOptions()): ?>
      <div id="widget_box_styles_holder" class="tb_subpanel tb_has_sidebar tb_cp clearfix tbWidgetCommonOptions">
        <?php require tb_modification(dirname(__FILE__) . '/common_options.tpl'); ?>
      </div>
      <?php endif; ?>

    </div>

    <div class="s_submit clearfix">
      <a class="s_button s_red s_h_40 tbWidgetUpdate" href="javascript:;">Update Settings</a>
    </div>

  </form>

</div>

<script type="text/javascript">
(function ($) {
  var $container = $("#widget_<?php echo $settings['widget_admin_prefix']; ?>_settings_holder");

  $container.find(".tbLanguageTabs").first().tabs();

  $container.find('select[name$="[like_box_style]"]').bind("change", function() {
      $container.find("div.tbOptCustom").toggle($(this).val() != 'default');
      $container.find("div.tbOptDefault").toggle($(this).val() == 'default');
  }).trigger("change");

})(jQuery);
</script>
