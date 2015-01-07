<?php $product = $theme_settings['product']; ?>
<h2>Product settings</h2>

<fieldset id="store_product_images">
  <legend>Product Images</legend>
  <div class="tb_wrap">
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Fullscreen</label>
      <input type="hidden" name="product[fullscreen_gallery]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[fullscreen_gallery]" value="1"<?php if($product['fullscreen_gallery'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Zoom</label>
      <input type="hidden" name="product[gallery_zoom]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[gallery_zoom]" value="1"<?php if($product['gallery_zoom'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1 tbSetting<?php if($product['gallery_zoom'] == '0') echo ' tb_disabled';?>">
      <label>Zoom trigger</label>
      <div class="s_full clearfix">
        <select name="product[gallery_zoom_action]">
          <option value="click"<?php if($product['gallery_zoom_action'] == 'click') echo ' selected="selected"';?>>Click</option>
          <option value="mouseover"<?php if($product['gallery_zoom_action'] == 'mouseover') echo ' selected="selected"';?>>Hover</option>
        </select>
      </div>
    </div>
  </div>
</fieldset>

<fieldset id="store_product_design">
  <legend>Product Layouts</legend>
  <div class="tb_wrap tb_gut_30 s_mb_0">
    <div class="s_row_2 tb_col tb_1_4 tb_live_row_1 tb_live_1_1">
      <label>Page design</label>
      <div class="s_full clearfix">
        <div class="s_select">
          <select name="product_designs">
            <?php foreach ($product_designs as $id => $name): ?>
            <option value="<?php echo $id; ?>"><?php echo $name; ?></option>
            <?php endforeach; ?>
          </select>
      </div>
      </div>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_row_1 tb_live_1_1">
      <label>Layout</label>
      <div class="s_full clearfix">
        <div class="s_select">
          <select name="product_layouts">
          <?php foreach ($oc_layouts as $layout): ?>
          <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
          <?php endforeach; ?>
          </select>
        </div>
      </div>
    </div>
    <div class="s_row_2 tb_col tb_1_4 tb_live_row_1 tb_live_1_1">
      <label>Column ratio (left/right)</label>
      <div class="s_full clearfix">
        <div class="s_select">
          <select name="product_column_ratio">
            <option value="1_2+1_2">1/2 + 1/2</option>
            <option value="1_3+2_3">1/3 + 2/3</option>
            <option value="2_3+1_3">2/3 + 1/3</option>
            <option value="1_4+3_4">1/4 + 3/4</option>
            <option value="3_4+1_4">3/4 + 1/4</option>
            <option value="1_5+4_5">1/5 + 4/5</option>
            <option value="2_5+3_5">2/5 + 3/5</option>
            <option value="3_5+2_5">3/5 + 2/5</option>
            <option value="4_5+1_5">4/5 + 1/5</option>
            <option value="1_6+5_6">1/6 + 5/6</option>
            <option value="5_6+1_6">5/6 + 1/6</option>
          </select>
        </div>
      </div>
    </div>
    <div class="s_row_2 tb_col tb_1_4 s_pt_25 tb_live_row_1 tb_live_1_1">
      <a href="javascript:;" class="s_button s_white s_h_30 s_icon_10 s_plus_10 right tbAddProductDesign">Add layout</a>
    </div>
  </div>

  <table class="tb_product_elements s_table_1 s_mt_20" cellpadding="0" cellspacing="0" border="0"<?php if(empty($product['designs']['layout'])) { echo ' style="display: none;"'; } ?>>
    <thead>
      <tr class="s_open s_nosep">
        <th width="300">Layouts</th>
        <th colspan="2" align="left">Column ratio</th>
      </tr>
    </thead>
    <tbody class="tbProductDesignList">
      <?php foreach ($product['designs']['layout'] as $layout_id => $layout_data): ?>
      <tr class="s_open s_nosep">
        <td>
          <input type="hidden" name="product[designs][layout][<?php echo $layout_id; ?>][design]" value="<?php echo $layout_data['design']; ?>" />
          <input type="hidden" name="product[designs][layout][<?php echo $layout_id; ?>][column_ratio]" value="<?php echo $layout_data['column_ratio']; ?>" />
          <?php echo $oc_layouts[$layout_id]['name']; ?> - <?php echo $product_designs[$layout_data['design']]; ?>
        </td>
        <td class="align_left tbColumnProportion"></td>
        <td width="10"><a href="javascript:;" class="s_button s_white s_h_20 s_icon_10 s_delete_10 tbRemove"></a></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>

</fieldset>

<fieldset id="store_product_option_styles">
  <h3 class="s_mb_15">Options styles</h3>
  <table class="s_table_1 tb_product_elements" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr class="s_open s_nosep">
        <th width="150">Option</th>
        <th class="align_left">Style</th>
      </tr>
    </thead>
    <tbody class="tbProductDesignList">
      <?php foreach ($product_options as $option_id => $option): ?>
      <tr class="s_open s_nosep">
        <td class="align_left"><?php echo $option['name']; ?></td>
        <td>
          <?php foreach ($product_option_styles as $style_id => $style_name): ?>
          <label class="s_radio left s_pt_0 s_pb_0">
            <input type="radio" name="product[designs][option][<?php echo $option_id; ?>][style_id]" value="<?php echo $style_id; ?>"<?php if ($product['designs']['option'][$option_id]['style_id'] == $style_id): ?> checked="checked"<?php endif; ?> />
            <span><?php echo $style_name; ?></span>
          </label>
          <?php endforeach; ?>
          <?php if ($option['type'] == 'image'): ?>
          <div class="left s_ml_20" style="margin-top: -2px; margin-bottom: -2px;">
            <input class="inline" type="text" name="product[designs][option][<?php echo $option_id; ?>][image_width]" value="<?php echo $product['designs']['option'][$option_id]['image_width']; ?>" size="3" style="height: 24px;" />
            <span class="s_input_separator" style="line-height: 24px !important;">&nbsp;x&nbsp;</span>
            <input class="inline" type="text" name="product[designs][option][<?php echo $option_id; ?>][image_height]" value="<?php echo $product['designs']['option'][$option_id]['image_height']; ?>" size="3" style="height: 24px;" />
            <span class="s_metric" style="line-height: 24px !important;">px</span>
          </div>
          <?php endif; ?>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</fieldset>

<fieldset id="store_product_share_buttons">
  <legend>Share Buttons</legend>
  
  <div class="tb_wrap">
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Facebook like</label>
      <input type="hidden" name="product[button_facebook]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[button_facebook]" value="1"<?php if($product['button_facebook'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Twitter</label>
      <input type="hidden" name="product[button_twitter]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[button_twitter]" value="1"<?php if($product['button_twitter'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Google +1</label>
      <input type="hidden" name="product[button_google]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[button_google]" value="1"<?php if($product['button_google'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Pinterest</label>
      <input type="hidden" name="product[button_pinterest]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[button_pinterest]" value="1"<?php if($product['button_pinterest'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>Stumbleupon</label>
      <input type="hidden" name="product[button_stumbleupon]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[button_stumbleupon]" value="1"<?php if($product['button_stumbleupon'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_6 tb_live_row_1 tb_live_1_1">
      <label>LinkedIn</label>
      <input type="hidden" name="product[button_linkedin]" value="0" />
      <label class="tb_toggle"><input type="checkbox" name="product[button_linkedin]" value="1"<?php if($product['button_linkedin'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
  </div>

  <div class="tb_wrap">
    <div class="s_row_2 tb_col tb_1_1">
      <label>Custom share buttons</label>
      <div class="s_full">
        <textarea name="product[button_custom]" rows="3"><?php echo $product['button_custom']; ?></textarea>
      </div>
    </div>
  </div>

</fieldset>

<script type="text/template" id="store_product_design_template">
  <tr class="s_open s_nosep">
    <td>
      <input type="hidden" name="product[designs][layout][{{layout_id}}][design]" value="{{design_id}}" />
      <input type="hidden" name="product[designs][layout][{{layout_id}}][column_ratio]" value="{{column_ratio_id}}" />
      {{layout_name}} - {{design_name}}
    </td>
    <td class="align_left">{{column_ratio_text}}</td>
    <td width="10">
      <a href="javascript:;" class="s_button s_white s_h_20 s_icon_10 s_delete_10 tbRemove"></a>
    </td>
  </tr>
</script>

<script type="text/template" id="store_product_option_style_template">
  <tr class="s_open s_nosep">
    <td>
      <input type="hidden" name="product[designs][option][{{option_id}}]" value="{{style_id}}" />
      <input type="hidden" name="product[designs][option][{{option_id}}][image_w]" value="{{image_w}}" />
      <input type="hidden" name="product[designs][option][{{option_id}}][image_h]" value="{{image_h}}" />
      {{option_name}} - {{style_name}}<span style="display: {{display_img}};"> - {{image_w}} x {{image_h}}px</style>
    </td>
    <td width="10">
      <a href="javascript:;" class="s_button s_white s_h_20 s_icon_10 s_delete_10 tbRemove"></a>
    </td>
  </tr>
</script>


