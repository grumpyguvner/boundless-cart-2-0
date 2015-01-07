<div id="cart" class="tb_nav">
  <h3 class="heading">
    <a href="<?php echo $cart; ?>">
      <?php if ($tbData->style['cart_icon']): ?>
      <i class="tb_icon fa-shopping-cart tb_main_color"></i>
      <?php endif; ?>
      <?php if ($tbData->style['cart_label']): ?>
      <span class="tb_label"><?php echo $tbData->text_cart; ?></span>
      <?php endif; ?>
      <?php if ($tbData->style['cart_items']): ?>
      <span class="tb_items">(<?php echo $tbData->extractCartText($text_items, 'count'); ?>)</span>
      <?php endif; ?>
      <?php if ($tbData->style['cart_total']): ?>
      <span class="tb_total tb_main_color tb_border_str_2"><?php echo $tbData->extractCartText($text_items, 'total'); ?></span>
      <?php endif; ?>
    </a>
  </h3>
  <div class="tb_submenu">
  <div class="content">
    <h3><?php echo $tbData->text_shopping_cart; ?></h3>
    <?php if ($products || $vouchers) { ?>
    <div class="cart-info mini-cart-info tb_table_1">
      <table>
        <?php foreach ($products as $product) { ?>
        <tr>
          <td class="image"><?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
            <?php } ?></td>
          <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <div>
              <?php foreach ($product['option'] as $option) { ?>
              - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
              <?php } ?>
              <?php if ($product['recurring']): ?>
              - <small><?php echo $text_recurring ?> <?php echo $product['recurring']; ?></small><br />
              <?php endif; ?>
            </div></td>
          <td class="quantity">x&nbsp;<?php echo $product['quantity']; ?></td>
          <td class="total"><?php echo $product['total']; ?></td>
          <td class="remove"><button class="tb_button_remove tb_button tb_bg_str_3 tb_text_str_6 tb_h_24 tb_fixed" type="button" onclick="cart.remove('<?php echo $product['key']; ?>');" title="<?php echo $button_remove; ?>"></button></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          <td class="image"></td>
          <td class="name"><?php echo $voucher['description']; ?></td>
          <td class="quantity">x&nbsp;1</td>
          <td class="total"><?php echo $voucher['amount']; ?></td>
          <td class="remove"><button class="tb_button_remove tb_button tb_bg_str_3 tb_text_str_6 tb_h_24 tb_fixed" type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>"></button></td>
        </tr>
        <?php } ?>
      </table>
    </div>
    <div class="cart-total mini-cart-total">
      <table>
        <?php foreach ($totals as $total) { ?>
        <tr>
          <td class="right"><strong><?php echo $total['title']; ?></strong></td>
          <td class="right"><?php echo $total['text']; ?></td>
        </tr>
        <?php } ?>
      </table>
    </div>
    <div class="checkout tb_submit clearfix">
      <a class="tb_button tb_h_30" href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a>
      <a class="tb_button tb_h_30" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a>
    </div>
    <?php } else { ?>
    <div class="empty"><?php echo $text_empty; ?></div>
    <?php } ?>
  </div>
  </div>
</div>
