<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/transaction.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/transaction.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/transaction.page_content'); ?>
<p><?php echo $text_total; ?> <strong class="tb_balance_total tb_main_color"><?php echo $total; ?></strong></p>

<div class="tb_transactions tb_table_1">
  <table>
    <thead>
      <tr>
        <th class="date"><?php echo $column_date_added; ?></th>
        <th class="description"><?php echo $column_description; ?></th>
        <th class="amount"><?php echo $column_amount; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php if ($transactions) { ?>
      <?php foreach ($transactions  as $transaction) { ?>
      <tr>
        <td class="date"><?php echo $transaction['date_added']; ?></td>
        <td class="description"><?php echo $transaction['description']; ?></td>
        <td class="amount"><?php echo $transaction['amount']; ?></td>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr>
        <td class="center" colspan="3"><?php echo $text_empty; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</div>

<div class="pagination"><?php echo $pagination; ?></div>

<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} table', [1000, 400, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>