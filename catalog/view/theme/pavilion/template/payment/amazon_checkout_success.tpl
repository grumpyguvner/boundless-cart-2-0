<?php $tbData->echoHeader($header); ?>


<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('payment/amazon_checkout/success.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('payment/amazon_checkout/success.page_content'); ?>
<p><?php echo $text_payment_success ?></p>

<div id="AmazonOrderDetail"></div>

<script type="text/javascript"><!--
new CBA.Widgets.OrderDetailsWidget ({
    merchantId: "<?php echo $merchant_id; ?>",
    orderID: "<?php echo $amazon_order_id; ?>"
}).render ("AmazonOrderDetail");
//--></script>


<?php $tbData->echoFooter($footer); ?>