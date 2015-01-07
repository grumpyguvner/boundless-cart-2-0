<?php $tbData->echoHeader($header); ?>


<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('payment/amazon_checkout/failure.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('payment/amazon_checkout/failure.page_content'); ?>
<p><?php echo $text_payment_failed ?></p>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>