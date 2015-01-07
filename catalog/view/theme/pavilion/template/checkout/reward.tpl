<h2 class="tb_bg_str_2"> <?php echo $heading_title; ?></h2>
<div id="reward" class="cart-content">
  <div id="apply_reward" class="tb_box_1">
    <label><strong><?php echo $entry_reward; ?></strong></label>
    <input type="text" name="reward" value="<?php echo $reward; ?>" size="28" />
    <button id="button-reward" class="tb_button tb_button_primary" type="submit"><?php echo $button_reward; ?></button>
  </div>
</div>

<script type="text/javascript"><!--
$('#button-reward').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/reward/reward',
		type: 'post',
		data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-reward').button('loading');
		},
		complete: function() {
			$('#button-reward').button('reset');
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
