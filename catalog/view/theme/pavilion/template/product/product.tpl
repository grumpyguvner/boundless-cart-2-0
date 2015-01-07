<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('product/product.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('product/product.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('product/product.page_content'); ?>
<article id="product" class="tb_<?php echo $tbData->product_layout_design_id; ?>" itemscope itemtype="http://schema.org/Product">

  <meta itemprop="name" content="<?php echo $heading_title; ?>" />
  <meta itemprop="image" content="<?php echo $thumb; ?>" />

  <?php // Product Vars -------------------------------------------------
    $base                = $tbData->fonts['body']['line-height'];
    $image_preview_w     = $tbData['config']->get('config_image_thumb_width');
    $image_preview_h     = $tbData['config']->get('config_image_thumb_height');
    $thumb_w             = $tbData['config']->get('config_image_additional_width');
    $thumb_h             = $tbData['config']->get('config_image_additional_height');
  ?>

  <?php // Product Images ----------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_images', array('data' => $data)); ?>
  <style onload="$('#product .tb_product_images').css('padding-top', (($('#product .tb_product_images').width() * <?php echo $image_preview_h; ?>) / <?php echo $image_preview_w; ?> + ($('#product_images_thumbs > a').length > 1 ? <?php echo $base; ?> : 0)));" scoped></style>
  <div class="tb_product_images tb_gallery tb_slide_view tb_inline">

    <?php if ($tbData->product['gallery_zoom']): ?>
    <span class="tb_zoom_box tb_zoom_<?php echo $tbData->product['gallery_zoom_action']; ?>" style="bottom: <?php echo $images ? $thumb_h + $base : '0'; ?>px;"></span>
    <?php endif; ?>

    <div id="product_images_thumbs" class="tb_product_images_thumbs fotorama" data-auto="false">
      <a href="<?php echo $popup; ?>">
        <img src="<?php echo $thumb; ?>" width="<?php echo $thumb_w; ?>" height="<?php echo $thumb_h; ?>" alt="<?php echo $heading_title; ?>" />
      </a>
      <?php $images_js_array = '{img: "' . $popup . '", thumb: "' . $thumb . '"}, '; ?>
      <?php foreach ($images as $image): ?>
      <a href="<?php echo $image['popup']; ?>">
        <img src="<?php echo $image['thumb']; ?>" width="<?php echo $thumb_w; ?>" height="<?php echo $thumb_h; ?>" alt="<?php echo $heading_title; ?>" />
      </a>
      <?php $images_js_array .= '{img: "' . $image['popup'] . '", thumb: "' . $image['thumb'] . '"}, '; ?>
      <?php endforeach; ?>
    </div>

    <?php if ($tbData->product['fullscreen_gallery']): ?>
    <a href="javascript:;" class="tb_fullscreen_button ent-resize-full tbGoFullscreen"></a>
    <?php endif; ?>

    <script type="text/javascript">

    tbApp.onWindowLoaded(function() {

        $('#product .tb_product_images').css('padding-top', '');

        var $gallery = $('#{{widget_dom_id}} .fotorama').fotorama({
          nav:         'thumbs',
          width:       '100%',
          maxheight:   <?php echo $image_preview_h; ?>,
          ratio:       '<?php echo $image_preview_w . '/' . $image_preview_h; ?>',
          thumbwidth:  <?php echo $thumb_w; ?>,
          thumbheight: <?php echo $thumb_h; ?>,
          thumbmargin: <?php echo $base; ?>,
          arrows:      false,
          shadows:     false
        });

        var fotorama = $gallery.data('fotorama');
        var images_arr = <?php echo '[ ' . trim($images_js_array, ', ') . ' ]'; ?>;

        $('#{{widget_dom_id}} .tbGoFullscreen').bind('click', function() {
          if (!$(this).hasClass('tbKeyPressed')) {
            lightbox_gallery('{{widget_dom_id}}', images_arr, fotorama.activeIndex);
          }
          $(this).addClass('tbKeyPressed');
        });

        <?php if ($tbData->product['gallery_zoom']): ?>
        function zoom_preview(id, img_url) {
            $('#' + id + ' .tb_zoom_box.tb_zoom_click').removeClass('tb_zoomed');
            $('#' + id + ' .tb_zoom_box').trigger('zoom.destroy');
            $('#' + id + ' .tb_zoom_box').zoom({
                url: img_url,
                on:  '<?php echo $tbData->product['gallery_zoom_action']; ?>'
            });
        }
        $('#{{widget_dom_id}} .tb_zoom_box.tb_zoom_click').bind('click', function(){
            if ($(this).hasClass('tb_zoomed')) {
                $(this).removeClass('tb_zoomed');
            } else {
                $(this).addClass('tb_zoomed');
            }
        });

        var $zoom_preview = $('#{{widget_dom_id}} .tb_zoom_box');

        zoom_preview('{{widget_dom_id}}', fotorama.activeFrame.img);
        $gallery.on('fotorama:show', function (e, fotorama) {
            zoom_preview('{{widget_dom_id}}', fotorama.activeFrame.img);
        });
        <?php endif; ?>
    });
    </script>

  </div>
  <?php $tbData->slotStop(); ?>


  <?php // Product Price ------------------------------------------------ ?>

  <?php $tbData->slotStart('product/product.product_price', array('data' => $data)); ?>
  <?php if ($price) { ?>
  <div id="product_price" class="tb_price_holder tb_size_4 tb_label">
    <?php $price = $tbData->priceFormat($price); ?>
    <?php if (!$special) { ?>
    <p class="tb_price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
      <span itemprop="availability" content="<?php echo str_replace(' ', '', strip_tags($stock)); ?>"></span>
      <span itemprop="price"><?php echo $price; ?></span>
    </p>
    <?php } else { ?>
    <?php $special = $tbData->priceFormat($special); ?>
    <p class="tb_price tb_promo_price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
      <span itemprop="availability" content="<?php echo str_replace(' ', '', strip_tags($stock)); ?>"></span>
      <span class="tb_old_price"><?php echo $price; ?></span>
      <span itemprop="price"><?php echo $special; ?></span>
    </p>
    <?php } ?>
    <?php if ($tax) { ?>
    <p class="tb_price_tax"><?php echo $text_tax; ?> <span><?php echo $tax; ?></span></p>
    <?php } ?>
    <?php if ($points) { ?>
    <p class="tb_reward_points"><small><?php echo $text_points; ?> <?php echo $points; ?></small></p>
    <?php } ?>
  </div>
  <?php } ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Info ------------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_info', array('data' => $data)); ?>
  <div id="product_info">
    <dl class="clearfix">
      <dt><?php echo $text_stock; ?></dt>
      <dd><?php echo $stock; ?></dd>
      <dt><?php echo $text_model; ?></dt>
      <dd><?php echo $model; ?></dd>
      <?php if ($reward): ?>
      <dt><?php echo $text_reward; ?></dt>
      <dd><?php echo $reward; ?></dd>
      <?php endif; ?>
      <?php if ($tbData->common['manufacturers_enabled'] && $manufacturer): ?>
      <dt><?php echo $text_manufacturer; ?></dt>
      <dd itemprop="brand"><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></dd>
      <?php endif; ?>
    </dl>
  </div>
  <?php $tbData->slotStop(); ?>


  <?php // Product Reviews Summary -------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_reviews_summary', array('data' => $data)); ?>
  <?php if ($review_status): ?>
  <div id="review_aggregate">
    <?php if ($rating): ?>
    <div class="tb_rating_holder" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
      <p class="tb_rating tb_rating_5">
        <span class="tb_base"></span>
        <span class="tb_percent" style="width: <?php echo $rating * 2 ; ?>0%;"></span>
      </p>
      <span class="tb_average">
        <span itemprop="ratingValue"><?php echo $rating; ?></span>/<span itemprop="bestRating">5</span>
      </span>
      <span class="tb_total">(<span itemprop="ratingCount"><?php echo $reviews; ?></span>)</span>
      <a class="tb_review_write tb_main_color tb_border_str_2 tbAddReviewButton" href="javascript:;"><span class="tb_icon fa-pencil"></span><?php echo $text_write; ?></a>
    </div>
    <?php else: ?>
    <div class="tb_rating_holder" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
      <p class="tb_rating tb_rating_5">
        <span class="tb_base"></span>
      </p>
      <span class="tb_total"><?php echo $tbData->text_product_not_yet_rated; ?></span>
      <a class="tb_review_write tb_main_color tb_border_str_2 tbAddReviewButton" href="javascript:;"><span class="tb_icon fa-pencil"></span><?php echo $text_write; ?></a>
    </div>
    <?php endif; ?>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Share ------------------------------------------------ ?>

  <?php $tbData->slotStart('product/product.product_share', array('data' => $data)); ?>
  <?php if ($tbData->product['button_facebook']
            || $tbData->product['button_twitter']
            || $tbData->product['button_google']
            || $tbData->product['button_pinterest']
            || $tbData->product['button_stumbleupon']
            || $tbData->product['button_linkedin']
            || $tbData->product['button_custom']): ?>
  <div id="product_share">
    <h3><?php echo $tbData->text_product_share; ?></h3>
    <?php if (!$tbData->product['button_custom']): ?>
    <div class="tb_share_box">
      <?php if ($tbData->product['button_facebook']): ?>
      <div class="tb_facebook">
        <a class="fb-like" data-layout="button_count" data-action="like" data-show-faces="true" data-share="false"></a>
      </div>
      <?php endif; ?>
      <?php if ($tbData->product['button_twitter']): ?>
      <div class="tb_twitter" style="width: 78px;">
        <a class="twitter-share-button" href="https://twitter.com/share">Tweet</a>
        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
      </div>
      <?php endif; ?>
      <?php if ($tbData->product['button_google']): ?>
      <div class="tb_gplus" style="width: 57px;">
        <a class="g-plusone" data-size="medium"></a>
        <script>(function(){var po=document.createElement('script');po.type='text/javascript';po.async=true;po.src='https://apis.google.com/js/platform.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(po,s);})();</script>
      </div>
      <?php endif; ?>
      <?php if ($tbData->product['button_pinterest']): ?>
      <div class="tb_pinterest">
        <a href="//www.pinterest.com/pin/create/button/?url=<?php echo $tbData->current_url; ?>&media=<?php echo $thumb; ?>" data-pin-do="buttonPin" data-pin-config="beside"><img src="//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_gray_20.png" /></a>
        <script type="text/javascript" async src="//assets.pinterest.com/js/pinit.js"></script>
      </div>
      <?php endif; ?>
      <?php if ($tbData->product['button_stumbleupon']): ?>
      <div class="tb_stumbleupon">
        <su:badge layout="1"></su:badge>
        <script type="text/javascript">(function(){var li=document.createElement('script');li.type='text/javascript';li.async=true;li.src=('https:'==document.location.protocol?'https:':'http:')+'//platform.stumbleupon.com/1/widgets.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(li,s);})();</script>
      </div>
      <?php endif; ?>
      <?php if ($tbData->product['button_linkedin']): ?>
      <div class="tb_social_button tb_linkedin">
        <script src="//platform.linkedin.com/in.js" type="text/javascript">lang: bg_BG</script>
        <script type="IN/Share" data-url="<?php echo $tbData->current_url; ?>" data-counter="right"></script>
      </div>
      <?php endif; ?>
    </div>
    <?php else: ?>
    <div class="tb_share_box_custom">
      <?php echo $tbData->product['button_custom'] ?>
    </div>
    <?php endif; ?>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Discounts -------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_discounts', array('data' => $data)); ?>
  <?php if ($price && $discounts): ?>
  <div id="product_discounts">
    <h3><?php echo $tbData->text_product_discount; ?></h3>
    <table width="100%" class="tb_table_1" border="0" cellpadding="0" cellspacing="0">
      <thead>
        <tr>
          <th><?php echo $tbData->text_product_order_quantity; ?></th>
          <th><?php echo $tbData->text_product_price_per_item; ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($discounts as $discount): ?>
        <tr>
          <td><?php echo sprintf($tbData->text_product_discount_items, $discount['quantity']); ?></td>
          <td><?php echo $discount['price']; ?></td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Options ---------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_options', array('data' => $data)); ?>
  <?php if ($options || $recurrings): ?>
  <div id="product_options" class="product-info tb_bg_str_1">
    <h3><?php echo $text_option; ?></h3>

    <?php $tbData->slotFilter('product/product_options.filter', $options, array('data' => $data)); ?>
    <?php if ($options) { ?>
    <?php foreach ($options as $option) { ?>

    <?php // SELECT  ?>
    <?php if ($option['type'] == 'select') { ?>
      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
        <div class="col-sm-10">
          <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['product_option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
            </option>
          <?php } ?>
        </select>
      </div>
    </div>
    <?php } ?>

    <?php // RADIO  ?>
    <?php if ($option['type'] == 'radio') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?><?php if (isset($option['tb_css_classes']) && !empty($option['tb_css_classes'])) echo' tb_' . $option['tb_css_classes']; ?>">
      <label class="control-label"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <div id="input-option<?php echo $option['product_option_id']; ?>">
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <div class="radio">
            <label<?php if (isset($option['tb_css_classes']) && !empty($option['tb_css_classes']) && $option['tb_css_classes'] == 'style_2'): ?> class="tb_bg_str_2 tb_bg_hover_str_3"<?php endif; ?><?php if ($option_value['price']) { ?> title="<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>"<?php } ?>>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <?php echo $option_value['name']; ?>
              <span>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              </span>
              <?php } ?>
            </label>
          </div>
          <?php } ?>
        </div>
      </div>
    </div>
    <?php } ?>

    <?php // CHECKBOX  ?>
    <?php if ($option['type'] == 'checkbox') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?><?php if (isset($option['tb_css_classes']) && !empty($option['tb_css_classes'])) echo' tb_' . $option['tb_css_classes']; ?>">
      <label class="control-label"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <div id="input-option<?php echo $option['product_option_id']; ?>">
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <div class="checkbox">
            <label<?php if (isset($option['tb_css_classes']) && !empty($option['tb_css_classes']) && $option['tb_css_classes'] == 'style_2'): ?> class="tb_bg_str_2 tb_bg_hover_str_3"<?php endif; ?><?php if ($option_value['price']) { ?> title="<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>"<?php } ?>>
              <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <?php echo $option_value['name']; ?>
              <span>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              </span>
              <?php } ?>
            </label>
          </div>
          <?php } ?>
        </div>
      </div>
    </div>
    <?php } ?>

    <?php // IMAGE  ?>
    <?php if ($option['type'] == 'image') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?><?php if (isset($option['tb_css_classes']) && !empty($option['tb_css_classes'])) echo' tb_' . $option['tb_css_classes']; ?>">
      <label class="control-label"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <div id="input-option<?php echo $option['product_option_id']; ?>">
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <div class="radio image">
            <label<?php if (isset($option['tb_css_classes']) && !empty($option['tb_css_classes']) && $option['tb_css_classes'] == 'style_2'): ?> class="tb_bg_str_2 tb_bg_hover_str_3" title="<?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?> (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?>"<?php endif; ?>>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" width="<?php echo $option['image_width']; ?>" height="<?php echo $option['image_height']; ?>" />
              <span>
              <?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
              </span>
            </label>
          </div>
          <?php } ?>
        </div>
      </div>
    </div>
    <?php } ?>

    <?php // TEXT  ?>
    <?php if ($option['type'] == 'text') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
      </div>
    </div>
    <?php } ?>

    <?php // TEXTAREA  ?>
    <?php if ($option['type'] == 'textarea') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
      </div>
    </div>
    <?php } ?>

    <?php // FILE  ?>
    <?php if ($option['type'] == 'file') { ?>
    <?php $hasFile = true; ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="tb_button tb_button_primary"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
      </div>
    </div>
    <?php } ?>

    <?php // DATE  ?>
    <?php if ($option['type'] == 'date') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <div class="input-group date">
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          <span class="input-group-btn">
            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
          </span>
        </div>
      </div>
    </div>
    <?php } ?>

    <?php // DATETIME  ?>
    <?php if ($option['type'] == 'datetime') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <div class="input-group datetime">
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          <span class="input-group-btn">
            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span>
        </div>
      </div>
    </div>
    <?php } ?>

    <?php // TIME  ?>
    <?php if ($option['type'] == 'time') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
      <div class="col-sm-10">
        <div class="input-group time">
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
          <span class="input-group-btn">
            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span>
        </div>
      </div>
    </div>
    <?php } ?>

    <?php } ?>
    <?php } ?>

    <?php if ($recurrings) { ?>
    <div class="form-group required">
      <label><?php echo $text_payment_recurring ?></label>
      <div class="col-sm-10">
        <select name="recurring_id" class="form-control">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($recurrings as $recurring) { ?>
          <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
          <?php } ?>
        </select>
        <div class="help-block" id="recurring-description"></div>
      </div>
    </div>
    <?php } ?>

  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Buy -------------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_buy', array('filter' => array('product/product.product_buy.filter', 'button_cart' => &$button_cart), 'data' => $data)); ?>
  <?php if ($price && ($button_cart || $tbData->common['wishlist_enabled'] || $tbData->common['compare_enabled'])): ?>
  <div id="product_buy" class="clearfix">
    <form id="product_add_to_cart_form" class="product-info">
      <div class="tb_trow">
        <?php if ($button_cart): ?>
        <div class="tb_purchase_button">
          <label for="input-quantity"><?php echo $entry_qty; ?></label>
          <input id="input-quantity" type="number" name="quantity" value="<?php echo $minimum; ?>" min="<?php echo $minimum; ?>" />
          <a id="button-cart" class="tb_button"><?php echo $button_cart; ?></a>
        </div>
        <?php endif; ?>
        <div class="tb_actions">
          <?php if ($tbData->common['wishlist_enabled']): ?>
          <div class="tb_button_wishlist">
            <a class="tb_icon_10 fa-heart tb_main_color" href="javascript:;" onclick="wishlist.add('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a>
          </div>
          <?php endif; ?>
          <?php if ($tbData->common['compare_enabled']): ?>
          <div class="tb_button_compare">
            <a class="tb_icon_10 fa-retweet tb_main_color" href="javascript:;" onclick="compare.add('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a>
          </div>
          <?php endif; ?>
        </div>
      </div>
      <?php if ($tbData->common['checkout_enabled'] && $tbData->store_common['disable_checkout_stock_status_name'] != $stock): ?>
      <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
      <?php endif; ?>
    </form>
    <?php if ($minimum > 1): ?>
    <p class="tb_purchase_info tb_text_str_4"><?php echo $text_minimum; ?></p>
    <?php endif; ?>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Description ------------------------------------------ ?>

  <?php $tbData->slotStart('product/product.product_description', array('data' => $data)); ?>
  <h2><?php echo $tab_description; ?></h2>
  <div class="tb_product_description tb_widget_text" itemprop="description">
    <?php echo $description; ?>
  </div>
  <?php $tbData->slotStop(); ?>


  <?php // Product Attributes ------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_attributes', array('data' => $data)); ?>
  <?php if ($attribute_groups): ?>
  <h2><?php echo $tab_attribute; ?></h2>
  <div class="tb_product_attributes">
    <table class="tb_table_1" width="100%" cellpadding="0" cellspacing="0" border="0">
      <?php foreach ($attribute_groups as $attribute_group): ?>
      <thead>
        <tr>
          <th colspan="2"><?php echo $attribute_group['name']; ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute): ?>
        <tr>
          <td width="30%"><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php endforeach; ?>
      </tbody>
      <?php endforeach; ?>
    </table>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Product Reviews ---------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_reviews', array('data' => $data)); ?>
  <?php if ($review_status): ?>
  <h2><?php echo $tab_review; ?></h2>
  <div class="tb_product_reviews">
    <div id="review"></div>
    <span class="clear"></span>
    <a class="tb_button tb_h_30 tbAddReviewButton" href="javascript:;"><?php echo $text_write; ?></a>
    <div class="tbReviewFormWrap" style="display: none;">
      <?php if ($review_guest) { ?>
      <div class="tbReviewForm form-vertical">
        <div class="form-group required">
          <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
          <div class="col-sm-12">
            <input type="text" name="name" value="" id="input-name" class="form-control" />
          </div>
        </div>
        <div class="form-group required">
          <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
          <div class="col-sm-12 tb_full">
            <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
            <div class="help-block"><?php echo $text_note; ?></div>
          </div>
        </div>
        <div class="form-group required">
          <label class="control-label"><?php echo $entry_rating; ?></label>
          <div class="col-sm-12">
            <?php echo $entry_bad; ?>&nbsp;
            <input type="radio" name="rating" value="1" />
            &nbsp;
            <input type="radio" name="rating" value="2" />
            &nbsp;
            <input type="radio" name="rating" value="3" />
            &nbsp;
            <input type="radio" name="rating" value="4" />
            &nbsp;
            <input type="radio" name="rating" value="5" />
            &nbsp;<?php echo $entry_good; ?></div>
        </div>
        <div class="form-group required">
          <label class="control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
          <div class="col-sm-12">
            <input type="text" name="captcha" value="" id="input-captcha" class="form-control" />
          </div>
        </div>
        <div class="form-group">
          <img src="index.php?route=tool/captcha" alt="" id="captcha" />
        </div>
        <span class="clear tb_sep"></span>
        <div class="tb_submit clearfix">
          <a id="button-review" class="tb_button tb_button_primary"><?php echo $button_continue; ?></a>
        </div>
      </div>
      <?php } else { ?>
      <p class="tb_text_wrap tb_empty"><?php echo $text_login; ?></p>
      <?php } ?>
    </div>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Related Products --------------------------------------------- ?>
  <?php $tbData->slotStart('product/product.related_products', array('filter' => array('product/product.related_products.filter', 'products' => &$products), 'data' => $data)); ?>
  <?php if ($products): ?>
  <h2><span><?php echo $text_related; ?></span></h2>
  <div class="tb_products tb_listing <?php echo $tbData['products_related']['listing_classes']; ?> clearfix">
    <?php foreach ($products as $product): ?>
    <?php $tbData->slotStart('product/product.related_products.each', array('product' => $product, 'data' => $data)); ?>
    <div class="tb_product tb_item <?php echo $product['tb_classes']; ?>">
      <?php if ($product['thumb'] && $tbData['products_related']['show_thumb']): ?>
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
        <?php if ($tbData['products_related']['show_title']): ?>
        <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
        <?php endif; ?>
        <?php if ($tbData['products_related']['show_price'] && $product['price']): ?>
        <div class="tb_price_holder <?php echo $tbData['products_related']['price_classes']; ?>">
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
        <?php if ($tbData['products_related']['show_desc'] && $product['description']): ?>
        <p class="tb_description"><?php echo $product['description']; ?></p>
        <?php endif; ?>
        <?php if ($tbData['products_related']['show_rating'] && $product['rating']): ?>
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
        <?php if ($product['show_cart'] || $tbData['products_related']['show_wishlist'] || $tbData['products_related']['show_compare']): ?>
        <div class="tb_actions">
          <?php if ($product['show_cart'] && $product['quantity'] > 0): ?>
          <div class="tb_button_add_to_cart<?php echo $tbData['products_related']['cart_button_position_classes']; ?>"<?php echo $tbData['products_related']['cart_button_offset_attr']; ?>>
            <a class="<?php echo $tbData['products_related']['cart_button_classes']; ?>" href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>');">
              <span data-tooltip="<?php echo $product['text_button_cart']; ?>"><?php echo $product['text_button_cart']; ?></span>
            </a>
          </div>
          <?php endif; ?>
          <?php if ($tbData['products_related']['show_wishlist']): ?>
          <div class="tb_button_wishlist<?php echo $tbData['products_related']['wishlist_button_position_classes']; ?>"<?php echo $tbData['products_related']['wishlist_button_offset_attr']; ?>>
            <a class="<?php echo $tbData['products_related']['wishlist_button_classes']; ?>" href="javascript:;" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
              <span data-tooltip="<?php echo $tbData->text_wishlist; ?>"><?php echo $tbData->text_wishlist; ?></span>
            </a>
          </div>
          <?php endif; ?>
          <?php if ($tbData['products_related']['show_compare']): ?>
          <div class="tb_button_compare<?php echo $tbData['products_related']['compare_button_position_classes']; ?>"<?php echo $tbData['products_related']['compare_button_offset_attr']; ?>>
            <a class="<?php echo $tbData['products_related']['compare_button_classes']; ?>" href="javascript:;" onclick="compare.add('<?php echo $product['product_id']; ?>');">
              <span data-tooltip="<?php echo $tbData->text_compare; ?>"><?php echo $tbData->text_compare; ?></span>
            </a>
          </div>
          <?php endif; ?>
        </div>
        <?php endif; ?>
      </div>
      <?php if ($tbData['products_related']['show_label_sale'] && $product['special']): ?>
      <span class="tb_label_special"><span><?php echo $product['savings_num']; ?><span>%</span></span><small>off</small></span>
      <?php endif; ?>
      <?php if ($tbData['products_related']['show_label_new'] && $product['is_new']): ?>
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
          <?php if ($tbData['products_related']['thumbs_hover_action'] != 'none'): ?>
          thumb_hover('#{{widget_dom_id}}', '<?php echo $tbData['products_related']['thumbs_hover_action']; ?>')
          <?php endif; ?>

          <?php // THUMB ZOOM ?>
          <?php if ($tbData['products_related']['thumbs_hover_action'] == 'zoom'): ?>
          $('#{{widget_dom_id}}').find('.tb_zoom > img').elevateZoom({
            zoomType:           'inner',
            zoomWindowFadeIn:   300,
            zoomWindowFadeOut:  300,
            cursor:             'crosshair'
          });
          <?php endif; ?>

          <?php // PRODUCT HOVER ?>
          <?php if (!($tbData['products_related']['slider'] && $tbData['products_related']['elements_hover_action'] == 'append') && $tbData['products_related']['elements_hover_action'] != 'none'): ?>
          item_hover('#{{widget_dom_id}}', '<?php echo $tbData['products_related']['active_elements']; ?>', '<?php echo $tbData['products_related']['hover_elements']; ?>', '<?php echo $tbData['products_related']['elements_hover_action']; ?>')
          <?php endif; ?>

          <?php endif; ?>

          <?php // PRODUCT SLIDER ?>
          <?php if ($tbData['products_related']['slider']): ?>
          tbApp.itemSlider{{widget_dom_id}} = createItemSlider('#{{widget_dom_id}}', <?php echo count($products); ?>, <?php echo $tbData['products_related']['slider_step']; ?>, <?php echo $tbData['products_related']['slider_speed']; ?>, <?php $tbData['products_related']['slider_pagination'] ? print '\'#{{widget_dom_id}} .tb_slider_pagination\'' : print 'false' ; ?>, <?php echo $tbData['products_related']['restrictions_json']; ?>);
          <?php endif; ?>
      });
  }

  tbApp.exec{{widget_dom_id}} = function() {
      tbApp.onScriptLoaded(function() {
          <?php // REFRESH SLIDER ?>
          <?php if ($tbData['products_related']['slider']): ?>
          tbApp.itemSlider{{widget_dom_id}}.refresh();
          <?php endif; ?>

          <?php // ADJUST PRODUCT SIZE ?>
          adjustItemSize('#{{widget_dom_id}}', <?php echo $tbData['products_related']['restrictions_json']; ?>);
      });
      <?php if($tbData['products_related']['products_style'] != 1): ?>
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
  <?php $tbData->slotStop(); ?>


  <?php // Product Tags ------------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.product_tags', array('data' => $data)); ?>
  <?php if ($tags): ?>
  <div id="product_tags">
    <h2><span><?php echo $text_tags; ?></span></h2>
    <ul class="clearfix">
      <?php foreach ($tags as $tag): ?>
      <li><a href="<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?></a></li>
      <?php endforeach; ?>
    </ul>
  </div>
  <?php endif; ?>
  <?php $tbData->slotStop(); ?>


  <?php // Separator border --------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.separator_border'); ?>
  <span class="clear tb_border_str_2"></span>
  <?php $tbData->slotStop(); ?>


  <?php // Separator plain ---------------------------------------------- ?>

  <?php $tbData->slotStart('product/product.separator_plain'); ?>
  <span class="clear tb_mb_20"></span>
  <?php $tbData->slotStop(); ?>


  <?php foreach ($tbData->getProductDesign($data) as $row): ?>
  <div class="tb_row<?php echo $row['class']; ?>">
    <div class="tb_wrap">
      <?php foreach ($row['columns'] as $column): ?>
      <?php // Column ratio -------------------------------------------------
        $column['width'] == 'product_column_left'  ? $column['width'] = $tbData->product_layout_column_ratio_left : '';
        $column['width'] == 'product_column_right' ? $column['width'] = $tbData->product_layout_column_ratio_right : '';
      ?>
      <div class="tb_col_<?php echo $column['width']; ?><?php echo $column['class']; ?>">
        <?php foreach ($column['rows'] as $inner_row): ?>
        <div class="tb_row<?php echo $inner_row['class']; ?>">
          <div class="tb_wrap">
            <?php foreach ($inner_row['columns'] as $inner_column): ?>
            <div class="tb_col_<?php echo $inner_column['width']; ?><?php echo $inner_column['class']; ?>">
              <?php foreach ($inner_column['slots'] as $inner_column_slot): ?>
              <?php $tbData->slotEcho('product/product.' . $inner_column_slot); ?>
              <?php endforeach; ?>
              <?php if ($inner_column['tabs']): ?>
              <div class="tb_tabs<?php if (isset($inner_column['tabs_settings']['class'])) echo $inner_column['tabs_settings']['class']; ?>">
                <nav class="tb_tabs_nav">
                  <ul class="clearfix">
                    <?php $content_ids = array(); ?>
                    <?php foreach ($inner_column['tabs'] as $key => $tab): ?><?php foreach ($tab['slots'] as $tab_slot) if ($tbData->slotHasContent('product/product.' . $tab_slot)) { $content_ids[$tab['id']] = true; break; }   ?><?php if (isset($content_ids[$tab['id']])): ?><li>
                      <a href="<?php echo $tbData->current_url; ?>#<?php echo $tab['id']; ?>"><?php echo $tab['title']; ?></a>
                    </li><?php endif; ?><?php endforeach; ?>
                  </ul>
                </nav>
                <div class="tb_tabs_content">
                  <?php foreach ($inner_column['tabs'] as $tab): ?>
                  <?php if (isset($content_ids[$tab['id']])): ?>
                  <div id="<?php echo $tab['id']; ?>">
                    <?php foreach ($tab['slots'] as $tab_slot): ?>
                    <?php $tbData->slotEcho('product/product.' . $tab_slot); ?>
                    <?php endforeach; ?>
                  </div>
                  <?php endif; ?>
                  <?php endforeach; ?>
                </div>
              </div>
              <?php endif; ?>
            </div>
            <?php endforeach; ?>
          </div>
        </div>
        <?php endforeach; ?>
        <?php foreach ($column['slots'] as $slot_name): ?>
        <?php $tbData->slotEcho('product/product.' . $slot_name); ?>
        <?php endforeach; ?>
        <?php if ($column['tabs']): ?>
        <div class="tb_tabs<?php if (isset($column['tabs_settings']['class'])) echo $column['tabs_settings']['class']; ?>">
          <nav class="tb_tabs_nav">
            <ul class="clearfix">
              <?php $content_ids = array(); ?>
              <?php foreach ($column['tabs'] as $tab): ?><?php foreach ($tab['slots'] as $tab_slot) if ($tbData->slotHasContent('product/product.' . $tab_slot)) { $content_ids[$tab['id']] = true; break; }   ?><?php if (isset($content_ids[$tab['id']])): ?><li>
                <a href="<?php echo $tbData->current_url; ?>#<?php echo $tab['id']; ?>"><?php echo $tab['title']; ?></a>
              </li><?php endif; ?><?php endforeach; ?>
            </ul>
          </nav>
          <div class="tb_tabs_content">
            <?php foreach ($column['tabs'] as $tab): ?>
            <?php if (isset($content_ids[$tab['id']])): ?>
            <div id="<?php echo $tab['id']; ?>">
              <?php foreach ($tab['slots'] as $tab_slot): ?>
              <?php $tbData->slotEcho('product/product.' . $tab_slot); ?>
              <?php endforeach; ?>
            </div>
            <?php endif; ?>
            <?php endforeach; ?>
          </div>
        </div>
        <?php endif; ?>
      </div>
      <?php endforeach; ?>
    </div>
  </div>
  <?php endforeach; ?>

</article>

<script type="text/javascript" src="<?php echo $tbData->theme_catalog_javascript_url; ?>jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript">
tbApp.onScriptLoaded(function() {

    element_query('#review_aggregate', [280, 0]);
    element_query('#product_buy', [1000, 400, 0]);
    element_query('#product_options', [1000, 300, 0]);

    $("#product .tb_tabs").tabs({
        show: { effect: 'fade', duration: 200 },
        hide: { effect: 'fade', duration: 200 }
    });

    $('#{{widget_dom_id}} .date').find('input[type="text"]').datepicker({
      dateFormat: 'yy-mm-dd',
      showOtherMonths: true,
      beforeShow: function(input, inst) {
        var newclass = 'tb_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('tb_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      }
    });

    $('#{{widget_dom_id}} .date').find('button').bind('click', function() {
        $(this).parents('.input-group').first().find('input[type="text"]').datepicker('show');
    });

    $('#{{widget_dom_id}} .datetime').find('input[type="text"]').datetimepicker({
      dateFormat: 'yy-mm-dd',
      showOtherMonths: true,
      timeFormat: 'h:m',
      beforeShow: function(input, inst) {
        var newclass = 'tb_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('tb_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      }
    });

    $('#{{widget_dom_id}} .datetime').find('button').bind('click', function() {
        $(this).parents('.input-group').first().find('input[type="text"]').datetimepicker('show');
    });

    $('#{{widget_dom_id}} .time').find('input[type="text"]').timepicker({
      timeFormat: 'h:m',
      beforeShow: function(input, inst) {
        var newclass = 'tb_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('tb_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      }
    });

    $('#{{widget_dom_id}} .time').bind('click', function() {
        $(this).parents('.input-group').first().find('input[type="text"]').timepicker('show');
    });

    $(".tbAddReviewButton").bind('click', function(){
        $(".tbReviewForm").dialog({
            title: '<?php echo $text_write; ?>',
            width: 600,
            maxWidth: 600,
            height: 'auto',
            modal: true,
            fluid: true, //new option
            resizable: false,
            open: function() {
                fluidDialog();
            }
        });
    });

    onSizeChange(fluidDialog, 'tbFluidDialog', true);

    $('#{{widget_dom_id}}').find('[name=quantity]').spinner();

    $('#product_options input[type=checkbox], #product_options input[type=radio]').bind('change', function() {
        if ($(this).attr('type') == 'radio') {
            if($(this).is(':checked')) {
                $(this).parents('.form-group').first().find('label').removeClass('tb_checked');
                $(this).parent('label').addClass('tb_checked');
            }
        }
        if ($(this).attr('type') == 'checkbox') {
            if($(this).is(':checked')) {
                $(this).parent('label').addClass('tb_checked');
            }
            else {
                $(this).parent('label').removeClass('tb_checked');
            }
        }
    });

});
</script>
<script type="text/javascript">

$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
    $.ajax({
        url: 'index.php?route=product/product/getRecurringDescription',
        type: 'post',
        data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
        dataType: 'json',
        beforeSend: function() {
            $('#recurring-description').html('');
        },
        success: function(json) {
            $('.alert, .text-danger').remove();

            if (json['success']) {
                $('#recurring-description').html(json['success']);
            }
        }
    });
});

$('#button-cart').on('click', function() {
    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: $('.product-info input[type=\'text\'], .product-info input[type=\'number\'], .product-info input[type=\'date\'], .product-info input[type=\'datetime\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-cart').attr('disabled', true);
            $('#button-cart').after('<i class="fa fa-circle-o-notch fa-spin"></i>');
        },
        success: function(json) {
            $('.alert, .text-danger').remove();
            $('.form-group').removeClass('has-error');
            $('#button-cart').next('.fa-spin').remove();
            $('#button-cart').attr('disabled', false);

            if (json['error']) {
                var errors = '';

                if (json['error']['option']) {
                    for (i in json['error']['option']) {
                        var element = $('#input-option' + i.replace('_', '-'));
            
                        element.parents('.form-group').first().find('> label + div').append('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                }
            }
            if (json['error']['recurring']) {
                $('select[name="recurring_id"]').after('<span class="error">' + json['error']['recurring'] + '</span>');
            }
            // Highlight any found errors
            $('.text-danger').each(function() {
                $(this).parents('.form-group').first().addClass('has-error');
            });
        }
        if (json['success']) {
                $('.tb_widget_cart > .tb_nav').load('index.php?route=common/cart/info .tb_nav > *');
                displayNotice('product', 'success', 'product', json['success']);
            }
        }
    });
});
</script>
<script type="text/javascript"><!--
$('button[id^=\'button-upload\']').on('click', function() {
    var node = this;

    $('#form-upload').remove();

    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

    $('#form-upload input[name=\'file\']').trigger('click');

    $('#form-upload input[name=\'file\']').on('change', function() {
        $.ajax({
            url: 'index.php?route=tool/upload',
            type: 'post',
            dataType: 'json',
            data: new FormData($(this).parent()[0]),
            cache: false,
            contentType: false,
            processData: false,
            beforeSend: function() {
                $(node).after('<i class="fa fa-circle-o-notch fa-spin"></i>');
                $(node).attr('disabled', true);
            },
            success: function(json) {
                $('.text-danger').remove();
                $(node).next('.fa-spin').remove();
                $(node).attr('disabled', false);

                if (json['error']) {
                    $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                }
                if (json['success']) {
                    alert(json['success']);
                    $(node).parent().find('input').attr('value', json['code']);
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');

  });

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

function submit_review () {
    $('.tbReviewForm .tb_submit .tb_button').bind('click', function() {
        $.ajax({
            url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
            type: 'post',
            dataType: 'json',
            data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
            beforeSend: function() {
                $('.tbReviewForm').addClass('tb_blocked tb_loading');
                $('.tbReviewForm').prepend('<i class="fa fa-circle-o-notch fa-spin"></i>');
                $('.tbReviewForm .tb_submit .tb_button').attr('disabled', true);
            },
            complete: function() {
                $('#captcha').attr('src', 'index.php?route=tool/captcha#'+new Date().getTime());
                $('input[name=\'captcha\']').val('');
            },
            success: function(json) {
                $('.tbReviewForm .alert').remove();
                $('.tbReviewForm').find('> .fa-spin').remove();
                $('.tbReviewForm').removeClass('tb_blocked tb_loading');
                $('.tbReviewForm .tb_submit .tb_button').attr('disabled', false);

                if (json['error']) {
                    $('.tbReviewForm').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
                }

                if (json['success']) {
                    $('.tbReviewForm').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
        
                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').prop('checked', false);
                    $('input[name=\'captcha\']').val('');
                    
                    setTimeout(function(){
                        $(".ui-dialog").fadeOut(function() {
                            $('.tbReviewForm .alert').remove();
                            $(".tbReviewForm").dialog('destroy');
                        });
                    }, 2000);
                }
            }
        });
    });
}

submit_review();
<?php if (!$tbData['config']->get('config_customer_price') || ($tbData['config']->get('config_customer_price') && $tbData['customer']->isLogged())): ?>
$(document).ready(function() {
  $('#content').find('select[name="profile_id"],:input[name^="option"],:input[name^="quantity"]').change(function(){
    $.ajax({
      type: 'post',
      url: 'index.php?route=tb/getProductPrice',
      dataType: 'json',
      data: $('select[name="profile_id"], input[name^="option"][type="checkbox"]:checked, input[name^="option"][type="radio"]:checked, select[name^="option"], input[type="hidden"], input[name="quantity"][type="text"], input[name="quantity"][type="radio"]:checked, select[name="quantity"]'),
      success: function (data) {
        if (typeof data.error != "undefined") {
          return;
        }

        var $priceWrap = $("#product_price .tb_price");

        if ($priceWrap.hasClass("tb_promo_price")) {
          $priceWrap.find(".tb_old_price").html(data.price);
          $priceWrap.find('[itemprop="price"]').html(data.special);
        } else {
          $priceWrap.find('[itemprop="price"]').html(data.price);
        }
        $priceWrap.parent().find(".tb_price_tax span").html(data.subtotal);
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });
});
<?php endif; ?>
//--></script>
<?php $tbData->slotStop(); ?>

<?php $tbData->echoFooter($footer); ?>