<?php if ($reviews): ?>

<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<div class="tb_products tb_listing tb_size_1 <?php echo $listing_classes; ?> clearfix">

  <?php foreach ($reviews as $product): ?>
  <div class="tb_product tb_item">
    <?php if ($product['thumb']): ?>
    <a class="tb_thumb" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb']; ?>" width="<?php echo $product['thumb_width']; ?>" height="<?php echo $product['thumb_height']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
    </a>
    <?php endif; ?>
    <div class="tb_item_info">
      <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
      <?php if ($show_price && $product['price']): ?>
      <div class="tb_price_holder">
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
      <div class="tb_review">
        <?php if ($show_text): ?>
        <p><?php echo $product['review_text']; ?></p>
        <?php endif; ?>
        <div class="tb_meta">
          <p class="tb_author"><strong><?php echo $product['author']; ?></strong> <small>(<?php echo $product['date_added']; ?>)</small></p>
          <div class="tb_rating_holder">
            <p class="tb_rating tb_rating_5">
              <span class="tb_base"></span>
              <span class="tb_percent" style="width: <?php echo $product['rating'] * 2 ; ?>0%;"></span>
            </p>
            <span class="tb_average"><?php echo $product['rating']; ?>/5</span>
          </div>
        </div>
      </div>
    </div>
  </div>
  <?php endforeach; ?>

</div>

<?php if (($show_text && $tooltip_review == 1) || $slider): ?>
<script type="text/javascript">
tbApp.init<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
        
        <?php // TOOLTIP REVIEW ?>
        <?php if ($show_text && $tooltip_review == 1): ?>
        $('#<?php echo $widget_dom_id; ?> .tb_item').each(function() {
            if ($(this).find('> .tb_item_info > .tb_review > p')) {
                $(this).tooltip({
                    items:   $(this).find('.tb_rating_holder'),
                    tooltipClass: '',
                    content: '\
                      <div class="tb_review">\
                        <p>' + $(this).find('> .tb_item_info > .tb_review > p').html() + '\
                        <div class="tb_meta"><p class="tb_author">' + $(this).find('> .tb_item_info > .tb_review .tb_author').html() + '</p></div>\
                      </div>'
                    ,
                    position: {
                        my: 'bottom',
                        at: 'top-5'
                    },
                    show: {effect: 'fadeIn', duration: 300, easing: 'easeInQuart'}
                });
            }
        });
        <?php endif; ?>

        <?php // REVIEW SLIDER ?>
        <?php if ($slider): ?>
        tbApp.itemSlider<?php echo $widget->getDomId(); ?> = createItemSlider('#<?php echo $widget->getDomId(); ?>', <?php echo count($reviews); ?>, <?php echo $slider_step; ?>, <?php echo $slider_speed; ?>, <?php $slider_pagination ? print '\'#' . $widget->getDomId() . ' .tb_slider_pagination\'' : print 'false' ; ?>, {"1200":{"items_per_row":1,"items_spacing":0}});
        <?php endif; ?>

    });
}
<?php if ($slider): ?>
tbApp.exec<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
        tbApp.itemSlider<?php echo $widget->getDomId(); ?>.refresh();
    });
}
<?php endif; ?>
<?php if (!isset($within_group) || !$within_group): ?>
tbApp.init<?php echo $widget->getDomId(); ?>();
<?php if ($slider): ?>
tbApp.exec<?php echo $widget->getDomId(); ?>();
<?php endif; ?>
<?php endif; ?>
</script>
<?php endif; ?>
<?php endif; ?>
