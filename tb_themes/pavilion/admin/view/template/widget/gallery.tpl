<div id="widget_gallery" class="s_widget_options_holder tb_cp">

  <h1 class="sm_title"><span>Gallery</span></h1>

  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <div class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs">

      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_settings_holder">Common</a></li>
          <li><a href="#widget_images_holder">Images</a></li>
          <li><a href="#widget_box_styles_holder">Box styles</a></li>
        </ul>
      </div>

      <div id="widget_settings_holder" class="tb_subpanel">

        <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>

        <div class="tb_cp">
          <h2>Edit Gallery</h2>
        </div>

        <?php if (count($languages) > 1): ?>
        <ul class="tb_tabs_nav clearfix">
          <?php foreach ($languages as $language): ?>
          <li class="s_language">
            <a href="#widget_gallery_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
              <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
              <?php echo $language['code']; ?>
            </a>
          </li>
          <?php endforeach; ?>
        </ul>
        <?php endif; ?>

        <?php foreach ($languages as $language): ?>
        <?php $language_id = $language['language_id']; ?>
        <div id="widget_gallery_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">
          <div class="s_row_1">
            <label><strong>Active</strong></label>
            <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
            <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
            <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
            <p class="s_help">Enables the Gallery content block for the current language.</p>
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

        </div>
        <?php endforeach; ?>

        <fieldset>
          <legend>Style</legend>
          <div class="tb_wrap tb_gut_30">
            <div class="s_row_2 tb_col tb_1_4">
              <label>Gallery type</label>
              <div class="s_select">
                <select name="widget_data[gallery_type]" id="widget_gallery_type">
                  <option value="slide"<?php if($settings['gallery_type'] == 'slide') echo ' selected="selected"';?>>Slide</option>
                  <option value="grid"<?php  if($settings['gallery_type'] == 'grid')  echo ' selected="selected"';?>>Grid</option>
                </select>
              </div>
            </div>
            <div class="s_row_2 tb_col tb_1_4 tbGalleryTypeSlide">
              <label>Navigation</label>
              <div class="s_select">
                <select name="widget_data[gallery_nav]" id="widget_gallery_type">
                  <option value="dots"<?php   if($settings['gallery_nav'] == 'dots')   echo ' selected="selected"';?>>Dots</option>
                  <option value="thumbs"<?php if($settings['gallery_nav'] == 'thumbs') echo ' selected="selected"';?>>Thumbs</option>
                  <option value="false"<?php  if($settings['gallery_nav'] == 'false')  echo ' selected="selected"';?>>None</option>
                </select>
              </div>
            </div>
            <div class="s_row_2 tb_col tb_1_4">
              <label>Prev/Next buttons size</label>
              <div class="s_select">
                <select name="widget_data[navigation_size]">
                  <option value="3"<?php if($settings['navigation_size'] == '3') echo ' selected="selected"';?>>Large</option>
                  <option value="2"<?php if($settings['navigation_size'] == '2') echo ' selected="selected"';?>>Medium</option>
                  <option value="1"<?php if($settings['navigation_size'] == '1') echo ' selected="selected"';?>>Small</option>
                </select>
              </div>
            </div>
          </div>
          <div class="tb_wrap tb_gut_30">
            <div class="s_row_2 tb_col tb_1_6 tbGalleryTypeGrid">
              <label>Thumb gutter</label>
              <input class="s_spinner" type="text" name="widget_data[thumb_gutter]" value="<?php echo $settings['thumb_gutter']; ?>" size="7" />
              <span class="s_metric">px</span>
            </div>
            <div class="s_row_2 tb_col tb_1_6 tbGalleryTypeSlide">
              <label>Max height</label>
              <input class="s_spinner" type="text" name="widget_data[gallery_height]" value="<?php echo $settings['gallery_height']; ?>" size="7" />
              <span class="s_metric">px</span>
            </div>
            <div class="s_row_2 tb_col tb_1_6 tbGalleryTypeSlide">
              <label>Allow Fullscreen</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[fullscreen]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[fullscreen]" value="1"<?php if ($settings['fullscreen'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
            <div class="s_row_2 tb_col tb_1_6">
              <label>Randomize</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[filter_randomize]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[filter_randomize]" value="1"<?php if ($settings['filter_randomize'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
          </div>
        </fieldset>

        <fieldset>
          <legend>Images</legend>
          <div class="tb_wrap tb_gut_30">
            <div class="s_row_2 tb_col tb_1_4">
              <label>Thumb size</label>
              <input class="s_spinner" type="text" name="widget_data[thumb_size_x]" value="<?php echo $settings['thumb_size_x']; ?>" size="7" />
              <span class="s_input_separator">&nbsp;x&nbsp;</span>
              <input class="s_spinner" type="text" name="widget_data[thumb_size_y]" value="<?php echo $settings['thumb_size_y']; ?>" size="7" />
              <span class="s_metric">px</span>
            </div>
            <div class="s_row_2 tb_col tb_1_4">
              <label>Preview size</label>
              <input class="s_spinner" type="text" name="widget_data[preview_size_x]" value="<?php echo $settings['preview_size_x']; ?>" size="7" />
              <span class="s_input_separator">&nbsp;x&nbsp;</span>
              <input class="s_spinner" type="text" name="widget_data[preview_size_y]" value="<?php echo $settings['preview_size_y']; ?>" size="7" />
              <span class="s_metric">px</span>
            </div>
            <div class="s_row_2 tb_col tb_1_4">
              <label>Full size</label>
              <input class="s_spinner" type="text" name="widget_data[full_size_x]" value="<?php echo $settings['full_size_x']; ?>" size="7" />
              <span class="s_input_separator">&nbsp;x&nbsp;</span>
              <input class="s_spinner" type="text" name="widget_data[full_size_y]" value="<?php echo $settings['full_size_y']; ?>" size="7" />
              <span class="s_metric">px</span>
            </div>
            <div class="s_row_2 tb_col tb_1_4">
              <label>Crop thumb/preview</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[crop_thumbs]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[crop_thumbs]" value="1"<?php if ($settings['crop_thumbs'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
          </div>
          <p class="s_help">Thumb and preview images will be resized based only on height value, if crop option is set to off.</p>
        </fieldset>

      </div>

    </div>

    <div id="widget_images_holder" class="tb_subpanel clearfix tbWidgetGalleryImages">
      <div class="tb_cp">
        <h2>Gallery Images</h2>
      </div>

      <div class="s_sortable_holder tb_style_3 clearfix tbImagesList"><?php $i = 0; ?><?php foreach ($settings['images'] as $row_num => $image): ?><div class="s_sortable_row tbImageRow">
          <input type="hidden" name="widget_data[images][<?php echo $row_num; ?>][file]" value="<?php echo $image['file']; ?>" id="bg_image_style_widget_gallery_<?php echo $row_num; ?>" />
          <img src="<?php echo $image['preview']; ?>" id="bg_preview_style_widget_gallery_<?php echo $row_num; ?>" class="image" onclick="image_upload('bg_image_style_widget_gallery_<?php echo $row_num; ?>', 'bg_preview_style_widget_gallery_<?php echo $row_num; ?>');" />
          <div class="s_actions">
            <a class="tbRemoveImage s_button s_white s_h_20 s_icon_10 s_delete_10" href="javascript:;"></a>
          </div>
          <h3 class="s_drag_area"></h3>
        </div><?php $i++; ?><?php endforeach; ?></div>
      
      <span class="clear"></span>
      
      <div class="clearfix">
        <a href="javascript:;" class="s_button s_h_30 s_white s_icon_10 s_plus_10 left s_mr_20 tbAddImage">Add Image</a>
        <p class="s_999 s_mb_0 s_pt_5">Each title will appear as a tab/accordion heading. Any extra titles will be ignored.</p>
      </div>
    </div>

    <div id="widget_box_styles_holder" class="tb_subpanel tb_has_sidebar clearfix tbWidgetCommonOptions">
      <?php require tb_modification(dirname(__FILE__) . '/common_options.tpl'); ?>
    </div>

</div>

<div class="s_submit clearfix">
  <a class="s_button s_red s_h_40 tbWidgetUpdate" href="javascript:;">Update Settings</a>
</div>

</form>

</div>

<script type="text/javascript">
  $(document).ready(function() {

    var $container = $("#widget_gallery");

    $container.find(".tbLanguageTabs").first().tabs();

    $("#widget_gallery_type").bind("change", function() {
        $container.find(".tbGalleryTypeGrid").toggle($(this).val() != 'slide');
        $container.find(".tbGalleryTypeSlide").toggle($(this).val() == 'slide');
    }).trigger("change");

    $container.find(".tbWidgetGalleryImages .tbImagesList").sortable({
        handle: ".s_drag_area",
        tolerance: "pointer"
    });

    $container.find(".tbWidgetGalleryImages .tbAddImage").bind("click", function() {
        var output = Mustache.render($("#widget_gallery_image_template").text(), {
            row_num: tbHelper.generateUniqueId(5)
        });

        $(output).appendTo($container.find(".tbWidgetGalleryImages .tbImagesList"));

        return false;
    });

    $container.find(".tbWidgetGalleryImages").on("click", ".tbRemoveImage", function() {

        if (confirm("Are you sure?")) {
            $(this).parents(".tbImageRow").first().remove();
        }

        return false;
    });

  });
</script>

<script type="text/template" id="widget_gallery_image_template">
  <div class="s_sortable_row tbImageRow">
    <input type="hidden" name="widget_data[images][{{row_num}}][file]" value="" id="bg_image_style_widget_gallery_{{row_num}}" />
    <img src="<?php echo $no_image; ?>" id="bg_preview_style_widget_gallery_{{row_num}}" class="image" onclick="image_upload('bg_image_style_widget_gallery_{{row_num}}', 'bg_preview_style_widget_gallery_{{row_num}}');" />
    <div class="s_actions">
      <a class="tbRemoveImage s_button s_white s_h_20 s_icon_10 s_delete_10" href="javascript:;"></a>
    </div>
    <h3 class="s_drag_area"></h3>
  </div>
</script>