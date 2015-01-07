<?php if (!isset($redirect)) { ?>
<div class="cart-info checkout-product">
  <table class="tb_table_1 tb_sep">
    <thead>
      <tr>
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
        <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <div>
            <?php foreach ($product['option'] as $option) { ?>
            - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
            <?php } ?>
            <?php if($product['recurring']): ?>
            <span class="tb_recurring">- <small><?php echo $product['recurring'] ?></small></span>
            <?php endif; ?>
          </div>
        </td>
        <td class="model"><?php echo $product['model']; ?></td>
        <td class="quantity">x <?php echo $product['quantity']; ?></td>
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
    <tfoot>
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td class="right"><strong><?php echo $total['title']; ?>:</strong></td>
        <td class="right"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
</div>

<?php echo $payment; ?>
<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script>
<?php } ?>
