<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/recurring/info.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/recurring/info.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/recurring/info.page_content'); ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<h2><?php echo $text_recurring_detail; ?></h2>

<span class="clear tb_sep tb_border_str_1"></span>

<div class="tb_wrap tb_sep">
  <div class="tb_col_1_2">
    <dl class="tb_dlist_1">
      <dt><?php echo $text_recurring_id; ?></dt>
      <dd>#<?php echo $recurring['order_recurring_id']; ?></dd>
      <dt><?php echo $text_date_added; ?></dt>
      <dd><?php echo $recurring['date_added']; ?></dd>
      <dt><?php echo $text_status; ?></dt>
      <dd><?php echo $status_types[$recurring['status']]; ?></dd>
      <dt><?php echo $text_payment_method; ?></dt>
      <dd><?php echo $recurring['payment_method']; ?></dd>
    </dl>
  </div>
  <div class="tb_col_1_2">
    <dl class="tb_dlist_1">
      <dt><?php echo $text_product; ?></dt>
      <dd><a class="tb_main_color" href="<?php echo $recurring['product_link']; ?>"><?php echo $recurring['product_name']; ?></a></dd>
      <dt><?php echo $text_quantity; ?></dt>
      <dd><?php echo $recurring['product_quantity']; ?></dd>
      <dt><?php echo $text_order; ?></dt>
      <dd><a href="<?php echo $recurring['order_link']; ?>">#<?php echo $recurring['order_id']; ?></a></dd>
    </dl>
  </div>
</div>

<table class="tb_table_1">
  <thead>
    <tr>
      <th><?php echo $text_recurring_description; ?></th>
      <th><?php echo $text_ref; ?></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="width: 50%;"><?php echo $recurring['recurring_description']; ?></td>
      <td style="width: 50%;"><?php echo $recurring['reference']; ?></td>
    </tr>
  </tbody>
</table>

<h2><?php echo $text_transactions; ?></h2>

<div class="tb_recurring_transactions tb_table_1">
  <table class="tb_table_1">
    <thead>
      <tr>
        <th><?php echo $column_date_added; ?></th>
        <th><?php echo $column_type; ?></th>
        <th><?php echo $column_amount; ?></th>
      </tr>
    </thead>
    <tbody>
    <?php if (!empty($recurring['transactions'])) { ?><?php foreach ($recurring['transactions'] as $transaction) { ?>
    <tr>
      <td class="left"><?php echo $transaction['date_added']; ?></td>
      <td class="center"><?php echo $transaction_types[$transaction['type']]; ?></td>
      <td class="right"><?php echo $transaction['amount']; ?></td>
    </tr>
    <?php } }else{ ?>
    <tr>
      <td colspan="3" class="center"><?php echo $text_empty_transactions; ?></td>
    </tr>
    <?php } ?>
    </tbody>
  </table>
</div>

<?php echo $buttons; ?>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>