<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('information/contact.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('information/contact.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('information/contact.page_content'); ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-vertical">
        
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-name"><strong><?php echo $entry_name; ?></strong></label>
    <div class="col-sm-10 tb_full">
      <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
      <?php if ($error_name) { ?>
      <div class="text-danger"><?php echo $error_name; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-email"><strong><?php echo $entry_email; ?></strong></label>
    <div class="col-sm-10 tb_full">
      <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
      <?php if ($error_email) { ?>
      <div class="text-danger"><?php echo $error_email; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-enquiry"><strong><?php echo $entry_enquiry; ?></strong></label>
    <div class="col-sm-10 tb_full">
      <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
      <?php if ($error_enquiry) { ?>
      <div class="text-danger"><?php echo $error_enquiry; ?></div>
      <?php } ?>
    </div>
  </div>
  <div class="form-group required">
    <label class="col-sm-2 control-label" for="input-captcha"><strong><?php echo $entry_captcha; ?></strong></label>
    <div class="col-sm-10">
      <input type="text" name="captcha" id="input-captcha" class="form-control" />
      <span class="clear"></span>
      <br />
      <img src="index.php?route=tool/captcha" alt="" />
      <?php if ($error_captcha) { ?>
      <div class="text-danger"><?php echo $error_captcha; ?></div>
      <?php } ?>
    </div>
  </div>

  <span class="clear border_eee tb_sep"></span>
          
  <div class="tb_submit clearfix">
    <button class="tb_button tb_button_primary" type="submit"><?php echo $button_submit; ?></button>
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
