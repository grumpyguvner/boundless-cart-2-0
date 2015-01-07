<div id="subcategories_system_widget_content" class="s_widget_options_holder">

  <h1 class="sm_title"><span>Subcategories</span></h1>

  <form action="<?php echo $tbUrl->generateJs('Widget/convertFormDataToSettings'); ?>&class_name=<?php echo $widget->getClassName(); ?>" method="post">

    <div class="tb_tabs tb_subpanel_tabs tbWidgetMainTabs">

      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <li><a href="#widget_product_styles_holder">Settings</a></li>
          <li><a href="#widget_box_styles_holder">Box styles</a></li>
        </ul>
      </div>

      <div id="widget_product_styles_holder" class="tb_subpanel">
        <div class="tb_cp">
          <h2>Subcategory listing settings</h2>
        </div>
        <div class="s_row_1">
          <label><strong>Show title</strong></label>
          <input type="hidden" name="widget_data[show_title]" value="0" />
          <label class="tb_toggle"><input type="checkbox" name="widget_data[show_title]" value="1"<?php if ($settings['show_title'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
        </div>
        <span class="clear border_eee s_mb_-5 s_pt_15"></span>
        <div class="s_actions tbWidgetCustomStyles">
          <label class="inline left s_mr_10"><strong>Use global category settings:</strong></label>
          <input type="hidden" name="widget_data[inherit_subcategories]" value="0" />
          <label class="tb_toggle tb_toggle_small"><input type="checkbox" name="widget_data[inherit_subcategories]" value="1"<?php if ($settings['inherit_subcategories'] == '1'): ?> checked="checked"<?php endif; ?> /><span></span><span></span></label>
        </div>
        <div class="clear<?php if ($settings['inherit_subcategories'] == '1'): ?> tb_disabled<?php endif; ?>">
          <?php echo $tbData->fetchTemplate('theme_store_category', array('subcategories' => $settings['subcategories'], 'input_property' => "widget_data")); ?>
        </div>
      </div>

      <div id="widget_box_styles_holder" class="tb_subpanel tb_has_sidebar tb_cp clearfix tbWidgetCommonOptions">
        <input type="hidden" name="widget_data[widget_name]" value="<?php echo $settings['widget_name']; ?>" />
        <input type="hidden" name="widget_data[slot_name]" value="<?php echo $settings['slot_name']; ?>" />
        <input type="hidden" name="widget_data[slot_prefix]" value="<?php echo $settings['slot_prefix']; ?>" />
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

    $("#subcategories_system_widget_content").find('.tbWidgetCustomStyles input[name*="inherit_subcategories"]').on("change", function() {
        $(this).parents(".tbWidgetCustomStyles").next().toggleClass("tb_disabled", $(this).is(":checked"));
      });

    tbApp.storeInitSubcategories($("#widget_product_styles_holder"), "widget_data[subcategories]");

  });
</script>