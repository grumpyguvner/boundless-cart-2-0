<div id="group_widget_content" class="s_widget_options_holder tb_cp">

  <h1 class="sm_title"><span>Tabs/Accordion</span></h1>


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
          <h2>Edit Group</h2>
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
              <p class="s_help">Enables the Tabs/Accordion content block for the current language.</p>
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

            <div class="s_sortable_holder tb_style_1 s_row_1 groupWidgetTabTitles"><?php $i = 0; ?><?php foreach ($settings['lang'][$language_id]['tabs'] as $tab): ?><div class="s_sortable_row tbTabTitleRow">
                <div class="s_actions">
                  <a class="tbRemoveRow s_button s_white s_h_20 s_icon_10 s_delete_10" href="javascript:;">Remove</a>
                </div>
                <h3 class="s_drag_area">
                  <span>
                    Tab/Accordion label
                    <span class="s_language_icon"><img src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /></span>
                  </span>
                </h3>
                <div class="tb_wrap tb_gut_30">
                  <div class="s_row_2 tb_col tb_1_3">
                    <label>Title <span class="row_order"></span></label>
                    <div class="s_full clearfix">
                      <input type="text" name="widget_data[lang][<?php echo $language_id; ?>][tabs][<?php echo $i; ?>][title]" value="<?php echo $tab['title']; ?>" size="40" />
                    </div>
                  </div>
                  <div class="s_row_2 tb_col tbIconRow">
                    <label>Icon</label>
                    <div class="tbIcon<?php if (!$tab['icon']): ?> s_icon_holder s_h_26<?php endif; ?>">
                      <?php if ($tab['icon']): ?>
                      <span class="glyph_symbol <?php echo $tab['icon']; ?>"></span>
                      <?php endif; ?>
                    </div>
                    <?php if (!$tab['icon']): ?>
                    <a class="s_button s_white s_h_26 s_icon_10 s_plus_10 tbChooseIcon" href="javascript:;">Choose</a>
                    <?php else: ?>
                    <a class="s_button s_white s_h_26 s_icon_10 s_delete_10 tbChooseIcon tbRemoveIcon" href="javascript:;">Remove</a>
                    <?php endif; ?>
                    <input type="hidden" name="widget_data[lang][<?php echo $language_id; ?>][tabs][<?php echo $i; ?>][icon]" value="<?php echo $tab['icon']; ?>" />
                  </div>
                  <div class="s_row_2 tb_col">
                    <label>Icon size</label>
                    <input class="s_spinner" type="text" name="widget_data[lang][<?php echo $language_id; ?>][tabs][<?php echo $i; ?>][icon_size]" value="<?php echo $tab['icon_size']; ?>" size="6" min="10" />
                    <span class="s_metric">px</span>
                  </div>
                </div>
              </div><?php $i++; ?><?php endforeach; ?></div>
            
            <div class="clearfix s_mb_20">
              <a href="javascript:;" class="s_button addTabTitle s_h_30 s_white s_icon_10 s_plus_10 left s_mr_20">Add heading label</a>
              <p class="s_999 s_mb_0">Each label will appear as a tab/accordion heading. Any extra labels will be ignored.</p>
            </div>

            <span class="clear border_ddd s_mb_20"></span>

          </div>
          <?php endforeach; ?>

        </div>

        <span class="clear"></span>
    
        <div class="s_row_1">
          <label><strong>Group Type</strong></label>
          <div class="s_select">
            <select name="widget_data[group_type]" id="widget_group_group_type">
              <option value="tabs"<?php if($settings['group_type'] == 'tabs') echo ' selected="selected"';?>>Tabs</option>
              <option value="accordion"<?php if($settings['group_type'] == 'accordion') echo ' selected="selected"';?>>Accordion</option>
            </select>
          </div>
        </div>

        <div class="s_row_1 opt_tabs">
          <label><strong>Tabs Direction</strong></label>
          <div class="s_select">
            <select name="widget_data[tabs_direction]" id="widget_group_tabs_direction">
              <option value="horizontal"<?php if($settings['tabs_direction'] == 'horizontal') echo ' selected="selected"';?>>Horizontal</option>
              <option value="vertical"<?php if($settings['tabs_direction'] == 'vertical') echo ' selected="selected"';?>>Vertical</option>
            </select>
          </div>
        </div>

        <div class="s_row_1 opt_tabs opt_vtabs">
          <label><strong>Tabs Position</strong></label>
          <div class="s_select">
            <select name="widget_data[tabs_position]" id="widget_group_tabs_position">
              <option value="left"<?php if($settings['tabs_position'] == 'left') echo ' selected="selected"';?>>Left</option>
              <option value="right"<?php if($settings['tabs_position'] == 'right') echo ' selected="selected"';?>>Right</option>
            </select>
          </div>
        </div>

        <div class="s_row_1 opt_vtabs">
          <div class="s_row_1 opt_tabs">
            <label><strong>Tabs Width</strong></label>
            <input id="widget_group_tabs_width" class="s_spinner" type="text" name="widget_data[tabs_width]" value="<?php echo $settings['tabs_width'] ?>" size="7" min="50" step="10" />
            <span class="s_metric">px</span>
          </div>
        </div>

        <div class="s_row_1">
          <label><strong>Inner padding</strong></label>
          <input class="s_spinner" type="text" name="widget_data[inner_padding]" value="<?php echo $settings['inner_padding'] ?>" size="7" min="0" max="50" step="5" />
          <span class="s_metric">px</span>
        </div>

        <div class="s_row_1 opt_tabs">
          <label><strong>Tabs Style</strong></label>
          <div class="s_select">
            <select name="widget_data[tabs_style]" id="widget_group_tabs_style">
              <option value="1"<?php if($settings['tabs_style'] == '1') echo ' selected="selected"';?>>Classic</option>
              <option value="2"<?php if($settings['tabs_style'] == '2') echo ' selected="selected"';?>>Inline</option>
              <option value="3"<?php if($settings['tabs_style'] == '3') echo ' selected="selected"';?>>Pills</option>
            </select>
          </div>
        </div>

        <div class="s_row_1 opt_tabs">
          <label><strong>Tabs Transition</strong></label>
          <div class="s_select">
            <select name="widget_data[tabs_transition]" id="widget_group_tabs_transition">
              <option value="none"<?php if($settings['tabs_transition'] == 'none') echo ' selected="selected"';?>>None</option>
              <option value="fade"<?php if($settings['tabs_transition'] == 'fade') echo ' selected="selected"';?>>Fade</option>
            </select>
          </div>
        </div>

        <div class="s_row_1 opt_accordion">
          <label><strong>Accordion Style</strong></label>
          <div class="s_select">
            <select name="widget_data[accordion_style]" id="widget_group_tabs_style">
              <option value="1"<?php if($settings['accordion_style'] == '1') echo ' selected="selected"';?>>Classic</option>
              <option value="2"<?php if($settings['accordion_style'] == '2') echo ' selected="selected"';?>>Inline</option>
            </select>
          </div>
        </div>

        <div class="s_row_1">
          <label><strong>Auto height</strong></label>
          <input type="hidden" name="widget_data[auto_height]" value="0" />
          <label class="tb_toggle"><input type="checkbox" name="widget_data[auto_height]" value="1"<?php if($settings['auto_height'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
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

        var $row = $(output).appendTo($("#widget_group_language_" + value + " .groupWidgetTabTitles"));

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