<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/edit.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/edit.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/edit.page_content'); ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<form id="affiliate_profile_edit_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

  <fieldset>
    <legend><?php echo $text_your_details; ?></legend>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
      <div class="col-sm-10">
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" />
        <?php if ($error_firstname) { ?>
        <div class="text-danger"><?php echo $error_firstname; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
      <div class="col-sm-10">
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" />
        <?php if ($error_lastname) { ?>
        <div class="text-danger"><?php echo $error_lastname; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
      <div class="col-sm-10">
        <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
        <?php if ($error_email) { ?>
        <div class="text-danger"><?php echo $error_email; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
      <div class="col-sm-10">
        <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
        <?php if ($error_telephone) { ?>
        <div class="text-danger"><?php echo $error_telephone; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
      <div class="col-sm-10">
        <input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
      </div>
    </div>
  </fieldset>

  <fieldset>
    <legend><?php echo $text_your_address; ?></legend>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-company"><?php echo $entry_company; ?></label>
      <div class="col-sm-10">
        <input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-company" class="form-control" />
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-website"><?php echo $entry_website; ?></label>
      <div class="col-sm-10">
        <input type="text" name="website" value="<?php echo $website; ?>" placeholder="<?php echo $entry_website; ?>" id="input-website" class="form-control" />
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-address-1"><?php echo $entry_address_1; ?></label>
      <div class="col-sm-10">
        <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address-1" class="form-control" />
        <?php if ($error_address_1) { ?>
        <div class="text-danger"><?php echo $error_address_1; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-address-2"><?php echo $entry_address_2; ?></label>
      <div class="col-sm-10">
        <input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-address-2" class="form-control" />
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-city"><?php echo $entry_city; ?></label>
      <div class="col-sm-10">
        <input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="form-control" />
        <?php if ($error_city) { ?>
        <div class="text-danger"><?php echo $error_city; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
      <div class="col-sm-10">
        <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
        <?php if ($error_postcode) { ?>
        <div class="text-danger"><?php echo $error_postcode; ?></div>
        <?php } ?>
      </div>
    </div>
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
        <?php if ($error_country) { ?>
        <div class="text-danger"><?php echo $error_country; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
      <div class="col-sm-10">
        <select name="zone_id" id="input-zone" class="form-control">
        </select>
        <?php if ($error_zone) { ?>
        <div class="text-danger"><?php echo $error_zone; ?></div>
        <?php } ?>
      </div>
    </div>
  </fieldset>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_back tb_button_default tb_bg_str_3" href="<?php echo $back; ?>"><?php echo $button_back; ?></a>
    <button class="tb_button tb_button_primary" type="submit"><?php echo $button_continue; ?></button>
  </div>
</form>

<script type="text/javascript">
$('select[name=\'country_id\']').on('change', function() {
    $.ajax({
        url: 'index.php?route=affiliate/edit/country&country_id=' + this.value,
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
tbApp.onScriptLoaded(function() {

  //Validation format
  $('#{{widget_dom_id}} .text-danger').each(function() {
      $(this).parents('.form-group').eq(0).addClass('has-error');
  });

});
</script> 
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>