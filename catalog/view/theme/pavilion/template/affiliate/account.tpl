<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/account.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/account.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/account.page_content'); ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
<?php } ?>

<div class="tb_wrap">
         
  <div class="tb_col_1_3">
    <h2><?php echo $text_my_account; ?></h2>
    <ul class="tb_list_1">
      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
      <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
      <?php if ($tbData['affiliate']->isLogged()): ?>
      <li><a href="<?php echo $tbData['url']->link('affiliate/logout', '', 'SSL'); ?>"><?php echo $tbData->text_logout; ?></a></li>
      <?php endif; ?>
    </ul>
  </div>

  <div class="tb_col_1_3">
    <h2><?php echo $text_my_tracking; ?></h2>
    <ul class="tb_list_1">
      <li><a href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
    </ul>
  </div>

  <div class="tb_col_1_3">
    <h2><?php echo $text_my_transactions; ?></h2>
    <ul class="tb_list_1">
      <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    </ul>
  </div>

</div>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>