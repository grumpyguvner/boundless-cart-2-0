<fieldset class="tb_background_color">
  <legend>Solid Color</legend>
  <div class="s_row_1">
    <div class="colorSelector">
      <div style="background-color: <?php echo $background['solid_color']; ?>"></div>
    </div>
    <input type="text" name="<?php echo $input_property; ?>[background][solid_color]" value="<?php echo $background['solid_color']; ?>" />
    &nbsp;
    <input class="s_spinner" type="text" name="<?php echo $input_property; ?>[background][solid_color_opacity]" min="0" max="100" value="<?php echo $background['solid_color_opacity']; ?>" size="6" />
    <span class="s_metric">%</span>
  </div>
</fieldset>

<h3 class="tb_background_listing_title">Backgrounds</h3>

<fieldset class="tb_background_listing tb_style_2 s_p_0 tbGradientListing"<?php if (!count($background['rows'])): ?> style="display: none;" <?php endif; ?>>
  <div class="tb_tabs tb_vtabs clearfix">
    <div class="tb_tabs_nav">
      <ul class="clearfix">
        <?php $bg_row_num = 0; ?>
        <?php foreach ($background['rows'] as $bg_row): ?>
        <li><a href="#<?php echo $section; ?>_row_<?php echo $bg_row_num+1; ?>">#<?php echo $bg_row_num+1; ?></a></li>
        <?php $bg_row_num++; ?>
        <?php endforeach; ?>
      </ul>
    </div>
    <?php $bg_row_num = 0; ?>
    <?php foreach ($background['rows'] as $bg_row): ?>
    <div id="<?php echo $section; ?>_row_<?php echo $bg_row_num+1; ?>" class="tb_<?php echo $bg_row['background_type']; ?>_listing tb_list_view tbTabContent" background_type="<?php echo $bg_row['background_type']; ?>">
      <?php if ($bg_row['background_type'] == 'gradient'): ?>
      <?php require(tb_modification(dirname(__FILE__) . '/theme_style_section_bg_gradient.tpl')); ?>
      <?php else: ?>
      <?php require(tb_modification(dirname(__FILE__) . '/theme_style_section_bg_image.tpl')); ?>
      <?php endif; ?>
    </div>
    <?php $bg_row_num++; ?>
    <?php endforeach; ?>
  </div>

</fieldset>

<span class="clear border_ddd s_mb_30"></span>

<a href="javascript:;" class="s_button s_h_30 s_icon_10 s_plus_10 s_white left s_mr_20 tbAddGradient">Add Gradient</a>
<a href="javascript:;" class="s_button s_h_30 s_icon_10 s_plus_10 s_white left s_mr_20 tbAddImage">Add Image</a>


