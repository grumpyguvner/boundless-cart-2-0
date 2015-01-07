<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/login.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>
<?php $tbData->slotStart('account/login.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/login.page_content'); ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
<?php } ?>

<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<div class="tb_wrap">

  <div class="tb_col_1_2">
    <div id="new_customer">
      <fieldset>
        <legend><?php echo $text_new_customer; ?></legend>
        <p><?php echo $text_register_account; ?></p>
      </fieldset>
      <div class="tb_submit clearfix">
        <a class="tb_button tb_button_continue" href="<?php echo $register; ?>"><?php echo $button_continue; ?></a>
      </div>
    </div>
  </div>

  <div class="tb_col_1_2">
    <form id="login_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

      <fieldset class="form-vertical">
        <legend><?php echo $text_returning_customer; ?></legend>
        <p><?php echo $text_i_am_returning_customer; ?></p>
        <div class="form-group">
          <label><strong><?php echo $entry_email; ?></strong></label>
          <input type="text" name="email" value="<?php echo $email; ?>" size="35" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
        </div>
        <div class="form-group">
          <label><strong><?php echo $entry_password; ?></strong></label>
          <input type="password" name="password" value="<?php echo $password; ?>" size="35" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
        </div>
      </fieldset>

      <div class="tb_submit clearfix">
        <a class="tb_button_forgotten" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
        <button class="tb_button" type="submit"><?php echo $button_login; ?></button>
        <?php if ($redirect): ?>
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        <?php endif; ?>
      </div>

    </form>
  </div>

</div>

<script type="text/javascript"><!--
$('#login_form input').keydown(function(e) {
  if (e.keyCode == 13) {
    $('#login_form').submit();
  }
});
//--></script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>