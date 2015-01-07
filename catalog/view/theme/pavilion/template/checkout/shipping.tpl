<h2 class="tb_bg_str_2"> <?php echo $heading_title; ?></h2>
<div id="shipping" class="cart-content">
  <div id="apply_shipping">

    <p><?php echo $text_shipping; ?></p>
    <fieldset>
      <div class="form-group required">
        <label class="col-sm-2 control-label" for="input-country"><?php echo $entry_country; ?></label>
        <div class="col-sm-10">
          <select name="country_id" id="input-country" class="form-control">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($countries as $country) { ?>
            <?php if ($country['country_id'] == $country_id) { ?>
            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
      </div>
      <div class="form-group required">
        <label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
        <div class="col-sm-10">
          <select name="zone_id" id="input-zone" class="form-control">
          </select>
        </div>
      </div>
      <div class="form-group required">
        <label class="col-sm-2 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
        <div class="col-sm-10">
          <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
        </div>
      </div>
      <button id="button-quote" class="tb_button tb_button_primary" type="button"><?php echo $button_quote; ?></button>
    </fieldset>
    <fieldset id="shipping_quote" style="display: none;"></fieldset>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-quote').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/shipping/quote',
		type: 'post',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-quote').button('loading');
		},
		complete: function() {
			$('#button-quote').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.has-error').removeClass('has-error');

			if (json['error']) {
				if (json['error']['warning']) {
				  $('#cart_form').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}

				if (json['error']['country']) {
					$('select[name=\'country_id\']').after('<div class="text-danger">' + json['error']['country'] + '</div>');
				}

				if (json['error']['zone']) {
					$('select[name=\'zone_id\']').after('<div class="text-danger">' + json['error']['zone'] + '</div>');
				}

				if (json['error']['postcode']) {
					$('input[name=\'postcode\']').after('<div class="text-danger">' + json['error']['postcode'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').each(function() {
            $(this).parents('.form-group').first().addClass('has-error');
        });

			}

			if (json['shipping_method']) {
        html  = '<legend><?php echo $text_shipping_method; ?></legend>';
        html += '  <table class="radio">';

        for (i in json['shipping_method']) {
          html += '<tr>';
          html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
          html += '</tr>';

          if (!json['shipping_method'][i]['error']) {
            for (j in json['shipping_method'][i]['quote']) {
              html += '<tr class="highlight">';

              if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
                html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
              } else {
                html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
              }

              html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
              html += '  <td valign="top"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
              html += '</tr>';
            }
          } else {
            html += '<tr>';
            html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
            html += '</tr>';
          }
        }

        html += '  </table>';
        <?php if ($shipping_method) { ?>
        html += '  <button type="submit" id="button-shipping" class="tb_button tb_button_primary"><?php echo $button_shipping; ?></button>';
        <?php } else { ?>
        html += '  <button type="submit" id="button-shipping" class="tb_button tb_button_primary" disabled="disabled"><?php echo $button_shipping; ?></button>';
        <?php } ?>

        $("#shipping_quote").empty().html(html).show();

				$('input[name=\'shipping_method\']').on('change', function() {
					$('#button-shipping').prop('disabled', false);
				});
			}
		}
	});
});

$(document).delegate('#button-shipping', 'click', function() {
	$.ajax({
		url: 'index.php?route=checkout/shipping/shipping',
		type: 'post',
		data: 'shipping_method=' + encodeURIComponent($('input[name=\'shipping_method\']:checked').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-shipping').button('loading');
		},
		complete: function() {
			$('#button-shipping').button('reset');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				$('#cart_form').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}

			if (json['redirect']) {
				location = json['redirect'];
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/shipping/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
      $('.fa-spin').remove();

			if (json['postcode_required'] == '1') {
				$('input[name=\'postcode\']').parent().parent().addClass('required');
			} else {
				$('input[name=\'postcode\']').parent().parent().removeClass('required');
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>
