<div class="tb_subpanel">

  <h2><span><?php echo $text_title_design_colors; ?></span></h2>

  <div id="colors_form_rows">
    <?php foreach($colors as $group_key => $group_values): ?>
    <?php if ($group_key != 'custom'): ?>
    <fieldset id="colors_group_<?php echo $group_key; ?>" class="tb_color_row">
      <legend><?php echo array_remove_key($group_values, '_label'); ?></legend>
      <div class="tb_wrap">
        <?php foreach ($group_values as $section_key => $section_values): ?>
        <?php echo $tbData->fetchTemplate('theme_colors_item', array('input_property' => "colors[$group_key][$section_key]", 'color_item' => $section_values, 'cols_num' => 5)); ?>
        <?php endforeach; ?>
      </div>
    </fieldset>
    <?php endif; ?>
    <?php endforeach; ?>

    <fieldset id="colors_group_custom">
      <legend><?php echo array_remove_key($colors['custom'], '_label'); ?></legend>
      <?php foreach ($colors['custom'] as $section_key => $section_values): ?>
      <?php echo $tbData->fetchTemplate('theme_colors_item_custom', array('group_key' => 'custom', 'section_key' => $section_key, 'color_item' => $section_values)); ?>
    <?php endforeach; ?>
    </fieldset>

    <div class="s_box_1 tbNewItemDiv">
      <h3>New Color Rule</h3>
      <div class="s_row_1 s_mb_20">
        <label>Title:</label>
        <input type="text" name="color_rule_label" value="" />
      </div>
      <a class="tbAddNewItem s_button s_white s_h_30 s_icon_10 s_plus_10" href="javascript:;">Add new</a>
    </div>
  </div>

  <div class="s_submit clearfix">
    <a class="s_button s_red s_h_40 tbSaveColors">Save colors</a>
  </div>

</div>

<script type="text/javascript">

$(document).ready(function() {

  var $container = $("#colors_form_rows");

  $container
    .find(".colorSelector").each(function() {
      assignColorPicker($(this), $(this).hasClass("tbBackgroundColor"));
    }).end()
    .find(".tbAddNewItem").bind("click", function() {
      var $label = $(this).parents(".tbNewItemDiv").first().find('input[name="color_rule_label"]');
      var title = $label.val().trim();

      if (title) {
        var item = Mustache.render($("#colors_custom_row_template").text(), {
          section_key: tbHelper.underscore(title + "_" + tbHelper.generateUniqueId(5).toLowerCase()),
          label:       title
        });

        $row = $(item).appendTo($("#colors_group_custom"));
        beautifyForm($row);
        assignColorPicker($row.find(".colorSelector"));
        $label.val("");
      }

      return false;
    }).end()
    .find(".tbColorItem").each(function() {
      var $row = $(this);

      $(this).find('input[name$="[color]"]').bind("changeColor", function() {
        $("#colors_form_rows, #style_settings_area_content_colors, #style_settings_area_footer_colors, #style_settings_area_intro_colors")
          .find('.tb_inherit[parent_id="' + $row.attr("id") + '"]')
          .find('input[name$="[color]"]').val($(this).val()).triggerAll("updateColor changeColor");
      });
    }).end()
    .on("click", "a.tbRemoveItem", function() {
      if (confirm("Are you sure?")) {
        $(this).parents(".tbColorItem").first().remove();
      }

      return false;
    })
    .on("click", ".tbColorToggleInherit", function() {
      var $row = $(this).parents(".tbColorItem").first();

      if ($row.hasClass("tb_inherit")) {
        $row
          .removeClass("tb_inherit tb_disabled")
          .addClass("tb_no_inherit")
          .find('input[name$="[inherit]"]').first().val(0);
      } else
      if ($row.hasClass("tb_no_inherit")) {
        $row
          .removeClass("tb_no_inherit")
          .addClass("tb_inherit tb_disabled")
          .find('input[name$="[inherit]"]').first().val(1);

        var new_color = $("#" + $row.attr("parent_id")).find('input[name$="[color]"]').val();

        $row.find('input[name$="[color]"]').val(new_color).trigger("updateColor");

        $("#colors_form_rows, #style_settings_area_content_colors, #style_settings_area_footer_colors, #style_settings_area_intro_colors")
          .find('.tb_inherit[parent_id="' + $row.attr("id") + '"]')
          .find('input[name$="[color]"]').val(new_color).triggerAll("updateColor changeColor");
      }
    })
    .parent().on("click", ".tbSaveColors", function() {
      $container.block({ message: '<h1>Saving settings</h1>' });
        setTimeout(function() {
            tbHelper.createCallbackRegister($(tbApp)).collectEvent('tbCp:beforeSave', function() {
                $.post($("#tb_cp_form").attr("action"), $.param({form_data: JSON.stringify($container.find(":input").serializeJSON())}), function(response) {
                    $container.unblock();
                }, "json");
            });
        }, 50);
    });

  $(tbApp).on("tbCp:beforeSerialize.global_colors", function(e, $form) {
    $container.find(':input[name^="colors"]').attr("disabled", "disabled");
  });

  $(tbApp).on("tbCp:afterSave.global_colors", function(e, data, $form) {
    $container.find(':input[name^="colors"]').removeAttr("disabled");
  });

  beautifyForm($("#colors_group_custom"));

});


</script>

<script type="text/template" id="colors_custom_row_template">
<?php
echo $tbData->fetchTemplate('theme_colors_item_custom', array(
  'section_key' => "{{section_key}}",
  'color_item'  => array(
    'label'       => '{{label}}',
    'elements'    => 'a',
    'property'    => 'color',
    'color'       => '#ff0000',
    'important'   => 0,
    'inherit'     => 0,
  )
));
?>
</script>