<?php if (!isset($available_options)) $available_options = array('common', 'box_shadow', 'background', 'border', 'colors', 'typography'); ?>
<div class="tb_tabs tbWidgetCommonOptionsTabs">

  <div class="tb_tabs_nav s_box_1">
    <h3>Styles</h3>
    <ul class="tb_nav clearfix">
      <?php if (in_array('common',     $available_options)): ?><li><a href="#style_settings_widget_common"     section="common">Layout</a></li><?php endif; ?>
      <?php if (in_array('box_shadow', $available_options)): ?><li><a href="#style_settings_widget_box_shadow" section="box_shadow">Box Shadow</a></li><?php endif; ?>
      <?php if (in_array('background', $available_options)): ?><li><a href="#style_settings_widget_background" section="background">Background</a></li><?php endif; ?>
      <?php if (in_array('border',     $available_options)): ?><li><a href="#style_settings_widget_border"     section="border">Border</a></li><?php endif; ?>
      <?php if (in_array('colors',     $available_options)): ?><li><a href="#style_settings_widget_colors"     section="colors">Colors</a></li><?php endif; ?>
      <?php if (in_array('typography', $available_options)): ?><li><a href="#style_settings_widget_typography" section="typography">Typography</a></li><?php endif; ?>
    </ul>
    <?php if (in_array('box_shadow', $available_options) || in_array('background', $available_options) || in_array('border', $available_options)): ?>
    <div class="tb_style_preview_wrap">
      <h4>Preview</h4>
      <div class="tb_style_preview">
        <div id="widget_style_preview" class="tb_style_preview_box"></div>
      </div>
    </div>
    <?php endif; ?>
  </div>

  <?php $options = $settings['common']; ?>
  <?php if (isset($custom_widget_title)) { $settings['widget_admin_title'] = $custom_widget_title; } ?>
  
  <?php // Common settings ?>
  <?php if (in_array('common', $available_options)): ?>
  <div id="style_settings_widget_common">
    <h2><?php echo $settings['widget_admin_title']; ?> Layout</h2>
    <div class="s_row_1">
      <label>Extra class</label>
      <input type="text" name="widget_data[common][layout][extra_class]" value="<?php echo $options['layout']['extra_class']; ?>" />
    </div>

    <?php $tbData->slotEcho('common_options_layout_display'); ?>

    <fieldset>
      <legend>Margin</legend>
      <div class="tb_wrap">
        <div class="s_row_2 tb_col tb_1_5">
          <label>Top</label>
          <input class="s_spinner" type="text" min="-50" max="50" step="5" name="widget_data[common][layout][margin_top]" value="<?php echo $options['layout']['margin_top']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>
        <div class="s_row_2 tb_col tb_1_5">
          <label>Bottom</label>
          <input class="s_spinner" type="text" min="-50" max="50" step="5" name="widget_data[common][layout][margin_bottom]" value="<?php echo $options['layout']['margin_bottom']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>
        <div class="s_row_2 tb_col tb_1_5">
          <label>Left/Right</label>
          <input class="s_spinner" type="text" min="-50" max="50" step="5" name="widget_data[common][layout][margin_right]" value="<?php echo $options['layout']['margin_right']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>
      </div>
    </fieldset>

    <fieldset>
      <legend>Padding</legend>
      <div class="tb_wrap">
        <div class="s_row_2 tb_col tb_1_5">
          <label>Top</label>
          <input class="s_spinner" type="text" min="0" max="50" step="5" name="widget_data[common][layout][padding_top]" value="<?php echo $options['layout']['padding_top']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>
        <div class="s_row_2 tb_col tb_1_5">
          <label>Bottom</label>
          <input class="s_spinner" type="text" min="0" max="50" step="5" name="widget_data[common][layout][padding_bottom]" value="<?php echo $options['layout']['padding_bottom']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>
        <div class="s_row_2 tb_col tb_1_5">
          <label>Right/Left</label>
          <input class="s_spinner" type="text" min="0" max="50" step="5" name="widget_data[common][layout][padding_right]" value="<?php echo $options['layout']['padding_right']; ?>" size="6" />
          <span class="s_metric">px</span>
        </div>
      </div>
    </fieldset>
      
  </div>
  <?php endif; ?>

  <?php // Box Shadow ?>
  <?php if (in_array('box_shadow', $available_options)): ?>
  <div id="style_settings_widget_box_shadow">
    <h2><?php echo $settings['widget_admin_title']; ?> Shadow</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_box_shadows', array('section' => 'box_styles', 'input_property' => 'widget_data[common]', 'box_shadow' => $options['box_shadow'])); ?>
  </div>
  <?php endif; ?>

  <?php // Background Color ?>
  <?php if (in_array('background', $available_options)): ?>
  <div id="style_settings_widget_background">
    <h2><?php echo $settings['widget_admin_title']; ?> Background</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_background', array('section' => 'box_styles', 'input_property' => 'widget_data[common]', 'background' => $options['background'])); ?>
  </div>
  <?php endif; ?>

  <?php // Border ?>
  <?php if (in_array('border', $available_options)): ?>
  <div id="style_settings_widget_border">
    <h2><?php echo $settings['widget_admin_title']; ?> Border</h2>
    <?php echo $tbData->fetchTemplate('theme_style_section_border', array('section' => 'box_styles', 'input_property' => 'widget_data[common]', 'border' => $options['border'], 'border_radius' => $options['border_radius'])); ?>
  </div>
  <?php endif; ?>

  <?php // Typography ?>
  <?php if (in_array('typography', $available_options)): ?>
  <div id="style_settings_widget_typography">
    
    <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>
    
      <h2><?php echo $settings['widget_admin_title']; ?> Typography</h2>

      <?php if (count($languages) > 1): ?>
      <div class="tb_tabs_nav">
        <ul class="clearfix">
          <?php foreach ($languages as $language): ?>
          <li class="s_language">
            <a href="#style_settings_widget_typography_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
              <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /> <?php echo $language['code']; ?>
            </a>
          </li>
          <?php endforeach; ?>
        </ul>
      </div>
      <?php endif; ?>

      <?php foreach ($languages as $language): $lid = $language['language_id']; ?>
      <div id="style_settings_widget_typography_language_<?php echo $lid; ?>">
        <?php foreach ($options['font'][$lid] as $name => $section): ?>
        <fieldset class="tb_font_row">
          <legend><?php echo $section['section_name']; ?></legend>
          <?php echo $tbData->fetchTemplate('theme_design_typography_item', array('input_property' => "widget_data[common][font][$lid][$name]", 'font' => $section, 'font_data' => $font_data)); ?>
        </fieldset>
        <?php endforeach; ?>
      </div>
      <?php endforeach; ?>

    </div>

  </div>
  <?php endif; ?>

  <?php // Colors ?>
  <?php if (in_array('colors', $available_options)): ?>
  <div id="style_settings_widget_colors">
    <h2><?php echo $settings['widget_admin_title']; ?> Colors</h2>
    <?php foreach($options['colors'] as $group_key => $group_values): ?>
    <fieldset id="widget_colors_group_<?php echo $group_key; ?>" class="tb_color_row">
      <?php if ($label = array_remove_key($group_values, '_label')): ?>
      <legend><?php echo $label; ?></legend>
      <?php endif; ?>
      <div class="tb_wrap">
        <?php foreach ($group_values as $section_key => $section_values): ?>
        <?php echo $tbData->fetchTemplate('theme_colors_item', array('input_property' => "widget_data[common][colors][$group_key][$section_key]", 'color_item' => $section_values, 'cols_num' => 4)); ?>
        <?php endforeach; ?>
      </div>
    </fieldset>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>
      
</div>