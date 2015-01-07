<div id="stories_tags_widget_content" class="s_widget_options_holder">

  <h1 class="sm_title"><span>Tags</span></h1>

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
            <h2>Edit Tags</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#stories_tags_widget_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="stories_tags_widget_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?> tbLanguagePanel">
            <textarea name="widget_data[lang][<?php echo $language_id; ?>][menu]" class="tbMenuData" style="display: none;"><?php echo json_encode($settings['lang'][$language_id]['menu']); ?></textarea>

            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <p class="s_help">Enables the Tags block for the current language.</p>
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

            <span class="clear s_mb_20"></span>

            <div class="tb_wrap tb_gut_10 s_mb_30">
              <div class="s_row_2 tb_col tb_1_5">
                <label><strong>Style</strong></label>
              </div>
              <div class="s_row_2 tb_col tb_1_5">
                <label>Level 1</label>
                <div class="s_select">
                  <select name="widget_data[level_1_style]">
                    <option value="h2"<?php if ($settings['level_1_style'] == 'h2'): ?> selected="selected"<?php endif; ?>>H2</option>
                    <option value="h3"<?php if ($settings['level_1_style'] == 'h3'): ?> selected="selected"<?php endif; ?>>H3</option>
                    <option value="h4"<?php if ($settings['level_1_style'] == 'h4'): ?> selected="selected"<?php endif; ?>>H4</option>
                    <option value="list"<?php if ($settings['level_1_style'] == 'list'): ?> selected="selected"<?php endif; ?>>List</option>
                  </select>
                </div>
              </div>
              <div class="s_row_2 tb_col tb_1_5 s_ml_20">
                <label>Level 2</label>
                <div class="s_select">
                  <select name="widget_data[level_2_style]">
                    <option value="h2"<?php if ($settings['level_2_style'] == 'h2'): ?> selected="selected"<?php endif; ?>>H2</option>
                    <option value="h3"<?php if ($settings['level_2_style'] == 'h3'): ?> selected="selected"<?php endif; ?>>H3</option>
                    <option value="h4"<?php if ($settings['level_2_style'] == 'h4'): ?> selected="selected"<?php endif; ?>>H4</option>
                    <option value="list"<?php if ($settings['level_2_style'] == 'list'): ?> selected="selected"<?php endif; ?>>List</option>
                  </select>
                </div>
              </div>
            </div>

            <span class="clear s_mb_30 border_ddd"></span>

            <div class="tb_menu_listing clearfix">
              <ol class="left tbSortable"></ol>
              <div class="s_box_1 tb_tabs tb_tabs_inline s_white right">
                <h3>Tags list</h3>
                <div class="tb_add_menu_item tbMenuItemsTab">
                  <div class="s_row_2">
                    <label>Filter:</label>
                    <input type="text" class="tbItemFilter tb_1_1 s_mb_20" value="">
                  </div>
                  <ul class="tbItemsList">
                    <?php foreach ($settings['tags'][$language_id] as $tag): ?>
                    <li><a class="s_button_add_subwidgets s_button s_white s_h_20 s_icon_10 s_plus_10 left tbAddMenuItem" href="javascript:;" item_id="tag_<?php echo $tag['tag_id']; ?>"></a><span><?php echo $tag['name']; ?></span></li>
                    <?php endforeach; ?>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <?php endforeach; ?>

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

    var $widgetForm = $("#stories_tags_widget_content");

    var menu = tbApp.initTags($widgetForm, {
      width:          600,
      margin_left:    -300,
      sticky_sidebar: false
    });

    var event_id = tbHelper.generateUniqueId(10);

    $widgetForm.find(".tbLanguageTabs").first().tabs();

    $(tbApp).one("tbWidget:onUpdate." + event_id, function(event, widget) {
      menu.prepareForSave();
      $(tbApp).unbind("tbWidget:onUpdate." + event_id);
    });

    $(tbApp).one("tbWidget:closeForm", function(event, widget) {
      $(tbApp).unbind("tbWidget:onUpdate." + event_id);
    });

  });
</script>