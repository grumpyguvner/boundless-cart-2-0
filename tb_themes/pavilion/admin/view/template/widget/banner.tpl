<div id="banner_widget_content" class="s_widget_options_holder">

  <h1 class="sm_title"><span>Banner</span></h1>

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
          <h2>Edit Banner</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#banner_widget_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="banner_widget_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">
            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <p class="s_help">Enables the content block for the current language.</p>
            </div>

            <div class="s_row_1">
              <label><strong>Line 1</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full">
                <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][line_1]" value="<?php echo $settings['lang'][$language_id]['line_1']; ?>" />
              </div>
            </div>

            <div class="s_row_1">
              <label><strong>Line 2</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full">
                <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][line_2]" value="<?php echo $settings['lang'][$language_id]['line_2']; ?>" />
              </div>
            </div>

            <div class="s_row_1">
              <label><strong>Line 3</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full">
                <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][line_3]" value="<?php echo $settings['lang'][$language_id]['line_3']; ?>" />
              </div>
            </div>

            <div class="s_row_1">
              <label><strong>Link</strong></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <div class="s_full">
                <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][url]" value="<?php echo $settings['lang'][$language_id]['url']; ?>" />
              </div>
              <span class="s_metric s_target">
                <select name="widget_data[lang][<?php echo $language_id; ?>][url_target]">
                  <option value="_self"<?php if($settings['lang'][$language_id]['url_target']  == '_self')  echo ' selected="selected"';?>>_self</option>
                  <option value="_blank"<?php if($settings['lang'][$language_id]['url_target'] == '_blank') echo ' selected="selected"';?>>_blank</option>
                </select>
              </span>
            </div>

            <div class="s_row_1">
              <label><strong>Text align</strong></label>
              <div class="s_select">
                <select name="widget_data[lang][<?php echo $language_id; ?>][text_align]">
                  <option value="left"<?php if($settings['lang'][$language_id]['text_align']  == 'left')  echo ' selected="selected"';?>>Left</option>
                  <option value="center"<?php if($settings['lang'][$language_id]['text_align'] == 'center') echo ' selected="selected"';?>>Center</option>
                  <option value="right"<?php if($settings['lang'][$language_id]['text_align'] == 'right') echo ' selected="selected"';?>>Right</option>
                  <option value="justify"<?php if($settings['lang'][$language_id]['text_align'] == 'justify') echo ' selected="selected"';?>>Justify</option>
                </select>
              </div>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
            </div>

            <div class="s_row_1">
              <label><strong>Text valign</strong></label>
              <div class="s_select">
                <select name="widget_data[lang][<?php echo $language_id; ?>][text_valign]">
                  <option value="top"<?php if($settings['lang'][$language_id]['text_valign']  == 'top')  echo ' selected="selected"';?>>Top</option>
                  <option value="middle"<?php if($settings['lang'][$language_id]['text_valign'] == 'middle') echo ' selected="selected"';?>>Middle</option>
                  <option value="bottom"<?php if($settings['lang'][$language_id]['text_valign'] == 'bottom') echo ' selected="selected"';?>>Bottom</option>
                </select>
              </div>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
            </div>

          </div>
          <?php endforeach; ?>

        </div>
        
        <fieldset class="tb_image_row">
          <legend>Banner image</legend>
          
          <div class="tb_wrap tb_gut_30">
            <div class="tb_col">
              <input type="hidden" name="widget_data[image]" value="<?php echo $settings['image']; ?>" id="banner_widget_image" />
              <span class="tb_thumb">
                <img src="<?php echo $settings['image_preview']; ?>" id="banner_widget_image_preview" class="image" onclick="image_upload('banner_widget_image', 'banner_widget_image_preview');" />
              </span>
            </div>
            <div class="tb_col tb_1_2">
              <div class="s_row_1">
                <label>Aspect Ratio</label>
                <input class="inline" type="text" name="widget_data[ratio_w]" value="<?php echo $settings['ratio_w']; ?>" size="3" />
                <span class="s_input_separator">&nbsp;/&nbsp;</span>
                <input class="inline" type="text" name="widget_data[ratio_h]" value="<?php echo $settings['ratio_h']; ?>" size="3" />
              </div>
              <div class="s_row_1">
                <label>Max Height</label>
                <input class="s_spinner" type="text" name="widget_data[max_height]" value="<?php echo $settings['max_height']; ?>" size="7" />
                <span class="s_metric">px</span>
                <p class="s_help right">0 for no maximum height.</p>
              </div>
              <div class="s_row_1">
                <label>Min Height</label>
                <input class="s_spinner" type="text" name="widget_data[min_height]" value="<?php echo $settings['min_height']; ?>" size="7" />
                <span class="s_metric">px</span>
              </div>
              <div class="s_row_1">
                <label>Hover effect</label>
                <div class="s_full tb_2_5">
                  <div class="s_select">
                    <select name="widget_data[hover]">
                      <option value="none"<?php  if ($settings['hover'] == 'none')  echo ' selected="selected"'; ?>>None</option>
                      <option value="zoom"<?php  if ($settings['hover'] == 'zoom')  echo ' selected="selected"'; ?>>Image zoom</option>
                      <option value="color"<?php if ($settings['hover'] == 'color') echo ' selected="selected"'; ?>>Color overlay</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="s_row_1 tbSettingsRow">
                <label>Zoom origin</label>
                <div class="s_full tb_2_5">
                  <div class="s_select">
                    <select name="widget_data[zoom_origin]">
                      <option value="center"<?php  if ($settings['zoom_origin'] == 'center')  echo ' selected="selected"'; ?>>Center</option>
                      <option value="top"<?php  if ($settings['zoom_origin'] == 'top')  echo ' selected="selected"'; ?>>Top</option>
                      <option value="top right"<?php  if ($settings['zoom_origin'] == 'top right')  echo ' selected="selected"'; ?>>Top Right</option>
                      <option value="right"<?php  if ($settings['zoom_origin'] == 'right')  echo ' selected="selected"'; ?>>Right</option>
                      <option value="bottom right"<?php  if ($settings['zoom_origin'] == 'bottom right')  echo ' selected="selected"'; ?>>Botttom Right</option>
                      <option value="bottom"<?php  if ($settings['zoom_origin'] == 'bottom')  echo ' selected="selected"'; ?>>Bottom</option>
                      <option value="bottom left"<?php  if ($settings['zoom_origin'] == 'bottom left')  echo ' selected="selected"'; ?>>Bottom Left</option>
                      <option value="left"<?php  if ($settings['zoom_origin'] == 'left')  echo ' selected="selected"'; ?>>Left</option>
                      <option value="top left"<?php  if ($settings['zoom_origin'] == 'top left')  echo ' selected="selected"'; ?>>Top Left</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </fieldset>

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
  $("#widget_settings_holder")
    .find(".tbLanguageTabs").first().tabs().end().end()
    .find('select[name="widget_data[hover]"]').bind("change", function() {
      $(this).closest("fieldset")
        .find('select[name="widget_data[zoom_origin]"]')
        .closest(".tbSettingsRow").toggle($(this).val() == 'zoom');
    }).trigger("change").end()
    .on("change", "input[name$='[image]']", function() {
      var img = new Image();
      var $el = $(this).closest(".tb_image_row");

      img.onload = function() {
        $el
          .find("input[name$='[ratio_w]']").val(this.width).end()
          .find("input[name$='[ratio_h]']").val(this.height);
      };

      img.src = $sReg.get("/tb/url/image_url") + $(this).val();
    });

});
</script>