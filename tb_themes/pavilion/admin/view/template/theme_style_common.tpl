<?php $style = $theme_settings['style']; ?>
<h2><span><?php echo $text_title_design_common; ?></span></h2>

<fieldset>
  <legend>Site width</legend>
  <div class="tb_wrap">
    <div class="s_row_2 tb_col tb_1_5 tb_live_1_1">
      <div class="s_full clearfix">
        <div class="s_select">
          <select name="style[maximum_width]">
            <option value="1000"<?php if($style['maximum_width'] == '1000') echo ' selected="selected"';?>>1000px</option>
            <option value="1200"<?php if($style['maximum_width'] == '1200') echo ' selected="selected"';?>>1200px</option>
          </select>
        </div>
      </div>
    </div>
    <div class="tb_col tb_4_5">
      <p class="s_help right">Maximum site width in desktop view.</p>
    </div>
  </div>
</fieldset>

<fieldset>
  <legend>Header</legend>
  <div class="tb_wrap tb_gut_30">
    <div class="s_row_2 tb_col tb_2_5 tb_live_row_1 tb_live_1_1">
      <label>Layout</label>
      <div class="s_full clearfix">
        <div class="s_select">
          <select id="style_common_header_layout" name="style[header_layout]">
            <option value="1"<?php if($style['header_layout'] == '1') echo ' selected="selected"';?>><?php echo ucfirst($theme_name); ?> default</option>
            <option value="2"<?php if($style['header_layout'] == '2') echo ' selected="selected"';?>>Centered logo</option>
            <option value="3"<?php if($style['header_layout'] == '3') echo ' selected="selected"';?>>Centered logo (no top bar)</option>
            <option value="2_1"<?php if($style['header_layout'] == '2_1') echo ' selected="selected"';?>>Separate menubar</option>
            <option value="2_4"<?php if($style['header_layout'] == '2_4') echo ' selected="selected"';?>>Separate menubar (centered logo)</option>
            <option value="2_2"<?php if($style['header_layout'] == '2_2') echo ' selected="selected"';?>>Separate menubar (cart in menubar)</option>
            <option value="2_3"<?php if($style['header_layout'] == '2_3') echo ' selected="selected"';?>>Separate menubar (search in menubar)</option>
            <option value="2_5"<?php if($style['header_layout'] == '2_5') echo ' selected="selected"';?>>Separate menubar (centered search)</option>
          </select>
        </div>
      </div>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Text logo</label>
      <input type="hidden" name="style[text_logo]" value="0" />
      <label class="tb_toggle"><input id="style_common_header_text_logo" type="checkbox" name="style[text_logo]" value="1"<?php if($style['text_logo'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Sticky header</label>
      <input type="hidden" name="style[header_sticky]" value="0" />
      <label class="tb_toggle"><input id="style_common_header_sticky" type="checkbox" name="style[header_sticky]" value="1"<?php if($style['header_sticky'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
  </div>
</fieldset>

<fieldset id="style_common_logo_options">
  <legend>Site Logo</legend>
  <div class="tb_wrap tb_gut_30">
    <div id="style_common_logo_width_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Max width</label>
      <input class="s_spinner" type="text" name="style[logo_max_w]" min="0" size="7" value="<?php echo $style['logo_max_w']; ?>" />
      <span class="s_metric">px</span>
    </div>
    <div id="style_common_logo_height_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Max height</label>
      <input class="s_spinner" type="text" name="style[logo_max_h]" min="0" size="7" value="<?php echo $style['logo_max_h']; ?>" />
      <span class="s_metric">px</span>
    </div>
    <div id="style_common_sticky_logo_width_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Max width (in sticky header)</label>
      <input class="s_spinner" type="text" name="style[sticky_logo_max_w]" min="0" size="7" value="<?php echo $style['sticky_logo_max_w']; ?>" />
      <span class="s_metric">px</span>
    </div>
    <div id="style_common_sticky_logo_height_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Max height (in sticky header)</label>
      <input class="s_spinner" type="text" name="style[sticky_logo_max_h]" min="0" size="7" value="<?php echo $style['sticky_logo_max_h']; ?>" />
      <span class="s_metric">px</span>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Sticky header logo</label>
      <input type="hidden" name="style[sticky_logo_show]" value="0" />
      <label class="tb_toggle"><input id="style_common_logo_sticky_show" type="checkbox" name="style[sticky_logo_show]" value="1"<?php if($style['sticky_logo_show'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
  </div>
</fieldset>

<fieldset id="style_common_menu_options">
  <legend>Menu</legend>
  <div class="tb_wrap tb_gut_30">
    <div id="style_common_menu_height_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Height</label>
      <input class="s_spinner" type="text" name="style[menu_height]" min="0" size="7" value="<?php echo $style['menu_height']; ?>" />
      <span class="s_metric">px</span>
    </div>
    <div id="style_common_menu_padding_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label for="style_common_stack_messages">Inner padding</label>
      <input class="s_spinner" type="text" name="style[menu_inner_padding]" min="0" size="7" value="<?php echo $style['menu_inner_padding']; ?>" />
      <span class="s_metric">px</span>
    </div>
    <div id="style_common_menu_spacing_wrap" class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label >Spacing</label>
      <input class="s_spinner" type="text" name="style[menu_spacing]" min="0" size="7" value="<?php echo $style['menu_spacing']; ?>" />
      <span class="s_metric">px</span>
    </div>
  </div>
</fieldset>

<fieldset id="style_common_cart_options">
  <legend>Cart</legend>
  <div class="tb_wrap  tb_gut_30">
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label for="style_common_cart_icon">Show icon</label>
      <span class="clear"></span>
      <input type="hidden" name="style[cart_icon]" value="0" />
      <label class="tb_toggle"><input id="style_common_cart_icon" type="checkbox" name="style[cart_icon]" value="1"<?php if($style['cart_icon'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label for="style_common_cart_label">Show label</label>
      <span class="clear"></span>
      <input type="hidden" name="style[cart_label]" value="0" />
      <label class="tb_toggle"><input id="style_common_cart_label" type="checkbox" name="style[cart_label]" value="1"<?php if($style['cart_label'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label for="style_common_cart_items">Show items count</label>
      <span class="clear"></span>
      <input type="hidden" name="style[cart_items]" value="0" />
      <label class="tb_toggle"><input id="style_common_cart_items" type="checkbox" name="style[cart_items]" value="1"<?php if($style['cart_items'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label for="style_common_cart_total">Show total</label>
      <span class="clear"></span>
      <input type="hidden" name="style[cart_total]" value="0" />
      <label class="tb_toggle"><input id="style_common_cart_total" type="checkbox" name="style[cart_total]" value="1"<?php if($style['cart_total'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
  </div>
</fieldset>

<fieldset id="style_common_system_messages">
  <legend>System messages</legend>
  <div class="tb_wrap tb_gut_30">
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label>Position</label>
      <div class="s_select">
        <select name="style[msg_position]">
          <option value="topLeft"<?php if($style['msg_position'] == 'topLeft') echo ' selected="selected"';?>>Top Left</option>
          <option value="topCenter"<?php if($style['msg_position'] == 'topCenter') echo ' selected="selected"';?>>Top Center</option>
          <option value="topRight"<?php if($style['msg_position'] == 'topRight') echo ' selected="selected"';?>>Top Right</option>
          <option value="bottomRight"<?php if($style['msg_position'] == 'bottomRight') echo ' selected="selected"';?>>Bottom Right</option>
          <option value="bottomCenter"<?php if($style['msg_position'] == 'bottomCenter') echo ' selected="selected"';?>>Bottom Center</option>
          <option value="bottomLeft"<?php if($style['msg_position'] == 'bottomLeft') echo ' selected="selected"';?>>Bottom Left</option>
        </select>
      </div>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label for="style_common_stack_messages">Stack messages</label>
      <span class="clear"></span>
      <input type="hidden" name="style[msg_stack]" value="0" />
      <label class="tb_toggle"><input id="style_common_stack_messages" type="checkbox" name="style[msg_stack]" value="1"<?php if($style['msg_stack'] == '1') echo ' checked="checked"';?> /><span></span><span></span></label>
    </div>
    <div class="s_row_2 tb_col tb_1_5 tb_live_row_1 tb_live_1_1">
      <label >Timeout</label>
      <input class="s_spinner" type="text" name="style[msg_timeout]" min="1000" size="7" step="500" value="<?php echo $style['msg_timeout']; ?>" />
      <span class="s_metric">ms</span>
    </div>
  </div>
</fieldset>
