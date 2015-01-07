<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/order/info.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/order/info.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/order/info.page_content'); ?>
<div class="tb_order_info">

  <h2 class="tb_id left"><?php echo $text_order_id; ?> <span class="tb_main_color">#<?php echo $order_id; ?></span></h2>

  <?php if ($invoice_no): ?>
  <p class="tb_status h2"><?php echo $text_invoice_no; ?> <span class="tb_main_color"><?php echo $invoice_no; ?></span></p>
  <?php endif; ?>

  <span class="clear tb_sep tb_border_str_2"></span>
          
  <dl class="tb_dlist_1 tb_sep">
    <dt><?php echo $text_date_added; ?></dt>
    <dd><?php echo $date_added; ?></dd>
    <?php if ($payment_method): ?>
    <dt><?php echo $text_payment_method; ?></dt>
    <dd><?php echo $payment_method; ?></dd>
    <?php endif; ?>
    <?php if ($shipping_method): ?>
    <dt><?php echo $text_shipping_method; ?></dt>
    <dd><?php echo $shipping_method; ?></dd>
    <?php endif; ?>
  </dl>

  <span class="clear tb_sep tb_border_str_1"></span>
          
  <div class="tb_wrap tb_sep">

    <div class="tb_col_1_2">
      <h2><?php echo $text_payment_address; ?></h2>
      <p class="tb_address tb_border_str_1"><?php echo $payment_address; ?></p>
    </div>

    <?php if ($shipping_address): ?>
    <div class="tb_col_1_2">
      <h2><?php echo $text_shipping_address; ?></h2>
      <p class="tb_address tb_border_str_1"><?php echo $shipping_address; ?></p>
    </div>
    <?php endif; ?>
            
  </div>

  <span class="clear tb_sep tb_border_str_1"></span>

  <h2><?php echo $tbData->text_ordered_products; ?></h2>
  <div class="tb_order_products tb_table_1 cart-info">
    <table>
      <thead>
        <tr>
          <?php if ($tbData->common['returns_enabled']): ?>
          <th class="action" width="90">&nbsp;</th>
          <?php endif; ?>
          <th class="name"><?php echo $column_name; ?></th>
          <th class="model"><?php echo $column_model; ?></th>
          <th class="quantity"><?php echo $column_quantity; ?></th>
          <th class="price"><?php echo $column_price; ?></th>
          <th class="total"><?php echo $column_total; ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($products as $product): ?>
        <tr>
          <?php if ($tbData->common['returns_enabled'] || $product['reorder']): ?>
          <td class="action">
            <span class="tb_button_group">
              <?php if ($product['reorder']) { ?>
              <a href="<?php echo $product['reorder']; ?>" title="<?php echo $button_reorder; ?>" class="tb_button tb_button_default tb_bg_str_3 tb_fixed"><i class="fa fa-shopping-cart"></i></a>
              <?php } ?>
              <?php if ($tbData->common['returns_enabled']) { ?>
              <a href="<?php echo $product['return']; ?>" title="<?php echo $button_return; ?>" class="tb_button tb_button_danger tb_fixed"><i class="fa fa-reply"></i></a></td>
              <?php } ?>
            </span>
          </td>
          <?php endif; ?>
          <td class="name">
            <strong data-quantity=" x<?php echo $product['quantity']; ?>"><?php echo $product['name']; ?></strong>
            <?php foreach ($product['option'] as $option): ?>
            <br />
            &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
            <?php endforeach; ?>
          </td>
          <td class="model"><?php echo $product['model']; ?></td>
          <td class="quantity"><?php echo $product['quantity']; ?></td>
          <td class="price"><?php echo $product['price']; ?></td>
          <td class="total"><?php echo $product['total']; ?></td>
        </tr>
        <?php endforeach; ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          <td class="return"></td>
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
  <?php if ($totals): ?>
  <div class="cart-total tb_sep clearfix">
    <table>
      <?php foreach ($totals as $total): ?>
      <tr>
        <td><strong><?php echo $total['title']; ?></strong></td>
        <td><?php echo $total['text']; ?></td>
      </tr>
      <?php endforeach; ?>
    </table>
  </div>
  <?php endif; ?>

  <?php if ($histories) { ?>

  <span class="clear tb_sep tb_border_str_1"></span>

  <h2><?php echo $text_history; ?></h2>
  <div class="tb_order_statuses tb_table_1 tb_open">
    <table>
      <thead>
        <tr>
          <th class="date"><?php echo $column_date_added; ?></th>
          <th class="status"><?php echo $column_status; ?></th>
          <th class="comment"><?php echo $column_comment; ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($histories as $history): ?>
        <tr>
          <td class="date"><?php echo $history['date_added']; ?></td>
          <td class="status"><?php echo $history['status']; ?></td>
          <td class="comment"><?php echo $history['comment']; ?></td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php } ?>

  <?php if ($comment): ?>
  <h2><?php echo $text_comment; ?></h2>
  <p><?php echo $comment; ?></p>
  <?php endif; ?>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
  </div>

</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .tb_order_products table', [1000, 400, 0]);
  element_query('#{{widget_dom_id}} .tb_order_statuses table', [1000, 400, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>
