<?php $tbData->echoHeader($header); ?>


<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('payment/pp_express/expressConfirm.page_title'); ?>
<h1><?php echo $text_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('payment/pp_express/expressConfirm.page_content'); ?>
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
        
<?php if ($coupon || $voucher || $reward || $shipping) { ?>
<div class="panel-group" id="accordion"><?php echo $coupon; ?><?php echo $voucher; ?><?php echo $reward; ?></div>
<?php } ?>

<span class="clear tb_sep tb_border_solid tb_border_str_2"></span>

<?php if($has_shipping) { ?>
    <?php if(!isset($shipping_methods)) { ?>
        <div class="warning"><?php echo $error_no_shipping ?></div>
    <?php } else { ?>
        <div class="cart-module">
            <div id="shipping" class="content" style="display: block;">
                <form action="<?php echo $action_shipping; ?>" method="post" id="shipping_form">
                    <table class="radio" cellpadding="0" cellspacing="0">

                    <?php foreach ($shipping_methods as $shipping_method) { ?>

                        <tr>
                            <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
                        </tr>
                        <?php if (!$shipping_method['error']) { ?>
                            <?php foreach ($shipping_method['quote'] as $quote) { ?>
                            <tr class="highlight">
                                <td><?php if ($quote['code'] == $code || !$code) { ?>
                                    <?php $code = $quote['code']; ?>
                                    <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
                                    <?php } else { ?>
                                    <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
                                    <?php } ?></td>
                                <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
                                <td style="text-align: right;"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                            </tr>
                            <?php } ?>
                        <?php } else { ?>
                        <tr>
                            <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
                        </tr>
                        <?php } ?>
                    <?php } ?>

                    </table>
                </form>
            </div>
        </div>
    <?php } ?>
<?php } ?>

<span class="clear tb_sep"></span>

<div class="checkout-product cart-info tb_table_1">
  <table width="100%" cellpadding="0" cellspacing="0">
    <thead>
      <tr>
        <th class="name"><?php echo $column_name; ?></th>
        <th class="model"><?php echo $column_model; ?></th>
        <th class="quantity"><?php echo $column_quantity; ?></th>
        <th class="price"><?php echo $column_price; ?></th>
        <th class="total"><?php echo $column_total; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="name">
          <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <div>
            <?php foreach ($product['option'] as $option) { ?>
            <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
            <?php } ?>
            <?php if($product['recurring']): ?>
            <small><strong><?php echo $text_recurring_item; ?>:</strong> (<?php echo $product['recurring_description'] ?>)</small>
            <?php endif; ?>
          </div>
        </td>
        <td class="model"><?php echo $product['model']; ?></td>
        <td class="quantity"><?php echo $product['quantity']; ?></td>
        <td class="price"><?php echo $product['price']; ?></td>
        <td class="total"><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="name"><?php echo $voucher['description']; ?></td>
        <td class="model"></td>
        <td class="quantity">1</td>
        <td class="price"><?php echo $voucher['amount']; ?></td>
        <td class="total"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</div>
  
<div class="cart-total tb_sep clearfix">
  <table id="total">
    <?php foreach ($totals as $total) { ?>
    <tr>
      <td class="right"><b><?php echo $total['title']; ?>:</b></td>
      <td class="right"><?php echo $total['text']; ?></td>
    </tr>
    <?php } ?>
  </table>
</div>
    
<div class="tb_submit clearfix">
  <a href="<?php echo $action_confirm; ?>" class="tb_button"><span class="tb_text"><?php echo $button_confirm; ?></span></a>
</div>

<script type="text/javascript">
$("input[name='shipping_method']").change( function() {
    $('#shipping_form').submit();
});

$('input[name=\'next\']').bind('change', function() {
    $('.cart-discounts > div').hide();

    $('#' + this.value).show();
});

tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .cart-info table', [1000, 650, 0]);
});

$("#accordion").accordion({
  heightStyle: 'content',
  collapsible: true,
  active:      false
});

</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>