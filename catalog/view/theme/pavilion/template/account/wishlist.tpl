<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/wishlist.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/wishlist.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/wishlist.page_content', array('filter' => array('account/wishlist.products.filter|oc_module_products.filter', 'products' => &$products), 'data' => $data)); ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>

<?php if ($products) { ?>
<div class="wishlist-info cart-info tb_table_1 tb_open">
  <table>
    <thead>
      <tr>
        <td class="image"><?php echo $column_image; ?></td>
        <td class="name"><?php echo $column_name; ?></td>
        <td class="model"><?php echo $column_model; ?></td>
        <td class="stock"><?php echo $column_stock; ?></td>
        <td class="price"><?php echo $column_price; ?></td>
        <td class="action" width="120"><?php echo $column_action; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr id="wishlist-row<?php echo $product['product_id']; ?>">
        <td class="image"><?php if ($product['thumb']) { ?>
          <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
          <?php } ?>
        </td>
        <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
        <td class="model"><?php echo $product['model']; ?></td>
        <td class="stock"><?php echo $product['stock']; ?></td>
        <td class="price"><?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <b><?php echo $product['special']; ?></b> <s><?php echo $product['price']; ?></s>
            <?php } ?>
          </div>
          <?php } ?>
        </td>
        <td class="action">
          <div class="tb_button_group">
            <?php if ($product['price'] && $tbData->common['checkout_enabled'] && $tbData->store_common['disable_checkout_stock_status_name'] != $product['stock_status']): ?>
            <button class="tb_button tb_button_default tb_bg_str_3 tb_fixed" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');" title="<?php echo $button_cart; ?>"><i class="fa fa-shopping-cart"></i></button>
            <?php endif; ?>
            <a class="tb_button tb_button_primary tb_fixed" href="<?php echo $product['remove']; ?>" title="<?php echo $button_remove; ?>"><i class="fa fa-times"></i></a>
          </div>
        </td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</div>

<?php } else { ?>
        
<p class="tb_text_empty"><?php echo $text_empty; ?></p>

<?php } ?>
        
<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .wishlist-info table', [1000, 650, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>