<div id="widget_featured_stories" class="s_widget_options_holder tb_cp">

  <h1 class="sm_title"><span>Featured Stories</span></h1>

  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <input type="hidden" name="widget_id" value="<?php echo $widget->getId(); ?>" />
    <div class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs">

      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_settings_holder">Options</a></li>
          <li><a href="#widget_product_choose_holder" add_modal_class="sm_wide">Choose stories</a></li>
          <li><a href="#widget_box_styles_holder">Box styles</a></li>
        </ul>
      </div>

      <div id="widget_settings_holder" class="tb_subpanel">

        <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>

          <div class="tb_cp">
            <h2>Edit</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#widget_featured_stories_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="widget_featured_stories_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">
            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <p class="s_help">Enables the Featured Products content block for the current language.</p>
            </div>

            <span class="s_mb_15 s_pt_15 clear border_eee"></span>

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

            <span class="s_mb_15 s_pt_15 clear border_eee"></span>

          </div>
          <?php endforeach; ?>

          <div class="tb_wrap tb_gut_30">
            <div class="s_row_2 tb_col tb_1_5">
              <label><strong>Filter</strong></label>
            </div>
            <div class="s_row_2 tb_col tb_1_5">
              <label>Randomize</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[filter_randomize]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[filter_randomize]" value="1"<?php if ($settings['filter_randomize'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
          </div>

          <span class="s_mb_15 s_pt_15 clear border_eee"></span>

          <div class="tb_wrap tb_gut_30">
            <div class="s_row_2 tb_col tb_1_5">
              <label><strong>Layout</strong></label>
            </div>
            <div class="s_row_2 tb_col tb_1_5">
              <label>Show description</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[show_text]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[show_text]" value="1"<?php if ($settings['show_text'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
            <div class="s_row_2 tb_col tb_1_5">
              <label>Show date</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[show_date]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[show_date]" value="1"<?php if ($settings['show_date'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
            <div class="s_row_2 tb_col tb_1_5">
              <label>Show tags</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[show_tags]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[show_tags]" value="1"<?php if ($settings['show_tags'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
            <div class="s_row_2 tb_col tb_1_5">
              <label>Show comments</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[show_comments]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[show_comments]" value="1"<?php if ($settings['show_comments'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
          </div>

          <div class="tb_wrap tb_gut_30 s_mt_15 s_mb_20">
            <div class="s_row_2 tb_col tb_1_5">
              <label>&nbsp;</label>
            </div>
            <div class="s_row_2 tb_col tb_1_5">
              <label>Show thumb</label>
              <span class="clear"></span>
              <input type="hidden" name="widget_data[show_thumb]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[show_thumb]" value="1"<?php if ($settings['show_thumb'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
            </div>
            <div class="s_row_2 tb_col tb_1_5 tbSettingsRow">
              <label>Thumb size</label>
              <input class="inline" type="text" name="widget_data[image_size_x]" value="<?php echo $settings['image_size_x']; ?>" size="2" />
              <span class="s_input_separator">&nbsp;x&nbsp;</span>
              <input class="inline" type="text" name="widget_data[image_size_y]" value="<?php echo $settings['image_size_y']; ?>" size="2" /> <span class="s_metric">px</span>
            </div>
            <div class="s_row_2 tb_col tb_1_5 tbSettingsRow">
              <label>Description limit</label>
              <input class="s_spinner" type="text" name="widget_data[text_limit]" value="<?php echo $settings['text_limit']; ?>" size="7" /><span class="s_metric">chars</span>
            </div>
          </div>

          <span class="s_mb_15 clear border_eee"></span>

          <?php require tb_modification(dirname(__FILE__) . '/product_options.tpl'); ?>

        </div>

      </div>

      <div id="widget_product_choose_holder" class="tb_subpanel tb_has_sidebar clearfix">
        <h2>Choose Stories</h2>
        <?php echo $tbGet->storiesModalController->getStoryList($widget->getStoryIds()); ?>
        <div class="tbFeaturedProductIds">
          <?php foreach ($widget->getStoryIds() as $id): ?>
          <input type="hidden" name="widget_data[story_ids][]" value="<?php echo $id; ?>" />
          <?php endforeach; ?>
        </div>
      </div>

      <div id="widget_box_styles_holder" class="tb_subpanel tb_has_sidebar clearfix tbWidgetCommonOptions">
        <?php $custom_widget_title = 'Featured Stories'; ?>
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

    $("#widget_settings_holder").find(".tbLanguageTabs").first().tabs();

    var $container = $("#widget_featured_stories");

    beautifyForm($container.find(".tbWidgetCustomStyles"));

    $container.find("input[name='filter_tags']").tagit({
      allowSpaces: true
      <?php if (!empty($settings['tags_names'])): ?>
      , availableTags: [<?php echo $settings['tags_names']; ?>]
      <?php endif; ?>
    });

    $container.find('input[name$="[show_text]"]').bind("change", function() {
      $container.find('input[name$="[text_limit]"]').closest(".tbSettingsRow").toggleClass("tb_disabled", !$(this).is(":checked"));
      $container.find('input[name$="[text_tooltip]"]').closest(".tbSettingsRow").toggleClass("tb_disabled", !$(this).is(":checked"));
    }).trigger("change");

    $container.find('input[name$="[show_thumb]"]').bind("change", function() {
      $container.find('select[name$="[thumb_position]"]').closest(".tbSettingsRow").toggleClass("tb_disabled", !$(this).is(":checked"));
      $container.find('input[name$="[image_size_x]"]').closest(".tbSettingsRow").toggleClass("tb_disabled", !$(this).is(":checked"));
    }).trigger("change");

  });

  function submitFeaturedUrl(url, $container, callback) {

    $container.find(".tbProductsListing").block();
    $.get(url, function(data) {
      $container.find(".tbProductsListing").replaceWith(data);
      beautifyForm($container);
      if ($.isFunction(callback)) {
        callback.call(this);
      }
      $container.find(".tbProductsListing").unblock();
    });
  }

  var $container = $("#widget_product_choose_holder");

  $container.on("click", ".tbSubmitFilter", function() {
    var query = $.jurlp($container.find('input[name="filter_request_url"]').val()).query();
    var url = getStoriesFilterUrl() + "&sort=" + query.sort + "&order=" + query.order;

    submitFeaturedUrl(url, $container);

    return false;
  });

  $container.on("click", ".tbResetFilter", function() {
    $container.find(".tbFilterForm").clearForm().find(":hidden").val("");
    submitFeaturedUrl(getStoriesFilterUrl(), $container);

    return false;
  });

  $container.on("click", "div.pagination a", function() {
    var query = $.jurlp($(this).attr("href")).query();
    var url = getStoriesFilterUrl() + "&page=" + query.page + "&sort=" + query.sort + "&order=" + query.order;

    submitFeaturedUrl(url, $container);

    return false;
  });

  $container.on("click", ".tbProductsListingTable thead a", function() {
    var query = $.jurlp($(this).attr("href")).query();
    var url = getStoriesFilterUrl() + "&page=" + query.page + "&sort=" + query.sort + "&order=" + query.order;

    submitFeaturedUrl(url, $container);

    return false;
  });

  $container.on("click", ".tbButtonProductSelect", function() {
    var parent = $(this).parents("tr:first");
    var story_id = parent.find("input").val();

    if (!parent.hasClass("tb_selected")) {
      parent.addClass("tb_selected");
      $container.find(".tbFeaturedProductIds")
        .append('<input type="hidden" name="widget_data[story_ids][]" value="' + story_id + '" />');
    } else {
      parent.removeClass("tb_selected");
      $container.find('.tbFeaturedProductIds input[value="' + story_id + '"]').remove();
    }

    return false;
  });

  $container.on("keydown", ".tbFilterForm input", function(e) {
    if (e.keyCode == 13) {
      submitFeaturedUrl(getStoriesFilterUrl(), $container);
    }
  });

  function getStoriesFilterUrl() {
    var url = '<?php echo str_replace('&amp;', '&', $tbUrl->generate('storiesModal/getStoriesOnly')); ?>';
    var input_params = tbHelper.collectInputParams([
      "filter_text",
      "filter_tags",
      "filter_disabled",
      "filter_selected"
    ], $container);

    if (input_params != "") {
      url += "&" + input_params;
    }

    url += '&' + decodeURIComponent($.param({
      story_ids : jQuery.map($container.find(".tbFeaturedProductIds input").serializeArray(), function(obj) {
        return obj.value;
      })
    }));

    return url;
  }
</script>