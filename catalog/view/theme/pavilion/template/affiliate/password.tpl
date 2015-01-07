<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/password.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/password.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/password.page_content'); ?>
<form id="change_password_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

  <fieldset>
    <legend><?php echo $text_password; ?></legend>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-password"><?php echo $entry_password; ?></label>
      <div class="col-sm-10">
        <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
        <?php if ($error_password) { ?>
        <div class="text-danger"><?php echo $error_password; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-confirm"><?php echo $entry_confirm; ?></label>
      <div class="col-sm-10">
        <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control" />
        <?php if ($error_confirm) { ?>
        <div class="text-danger"><?php echo $error_confirm; ?></div>
        <?php } ?>
      </div>
    </div>
  </fieldset>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_back tb_button_default tb_bg_str_3" href="<?php echo $back; ?>"><?php echo $button_back; ?></a>
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
