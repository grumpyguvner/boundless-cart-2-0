<div id="category_widget_content" class="s_widget_options_holder">

  <h1 class="sm_title"><span>Categories</span></h1>

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
          <h2>Edit Categories</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#category_widget_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="category_widget_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">
            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <p class="s_help">Enables the Text content block for the current language.</p>
            </div>

            <div class="s_row_1">
              <label><strong>Title</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full clearfix">
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
          </div>
          <?php endforeach; ?>

          <fieldset>
            <legend>Level 1</legend>
            <div class="tb_wrap">
              <div class="s_row_2 tb_col tb_1_4">
                <label>Visibility</label>
                <div class="s_full clearfix">
                  <div class="s_select">
                    <select name="widget_data[level_1]">
                      <option value="show"<?php if ($settings['level_1'] == 'show')  echo ' selected="selected"'; ?>>Always show</option>
                      <option value="hide"<?php if ($settings['level_1'] == 'hide') echo ' selected="selected"'; ?>>Hide unselected</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="s_row_2 tb_col tb_1_4">
                <label>Style</label>
                <div class="s_full clearfix">
                  <div class="s_select">
                    <select name="widget_data[level_1_style]">
                      <option value="list"<?php  if ($settings['level_1_style'] == 'list')  echo ' selected="selected"'; ?>>List</option>
                      <option value="h2"<?php if ($settings['level_1_style'] == 'h2') echo ' selected="selected"'; ?>>H2</option>
                      <option value="h3"<?php if ($settings['level_1_style'] == 'h3') echo ' selected="selected"'; ?>>H3</option>
                      <option value="h4"<?php if ($settings['level_1_style'] == 'h4') echo ' selected="selected"'; ?>>H4</option>
                      <option value="hide"<?php if ($settings['level_1_style'] == 'hide') echo ' selected="selected"'; ?>>Hidden</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="s_row_2 tb_col tb_1_4">
                <label>Respect 'Top'</label>
                <input type="hidden" name="widget_data[respect_top]" value="0" />
                <label class="tb_toggle"><input type="checkbox" name="widget_data[respect_top]" value="1"<?php if($settings['respect_top'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              </div>
            </div>
          </fieldset>
          
          <fieldset>
            <legend>Level 2</legend>
            <div class="tb_wrap">
              <div class="s_row_2 tb_col tb_1_4">
                <label>Visibility</label>
                <div class="s_full clearfix">
                  <div class="s_select">
                    <select name="widget_data[level_2]">
                      <option value="show_select"<?php if ($settings['level_2'] == 'show_select')  echo ' selected="selected"'; ?>>Show on parent selected</option>
                      <option value="show"<?php if ($settings['level_2'] == 'show')  echo ' selected="selected"'; ?>>Always show</option>
                      <option value="accordion"<?php if ($settings['level_2'] == 'accordion')  echo ' selected="selected"'; ?>>Accordion</option>
                      <option value="toggle"<?php if ($settings['level_2'] == 'toggle')  echo ' selected="selected"'; ?>>Toggle</option>
                      <option value="hide"<?php if ($settings['level_2'] == 'hide') echo ' selected="selected"'; ?>>Hidden</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="s_row_2 tb_col tb_1_4">
                <label>Style</label>
                <div class="s_full clearfix">
                  <div class="s_select">
                    <select name="widget_data[level_2_style]">
                      <option value="list"<?php  if ($settings['level_2_style'] == 'list')  echo ' selected="selected"'; ?>>List</option>
                      <option value="h2"<?php if ($settings['level_2_style'] == 'h2') echo ' selected="selected"'; ?>>H2</option>
                      <option value="h3"<?php if ($settings['level_2_style'] == 'h3') echo ' selected="selected"'; ?>>H3</option>
                      <option value="h4"<?php if ($settings['level_2_style'] == 'h4') echo ' selected="selected"'; ?>>H4</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </fieldset>

          <fieldset>
            <legend>Level 3</legend>
            <div class="tb_wrap">
              <div class="s_row_2 tb_col tb_1_4">
                <label>Visibility</label>
                <div class="s_full clearfix">
                  <div class="s_select">
                    <select name="widget_data[level_3]">
                      <option value="show_select"<?php if ($settings['level_3'] == 'show_select')  echo ' selected="selected"'; ?>>Show on parent select</option>
                      <option value="show"<?php if ($settings['level_3'] == 'show')  echo ' selected="selected"'; ?>>Always show</option>
                      <option value="hide"<?php if ($settings['level_3'] == 'hide') echo ' selected="selected"'; ?>>Hidden</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="s_row_2 tb_col tb_1_4">
                <label>Style</label>
                <div class="s_full clearfix">
                  <div class="s_select">
                    <select name="widget_data[level_3_style]">
                      <option value="list"<?php  if ($settings['level_3_style'] == 'list')  echo ' selected="selected"'; ?>>List</option>
                      <option value="h2"<?php if ($settings['level_3_style'] == 'h2') echo ' selected="selected"'; ?>>H2</option>
                      <option value="h3"<?php if ($settings['level_3_style'] == 'h3') echo ' selected="selected"'; ?>>H3</option>
                      <option value="h4"<?php if ($settings['level_3_style'] == 'h4') echo ' selected="selected"'; ?>>H4</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </fieldset>

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
$(document).ready(function() {

  $("#widget_settings_holder").find(".tbLanguageTabs").first().tabs();

});
</script>