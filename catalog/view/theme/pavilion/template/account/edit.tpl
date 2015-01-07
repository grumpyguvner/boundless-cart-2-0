<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/edit.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/edit.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/edit.page_content'); ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<form id="edit_account_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

  <fieldset>
    <legend><?php echo $text_your_details; ?></legend>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-firstname"><?php echo $entry_firstname; ?> </label>
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
        <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
        <?php if ($error_email) { ?>
        <div class="text-danger"><?php echo $error_email; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
      <div class="col-sm-10">
        <input type="tel" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
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
    <?php foreach ($custom_fields as $custom_field) { ?>
    <?php if ($custom_field['location'] == 'account') { ?>
    <?php if ($custom_field['type'] == 'select') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
          <?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'radio') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <div>
          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
          <div class="radio">
            <?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
            <label>
              <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
              <?php echo $custom_field_value['name']; ?></label>
            <?php } else { ?>
            <label>
              <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
              <?php echo $custom_field_value['name']; ?></label>
            <?php } ?>
          </div>
          <?php } ?>
        </div>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'checkbox') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <div>
          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
          <div class="checkbox">
            <?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $account_custom_field[$custom_field['custom_field_id']])) { ?>
            <label>
              <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
              <?php echo $custom_field_value['name']; ?></label>
            <?php } else { ?>
            <label>
              <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
              <?php echo $custom_field_value['name']; ?></label>
            <?php } ?>
          </div>
          <?php } ?>
        </div>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'text') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'textarea') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'file') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="tb_button tb_button_primary"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'date') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <div class="input-group date">
          <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span></div>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'time') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <div class="input-group time">
          <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span></div>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'datetime') { ?>
    <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
      <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <div class="col-sm-10">
        <div class="input-group datetime">
          <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span></div>
        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php } ?>
    <?php } ?>
  </fieldset>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_back tb_button_default tb_bg_str_3" href="<?php echo $back; ?>"><?php echo $button_back; ?></a>
    <button class="tb_button tb_button_primary" type="submit"><?php echo $button_continue; ?></button>
  </div>

</form>
<script type="text/javascript" src="<?php echo $tbData->theme_catalog_javascript_url; ?>jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
// Sort the custom fields
$('.form-group[data-sort]').detach().each(function() {
  if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('.form-group').length) {
    $('.form-group').eq($(this).attr('data-sort')).before(this);
  } 
  
  if ($(this).attr('data-sort') > $('.form-group').length) {
    $('.form-group:last').after(this);
  }
    
  if ($(this).attr('data-sort') < -$('.form-group').length) {
    $('.form-group:first').before(this);
  }
});

$('button[id^=\'button-custom-field\']').on('click', function() {
    var node = this;
  
    $('#form-upload').remove();
  
    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

    $('#form-upload input[name=\'file\']').trigger('click');

    timer = setInterval(function() {
        if ($('#form-upload input[name=\'file\']').val() != '') {
            clearInterval(timer);

            $.ajax({
                url: 'index.php?route=tool/upload',
                type: 'post',   
                dataType: 'json',
                data: new FormData($('#form-upload')[0]),
                cache: false,
                contentType: false,
                processData: false,   
                beforeSend: function() {
                  $(node).button('loading');
                },
                complete: function() {
                  $(node).button('reset');      
                },    
                success: function(json) {
                    $(node).parent().find('.text-danger').remove();
        
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
        }
    }, 500);
});
tbApp.onScriptLoaded(function() {

  //Validation format
  $('#{{widget_dom_id}} .text-danger').each(function() {
      $(this).parents('.form-group').eq(0).addClass('has-error');
  });

  //Init dialog
  tbCreateDialog($('#{{widget_dom_id}} .tb_submit a.agree'));

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

});
//--></script> 
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>