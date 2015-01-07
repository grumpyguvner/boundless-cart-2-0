///////////////////////////////////////////
//  OPENCART
///////////////////////////////////////////

// Cart add remove functions
var cart = {
  'add': function(product_id, quantity) {
    $.ajax({
      url: 'index.php?route=checkout/cart/add',
      type: 'post',
      data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
      dataType: 'json',
      success: function(json) {
        $('.alert, .text-danger').remove();
        if (json['redirect']) {
          location = json['redirect'];
        } else
              if (json['error']) {
                  for (var first in json.error) break;
                  displayNotice('product', 'failure', product_id, json.error[first]);
              } else
              if (json['success']) {
                  $('.tb_widget_cart > .tb_nav').load('index.php?route=common/cart/info .tb_nav > *');
                  displayNotice('product', 'success', product_id, json['success']);
              }       
      }
    });
  },
  'update': function(key, quantity) {
    $.ajax({
      url: 'index.php?route=checkout/cart/edit',
      type: 'post',
      data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
      dataType: 'json',
      beforeSend: function() {
        $('#cart > button').button('loading');
      },
      success: function(json) {
        $('#cart > button').button('reset');
        if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
          location = 'index.php?route=checkout/cart';
        } else {
          $('.tb_widget_cart > .tb_nav').load('index.php?route=common/cart/info .tb_nav > *');
        }
      }
    });
  },
  'remove': function(key) {
    $.ajax({
      url: 'index.php?route=checkout/cart/remove',
      type: 'post',
      data: 'key=' + key,
      dataType: 'json',
      beforeSend: function() {
        $('#cart > button').button('loading');
      },
      success: function(json) {
        $('#cart > button').button('reset');
        if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
          location = 'index.php?route=checkout/cart';
        } else {
          $('.tb_widget_cart > .tb_nav').load('index.php?route=common/cart/info .tb_nav > *');
        }
      }
    });
  }
}

var voucher = {
  'add': function() {

  },
  'remove': function(key) {
    $.ajax({
      url: 'index.php?route=checkout/cart/remove',
      type: 'post',
      data: 'key=' + key,
      dataType: 'json',
      beforeSend: function() {
        $('#cart > button').button('loading');
      },
      complete: function() {
        $('#cart > button').button('reset');
      },
      success: function(json) {
        $('#cart-total').html(json['total']);
        if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
          location = 'index.php?route=checkout/cart';
        } else {
          $('.tb_widget_cart > .tb_nav').load('index.php?route=common/cart/info .tb_nav > *');
        }
      }
    });
  }
}

var wishlist = {
  'add': function(product_id) {
    $.ajax({
      url: 'index.php?route=account/wishlist/add',
      type: 'post',
      data: 'product_id=' + product_id,
      dataType: 'json',
      success: function(json) {
        $('.alert').remove();

        if (json['success']) {
                  displayNotice('wishlist', 'success', product_id, json['success']);
        }

        if (json['info']) {
          displayNotice('wishlist', 'failure', product_id, json['info']);
        }

        $('#wishlist-total').html(json['total']);
      }
    });
  },
  'remove': function() {

  }
}

var compare = {
  'add': function(product_id) {
    $.ajax({
      url: 'index.php?route=product/compare/add',
      type: 'post',
      data: 'product_id=' + product_id,
      dataType: 'json',
      success: function(json) {
        $('.alert').remove();

        if (json['success']) {
          displayNotice('compare', 'success', product_id, json['success']);
          $('.tb_compare_total').html(json['total']);
        }
      }
    });
  },
  'remove': function() {

  }
}


/* Search */
function moduleSearch($element) {
    var filter_name = $element.parent().find('input[name=search]').val();

    if (filter_name) {
        location = 'index.php?route=product/search&search=' + encodeURIComponent(filter_name);
    }
}

function changeLanguage($link) {
    $('input[name=\'code\']').attr('value', $link.attr('data-language-code'));
    $link.closest('form').submit()
}

function changeCurrency($link) {
    $('input[name=\'code\']').attr('value', $link.attr('data-currency-code'));
    $link.closest('form').submit()
}

///////////////////////////////////////////
//  RESIZE EVENTS
///////////////////////////////////////////

function onSizeChange(callback, namespace, unbind_namespace) {

    if ($.browser.msie && $.browser.version < 9) {
        return;
    }

    var resizeEvent = window.hasOwnProperty("onorientationchange") ? "orientationchange" : "resize";

    if (typeof namespace != "undefined") {

        if (typeof unbind_namespace == "undefined") {
            unbind_namespace = false;
        }

        if (unbind_namespace) {
            offSizeChange(namespace);
        }

        resizeEvent += "." + namespace;
    }

    $(window).on(resizeEvent, callback);
}

function offSizeChange(namespace) {
    var resizeEvent = window.hasOwnProperty("onorientationchange") ? "orientationchange" : "resize";

    resizeEvent += "." + namespace;

    $(window).off(resizeEvent);
}

///////////////////////////////////////////
//  GLOBAL VARS
///////////////////////////////////////////

var tb_user_agent = navigator.userAgent;
var tb_is_iphone  = ~tb_user_agent.indexOf('iPhone') || ~tb_user_agent.indexOf('iPod');
var tb_is_ipad    = ~tb_user_agent.indexOf('iPad');
var tb_is_ios     = tb_is_iphone || tb_is_ipad;
var tb_is_ios4    = tb_is_ios && ~tb_user_agent.indexOf(' 4_');

///////////////////////////////////////////
//  NOTIFICATIONS
///////////////////////////////////////////

function displayNotice(context, type, product_id, message) {

    var stack = Number($sReg.get('/tb/msg_stack'));
    var thumb;

    if (!stack) {
        $.noty.closeAll();
    }

    var $product = $(".tb_product.tb_id_" + product_id);

    if (!$product.length) {
        $product = $("#" + product_id);
        thumb = $product.find(" > meta[itemprop=image]").attr("content");
    } else {
        thumb = $product.find(".tb_thumb img").attr("src");
    }

    var buttons_config = [{
        type: 'tb_button tb_h_30', text: $sReg.get('/lang/text_continue'), click: function() {
            $.noty.closeAll();
        }
    }];

    var modal = false;
    var w_width  = document.documentElement.clientWidth;
    var w_height = document.documentElement.clientHeight;

    if (w_width < 767 && w_height < 767) {
        modal = true;
    }

    function ios_fixed($cont) {
        if (tb_is_ios4) {
            top = $(window).scrollTop();
            $cont.css('top', top + 15);
            $cont.parents('.noty_cont').first().prev('.noty_modal').height(1000).css('top', top);

            $(document).bind('touchmove.noty', function(e) {
                e.preventDefault();
            }, false);

            onSizeChange(function() {
                top = $(window).scrollTop();
                $cont.css('top', top + 15);
                $cont.parents('.noty_cont').first().prev('.noty_modal').css('top', top);
            }, 'noty');
        }
    }

    var msg_tpl;

    if ($product.length) {
        msg_tpl = '\
            <h3><i class="tb_icon fa-{{icon}}"></i>{{title}}</h3>\
            <a class="tb_thumb" href=""><img src="{{thumb_src}}"></a>\
            <p>{{contents}}</p>';
    } else {
        msg_tpl = '\
            <h3><i class="tb_icon fa-{{icon}}"></i>{{title}}</h3>\
            <p>{{contents}}</p>';
    }

    var showNotice = function(title) {
        var template_vars = {
            icon:      type == 'success' ? 'check' : 'times',
            title:     title,
            contents:  message,
            thumb_src: thumb
        };

        noty({
            text: $.tim(msg_tpl, template_vars),
            layout: $sReg.get('/tb/msg_position'),
            closeOnSelfClick: false,
            modal: modal,
            buttons: modal ? buttons_config : false,
            closeButton: !modal,
            timeout: modal ? false : Number($sReg.get('/tb/msg_timeout')),
            animateOpen: {opacity: 'toggle'},
            animateClose: {opacity: 'toggle'},
            close_speed: stack ? 500 : 0,
            onShow: function() {
                ios_fixed($(this));
            },
            onClose: function() {
                $(document).unbind('touchmove.noty');
                offSizeChange('lightbox');
            }
        });
    };

    if (type == 'failure') {
        showNotice($sReg.get('/lang/text_failure'));
        return;
    }

    switch (context) {
        case 'product':
            buttons_config = [{
                type: 'tb_button tb_h_30', text: $sReg.get('/lang/text_continue_shopping'), click: function() {
                    $.noty.closeAll();
                }
            },{
                type: 'tb_button tb_h_30', text: $sReg.get('/lang/text_shopping_cart'), click: function() {
                    window.location = $sReg.get('/tb/shopping_cart_url');
                }
            }];

            showNotice($sReg.get('/lang/text_cart_updated'));
            break;
        case 'wishlist':
            buttons_config.push({
                type: 'tb_button tb_h_30', text: $sReg.get('/lang/text_wishlist'), click: function() {
                    window.location = $sReg.get('/tb/wishlist_url');
                }
            });
            showNotice($sReg.get('/lang/text_wishlist_updated'));
            break;
        case 'compare':
            buttons_config.push({
                type: 'tb_button tb_h_30', text: $sReg.get('/lang/text_product_comparison'), click: function() {
                    window.location = $sReg.get('/tb/compare_url');
                }
            });
            showNotice($sReg.get('/lang/text_compare_updated'));
            break;
    }
}

///////////////////////////////////////////
//  HEADER
///////////////////////////////////////////

function sticky_header(show_logo) {

    if ((document.documentElement.clientWidth <= 767 && document.documentElement.clientHeight <= 767) || ($.browser.msie && $.browser.version <= 8)) {
        return;
    }

    var $wrap    = $('#wrapper');
    var $cont    = $('#main_navigation_row').length ? $('#main_navigation_row') : $('#header');
    var $nav     = $('#main_navigation');
    var $nav_row = $nav.parents('.tb_row').first();
    var $nav_col = $nav.parent();
    var height   = $cont.outerHeight(true);
    var offset   = $cont.offset();
    var padding  = $wrap.outerHeight() - $wrap.height();

    var $temp_logo;
    var $temp_cart;
    var $temp_search;

    $cont.removeClass('tb_sticky');

    $(window).scroll(function () {
        if ($(this).scrollTop() > height + offset.top - 50 && $(window).width() > 766) {
            if (!$wrap.hasClass('tb_sticky')) {

                $temp_logo   = show_logo ? $('#site_logo').clone().addClass('tbCloned').insertBefore($nav) : $();
                $temp_cart   = $('.tb_widget_cart').clone(true).addClass('tbCloned').insertAfter($nav);
                $temp_search = $('.tb_widget_site_search').clone(true).addClass('tbCloned').insertAfter($nav);

                $wrap.addClass('tb_sticky');
                $cont.addClass('tb_sticky_container');
                $cont.parent().css('padding-top', padding + height);
                $nav_row.addClass('tbNavContainer');
                $nav_col.addClass('tbNavContainerCol');
            }
        }
        else {
            if (typeof $temp_logo != "undefined") {
                $temp_logo.remove();
                $temp_cart.remove();
                $temp_search.remove();

                $temp_logo = $temp_cart = $temp_search = undefined;
            }

            $wrap.removeClass('tb_sticky');
            $cont.removeClass('tb_sticky_container');
            $cont.parent().css('padding-top', '');
            $nav_row.removeClass('tbNavContainer');
            $nav_col.removeClass('tbNavContainerCol');
        }
    });

}

function responsive_header() {

    var position = $('#header').find('.tbSystemRow').length ? 'before' : 'after';
    var $system_row;

    var change_header = function () {
        if (document.documentElement.clientWidth < 767) {
            if (!$('#header').hasClass('tbMobile')) {
                var $row_markup = $('#header').find('.tbSystemRow').length ? $('<div class="tb_row tbSystemRow tbCloned"></div>') : $('<div class="tb_row tbCloned"></div>');

                $system_row = $row_markup
                  .append($('.tb_widget_currency').clone(true))
                  .append($('.tb_widget_language').clone(true))
                  .append($('#user_navigation li.menu_account a').clone());

                if (position == 'before') {
                    $system_row = $system_row.insertBefore('.tbLogoRow');
                    $('#wrapper').addClass('tbSystemBefore');
                }
                else {
                    $system_row = $system_row.insertAfter('.tbLogoRow');
                    $('#wrapper').addClass('tbSystemAfter');
                }

                $('#header').addClass('tbMobile');
            }
        }
        else {
            if (typeof $system_row != "undefined") {
                $system_row.remove();
                $system_row = undefined;
            }

            $('#wrapper').removeClass('tbSystemBefore tbSystemAfter');
            $('#header').removeClass('tbMobile');
        }
    };

    change_header();
    onSizeChange(change_header);
}


///////////////////////////////////////////
//  CREATE SLIDER
///////////////////////////////////////////

function createItemSlider(container, items_count, slide_step, speed, pagination, responsive_params) {

    var $slides = $(container + ' .tb_listing').children();
    var init = false;
    var responsive_keys = [];

    for(var k in responsive_params) {
        responsive_keys.push(Number(k));
    }
    responsive_keys.sort(function(a, b){return a-b});

    function getRestrictions(c_width) {
        var result = {};

        if (responsive_keys.length) {
            $.each(responsive_keys, function(key, value) {
                result = responsive_params[value];
                if(c_width <= value) {
                    return false;
                }
            });
        }

        return result;
    }

    var SwiperObj = null;
    var current_slides_per_view;

    var buttons = function() {
        if (SwiperObj === null) {
            return;
        }

        if (SwiperObj.activeIndex < 1) {
            $(container)
                .find('.tb_prev').addClass('tb_disabled').end()
                .find('.tb_next').removeClass('tb_disabled');
        } else
        if (SwiperObj.activeIndex + current_slides_per_view == items_count) {
            $(container)
                .find('.tb_next').addClass('tb_disabled').end()
                .find('.tb_prev').removeClass('tb_disabled');
        } else {
            $(container).find('.tb_prev, .tb_next').removeClass('tb_disabled');
        }
    };

    function max_height(container) {
        var max_h = 0;
        var $items = $(container).find('.swiper-slide-visible .tb_item');

        $items.each(function() {
            var h = $(this).innerHeight();
            if (max_h == 0 || max_h < h) {
                max_h = h;
            }
        });

        return max_h;
    }

    function createSlider(slides_per_view, slide_step) {

        $slides.wrapAll('<div class="swiper-container"><div class="swiper-wrapper"></div></div>').wrap('<div class="swiper-slide"></div>');
        $(container)
            .addClass('has_slider')
            .find('.tb_listing')
            .addClass('tb_slider')
            .removeClass('tb_slider_load');

        if (pagination) {
            $(container)
                .find('.tb_listing')
                .after('<div class="tb_slider_pagination"></div>');
        }

        $(container)
            .find('.tb_listing')
            .after('<div class="tb_slider_controls"><a class="tb_prev" href="javascript:;" title="' + $sReg.get('/lang/text_previous') + '"></a><a class="tb_next" href="javascript:;" title="' + $sReg.get('/lang/text_next') + '"></a></div>');

        SwiperObj = new Swiper(container + ' .swiper-container', {
            slidesPerView:         slides_per_view,
            slidesPerGroup:        slide_step,
            speed:                 speed,
            pagination:            pagination,
            paginationClickable:   true,
            paginationActiveClass: 'tb_active',
            roundLengths:          true,
            autoResize:            false,
            visibilityFullFit:     true,
            onSwiperCreated: function (swiper) {
                buttons();
                $(container).find('.swiper-container').addClass('tb_slider_init');
                //$(swiper.container).css('height', max_height(swiper.container));
            },
            onSlideChangeEnd: function (swiper){
                buttons();
                //$(swiper.container).css('height', max_height(swiper.container));
            },
            onTouchEnd: function (swiper){
                buttons();
                //$(swiper.container).css('height', max_height(swiper.container));
            }
        });
    }

    function destroySlider() {
        SwiperObj.destroy();
        SwiperObj = null;
        $(container).removeClass('has_slider')
            .find('.swiper-slide').unwrap().unwrap().end()
            .find('.swiper-slide .tb_item').unwrap().end()
            .find('.tb_slider_controls, .tb_slider_pagination').remove();
        $(container).find('.tb_listing').removeClass('tb_slider');

    }

    function responsive() {

        var restrictions = getRestrictions($(container).width());
        var slides_per_view = Number(restrictions.items_per_row);

        if (items_count > slides_per_view && SwiperObj === null) {
            // create
            createSlider(slides_per_view, slide_step < slides_per_view ? slide_step : slides_per_view);
            $(container).find('.tb_slider_pagination').addClass('tb_size_' + slides_per_view);
            current_slides_per_view = slides_per_view;
            buttons();
        } else
        if (items_count <= slides_per_view && SwiperObj !== null) {
            // destroy
            destroySlider();
        } else
        if (current_slides_per_view == slides_per_view && SwiperObj !== null) {
            // fix size
            SwiperObj.resizeFix();
        } else
        if (current_slides_per_view != slides_per_view && SwiperObj !== null) {
            // reinit
            SwiperObj.params.slidesPerView = slides_per_view;
            SwiperObj.params.slidesPerGroup = slide_step < slides_per_view ? slide_step : slides_per_view;

            $(container).find('.tb_slider_pagination')
                .removeClass('tb_size_' + current_slides_per_view)
                .addClass('tb_size_' + slides_per_view);

            current_slides_per_view = slides_per_view;
            buttons();
            SwiperObj.resizeFix();
        }

        if ($(container).find('.tb_slider').hasClass('tb_side_nav')) {
            tbApp.onWindowLoaded(function() {
                var nav_height = $(container).find('.tb_slider_controls > a:first-child').height();

                $(container).find('.tb_slider_controls').css('visibility', 'visible');
                $(container).find('.tb_slider_controls > a').css('margin-top', -($(container + ' .swiper-container').height()/2 + nav_height/2));
            });
        }
    }

    $(container).on('click', '.tb_prev', function (e) {
        e.preventDefault();
        SwiperObj.swipePrev();
        buttons();
    });

    $(container).on('click', '.tb_next', function (e) {
        e.preventDefault();
        SwiperObj.swipeNext();
        buttons();
    });

    return {
        refresh: function() {
            if(false !== responsive_params) {
                responsive();
                if (false === init) {
                    onSizeChange(function() {
                        if ($(container).is(":visible")) {
                            responsive();
                            if ($(container).parent().parent().hasClass('tb_tabs_content')) {
                                $(container).parent().css('height', '');
                            }
                        }
                    });
                    init = true;
                }
            } else
            if (false === init) {
                buttons();
                init = true;
            }
        }
    }
}

///////////////////////////////////////////
//  ADJUST ITEM SIZE
///////////////////////////////////////////

function adjustItemSize(container, responsive_params) {

    var responsive_keys = [];

    for(var k in responsive_params) {
        responsive_keys.push(Number(k));
    }
    responsive_keys.sort(function(a, b){return a-b});

    function getRestrictions(c_width) {
        var result = {};

        if (responsive_keys.length) {
            $.each(responsive_keys, function(key, value) {
                result = responsive_params[value];
                if(c_width <= value) {
                    return false;
                }
            });
        }

        return result;
    }

    function responsive() {
        var restrictions = getRestrictions($(container).width());

        $(container).find('.tb_listing')
            .removeClass('tb_size_1 tb_size_2 tb_size_3 tb_size_4 tb_size_5 tb_size_6 tb_size_7 tb_size_8')
            .removeClass('tb_gut_0 tb_gut_10 tb_gut_20 tb_gut_30 tb_gut_40 tb_gut_50')
            .addClass('tb_size_' + restrictions.items_per_row)
            .addClass('tb_gut_'  + restrictions.items_spacing);
    }

    responsive();
    onSizeChange(function() {
        responsive();
        if ($(container).parent().parent().hasClass('tb_tabs_content')) {
            $(container).parent().css('height', '');
        }
    });

}

///////////////////////////////////////////
//  ELEMENT QUERY
///////////////////////////////////////////

function element_query(element, resolutions) {

    if (typeof resolutions == "undefined") {
        resolutions = [
            1000,
            900,
            800,
            700,
            600,
            500,
            400,
            300,
            200,
            100,
            0
        ];
    }

    var max_w = resolutions[0];
    var min_w = resolutions[resolutions.length - 1];

    var width_detect = function() {
        var outerWidth = $(element).outerWidth();

        $.each(resolutions, function(i) {
            if (i == 0) {
                if (outerWidth > resolutions[i]) {
                    $(element).removeClass('tb_max_w_' + max_w);
                    $(element).removeClass('tb_min_w_' + min_w);
                    $(element).addClass('tb_min_w_' + (resolutions[0]));
                    max_w = 0;
                    min_w = resolutions[i];

                    return false;
                }
            } else {
                if (outerWidth > resolutions[i] && outerWidth <= resolutions[i - 1]) {
                    $(element).removeClass('tb_max_w_' + max_w);
                    $(element).removeClass('tb_min_w_' + min_w);
                    $(element).addClass('tb_max_w_' + resolutions[i-1]);
                    $(element).addClass('tb_min_w_' + resolutions[i]);
                    max_w = resolutions[i-1];
                    min_w = resolutions[i];

                    return false;
                }
            }
        });
    };

    width_detect();

    onSizeChange(width_detect);
}

///////////////////////////////////////////
//  PRODUCT BEAUTIFY
///////////////////////////////////////////

function item_beautify(container) {

    var original_per_row;
    var $viewport = $(window);
    var $tbListing = $(container).find('.tb_listing');

    for (var i = 2; i <= 8; i++) {
        if ($tbListing.hasClass('tb_size_' + i)) {
            original_per_row = i;
            break;
        }
    }

    var cur_products_per_row = original_per_row;

    function adjust_height(cur_products_per_row) {

        var $products = $(container).find('.tb_item');
        var $product_row;
        var chunk = cur_products_per_row;

        if ($(container).hasClass('has_slider')) {
            chunk = $products.length;
        }

        for (var i = 0; i < $products.length; i += chunk) {
            var max_h = 0;

            $product_row = $products.slice(i , i + chunk);
            $product_row.each(function() {
                var h = $(this).height();
                if (max_h == 0 || max_h < h) {
                    max_h = h;
                }
            });
            $product_row.each(function() {
                $(this).height(max_h);
            });
        }
    }

    function responsive() {
        if ($tbListing.hasClass('tb_grid_view')) {
            $(container).find('.tb_item').css('height', '');

            if ($viewport.width() <= 767) {
              cur_products_per_row = 3;
            }
            if ($viewport.width() <= 480) {
              cur_products_per_row = 2;
            }
            if ($viewport.width() <= 300) {
              cur_products_per_row = 1;
            }
            if ($viewport.width() > 767) {
              cur_products_per_row = original_per_row;
            }

            adjust_height(cur_products_per_row);
        }
    }

    responsive();
    onSizeChange(function() {
        responsive();
    });

}

///////////////////////////////////////////
//  PRODUCT HOVER
///////////////////////////////////////////

function item_hover(container, active_elements, hover_elements, hover_style) {

  // Append
  if(hover_style == 'append') {
    $(container + ' .tb_products.tb_grid_view:not(".tb_slider") .tb_item').each(function() {
      var $item = $(this);
      var $hover_content = $item.clone();

      $hover_content.find(hover_elements).remove();
      $hover_content.find('div.tb_actions:not(:has(*))').remove();
      $hover_content.find('div.tb_item_info:not(:has(*))').remove();

      $item.find(active_elements).remove();
      $item.find('div.tb_actions:not(:has(*))').remove();
      $item.find('div.tb_item_info:not(:has(*))').remove();

      $item.hover(
        function() {
          $item.append('<div class="tb_item_hovered">' + $hover_content.html() + '</div>');
        }, function() {
          $item.find('.tb_item_hovered').remove();
        }
      );
    });
  }

  // Flip && Overlay
  if(hover_style == 'flip' || hover_style == 'overlay') {
    $(container + ' .tb_products.tb_grid_view .tb_item').each(function() {
      var $item = $(this);

      var $active_content = $item.clone();
      var $hover_content = $item.clone();

      $active_content.find(active_elements).remove();
      $hover_content.find(hover_elements).remove();

      $item.addClass('tb_' + hover_style);
      $item.children().remove();

      $item.append('<div class="tb_item_info_active tb_front">' + $active_content.html() + '</div>');
      $item.append('<div class="tb_item_info_hover tb_back"><div class="tb_item_info_wrap">' + $hover_content.html() + '</div></div>');

      $item.find('div.tb_actions:not(:has(*))').remove();
      $item.find('div.tb_item_info:not(:has(*))').remove();
    });
  }
}

///////////////////////////////////////////
//  THUMB HOVER
///////////////////////////////////////////

function thumb_hover(container, hover_style) {
  // Flip
  if(hover_style == 'flip' || hover_style == 'overlay') {
    $(container + ' .tb_products.tb_listing .tb_item').each(function() {
      var $item = $(this);

      if (!$item.find(".tb_thumb_hover").length) {
        return true;
      }

      $item.find('.tb_thumb:first-child').addClass('tb_front');
      $item.find('.tb_thumb_hover').addClass('tb_back');

      var thumb = $item.find('.tb_thumb:first-child').outerHTML();

      if (typeof thumb != "string") {
        thumb = '';
      }

      var thumb_hover = $item.find('.tb_thumb_hover').outerHTML();

      if (typeof thumb_hover != "string") {
        thumb_hover = '';
      }

      $item.find('.tb_thumb').remove();
      $item.prepend('<div class="tb_thumb tb_' + hover_style + '">' + thumb + thumb_hover + '</div>');
    });
  }
}

///////////////////////////////////////////
//  RESPONSIVE DIALOG
///////////////////////////////////////////

function fluidDialog() {
    var $visible = $(".ui-dialog:visible");

    $visible.each(function () {
        var $this = $(this);
        var dialog = $this.find(".ui-dialog-content").data("ui-dialog");

        if (dialog.options.fluid) {
            var wWidth = $(window).width();
            if (wWidth < dialog.options.maxWidth + 50) {
                $this.css("max-width", "90%");
            } else {
                $this.css("max-width", dialog.options.maxWidth);
            }
            dialog.option("position", dialog.options.position);
        }
    });
}

function tbCreateDialog($selector, $parent) {

    onSizeChange(fluidDialog, 'tbFluidDialog', true);

    var $dialog = null;
    var callback = function() {

        if (null !== $dialog) {
            $dialog.dialog('open');

            return false;
        }

        var title = $(this).attr('alt') ? $(this).attr('alt') : $(this).text();

        $dialog = $('<div></div>')
            .appendTo('body')
            .addClass('tb_loading')
            .append('<i class="fa fa-circle-o-notch fa-spin"></i>')
            .load($(this).attr('href'), function() {
                $(this).removeClass('tb_loading').wrap('<div class="overflow_text"></div>');
            })
            .dialog({
                title: title,
                width: 600,
                maxWidth: 600,
                height: 'auto',
                maxHeight: document.documentElement.clientHeight - 60,
                modal: true,
                fluid: true,
                resizable: false,
                position: {
                    my: "top+30",
                    at: "top",
                    of: window
                },
                draggable: false,
                open: function() {
                    fluidDialog();
                }
            });

        return false;
    };

    if (typeof $parent == 'undefined') {
        $selector.bind('click', callback);
    } else {
        $parent.on('click', $selector, callback);
    }
}

///////////////////////////////////////////
//  LIGHTBOX GALLERY
///////////////////////////////////////////

function lightbox_gallery(id, gallery, index) {

    $('body').append('<div id="fotorama_' + id + '"><div class="tb_gallery tb_fullscreen"><div class="fotorama"></div><a class="tb_close" href="javascript:;"></a></div></div>');

    var $cont = $('#fotorama_' + id + '');
    $cont.css('position', 'relative');
    $cont.css('z-index', '1000');

    function ios_fixed() {

        if ((tb_is_iphone || tb_is_ipad) && tb_is_ios4) {
            var w_height = document.documentElement.clientHeight;
            var top = $(window).scrollTop();

            if (tb_is_iphone && !window.navigator.standalone) {
                w_height += 60;
            }

            $cont.find('> .tb_gallery').height(w_height);
            $cont.find('> .tb_gallery').css('top', top);

            $(document).bind('touchmove.lightbox', function(e) {
              // This prevents native scrolling from happening.
              e.preventDefault();
            }, false);
        }
    }

    ios_fixed();
    onSizeChange(function() {
        ios_fixed();
        if (typeof lightbox_fotorama != 'undefined') {
            lightbox_fotorama.resize();
        }
    }, 'lightbox');

    var $lightbox_gallery = $cont.find('> .tb_gallery > .fotorama').fotorama({
        data:       gallery,
        width:      '100%',
        height:     '100%',
        fit:        'scaledown',
        startindex: index,
        shadows:    false
    });

    var lightbox_fotorama = $lightbox_gallery.data('fotorama');

    function lightbox_remove() {
        lightbox_fotorama.destroy();
        $cont.fadeOut(function(){
            $(this).remove();
        });
        $('#' + id + ' .tbGoFullscreen').removeClass('tbKeyPressed');
        $(document).unbind('keydown.lightbox_remove');
        $(document).unbind('touchmove.lightbox');
        offSizeChange('lightbox');
    }

    $cont.find('.tb_close').bind('click', function() {
        lightbox_remove();

        return false;
    });

    $(document).bind("keydown.lightbox_remove", function(e) {
        if(e.keyCode === 27) {
            lightbox_remove();
        }
        if(e.keyCode === 37) {
            lightbox_fotorama.show('<');
        }
        if(e.keyCode === 39) {
            lightbox_fotorama.show('>');
        }
    });
}

///////////////////////////////////////////
//  SYSTEM
///////////////////////////////////////////

function getURLVar(key) {
    var value = [];
    var query = String(document.location).split('?');
    if (query[1]) {
        var part = query[1].split('&');
        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');
            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }
        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}

var $sReg = new function() {

    function unlink(object) {

        var unlinked;

        switch (typeof object){
            case 'object':
                unlinked = {};
                for (var p in object) unlinked[p] = unlink(object[p]);
                break;
            case 'array':
                unlinked = [];
                for (var i = 0, l = object.length; i < l; i++) unlinked[i] = unlink(object[i]);
                break;
            default: return object;
        }

        return unlinked;
    }

    function mixin(mix) {

        for (var i = 1, l = arguments.length; i < l; i++){
            var object = arguments[i];
            if (typeof object != 'object') continue;
            for (var key in object){
                var op = object[key], mp = mix[key];
                mix[key] = (mp && typeof op == 'object' && typeof mp == 'object') ? mixin(mp, op) : unlink(op);
            }
        }

        return mix;
    }

    function merge() {

        var args = Array.prototype.slice.call(arguments);

        args.unshift({});

        return mixin.apply(null, args);
    }

    return {

        conf : {},

        set : function(path,value){

            var fragments = path.split('/');

            if( fragments.shift() !== '') {
                return false;
            }

            if(fragments.length > 0 && fragments[fragments.length - 1] == '') {
                fragments.pop();
            }

            var obj = {};
            var ref = obj;
            var len = fragments.length;

            if( len > 0){
                for(var i = 0; i < len-1; i++){
                    ref[fragments[i]] = {};
                    ref = ref[fragments[i]];
                }
                ref[fragments[len-1]] = value;
                this.conf = merge(this.conf,obj);
            } else {
                this.conf = value;
            }
        },

        get : function(path){

            var fragments = path.split('/');

            if( fragments.shift() !== '') {
                return null;
            }

            if(fragments.length > 0 && fragments[fragments.length -1] == '') fragments.pop();

            var ref = this.conf;
            var path_exists = true;
            var i = 0;

            if (ref[fragments[i]] === undefined) {
                return null;
            }

            var len = fragments.length;

            while(path_exists && i < len){
                path_exists = path_exists && (ref[fragments[i]] !== undefined);
                ref = ref[fragments[i]]; i++;
            }

            return ref;
        }
    };
};

///////////////////////////////////////////
//  BOOT
///////////////////////////////////////////

tbApp.onScriptLoaded(function() {

    var $uiButton = $.fn.button;

    $.fn.button = function() {
        if (arguments.length == 1 && typeof arguments[0] == 'string') {
          var $button = $(this);
          var position = $button.parent().hasClass('tb_submit') || $button.parent().hasClass('buttons') ? 'before' : 'after';
          if (arguments[0] == 'loading') {
              $button.attr('disabled', true);
              if (position == 'before') {
                  $button.prev('.fa-spin').remove();
                  $button.before('<i class="fa fa-circle-o-notch fa-spin"></i>');
              } else {
                  $button.next('.fa-spin').remove();
                  $button.after('<i class="fa fa-circle-o-notch fa-spin"></i>');
              }
          }
          if (arguments[0] == 'reset') {
              $button.attr('disabled', false);
              if (position == 'before') {
                  setTimeout(function(){ $button.prev('.fa-spin').fadeOut(300, function() { $(this).remove(); }); }, 500);
              } else {
                  setTimeout(function(){ $button.next('.fa-spin').fadeOut(300, function() { $(this).remove(); }); }, 500);
              }
          }
        } else {
          $uiButton.apply(this, arguments);
      
        return this;
        }
    }

    if($sReg.get("/tb/is_touch") != 0) {
        $('body').addClass('is_touch');
    }

    $('#search_button').bind('click', function() {
        moduleSearch($(this));
    });

    $('#filter_keyword').bind('keydown', function(e) {
        if (e.keyCode == 13) {
            moduleSearch($(this));
        }
    });

    $("body").on("click", ".tb_server_msg, .warning, .alert", function() {
        $(this).fadeOut(200, function(){
            $(this).remove();
        });
    });

    $('.tb_widget_cart > .tb_nav > .heading a').one('mouseenter', function() {
        $('.tb_widget_cart > .tb_nav')
            .addClass('active')
            .load('index.php?route=common/cart/info .tb_nav > *')
            .on('mouseleave', function() {
                $(this).removeClass('active');
            });
    });

    $('.tb_nav > ul').find('li.tb_multiple:not(.tb_item)').hoverIntent({
        over: function(){
            $(this).addClass('tb_hovered');

            var site_width          = $('#bottom > .tb_wrap > .tb_col_1_1 > .tb_row > .tb_wrap > .tb_col_1_1').width();
            var site_offset         = $('#bottom > .tb_wrap > .tb_col_1_1 > .tb_row > .tb_wrap > .tb_col_1_1').offset().left;
            var submenu_width       = $(this).find('> .tb_submenu').width();
            var submenu_outer_width = $(this).find('> .tb_submenu').outerWidth();
            var submenu_offset      = $(this).find('> .tb_submenu').offset().left;
            var adjust =
                site_width
                + site_offset
                - submenu_width
                - submenu_outer_width / 4
                + submenu_width / 4
                - submenu_offset
                - 1;

            if (adjust < 0 && site_offset < submenu_width) {
                $(this).find('> .tb_submenu').css('margin-left', Math.ceil(adjust));
            }
        }
        ,
        out: function(){
            $(this).removeClass('tb_hovered');
            $(this).find('> .tb_submenu').css('margin-left', '');
        },
        timeout: 250
    });

    $('#menu > ul').find('> li').hoverIntent({
        over: function(){
            $(this).addClass('tb_hovered');
            if(!$(this).find('> div').is(":within-viewport-left")) {
                $(this).addClass('tb_out_of_view_left');
            }
            if(!$(this).find('> div').is(":within-viewport-right")) {
                $(this).addClass('tb_out_of_view_right');
            }
        }
        ,
        out: function(){
            $(this).removeClass('tb_hovered');
            $(this).removeClass('tb_out_of_view_left');
            $(this).removeClass('tb_out_of_view_right');
        },
        timeout: 250
    });

    $('.tb_widget_cart > .tb_nav').hoverIntent({
        over: function(){
            $(this).addClass('tb_hovered');
            if(!$(this).find('> .tb_submenu').is(":within-viewport-left")) {
                $(this).addClass('tb_out_of_view_left');
            }
            if(!$(this).find('> .tb_submenu').is(":within-viewport-right")) {
                $(this).addClass('tb_out_of_view_right');
            }
        }
        ,
        out: function(){
            $(this).removeClass('tb_hovered');
            $(this).removeClass('tb_out_of_view_left');
            $(this).removeClass('tb_out_of_view_right');
        },
        timeout: 250
    });

    responsive_header();

    $('#header .tb_widget_currency, #main_navigation_row .tb_widget_currency').on('click', '.tb_submenu a', function(e) {
        changeCurrency($(this));
    });
    $('#header .tb_widget_language, #main_navigation_row .tb_widget_language').on('click', '.tb_submenu a', function(e) {
        changeLanguage($(this));
    });

    $('#header, #main_navigation_row').on('click', '.tb_nav > ul > li.tb_multiple > a', function(e) {
        if (!$(this).next('.tb_submenu').is(':visible') && !$(this).parent().find('> .tb_toggle').is(':visible')) {
            e.preventDefault();
        }
    });
    $('#header, #main_navigation_row').on('click', '.tb_widget_cart > .tb_nav > .heading > a', function(e) {
        if (!$('.tb_widget_cart > .tb_nav > .tb_submenu').is(':visible')) {
            e.preventDefault();
        }
    });

    var tb_nav_touch_event = tb_is_ios ? 'touchend' : 'click';

    $('#header, #main_navigation_row').on(tb_nav_touch_event, 'li.tb_multiple > .tb_toggle, li.tb_multiple > a[href*="javascript"]', function() {
        if (!$(this).parent().find('> .tb_submenu').is(':visible')) {
            $(this).parent().addClass('tb_active').find('> .tb_toggle').addClass('tb_active');
        } else {
            $(this).parent().removeClass('tb_active').find('> .tb_toggle').removeClass('tb_active');
        }
    });

    $('#main_navigation > .tb_toggle').bind('click', function() {
        $('#main_navigation .tb_nav, #main_navigation #menu').toggleClass('tb_active');
        $('.tb_widget_site_search .tb_search_wrap').removeClass('tb_active');
        $('.tb_widget_cart > .tb_nav').removeClass('tb_active');
    });

    $('.tb_widget_site_search > .tb_toggle').bind('click', function() {
        $('.tb_widget_site_search .tb_search_wrap').toggleClass('tb_active');
        $('#main_navigation .tb_nav, #main_navigation #menu').removeClass('tb_active');
        $('.tb_widget_cart > .tb_nav').removeClass('tb_active');
    });

    $('.tb_widget_cart > .tb_toggle').bind('click', function() {
        $('.tb_widget_cart > .tb_nav').toggleClass('tb_active');
        $('#main_navigation .tb_nav, #main_navigation #menu').removeClass('tb_active');
        $('.tb_widget_site_search .tb_search_wrap').removeClass('tb_active');
    });

    function adjust_menu_height($items, items_per_row) {

        var heights = [];

        for (var i = 1; i <= $items.length; i ++) {

            var row_index = Math.ceil(i/items_per_row) - 1;
            var diff = 0;

            if (typeof heights[row_index] == "undefined") {
                heights[row_index] = {};
                heights[row_index].h = []
            }

            if(i > items_per_row) {
                diff = heights[row_index-1]['max'] - heights[row_index-1].h[i-(items_per_row*row_index)-1];
                if (diff > 0 ) {
                    $($items[i-1]).css('margin-top', '-' + diff + 'px');
                }
            }

            heights[row_index].h.push($($items[i-1]).height() - diff);
            heights[row_index].max = Math.max.apply(Math, heights[row_index].h);
        }
    }

    $('#main_navigation .tb_megamenu').each(function() {
        $(this).hover(function() {

            if ($(window).width() > 750) {
                $subcategories = $(this).find('> .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > .tb_subcategories');

                //$(this).find('> .tb_submenu').css('display', 'block');
                if(!$subcategories.hasClass('height_adjusted')) {
                    adjust_menu_height($subcategories.find('> .tb_item'), $subcategories.attr('data-cols'));
                    $subcategories.addClass('height_adjusted');
                }
            }

        }, function() {
            //$(this).find('> .tb_submenu').css('display', '');
        });
    });
});

$(document).ready(function() {
    $(tbApp).trigger("tbScriptLoadedInit");
    $(tbApp).trigger("tbScriptLoaded");
});
