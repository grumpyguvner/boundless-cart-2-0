<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('checkout/cart.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('checkout/cart.page_title'); ?>
<h1><?php echo $heading_title; ?><?php if ($weight) { ?> (<?php echo $weight; ?>) <?php } ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('checkout/cart.page_content'); ?>
<?php if ($attention) { ?>
<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>

<form id="cart_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div class="tb_table_1">
    <div class="cart-info">
      <table>
        <thead>
          <tr>
            <td class="image"><?php echo $column_image; ?></td>
            <td class="name"><?php echo $column_name; ?></td>
            <td class="model"><?php echo $column_model; ?></td>
            <td class="quantity"><?php echo $column_quantity; ?></td>
            <td class="price"><?php echo $column_price; ?></td>
            <td class="total"><?php echo $column_total; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="image"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?></td>
            <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
              <?php if (!$product['stock']) { ?>
              <strong class="tb_red">***</strong>
              <?php } ?>
              <div>
                <?php foreach ($product['option'] as $option) { ?>
                - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                <?php } ?>
                <?php if($product['recurring']): ?>
                <span class="tb_recurring">- <small><?php echo $product['recurring'] ?></small></span>
                <?php endif; ?>
              </div>
              <?php if ($product['reward']) { ?>
              <small><?php echo $product['reward']; ?></small>
              <?php } ?></td>
            <td class="model"><?php echo $product['model']; ?></td>
            <td class="quantity">
              <div class="tb_button_group">
                <input type="number" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" />
                <button class="tb_button_default tb_bg_str_3 tb_fixed" type="submit" title="<?php echo $button_update; ?>"><i class="fa fa-refresh"></i></button>
                <button class="tb_button_danger tb_fixed" type="button" title="<?php echo $button_remove; ?>" onclick="cart.remove('<?php echo $product['key']; ?>');"><i class="fa fa-times"></i></button></td>
              </div>
            <td class="price"><?php echo $product['price']; ?></td>
            <td class="total"><?php echo $product['total']; ?></td>
          </tr>
          <?php } ?>
          <?php foreach ($vouchers as $vouchers) { ?>
          <tr>
            <td class="image"></td>
            <td class="name"><?php echo $vouchers['description']; ?></td>
            <td class="model"></td>
            <td class="quantity">
              <div class="tb_button_group">
                <input type="text" name="" value="1" disabled="disabled" />
                <button class="tb_button_danger tb_fixed" type="button" title="<?php echo $button_remove; ?>" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times"></i></button>
              </div>
            </td>
            <td class="price"><?php echo $vouchers['amount']; ?></td>
            <td class="total"><?php echo $vouchers['amount']; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>
  </div>
</form>

<?php if ($coupon || $voucher || $reward || $shipping): ?>
<div id="cart_modules" class="tb_accordion tb_style_1 tb_sep">
  <?php echo $coupon; ?>
  <?php echo $voucher; ?>
  <?php echo $reward; ?>
  <?php echo $shipping; ?>
</div>
<?php endif; ?>

<div class="clearfix tb_sep">
  <div class="cart-total">
    <table id="total">
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td class="right"><strong><?php echo $total['title']; ?>:</strong></td>
        <td class="right"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </table>
  </div>
</div>

<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_shopping; ?></a>
  <a class="tb_button tb_button_checkout" href="<?php echo $checkout; ?>"><?php echo $button_checkout; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .cart-info table', [1000, 650, 0]);
});

$("#cart_modules").accordion({
  heightStyle: 'content',
  collapsible: true,
  active:      false
});

$('#cart_form .quantity input[name*="quantity"]').bind('change', function() {
  $('#cart_form').submit();
});

</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>