<div class="tb_products tb_listing <?php echo $listing_classes; ?> clearfix">

  <?php foreach ($products as $product): ?>
  <div class="tb_product tb_item <?php echo $product['tb_classes']; ?>">
    <?php if ($product['thumb'] && $show_thumb): ?>
    <a class="tb_thumb<?php if ($thumbs_hover_action == 'zoom'): ?> tb_zoom<?php endif; ?>" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb']; ?>" width="<?php echo $product['thumb_width']; ?>" height="<?php echo $product['thumb_height']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>"<?php if ($thumbs_hover_action == 'zoom'): ?> data-zoom-image="<?php echo $product['thumb_zoom']; ?>"<?php endif; ?> />
    </a>
    <?php if ($product['thumb_hover']): ?>
    <a class="tb_thumb tb_thumb_hover" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb_hover']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
    </a>
    <?php endif; ?>
    <?php endif; ?>
    <div class="tb_item_info">
      <?php if ($show_title): ?>
      <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
      <?php endif; ?>
      <?php if ($show_price && $product['price']): ?>
      <div class="tb_price_holder<?php echo $price_classes; ?>">
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
      <?php if ($show_desc && $product['description']): ?>
      <p class="tb_description"><?php echo $product['description']; ?></p>
      <?php endif; ?>
      <?php if ($show_rating && $product['rating']): ?>
      <div class="tb_rating_holder">
        <p class="tb_rating tb_rating_5" title="<?php echo $product['rating']; ?>/5">
          <span class="tb_base"></span>
          <span class="tb_percent" style="width: <?php echo $product['rating'] * 2 ; ?>0%;"></span>
        </p>
        <span class="tb_average"><?php echo $product['rating']; ?>/5</span>
      </div>
      <?php endif; ?>
      <?php if ($product['show_cart'] && $product['quantity'] < 1 && !$config_stock_checkout): ?>
      <p class="tb_label_stock_status"><?php echo $product['stock_status']; ?></p>
      <?php endif; ?>
      <?php if ($product['show_cart'] || $show_wishlist || $show_compare): ?>
      <div class="tb_actions">
        <?php if ($product['show_cart'] && $product['quantity'] > 0): ?>
        <div class="tb_button_add_to_cart<?php echo $cart_button_position_classes; ?>"<?php echo $cart_button_offset_attr; ?>>
          <a class="<?php echo $cart_button_classes; ?>" href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $product['text_button_cart']; ?>"><?php echo $product['text_button_cart']; ?></span>
          </a>
        </div>
        <?php endif; ?>
        <?php if ($show_wishlist): ?>
        <div class="tb_button_wishlist<?php echo $wishlist_button_position_classes; ?>"<?php echo $wishlist_button_offset_attr; ?>>
          <a class="<?php echo $wishlist_button_classes; ?>" href="javascript:;" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $tbData->text_wishlist; ?>"><?php echo $tbData->text_wishlist; ?></span>
          </a>
        </div>
        <?php endif; ?>
        <?php if ($show_compare): ?>
        <div class="tb_button_compare<?php echo $compare_button_position_classes; ?>"<?php echo $compare_button_offset_attr; ?>>
          <a class="<?php echo $compare_button_classes; ?>" href="javascript:;" onclick="compare.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $tbData->text_compare; ?>"><?php echo $tbData->text_compare; ?></span>
          </a>
        </div>
        <?php endif; ?>
      </div>
      <?php endif; ?>
    </div>
    <?php if ($show_label_sale && $product['special']): ?>
    <span class="tb_label_special"><span><?php echo $product['savings_num']; ?><span>%</span></span><small>off</small></span>
    <?php endif; ?>
    <?php if ($show_label_new && $product['is_new']): ?>
    <span class="tb_label_new"><?php echo $tbData->text_label_new; ?></span>
    <?php endif; ?>
  </div>
  <?php endforeach; ?>

</div>

<script type="text/javascript">
tbApp.init<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {

        <?php if (!$tbData->is_touch): ?>

        <?php // THUMB HOVER ?>
        <?php if ($thumbs_hover_action != 'none'): ?>
        thumb_hover('#<?php echo $widget->getDomId(); ?>', '<?php echo $thumbs_hover_action; ?>')
        <?php endif; ?>

        <?php // THUMB ZOOM ?>
        <?php if ($thumbs_hover_action == 'zoom'): ?>
        $('#<?php echo $widget->getDomId(); ?>').find('.tb_zoom > img').elevateZoom({
            zoomType:           'inner',
            zoomWindowFadeIn:   300,
            zoomWindowFadeOut:  300,
            cursor:             'crosshair'
        });
        <?php endif; ?>

        <?php // PRODUCT HOVER ?>
        <?php if (!($slider && $elements_hover_action == 'append') && $elements_hover_action != 'none'): ?>
        item_hover('#<?php echo $widget->getDomId(); ?>', '<?php echo $active_elements; ?>', '<?php echo $hover_elements; ?>', '<?php echo $elements_hover_action; ?>');
        <?php endif; ?>

        <?php endif; ?>

        <?php // PRODUCT SLIDER ?>
        <?php if ($slider): ?>
        tbApp.itemSlider<?php echo $widget->getDomId(); ?> = createItemSlider('#<?php echo $widget->getDomId(); ?>', <?php echo count($products); ?>, <?php echo $slider_step; ?>, <?php echo $slider_speed; ?>, <?php $slider_pagination ? print '\'#' . $widget->getDomId() . ' .tb_slider_pagination\'' : print 'false' ; ?>, <?php echo $restrictions_json; ?>)
        <?php endif; ?>
    });
}
tbApp.exec<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
        <?php // REFRESH SLIDER ?>
        <?php if ($slider): ?>
        tbApp.itemSlider<?php echo $widget->getDomId(); ?>.refresh();
        <?php endif; ?>

        <?php // ADJUST PRODUCT SIZE ?>
        adjustItemSize('#<?php echo $widget->getDomId(); ?>', <?php echo $restrictions_json; ?>);
    });
    tbApp.onWindowLoaded(function() {
        item_beautify('#<?php echo $widget->getDomId(); ?>');
    });
}

<?php if (!isset($within_group) || !$within_group): ?>
tbApp.init<?php echo $widget->getDomId(); ?>();
tbApp.exec<?php echo $widget->getDomId(); ?>();
<?php endif; ?>

</script>