<?php $system = $theme_settings['system']; ?>
<div class="tb_tabs tb_subpanel_tabs">

  <div class="tb_tabs_nav">
    <ul class="clearfix">
      <li><a href="#system_settings_cache">Cache</a></li>
      <li><a href="#system_settings_compatibility">Compatibility</a></li>
      <li><a href="#system_settings_pages">Pages</a></li>
    </ul>
  </div>

  <div id="system_settings_cache" class="tb_subpanel tb_has_sidebar">
    <div class="tb_tabs clearfix">

      <div class="tb_tabs_nav s_box_1">
        <h3>Cache</h3>
        <div class="s_actions s_pt_5">
          <input type="hidden" name="system[cache_enabled]" value="0" />
          <label class="tb_toggle tb_toggle_small"><input id="system_settings_cache_enabled" type="checkbox" name="system[cache_enabled]" value="1"<?php if($system['cache_enabled'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
        </div>
        <ul class="tb_nav clearfix">
          <li><a href="#system_settings_cache_general_tab">General</a></li>
          <li><a href="#system_settings_cache_content_tab">Content blocks</a></li>
        </ul>
        <div class="align_center s_pt_20" style="margin: 0 -10px;">
          <a class="s_button s_h_30 s_white s_icon_10 s_trash_10 tbClearCache" href="<?php echo $tbUrl->generate('default/clearCache'); ?>">Clear cache</a>
        </div>
      </div>

      <div id="system_settings_cache_general_tab">
        <fieldset>
          <h2>General cache</h2>
          <div class="s_row_1 tbSetting">
            <label for="system_settings_cache_styles">Styles</label>
            <input type="hidden" name="system[cache_styles]" value="0" />
            <label class="tb_toggle"><input id="system_settings_cache_styles" type="checkbox" name="system[cache_styles]" value="1"<?php if($system['cache_styles'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
          </div>
          <div class="s_row_1 tbSetting">
            <label for="system_settings_cache_scripts">Scripts</label>
            <input type="hidden" name="system[cache_scripts]" value="0" />
            <label class="tb_toggle"><input id="system_settings_cache_scripts" type="checkbox" name="system[cache_scripts]" value="1"<?php if($system['cache_scripts'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
          </div>
          <div class="s_row_1 tbSetting">
            <label for="system_settings_cache_settings">Configuration</label>
            <input type="hidden" name="system[cache_settings]" value="0" />
            <label class="tb_toggle"><input id="system_settings_cache_settings" type="checkbox" name="system[cache_settings]" value="1"<?php if($system['cache_settings'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
          </div>
          <div class="s_row_1 tbSetting">
            <label for="system_settings_cache_menu">Menu</label>
            <input type="hidden" name="system[cache_menu]" value="0" />
            <label class="tb_toggle"><input id="system_settings_cache_menu" type="checkbox" name="system[cache_menu]" value="1"<?php if($system['cache_menu'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
          </div>
          <div class="s_row_1 tbSetting" style="display: none">
            <label for="system_settings_cache_classes" >System classes</label>
            <input type="hidden" name="system[cache_classes]" value="0" />
            <label class="tb_toggle"><input id="system_settings_cache_classes" type="checkbox" name="system[cache_classes]" value="1"<?php if($system['cache_classes'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
          </div>
          <?php if ($system['tb_optimizations_mod']): ?>
          <?php foreach ($tbData->optimizations_cache as $cache_key => $cache_value): ?>
          <div class="s_row_1 tb_live_row_1 tbSetting">
            <label for="system_settings_cache_<?php echo $cache_key; ?>"><?php echo $cache_value['label']; ?></label>
            <input type="hidden" name="system[cache_<?php echo $cache_key; ?>]" value="0" />
            <label class="tb_toggle"><input id="system_settings_cache_<?php echo $cache_key; ?>" type="checkbox" name="system[cache_<?php echo $cache_key; ?>]" value="1"<?php if($system['cache_' . $cache_key] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
          </div>
          <?php endforeach; ?>
          <?php endif; ?>
        </fieldset>
      </div>

      <div id="system_settings_cache_content_tab">
        <h2>Content cache</h2>
        <div class="s_row_1 tbSetting">
          <label for="system_settings_cache_content">Enable content cache</label>
          <input type="hidden" name="system[cache_content]" value="0" />
          <label class="tb_toggle"><input id="system_settings_cache_content" type="checkbox" name="system[cache_content]" value="1"<?php if($system['cache_content'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
        </div>

        <fieldset class="tb_color_row">
          <legend>Theme blocks</legend>
          <div class="tb_wrap tb_gut_20">
            <?php foreach ($tbData->cache_widget_names as $class_name => $widget_name): ?>
            <?php if (0 !== strpos($class_name, 'oc_')): ?>
            <div class="s_row_2 tb_col tb_1_2 s_mt_15 tbSetting">
              <label for="system_settings_cache_content"><?php echo $widget_name; ?></label>
              <input type="hidden" name="system[cache_widgets][<?php echo $class_name; ?>][enabled]" value="0" />
              <label class="tb_toggle"><input id="system_settings_cache_content" type="checkbox" name="system[cache_widgets][<?php echo $class_name; ?>][enabled]" value="1"<?php if($system['cache_widgets'][$class_name]['enabled'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="s_spinner" type="text" name="system[cache_widgets][<?php echo $class_name; ?>][ttl]" value="<?php echo $system['cache_widgets'][$class_name]['ttl']; ?>" size="7" />
              <span class="s_metric">min</span>
            </div>
            <?php endif; ?>
            <?php endforeach; ?>
          </div>
        </fieldset>

        <fieldset class="tb_color_row">
          <legend>Module blocks</legend>
          <div class="tb_wrap tb_gut_20">
            <?php foreach ($tbData->cache_widget_names as $class_name => $widget_name): ?>
            <?php if (0 === strpos($class_name, 'oc_')): ?>
            <div class="s_row_2 tb_col tb_1_2 s_mt_15 tbSetting">
              <label for="system_settings_cache_content"><?php echo $widget_name; ?></label>
              <input type="hidden" name="system[cache_widgets][<?php echo $class_name; ?>][enabled]" value="0" />
              <label class="tb_toggle"><input id="system_settings_cache_content" type="checkbox" name="system[cache_widgets][<?php echo $class_name; ?>][enabled]" value="1"<?php if($system['cache_widgets'][$class_name]['enabled'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="s_spinner" type="text" name="system[cache_widgets][<?php echo $class_name; ?>][ttl]" value="<?php echo $system['cache_widgets'][$class_name]['ttl']; ?>" size="7" min="1" />
              <span class="s_metric">min</span>
            </div>
            <?php endif; ?>
            <?php endforeach; ?>
          </div>
        </fieldset>

      </div>

    </div>
  </div>

  <div id="system_settings_compatibility" class="tb_subpanel">

    <h2>Compatibility</h2>

    <div class="s_row_1 tb_live_row_1">
      <label for="system_compatibility_use_default_menu">Use default menu code</label>
      <input type="hidden" name="system[compatibility_menu]" value="0" />
      <label class="tb_toggle"><input id="system_compatibility_use_default_menu" type="checkbox" name="system[compatibility_menu]" value="1"<?php if($system['compatibility_menu'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
      <p class="s_help">The Menu Composer feature will not be available with this option enabled.</p>
    </div>

    <?php if (!$tbData['gteOc2']): ?>
    <div class="s_row_1 tb_live_row_1">
      <label for="system_compatibility_load_colorbox">Load colorbox.js</label>
      <input type="hidden" name="system[compatibility_colorbox]" value="0" />
      <label class="tb_toggle"><input id="system_compatibility_load_colorbox" type="checkbox" name="system[compatibility_colorbox]" value="1"<?php if($system['compatibility_colorbox'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <?php endif; ?>

    <div class="s_row_1 tb_live_row_1">
      <label for="system_compatibility_load_jquery_migrate">Load jquery migrate</label>
      <input type="hidden" name="system[compatibility_jquery]" value="0" />
      <label class="tb_toggle"><input id="system_compatibility_load_jquery_migrate" type="checkbox" name="system[compatibility_jquery]" value="1"<?php if($system['compatibility_jquery'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>

    <?php if ($tbData['gteOc2']): ?>
    <div class="s_row_1 tb_live_row_1">
      <label for="system_compatibility_load_moment_js">Load moment.js</label>
      <input type="hidden" name="system[compatibility_moment_js]" value="0" />
      <label class="tb_toggle"><input id="system_compatibility_load_moment_js" type="checkbox" name="system[compatibility_moment_js]" value="1"<?php if($system['compatibility_moment_js'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <?php endif; ?>

    <!-- mods -->

  </div>

  <div id="system_settings_pages" class="tb_subpanel">

    <h2>Custom system pages</h2>
    <div class="s_sortable_holder tb_style_1 tbSystemPages"><?php foreach ($system['pages'] as $hash => $system_page): ?><div class="s_sortable_row s_nodrag tbSystemPage">
        <div class="s_actions">
          <div class="s_buttons_group">
            <a href="javascript:;" class="s_button s_white s_h_20 s_icon_10 s_delete_10 tbRemoveRow"></a>
          </div>
        </div>
        <div class="s_sortable_contents">
          <div class="s_row_1">
            <label>Label</label>
            <input type="text" name="system[pages][<?php echo $hash; ?>][label]" value="<?php echo $system_page['label'];?>" />
          </div>
          <div class="s_row_1">
            <label>Route</label>
            <input type="text" name="system[pages][<?php echo $hash; ?>][route]" value="<?php echo $system_page['route'];?>" />
          </div>
          <div class="s_row_1">
            <label>System blocks</label>
            <div class="s_full clearfix">
              <?php foreach (array('breadcrumbs' => 'Breadcrumbs', 'page_title' => 'Page title', 'page_content' => 'Page content') as $system_page_value => $system_page_title): ?>
              <input type="hidden" name="system[pages][<?php echo $hash; ?>][widgets][<?php echo $system_page_value; ?>]" value="0" />
              <label class="s_checkbox">
                <input type="checkbox" name="system[pages][<?php echo $hash; ?>][widgets][<?php echo $system_page_value; ?>]" value="1"<?php if ($system_page['widgets'][$system_page_value] == 1): ?> checked="checked<?php endif; ?>" />
                <span><?php echo $system_page_title; ?></span>
              </label>
              <?php endforeach; ?>
            </div>
          </div>
        </div>
      </div><?php endforeach; ?></div>
    <a class="s_button s_white s_h_30 s_icon_10 s_plus_10 tbAddSystemPage" href="javascript:;">Add Page</a>
  </div>

</div>

<div class="s_submit clearfix">
  <a class="s_button s_red s_h_40 tb_cp_form_submit">Save settings</a>
</div>

<script type="text/javascript">

  $(document).ready(function(){

    $("#system_settings").find("> .tb_tabs").tabs();
    $("#system_settings_cache").find("> .tb_tabs").tabs();
    
    beautifyForm($("#system_settings"));

    $("#system_settings_cache").find(':checkbox[name="system[cache_styles]"]').bind("change", function() {
      if (!$(this).is(":checked")) {
        $("#system_settings_cache").find(':checkbox[name="system[cache_settings]"]').removeProp("checked");
      }
      $("#system_settings_cache").find(':checkbox[name="system[cache_settings]"]').closest(".tbSetting").toggleClass("tb_disabled", !$(this).is(":checked"));
    }).trigger("change");

    $("#system_settings_cache").find(':checkbox[name="system[cache_enabled]"]').bind("change", function() {
      $("#system_settings_cache").find(".tbSetting").not($(this).closest(".tbSetting")).toggleClass("tb_disabled", !$(this).is(":checked"));
      if ($(this).is(":checked")) {
        $("#system_settings_cache").find(':checkbox[name="system[cache_styles]"]').trigger("change");
      }
    }).trigger("change");

    $("#system_settings").find(".tbClearCache").bind("click", function() {
      $("#tb_cp_content").block({ message: '<h1>Clearing</h1>' });
      $.getJSON($(this).attr("href"), function() {
        $("#tb_cp_content").unblock();
      });

      return false;
    });

    $("#export_settings, #export_content, #export_colors").bind("click", function() {
      $.getJSON($(this).attr("href"), {
        export_store_id: $(this).parent().find("select").val()
      }, function() {

      });

      return false;
    });

    $("#export_defaults").bind("click", function() {
      $.getJSON($(this).attr("href"), function() {

      });

      return false;
    });

    $("#system_settings_pages .tbAddSystemPage").bind("click", function() {
      $(Mustache.render($("#system_page_template").text(), {
        hash: tbHelper.generateUniqueId().toLowerCase()
      })).appendTo($("#system_settings_pages").find(".tbSystemPages"));

      return false;
    });

    $("#system_settings_pages").on("click", ".tbRemoveRow", function() {
      confirm("Are you sure?") && $(this).closest(".tbSystemPage").remove();

      return false;
    });

  });

</script>