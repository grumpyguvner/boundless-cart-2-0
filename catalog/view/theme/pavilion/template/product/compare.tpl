<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('product/compare.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('product/compare.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('product/compare.page_content', array('filter' => array('product/compare.products.filter|oc_module_products.filter', 'products' => &$products), 'data' => $data)); ?>
<?php if ($products) { ?>
<div class="compare-info tb_table_1">
  <table>
    <thead>
      <tr>
        <td class="compare-product" colspan="<?php echo count($products) + 1; ?>"><?php echo $text_product; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><?php echo $text_name; ?></td>
        <?php foreach ($products as $product) { ?>
        <td class="name"><a href="<?php echo $products[$product['product_id']]['href']; ?>"><?php echo $products[$product['product_id']]['name']; ?></a></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_image; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php if ($products[$product['product_id']]['thumb']) { ?>
          <img src="<?php echo $products[$product['product_id']]['thumb']; ?>" alt="<?php echo $products[$product['product_id']]['name']; ?>" />
          <?php } ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_price; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php if ($products[$product['product_id']]['price']) { ?>
          <?php if (!$products[$product['product_id']]['special']) { ?>
          <?php echo $products[$product['product_id']]['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $products[$product['product_id']]['price']; ?></span> <span class="price-new"><?php echo $products[$product['product_id']]['special']; ?></span>
          <?php } ?>
          <?php } ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_model; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['model']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_manufacturer; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['manufacturer']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_availability; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['availability']; ?></td>
        <?php } ?>
      </tr>
      <?php if ($review_status) { ?>
      <tr>
        <td><?php echo $text_rating; ?></td>
        <?php foreach ($products as $product): ?>
        <td class="product_rating product_<?php echo $product['product_id']; ?>">
          <?php if ($products[$product['product_id']]['rating']): ?>
          <div class="tb_rating_holder">
            <p class="tb_rating tb_rating_5">
              <span class="tb_base"></span>
              <span class="tb_percent" style="width: <?php echo $products[$product['product_id']]['rating'] * 2 ; ?>0%;"></span>
            </p>
            <span class="tb_average tb_mb_0"><?php echo $products[$product['product_id']]['rating']; ?>/5</span>
            <span class="tb_total">(<?php echo $products[$product['product_id']]['reviews']; ?>)</span>
          </div>
          <?php else: ?>
          <div class="tb_rating_holder">
            <p class="tb_rating tb_rating_5 tb_mb_0">
              <span class="tb_base"></span>
              <span class="tb_percent" style="width: 0;"></span>
            </p>
            <span class="tb_total"><?php echo $tbData->text_product_not_yet_rated; ?></span>
          </div>
          <?php endif; ?>
        </td>
        <?php endforeach; ?>
      </tr>
      <?php } ?>
      <tr>
        <td><?php echo $text_summary; ?></td>
        <?php foreach ($products as $product) { ?>
        <td class="description"><?php echo $products[$product['product_id']]['description']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_weight; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['weight']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_dimension; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?></td>
        <?php } ?>
      </tr>
    </tbody>
    <?php foreach ($attribute_groups as $attribute_group) { ?>
    <thead>
      <tr>
        <td class="compare-attribute" colspan="<?php echo count($products) + 1; ?>"><?php echo $attribute_group['name']; ?></td>
      </tr>
    </thead>
    <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
    <tbody>
      <tr>
        <td><?php echo $attribute['name']; ?></td>
        <?php foreach ($products as $product) { ?>
        <?php if (isset($products[$product['product_id']]['attribute'][$key])) { ?>
        <td><?php echo $products[$product['product_id']]['attribute'][$key]; ?></td>
        <?php } else { ?>
        <td></td>
        <?php } ?>
        <?php } ?>
      </tr>
    </tbody>
    <?php } ?>
    <?php } ?>
    <tbody>
      <tr>
        <td></td>
        <?php foreach ($products as $product) { ?>
        <td>
          <?php if ($product['show_cart']): ?>
          <?php if ($product['quantity'] < 1 && !$tbData['config']->get('config_stock_checkout')): ?>
          <p class="tb_label_stock_status tb_h_30"><?php echo $product['stock_status']; ?></p>
          <?php else: ?>
          <div class="tb_button_add_to_cart">
            <a class="tb_button tb_h_30" href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>');"><?php echo $product['text_button_cart']; ?></a>
          </div>
          <?php endif; ?>
          <span class="clear tb_mb_10"></span>
          <?php endif; ?>
          <a class="tb_main_color tb_icon fa-times" href="<?php echo $product['remove']; ?>"> <?php echo $button_remove; ?></a>
        </td>
        <?php } ?>
      </tr>
    </tbody>
  </table>
</div>

<?php } else { ?>

<p class="tb_empty"><?php echo $text_empty; ?></p>

<?php } ?>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>