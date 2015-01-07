<div class="s_widget_options_holder tb_cp">

  <h1 class="sm_title"><span>Row</span></h1>

  <form action="<?php echo $tbUrl->generateJs('LayoutBuilder/convertRowFormDataToSettings'); ?>&section=<?php echo $section; ?>" method="post">
    
    <div class="tb_subpanel">
    
      <div class="tb_tabs clearfix tbWidgetsRowMainTabs">

        <div class="tb_tabs_nav s_box_1">
          <h3>Styles</h3>
          <ul class="tb_nav clearfix">
            <li><a href="#style_settings_widgets_row_layout" section="layout">Layout</a></li>
            <li><a href="#style_settings_widgets_row_box_shadow" section="box_shadow">Box Shadow</a></li>
            <li><a href="#style_settings_widgets_row_background" section="background">Background</a></li>
            <li><a href="#style_settings_widgets_row_border" section="border">Border</a></li>
            <li><a href="#style_settings_widgets_row_colors" section="colors">Colors</a></li>
            <li><a href="#style_settings_widgets_row_typography" section="typography">Typography</a></li>
          </ul>
          <div class="tb_style_preview_wrap">
            <h4>Preview</h4>
            <div class="tb_style_preview">
              <div id="widgets_row_style_preview" class="tb_style_preview_box"></div>
            </div>
          </div>
        </div>

        <div id="style_settings_widgets_row_layout">
          <h2>Layout</h2>
          <?php echo $tbData->fetchTemplate('theme_style_section_layout', array('section' => $section, 'input_property' => $section, 'layout' => $row['layout'])); ?>
        </div>

        <div id="style_settings_widgets_row_box_shadow">
          <h2>Shadow</h2>
          <?php echo $tbData->fetchTemplate('theme_style_section_box_shadows', array('section' => $section, 'input_property' => $section, 'box_shadow' => $row['box_shadow'])); ?>
        </div>

        <div id="style_settings_widgets_row_background">
          <h2>Background</h2>
          <?php echo $tbData->fetchTemplate('theme_style_section_background', array('section' => $section, 'input_property' => $section, 'background' => $row['background'])); ?>
        </div>

        <div id="style_settings_widgets_row_border">
          <h2>Border</h2>
          <?php echo $tbData->fetchTemplate('theme_style_section_border', array('section' => $section, 'input_property' => $section, 'border' => $row['border'], 'border_radius' => $row['border_radius'])); ?>
        </div>

        <?php // Colors ?>
        <div id="style_settings_widgets_row_colors">
          <h2>Colors</h2>
          <?php foreach($row['colors'] as $group_key => $group_values): ?>
          <?php if ($group_key != 'custom'): ?>
          <fieldset id="colors_group_<?php echo $group_key; ?>" class="tb_color_row">
            <legend><?php echo array_remove_key($group_values, '_label'); ?></legend>
            <div class="tb_wrap">
              <?php foreach ($group_values as $section_key => $section_values): ?>
              <?php echo $tbData->fetchTemplate('theme_colors_item', array('cols_num' => 4, 'input_property' => "{$section}[colors][$group_key][$section_key]", 'color_item' => $section_values)); ?>
              <?php endforeach; ?>
            </div>
          </fieldset>
          <?php endif; ?>
          <?php endforeach; ?>
        </div>

        <?php // Typography ?>
        <div id="style_settings_widgets_row_typography">

          <div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>

            <h2>Typography</h2>

            <?php if (count($languages) > 1): ?>
            <div class="tb_tabs_nav">
              <ul class="clearfix">
                <?php foreach ($languages as $language): ?>
                <li class="s_language">
                  <a href="#style_settings_widgets_row_typography_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
                    <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" /> <?php echo $language['code']; ?>
                  </a>
                </li>
                <?php endforeach; ?>
              </ul>
            </div>
            <?php endif; ?>

            <?php foreach ($languages as $language): $lid = $language['language_id']; ?>
            <div id="style_settings_widgets_row_typography_language_<?php echo $lid; ?>">
              <?php foreach ($row['font'][$lid] as $name => $font_section): ?>
              <fieldset class="tb_font_row">
                <legend><?php echo $font_section['section_name']; ?></legend>
                <?php echo $tbData->fetchTemplate('theme_design_typography_item', array('input_property' => $section . "[font][$lid][$name]", 'font' => $font_section, 'font_data' => $font_data)); ?>
              </fieldset>
              <?php endforeach; ?>
            </div>
            <?php endforeach; ?>

          </div>

        </div>

      </div>

    </div>

    <div class="s_submit clearfix">
      <a class="update_settings s_button s_red s_h_40 tb_cp_form_submit" href="javascript:;">Update row settings</a>
    </div>

  </form>

</div>