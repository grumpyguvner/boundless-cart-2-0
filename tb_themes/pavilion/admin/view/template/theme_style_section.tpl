<?php $style = $theme_settings['style']; ?>
<div class="tb_tabs clearfix">

  <div class="tb_tabs_nav s_box_1">

    <h3><?php echo $menu_name; ?></h3>
    <ul class="tb_nav clearfix">
      <li><a href="#style_settings_<?php echo $section; ?>_layout" data-section="layout">Layout</a></li>
      <li><a href="#style_settings_<?php echo $section; ?>_box_shadow" data-section="box_shadow">Box Shadow</a></li>
      <li><a href="#style_settings_<?php echo $section; ?>_background" data-section="background">Background</a></li>
      <li><a href="#style_settings_<?php echo $section; ?>_border" data-section="border">Border</a></li>
    </ul>

    <div class="tb_style_preview_wrap">
      <h4>Preview</h4>
      <div class="tb_style_preview">
        <div id="<?php echo $section; ?>_style_preview" class="tb_style_preview_box"></div>
      </div>
    </div>
  </div>

  <div id="style_settings_<?php echo $section; ?>_layout">

    <?php if (!empty($inherit_msg)): ?>
    <div class="s_server_msg s_msg_blue tbRecordInfoMessage1">
      <p class="s_icon_16 s_info_16">
        There are no saved settings for <strong class="tbPageDescription">GLOBAL</strong>. <?php echo $inherit_msg; ?> are applied instead.
      </p>
    </div>
    <?php endif; ?>

    <h2><?php echo $section; ?> Layout</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_layout', array('section' => $section, 'input_property' => "style[$section]", 'layout' => $settings['layout'])); ?>
  </div>

  <div id="style_settings_<?php echo $section; ?>_box_shadow">
    <h2><?php echo $section; ?> Shadow</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_box_shadows', array('section' => $section, 'input_property' => "style[$section]", 'box_shadow' => $settings['box_shadow'])); ?>
  </div>

  <div id="style_settings_<?php echo $section; ?>_background">
    <h2><?php echo $section; ?> Background</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_background', array('section' => $section, 'input_property' => "style[$section]", 'background' => $settings['background'])); ?>
  </div>

  <div id="style_settings_<?php echo $section; ?>_border">
    <h2><?php echo $section; ?> Border</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_border', array('section' => $section, 'input_property' => "style[$section]", 'border' => $settings['border'], 'border_radius' => $settings['border_radius'])); ?>
  </div>

</div>

<div class="s_submit clearfix">
  <a class="s_button s_red s_h_40 tb_cp_form_submit"><?php echo $text_button_save_settings; ?></a>
</div>
