<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/voucher.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/voucher.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/voucher.page_content'); ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<p><?php echo $text_description; ?></p>
    
<form id="gift_voucher_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-to-name"><?php echo $entry_to_name; ?></label>
    <div class="col-sm-10">
      <input type="text" name="to_name" value="<?php echo $to_name; ?>" id="input-to-name" class="form-control" />
      <?php if ($error_to_name) { ?>
      <div class="text-danger"><?php echo $error_to_name; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-to-email"><?php echo $entry_to_email; ?></label>
    <div class="col-sm-10">
      <input type="text" name="to_email" value="<?php echo $to_email; ?>" id="input-to-email" class="form-control" />
      <?php if ($error_to_email) { ?>
      <div class="text-danger"><?php echo $error_to_email; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-from-name"><?php echo $entry_from_name; ?></label>
    <div class="col-sm-10">
      <input type="text" name="from_name" value="<?php echo $from_name; ?>" id="input-from-name" class="form-control" />
      <?php if ($error_from_name) { ?>
      <div class="text-danger"><?php echo $error_from_name; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-from-email"><?php echo $entry_from_email; ?></label>
    <div class="col-sm-10">
      <input type="text" name="from_email" value="<?php echo $from_email; ?>" id="input-from-email" class="form-control" />
      <?php if ($error_from_email) { ?>
      <div class="text-danger"><?php echo $error_from_email; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label"><?php echo $entry_theme; ?></label>
    <div class="col-sm-10">
      <?php foreach ($voucher_themes as $voucher_theme) { ?>
      <?php if ($voucher_theme['voucher_theme_id'] == $voucher_theme_id) { ?>
      <div class="radio">
        <label>
          <input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked" />
          <?php echo $voucher_theme['name']; ?></label>
      </div>
      <?php } else { ?>
      <div class="radio">
        <label>
          <input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" />
          <?php echo $voucher_theme['name']; ?></label>
      </div>
      <?php } ?>
      <?php } ?>
      <?php if ($error_theme) { ?>
      <div class="text-danger"><?php echo $error_theme; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label" for="input-message"><span data-toggle="tooltip" title="<?php echo $help_message; ?>"><?php echo $entry_message; ?></span></label>
    <div class="col-sm-10">
      <textarea name="message" cols="40" rows="5" id="input-message" class="form-control"><?php echo $message; ?></textarea>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label" for="input-amount"><span data-toggle="tooltip" title="<?php echo $help_amount; ?>"><?php echo $entry_amount; ?></span></label>
    <div class="col-sm-10">
      <input type="text" name="amount" value="<?php echo $amount; ?>" id="input-amount" class="form-control" size="5" />
      <?php if ($error_amount) { ?>
      <div class="text-danger"><?php echo $error_amount; ?></div>
      <?php } ?>
    </div>
  </div>

  <div class="tb_submit clearfix">
    <label class="checkbox">
    <?php if ($agree) { ?>
    <input type="checkbox" name="agree" value="1" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="agree" value="1" />
    <?php } ?>
    <?php echo $text_agree; ?></label>
    <button class="tb_button tb_button_primary" type="submit"><?php echo $button_continue; ?></button>
  </div>

</form>

<script type="text/javascript"><!--
tbApp.onScriptLoaded(function() {

  //Validation format
  $('#{{widget_dom_id}} .text-danger').each(function() {
      $(this).parents('.form-group').eq(0).addClass('has-error');
  });

});
//--></script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>