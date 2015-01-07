<div id="widget_latest_tweets" class="s_widget_options_holder tb_cp">

  <h1 class="sm_title"><span>Latest Tweets</span></h1>
  
  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <div<?php if ($widget->hasCommonOptions()) echo ' class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs"'; ?>>

      <?php if ($widget->hasCommonOptions()): ?>
      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_settings_holder">Common</a></li>
          <li><a href="#widget_box_styles_holder">Box style</a></li>
        </ul>
      </div>
      <?php endif; ?>

      <div id="widget_settings_holder" class="tb_subpanel">
        
        <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>

          <div class="tb_cp">
            <h2>Edit <?php echo $settings['widget_admin_title']; ?></h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#latest_tweets_widget_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): $language_id = $language['language_id']; $lang = $settings['lang'][$language_id]; ?>
          <div id="latest_tweets_widget_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">

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

            <div class="s_row_1 tbDisplayCustom">
              <label><strong>Follow button text</strong></label>
              <?php $button_lang = $lang['follow_button_lang']; ?>
              <div class="s_select">
                <select name="widget_data[lang][<?php echo $language_id; ?>][follow_button_lang]">
                  <option value="ja"<?php if($button_lang == 'ja') echo ' selected="selected"'; ?>>Japanese - 日本語</option>
                  <option value="pt"<?php if($button_lang == 'pt') echo ' selected="selected"'; ?>>Portuguese - Português</option>
                  <option value="da"<?php if($button_lang == 'da') echo ' selected="selected"'; ?>>Danish - Dansk</option>
                  <option value="sv"<?php if($button_lang == 'sv') echo ' selected="selected"'; ?>>Swedish - Svenska</option>
                  <option value="uk"<?php if($button_lang == 'uk') echo ' selected="selected"'; ?>>Ukrainian - Українська мова</option>
                  <option value="it"<?php if($button_lang == 'it') echo ' selected="selected"'; ?>>Italian - Italiano</option>
                  <option value="es"<?php if($button_lang == 'es') echo ' selected="selected"'; ?>>Spanish - Español</option>
                  <option value="fr"<?php if($button_lang == 'fr') echo ' selected="selected"'; ?>>French - français</option>
                  <option value="tr"<?php if($button_lang == 'tr') echo ' selected="selected"'; ?>>Turkish - Türkçe</option>
                  <option value="hi"<?php if($button_lang == 'hi') echo ' selected="selected"'; ?>>Hindi - हिन्दी</option>
                  <option value="he"<?php if($button_lang == 'he') echo ' selected="selected"'; ?>>Hebrew - עִבְרִית</option>
                  <option value="id"<?php if($button_lang == 'id') echo ' selected="selected"'; ?>>Indonesian - Bahasa Indonesia</option>
                  <option value="th"<?php if($button_lang == 'th') echo ' selected="selected"'; ?>>Thai - ภาษาไทย</option>
                  <option value="ar"<?php if($button_lang == 'ar') echo ' selected="selected"'; ?>>Arabic - العربية</option>
                  <option value="en"<?php if($button_lang == 'en') echo ' selected="selected"'; ?>>English</option>
                  <option value="de"<?php if($button_lang == 'de') echo ' selected="selected"'; ?>>German - Deutsch</option>
                  <option value="pl"<?php if($button_lang == 'pl') echo ' selected="selected"'; ?>>Polish - Polski</option>
                  <option value="ca"<?php if($button_lang == 'ca') echo ' selected="selected"'; ?>>Catalan - català</option>
                  <option value="ko"<?php if($button_lang == 'ko') echo ' selected="selected"'; ?>>Korean - 한국어</option>
                  <option value="no"<?php if($button_lang == 'no') echo ' selected="selected"'; ?>>Norwegian - Norsk</option>
                  <option value="nl"<?php if($button_lang == 'nl') echo ' selected="selected"'; ?>>Dutch - Nederlands</option>
                  <option value="hu"<?php if($button_lang == 'hu') echo ' selected="selected"'; ?>>Hungarian - Magyar</option>
                  <option value="fa"<?php if($button_lang == 'fa') echo ' selected="selected"'; ?>>Farsi - فارسی</option>
                  <option value="ur"<?php if($button_lang == 'ur') echo ' selected="selected"'; ?>>Urdu - اردو</option>
                  <option value="ru"<?php if($button_lang == 'ru') echo ' selected="selected"'; ?>>Russian - Русский</option>
                  <option value="fi"<?php if($button_lang == 'fi') echo ' selected="selected"'; ?>>Finnish - Suomi</option>
                  <option value="msa"<?php if($button_lang == 'msa') echo ' selected="selected"'; ?>>Malay - Bahasa Melayu</option>
                  <option value="zh-tw"<?php if($button_lang == 'zh-tw') echo ' selected="selected"'; ?>>Traditional Chinese - 繁體中文</option>
                  <option value="zh-cn"<?php if($button_lang == 'zh-cn') echo ' selected="selected"'; ?>>Simplified Chinese - 简体中文</option>
                  <option value="fil"<?php if($button_lang == 'fil') echo ' selected="selected"'; ?>>Filipino - Filipino</option>
                </select>
              </div>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>

            </div>

            <span class="clear s_mb_20"></span>

          </div>
          <?php endforeach; ?>

          <div class="tb_wrap tb_gut_30">
            <div class="s_row_1">
              <label><strong>Display type</strong></label>
              <div class="s_select">
                <select name="widget_data[display_type]">
                  <option value="default"<?php if($settings['display_type'] == 'default') echo ' selected="selected"';?>>Default</option>
                  <option value="custom"<?php if($settings['display_type'] == 'custom') echo ' selected="selected"';?>>Custom</option>
                </select>
              </div>
            </div>

            <div class="s_row_1 tbDisplayCustom">
              <label><strong>Style</strong></label>
              <div class="s_select">
                <select name="widget_data[style]">
                  <option value="1"<?php if($settings['style'] == '1') echo ' selected="selected"';?>>Thumb next to description</option>
                  <option value="2"<?php if($settings['style'] == '2') echo ' selected="selected"';?>>Thumb on top on description</option>
                  <option value="3"<?php if($settings['style'] == '3') echo ' selected="selected"';?>>No thumb</option>
                </select>
              </div>
            </div>

            <div class="s_row_1 tbDisplayCustom">
              <label><strong>Max Tweets Shown</strong></label>
              <input class="s_spinner" type="text" name="widget_data[tweets_num]" value="<?php echo $settings['tweets_num']; ?>" size="5" min="1" />
            </div>

            <div class="s_row_1 tbDisplayCustom">
              <label for="widget_latest_tweets_button_toggle"><strong>Follow button</strong></label>
              <input type="hidden" name="widget_data[show_follow_button]" value="0" />
              <label class="tb_toggle"><input id="widget_latest_tweets_button_toggle" type="checkbox" name="widget_data[show_follow_button]" value="1"<?php if($settings['show_follow_button'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
            </div>

            <div class="s_row_1 tbDisplayCustom">
              <label for="widget_latest_tweets_hide_replies_toggle"><strong>Hide replies</strong></label>
              <input type="hidden" name="widget_data[hide_replies]" value="0" />
              <label class="tb_toggle"><input id="widget_latest_tweets_hide_replies_toggle" type="checkbox" name="widget_data[hide_replies]" value="1"<?php if($settings['hide_replies'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
            </div>

             <div class="s_row_1 tbDisplayCustom">
              <label for="widget_latest_tweets_hide_replies_toggle"><strong>Show actions</strong></label>
              <input type="hidden" name="widget_data[hover_actions]" value="0" />
              <label class="tb_toggle"><input id="widget_latest_tweets_show_actions_toggle" type="checkbox" name="widget_data[hover_actions]" value="1"<?php if($settings['hover_actions'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
            </div>

          </div>

        </div>
      </div>
      
      <?php if ($widget->hasCommonOptions()): ?>
      <div id="widget_box_styles_holder" class="tb_subpanel tb_has_sidebar clearfix tbWidgetCommonOptions">
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
  $("#widget_settings_holder").find(".tbLanguageTabs").first().tabs();
  $("#widget_settings_holder").find('select[name$="[display_type]"]').bind("change", function() {
      $("#widget_settings_holder").find(".tbDisplayCustom").toggle($(this).val() != 'default');
    }).trigger("change");

})(jQuery);
</script>