<?php $tbData->slotStart('module/special.products', array('filter' => array('module/special.products.filter|oc_module_products.filter', 'products' => &$products), 'data' => $data)); ?>
<?php if ($products): ?>

<?php if ($heading_title): ?>
<h2><?php echo $heading_title; ?></h2>
<?php endif; ?>

<div class="tb_products tb_listing <?php echo $tbData->category_products_current['listing_classes']; ?> tb_{{widget_dom_id}}_classes clearfix">
  <?php foreach ($products as $product): ?>
  <?php $tbData->slotStart('module/special.products.each', array('product' => $product, 'data' => $data)); ?>
  <div class="tb_product tb_item <?php echo $product['tb_classes']; ?>">
    <?php if ($product['thumb'] && $tbData->category_products_current['show_thumb']): ?>
    <a class="tb_thumb<?php if ($product['thumb_zoom']): ?> tb_zoom<?php endif; ?>" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>"<?php if ($product['thumb_zoom']): ?> data-zoom-image="<?php echo $product['thumb_zoom']; ?>"<?php endif; ?> />
    </a>
    <?php if ($product['thumb_hover']): ?>
    <a class="tb_thumb tb_thumb_hover" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb_hover']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
    </a>
    <?php endif; ?>
    <?php endif; ?>
    <div class="tb_item_info">
      <?php if ($tbData->category_products_current['show_title']): ?>
      <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
      <?php endif; ?>
      <?php if ($tbData->category_products_current['show_price'] && $product['price']): ?>
      <div class="tb_price_holder <?php echo $tbData->category_products_current['price_classes']; ?>">
        <?php if (!$product['special']): ?>
        <p class="tb_price"><?php echo $tbData->priceFormat($product['price']); ?></p>
        <?php else: ?>
        <p class="tb_price tb_promo_price">
          <span class="tb_old_price"><?php echo $tbData->priceFormat($product['price']); ?></span>
          <span class="tb_new_price"><?php echo $tbData->priceFormat($product['special']); ?></span>
        </p>
        <?php endif; ?>
      </div>
      <?php endif; ?>
      <?php if ($tbData->category_products_current['show_desc'] && $product['description']): ?>
      <p class="tb_description"><?php echo $product['description']; ?></p>
      <?php endif; ?>
      <?php if ($tbData->category_products_current['show_rating'] && $product['rating']): ?>
      <div class="tb_rating_holder">
        <p class="tb_rating tb_rating_5" title="<?php echo $product['rating']; ?>/5">
          <span class="tb_base"></span>
          <span class="tb_percent" style="width: <?php echo $product['rating'] * 2 ; ?>0%;"></span>
        </p>
        <span class="tb_average"><?php echo $product['rating']; ?>/5</span>
      </div>
      <?php endif; ?>
      <?php if ($product['show_cart'] && $product['quantity'] < 1 && !$tbData['config']->get('config_stock_checkout')): ?>
      <p class="tb_label_stock_status"><?php echo $product['stock_status']; ?></p>
      <?php endif; ?>
      <?php if ($product['show_cart'] || $tbData->category_products_current['show_wishlist'] || $tbData->category_products_current['show_compare']): ?>
      <div class="tb_actions">
        <?php if ($product['show_cart'] && $product['quantity'] > 0): ?>
        <div class="tb_button_add_to_cart<?php echo $tbData->category_products_current['cart_button_position_classes']; ?>"<?php echo $tbData->category_products_current['cart_button_offset_attr']; ?>>
          <a class="<?php echo $tbData->category_products_current['cart_button_classes']; ?>" href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $product['text_button_cart']; ?>"><?php echo $product['text_button_cart']; ?></span>
          </a>
        </div>
        <?php endif; ?>
        <?php if ($tbData->category_products_current['show_wishlist']): ?>
        <div class="tb_button_wishlist<?php echo $tbData->category_products_current['wishlist_button_position_classes']; ?>"<?php echo $tbData->category_products_current['wishlist_button_offset_attr']; ?>>
          <a class="<?php echo $tbData->category_products_current['wishlist_button_classes']; ?>" href="javascript:;" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $tbData->text_wishlist; ?>"><?php echo $tbData->text_wishlist; ?></span>
          </a>
        </div>
        <?php endif; ?>
        <?php if ($tbData->category_products_current['show_compare']): ?>
        <div class="tb_button_compare<?php echo $tbData->category_products_current['compare_button_position_classes']; ?>"<?php echo $tbData->category_products_current['compare_button_offset_attr']; ?>>
          <a class="<?php echo $tbData->category_products_current['compare_button_classes']; ?>" href="javascript:;" onclick="compare.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $tbData->text_compare; ?>"><?php echo $tbData->text_compare; ?></span>
          </a>
        </div>
        <?php endif; ?>
      </div>
      <?php endif; ?>
    </div>
    <?php if ($tbData->category_products_current['show_label_sale'] && $product['special']): ?>
    <span class="tb_label_special"><span><?php echo $product['savings_num']; ?><span>%</span></span><small>off</small></span>
    <?php endif; ?>
    <?php if ($tbData->category_products_current['show_label_new'] && $product['is_new']): ?>
    <span class="tb_label_new"><?php echo $tbData->text_label_new; ?></span>
    <?php endif; ?>
  </div>
  <?php $tbData->slotStopEcho(); ?>
  <?php endforeach; ?>
</div>

<script type="text/javascript">
tbApp.init{{widget_dom_id}} = function() {
    tbApp.onScriptLoaded(function() {

        <?php if (!$tbData->is_touch): ?>

        <?php // THUMB HOVER ?>
        <?php if ($tbData->category_products_current['thumbs_hover_action'] != 'none'): ?>
        thumb_hover('#{{widget_dom_id}}', '<?php echo $tbData->category_products_current['thumbs_hover_action']; ?>')
        <?php endif; ?>

        <?php // THUMB ZOOM ?>
        <?php if ($tbData->category_products_current['thumbs_hover_action'] == 'zoom'): ?>
        $('#{{widget_dom_id}}').find('.tb_zoom > img').elevateZoom({
          zoomType:           'inner',
          zoomWindowFadeIn:   300,
          zoomWindowFadeOut:  300,
          cursor:             'crosshair'
        });
        <?php endif; ?>

        <?php // PRODUCT HOVER ?>
        <?php if ($tbData->category_products_current['elements_hover_action'] != 'none'): ?>
        item_hover('#{{widget_dom_id}}', '<?php echo $tbData->category_products_current['active_elements']; ?>', '<?php echo $tbData->category_products_current['hover_elements']; ?>', '<?php echo $tbData->category_products_current['elements_hover_action']; ?>');
        <?php endif; ?>

        <?php endif; ?>

    });

}
tbApp.exec{{widget_dom_id}} = function() {
    tbApp.onScriptLoaded(function() {
        <?php // ADJUST PRODUCT SIZE ?>
        adjustItemSize('#{{widget_dom_id}}', <?php echo $tbData->category_products_current['restrictions_json']; ?>);
    });

    <?php // ITEM BEAUTIFY ?>
    <?php if($tbData->category_products_current['products_style'] != 1): ?>
    tbApp.onWindowLoaded(function() {
        item_beautify('#{{widget_dom_id}}');
    });
    <?php endif; ?>
}

if ({{within_group}}) {
  tbApp.init{{widget_dom_id}}();
  tbApp.exec{{widget_dom_id}}();
}

</script>
<?php endif; ?>
<?php $tbData->slotStopEcho(); ?>
