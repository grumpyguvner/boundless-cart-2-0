<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStartSystem('error/not_found.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStartSystem('error/not_found.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStartSystem('error/not_found.page_content'); ?>
<div class="tb_text_wrap tb_sep">
  <p><?php echo $text_error; ?></p>
</div>

<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>
