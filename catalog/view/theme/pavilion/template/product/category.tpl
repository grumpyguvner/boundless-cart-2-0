<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('product/category.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('product/category.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Category thumb ----------------------------------------------- ?>

<?php $tbData->slotStart('product/category.category_thumb'); ?>
<?php if ($thumb): ?>
<div class="tb_category_thumb">
  <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" />
</div>
<?php endif; ?>
<?php $tbData->slotStop(); ?>

<?php // Category description ----------------------------------------- ?>

<?php $tbData->slotStart('product/category.category_description'); ?>
<?php if ($description): ?>
<div class="tb_category_description">
  <?php echo $description; ?>
</div>
<?php endif; ?>
<?php $tbData->slotStop(); ?>

<?php // Category listing --------------------------------------------- ?>

<?php $tbData->slotStart('product/category.subcategory_listing', array('filter' => array('product/category.subcategory_listing.filter', 'categories' => &$categories), 'data' => $data)); ?>
<?php if ($categories): ?>

<?php if ($tbData['product/category.subcategory_listing']['show_title']): ?>
<h2><?php echo $tbData->text_subcategory_title; ?></h2>
<?php endif; ?>

<div class="tb_subcategories tb_listing tb_grid_view <?php echo $tbData['subcategories']['listing_classes']; ?> tb_side_nav clearfix">
  <?php if ($tbData['subcategories']['style'] == 6): ?>
  
  <ul class="tb_list_1">
    <?php foreach ($categories as $category): ?>
    <li>
      <a href="<?php echo $category['url']; ?>" title="<?php echo $category['name']; ?>">
        <?php echo $category['name']; ?>
        <?php if ($tbData['subcategories']['product_count']): ?>
        <span>(<?php echo $category['products_count']; ?>)</span>
        <?php endif; ?>
      </a>
      <?php if (isset($category['children']) && $category['children'] && $tbData['subcategories']['show_children']): ?>
      <ul class="tb_list_1">
        <?php foreach ($category['children'] as $child): ?>
        <li><a href="<?php echo $child['url']; ?>"><?php echo $child['name']; ?></a></li>
        <?php endforeach; ?>
      </ul>
      <?php endif; ?>
    </li>
    <?php endforeach; ?>
  </ul>
  
  <?php else: ?>

  <?php foreach ($categories as $category): ?>
  <div class="tb_subcategory tb_item<?php echo $category['tb_css_classes']; ?>">
    <?php if ($tbData['subcategories']['show_thumb']): ?>
    <a class="tb_thumb" href="<?php echo $category['url']; ?>" title="<?php echo $category['name']; ?>">
      <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" />
    </a>
    <?php endif; ?>
    <?php if ($tbData['subcategories']['show_title']): ?>
    <h3>
      <a href="<?php echo $category['url']; ?>">
        <?php echo $category['name']; ?>
        <?php if ($tbData['subcategories']['product_count']): ?>
        <span>(<?php echo $category['products_count']; ?>)</span>
        <?php endif; ?>
      </a>
    </h3>
    <?php endif; ?>
    <?php if (isset($category['children']) && $tbData['subcategories']['show_children']): ?>
    <ul class="tb_list_1">
      <?php foreach ($category['children'] as $child): ?>
      <li><a href="<?php echo $child['url']; ?>"><?php echo $child['name']; ?></a></li>
      <?php endforeach; ?>
    </ul>
    <?php endif; ?>
  </div>
  <?php endforeach; ?>

  <?php endif; ?>

</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  <?php // ITEM SLIDER ?>
  <?php if ($tbData['subcategories']['is_slider']): ?>
  createItemSlider('#{{widget_dom_id}}', <?php echo count($categories); ?>, 1, 500, '#{{widget_dom_id}} .tb_slider_pagination', <?php echo $tbData['subcategories']['restrictions_json']; ?>).refresh();
  <?php endif; ?>

  <?php // ADJUST ITEM SIZE ?>
  adjustItemSize('#{{widget_dom_id}}', <?php echo $tbData['subcategories']['restrictions_json']; ?>)
});
</script>

<?php endif; ?>
<?php $tbData->slotStop(); ?>

<?php // Product listing ---------------------------------------------- ?>

<?php $tbData->slotStart('product/category.products', array('filter' => array('product/category.products.filter|oc_system_products_filter', 'products' => &$products), 'data' => $data)); ?>
<?php if ($products) { ?>
<nav class="tb_listing_options tb_style_<?php echo $tbData['products_system']['products_style']; ?><?php if ($tbData['products_system']['products_style'] == 1) echo ' tb_bg_str_1'; ?> tb_row tb_row_full tb_gut_0">
  <div class="tb_wrap">
    <div class="tb_col_1_2">
      <div class="tb_view_mode tb_nav">
        <ul>
          <li class="tb_button_grid">
            <a class="tb_icon_16 <?php if ($tbData->product_listing_type == 'grid'): ?>tb_main_color<?php endif; ?>" href="javascript:;"><?php echo $button_grid; ?></a>
          </li>
          <li class="tb_button_list">
            <a class="tb_icon_16 <?php if ($tbData->product_listing_type == 'list'): ?>tb_main_color<?php endif; ?>" href="javascript:;"><?php echo $button_list; ?></a>
          </li>
        </ul>
      </div>
      <?php if ($tbData->common['compare_enabled']): ?>
      <a class="tb_compare_total tb_border_str_1" href="<?php echo $compare; ?>"><?php echo $text_compare; ?></a>
      <?php endif; ?>
    </div>
    <div class="tb_col_1_2">
      <div class="tb_listing_limit">
        <label><?php echo $text_limit; ?></label>
        <select onchange="location = this.value;">
          <?php foreach ($limits as $limits) { ?>
          <?php if ($limits['value'] == $limit) { ?>
          <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
      </div>
      <div class="tb_listing_sort">
        <label><?php echo $text_sort; ?></label>
        <select onchange="location = this.value;">
          <?php foreach ($sorts as $sorts) { ?>
          <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
      </div>
    </div>
  </div>
</nav>

<div class="tb_products tb_listing <?php echo $tbData['products_system']['listing_classes']; ?> clearfix">
  <?php foreach ($products as $product): ?>
  <?php $tbData->slotStart('product/category.products.each', array('product' => $product, 'data' => $data)); ?>
  <div class="tb_product tb_item <?php echo $product['tb_classes']; ?>">
    <?php if ($product['thumb'] && $tbData['products_system']['show_thumb']): ?>
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
      <?php if ($tbData['products_system']['show_title']): ?>
      <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
      <?php endif; ?>
      <?php if ($tbData['products_system']['show_price'] && $product['price']): ?>
      <div class="tb_price_holder <?php echo $tbData['products_system']['price_classes']; ?>">
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
      <?php if ($tbData['products_system']['show_desc'] && $product['description']): ?>
      <p class="tb_description"><?php echo $product['description']; ?></p>
      <?php endif; ?>
      <?php if ($tbData['products_system']['show_rating'] && $product['rating']): ?>
      <div class="tb_rating_holder">
        <p class="tb_rating tb_rating_5" title="<?php echo $product['rating']; ?>/5">
          <span class="tb_base"></span>
          <span class="tb_percent" style="width: <?php echo $product['rating'] * 2 ; ?>0%;"></span>
        </p>
        <span class="tb_average"><?php echo $product['rating']; ?>/5</span>
      </div>
      <?php endif; ?>
      <?php if ($product['show_stock'] && $product['quantity'] < 1 && !$tbData['config']->get('config_stock_checkout')): ?>
      <p class="tb_label_stock_status"><?php echo $product['stock_status']; ?></p>
      <?php endif; ?>
      <?php if ($product['show_cart'] || $tbData['products_system']['show_wishlist'] || $tbData['products_system']['show_compare']): ?>
      <div class="tb_actions">
        <?php if ($product['show_cart']): ?>
        <div class="tb_button_add_to_cart<?php echo $tbData['products_system']['cart_button_position_classes']; ?>"<?php echo $tbData['products_system']['cart_button_offset_attr']; ?>>
          <a class="<?php echo $tbData['products_system']['cart_button_classes']; ?>" href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $product['text_button_cart']; ?>"><?php echo $product['text_button_cart']; ?></span>
          </a>
        </div>
        <?php endif; ?>
        <?php if ($tbData['products_system']['show_wishlist']): ?>
        <div class="tb_button_wishlist<?php echo $tbData['products_system']['wishlist_button_position_classes']; ?>"<?php echo $tbData['products_system']['wishlist_button_offset_attr']; ?>>
          <a class="<?php echo $tbData['products_system']['wishlist_button_classes']; ?>" href="javascript:;" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $tbData->text_wishlist; ?>"><?php echo $tbData->text_wishlist; ?></span>
          </a>
        </div>
        <?php endif; ?>
        <?php if ($tbData['products_system']['show_compare']): ?>
        <div class="tb_button_compare<?php echo $tbData['products_system']['compare_button_position_classes']; ?>"<?php echo $tbData['products_system']['compare_button_offset_attr']; ?>>
          <a class="<?php echo $tbData['products_system']['compare_button_classes']; ?>" href="javascript:;" onclick="compare.add('<?php echo $product['product_id']; ?>');">
            <span data-tooltip="<?php echo $tbData->text_compare; ?>"><?php echo $tbData->text_compare; ?></span>
          </a>
        </div>
        <?php endif; ?>
      </div>
      <?php endif; ?>
    </div>
    <?php if ($tbData['products_system']['show_label_sale'] && $product['special']): ?>
    <span class="tb_label_special"><span><?php echo $product['savings_num']; ?><span>%</span></span><small>off</small></span>
    <?php endif; ?>
    <?php if ($tbData['products_system']['show_label_new'] && $product['is_new']): ?>
    <span class="tb_label_new"><?php echo $tbData->text_label_new; ?></span>
    <?php endif; ?>
  </div>
  <?php $tbData->slotStopEcho(); ?>
  <?php endforeach; ?>
</div>

<div class="pagination tb_border_str_2">
  <?php echo str_replace('pagination', 'links', $pagination); ?>
  <div class="results"><?php echo $results; ?></div>
</div>

<?php } else { ?>

<p class="tb_empty"><?php echo $text_empty; ?></p>

<?php } ?>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {

    $('#{{widget_dom_id}} .tb_view_mode li').bind("click", function() {
      if ($(this).find("a").is(".tb_main_color")) {
        return false;
      }
      $.cookie('listingType', $(this).is(".tb_button_grid") ? 'grid' : 'list', { path: '/' });
      location.reload();
    });

    <?php // RESPONSIVE ?>
    element_query('#{{widget_dom_id}} .tb_listing_options', [1000, 650, 350, 0]);

    <?php if (!$tbData->is_touch): ?>

    <?php // THUMB HOVER ?>
    <?php if ($tbData['products_system']['thumbs_hover_action'] != 'none'): ?>
    thumb_hover('#{{widget_dom_id}}', '<?php echo $tbData['products_system']['thumbs_hover_action']; ?>')
    <?php endif; ?>

    <?php // THUMB ZOOM ?>
    <?php if ($tbData['products_system']['thumbs_hover_action'] == 'zoom'): ?>
    $('#{{widget_dom_id}}').find('.tb_zoom > img').elevateZoom({
      zoomType:           'inner',
      zoomWindowFadeIn:   300,
      zoomWindowFadeOut:  300,
      cursor:             'crosshair'
    });
    <?php endif; ?>

    <?php // PRODUCT HOVER ?>
    <?php if ($tbData['products_system']['elements_hover_action'] != 'none'): ?>
    item_hover('#{{widget_dom_id}}', '<?php echo $tbData['products_system']['active_elements']; ?>', '<?php echo $tbData['products_system']['hover_elements']; ?>', '<?php echo $tbData['products_system']['elements_hover_action']; ?>');
    <?php endif; ?>

    <?php endif; ?>

    <?php // ADJUST PRODUCT SIZE ?>
    adjustItemSize('#{{widget_dom_id}}', <?php echo $tbData['products_system']['restrictions_json']; ?>)

});

<?php // ITEM BEAUTIFY ?>
tbApp.onWindowLoaded(function() {
    item_beautify('#{{widget_dom_id}}');
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>