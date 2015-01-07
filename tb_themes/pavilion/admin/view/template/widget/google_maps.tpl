<div id="google_maps_widget_content" class="s_widget_options_holder tb_cp">

  <h1 class="sm_title"><span>Google Maps</span></h1>


  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <div<?php if ($widget->hasCommonOptions()) echo ' class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs"'; ?>>

      <?php if ($widget->hasCommonOptions()): ?>
      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_settings_holder">Wiget settings</a></li>
          <li><a href="#widget_box_styles_holder">Box style</a></li>
        </ul>
      </div>
      <?php endif; ?>

      <div id="widget_settings_holder" class="tb_subpanel">
        
        <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>
          
          <div class="tb_cp">
          <h2>Edit Google Maps</h2>
          </div>

          <?php if (count($languages) > 1): ?>
          <ul class="tb_tabs_nav clearfix">
            <?php foreach ($languages as $language): ?>
            <li class="s_language">
              <a href="#widget_group_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /> <?php echo $language['code']; ?>
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
          <?php endif; ?>

          <?php foreach ($languages as $language): ?>
          <?php $language_id = $language['language_id']; ?>
          <div id="widget_group_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?>">
            <div class="s_row_1">
              <label><strong>Active</strong></label>
              <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="0" />
              <label class="tb_toggle"><input type="checkbox" name="widget_data[lang][<?php echo $language_id; ?>][is_active]" value="1"<?php if($settings['lang'][$language_id]['is_active'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
              <p class="s_help">Enables the Google maps content block for the current language.</p>
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

        </div>

        <span class="clear"></span>

        <div class="s_row_1">
          <label><strong>Embed code</strong></label>
          <div class="s_full">
            <textarea name="widget_data[embed]" rows="5"><?php echo $settings['embed']; ?></textarea>
          </div>
        </div>
    
        <div class="s_row_1">
          <label><strong>Height</strong></label>
          <input class="s_spinner" type="text" name="widget_data[height]" value="<?php echo $settings['height']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>

        <div class="s_row_1">
          <label><strong>Full width</strong></label>
          <input type="hidden" name="widget_data[fullwidth]" value="0" />
          <label class="tb_toggle"><input type="checkbox" type="checkbox" name="widget_data[fullwidth]" value="1"<?php if($settings['fullwidth'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
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

  var lang_ids = $sReg.get('/tb/language_ids');
  var languages = $sReg.get('/tb/languages');

  var reArrangeTabTitles = function() {

    $("#group_widget_content").find(".groupWidgetTabTitles").each(function() {
      var $rows = $(this).find(" div.s_row_1");

      $rows.each(function() {
        var row_index = $rows.index(this);
        $(this).find("span.row_order").eq(0).text(parseInt(row_index) + 1);
      });
    });
  }

  $(document).ready(function() {

    var $container = $("#group_widget_content");
    
    $container.find(".groupWidgetTabTitles").sortable({
      handle: ".s_drag_area",
      tolerance: "pointer"
    });

    $("#widget_group_group_type").bind("change", function() {
      $container.find("div.opt_accordion").toggle($(this).val() != 'tabs');
      $container.find("div.opt_tabs").toggle($(this).val() == 'tabs');
    }).trigger("change");
    
    $("#widget_group_tabs_direction").bind("change", function() {
      $container.find("div.opt_htabs").toggle($(this).val() != 'vertical');
      $container.find("div.opt_vtabs").toggle($(this).val() == 'vertical');
    }).trigger("change");

    $container.find(".addTabTitle").bind("click", function() {
      $.each(lang_ids, function(key, value) {
        var output = Mustache.render($("#tab_title_template").text(), {
          row_num:        tbHelper.generateUniqueId(5),
          language_id:    value,
          language_image: languages[value].image
        });

        var $row = $(output)
          .appendTo($("#widget_group_language_" + value + " .groupWidgetTabTitles"));

        $row.find(".s_spinner").spinner();

      });
      reArrangeTabTitles();

      return false;
    });

    var widgetIconListReplace = function($newIcon, $activeRow) {
      $activeRow.find(".tbIcon").removeClass("s_icon_holder s_h_26").empty().append($newIcon).end()
        .find('input[name*="icon"]:hidden').val($newIcon.attr("glyph_value")).end()
        .find(".tbChooseIcon").removeClass("s_plus_10").addClass("s_delete_10 tbRemoveIcon").text("Remove");
    }

    $container.on("click", ".tbChooseIcon", function() {
      if ($(this).hasClass("tbRemoveIcon")) {
        $(this).removeClass("tbRemoveIcon s_delete_10").addClass("s_plus_10").text("Choose")
          .parents(".tbIconRow").first()
          .find('input[name*="icon"]:hidden').val("").end()
          .find(".tbIcon").addClass("s_icon_holder s_h_26").empty();
      } else {
        tbApp.openIconManager(widgetIconListReplace, $(this).parents(".tbIconRow").first());
      }
    });

    $container.on("click", ".tbRemoveRow", function() {

      if (confirm("Are you sure?")) {
        var $currentRow = $(this).parents(".tbTabTitleRow").first();
        var $rows = $currentRow.siblings(".tbTabTitleRow").andSelf();
        var index = $rows.index($currentRow);

        $("#group_widget_content").find(".groupWidgetTabTitles").each (function() {
          $(this).find(".tbTabTitleRow").eq(index).remove();
        });
        reArrangeTabTitles();
      }

      return false;
    });

    reArrangeTabTitles();

  });

})(jQuery);
</script>

<script type="text/template" id="tab_title_template">
  <div class="s_sortable_row tbTabTitleRow">
    <div class="s_actions">
      <a class="tbRemoveRow s_button s_white s_h_20 s_icon_10 s_delete_10" href="javascript:;">Remove</a>
    </div>
    <h3 class="s_drag_area">
      <span>
        Tab/Accordion label
        <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/{{language_image}}" /></span>
      </span>
    </h3>
    <div class="tb_wrap tb_gut_30 tbTabTitleRow">
      <div class="s_row_2 tb_col tb_1_3">
        <label>Title <span class="row_order"></span></label>
        <div class="s_full clearfix">
          <input type="text" name="widget_data[lang][{{language_id}}][tabs][{{row_num}}][title]" size="30" />
        </div>
      </div>
      <div class="s_row_2 tb_col tbIconRow">
        <label>Icon</label>
        <div class="tbIcon s_icon_holder s_h_26"></div>
        <a class="s_button s_white s_h_26 s_icon_10 s_plus_10 tbChooseIcon" href="javascript:;">Choose</a>
        <input type="hidden" name="widget_data[lang][{{language_id}}][tabs][{{row_num}}][icon]" value="" />
      </div>
      <div class="s_row_2 tb_col">
        <label>Icon Size</label>
        <input class="s_spinner" type="text" name="widget_data[lang][{{language_id}}][tabs][{{row_num}}][icon_size]" value="" size="6" min="10" />
        <span class="s_metric">px</span>
      </div>
    </div>
  </div>
</script>