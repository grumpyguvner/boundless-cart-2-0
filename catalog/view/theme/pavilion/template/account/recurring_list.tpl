<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/recurring.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/recurring.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/recurring.page_content'); ?>
<?php if ($recurrings) { ?>
<div class="tb_recurring_payments tb_table_1">
  <table>
    <thead>
      <tr>
        <th class="id" width="130"><?php echo $column_recurring_id; ?></th>
        <th class="name"><?php echo $column_product; ?></th>
        <th class="date" width="130"><?php echo $column_date_added; ?></th>
        <th class="status" width="130"><?php echo $column_status; ?></th>
        <th class="action" width="130"><?php echo $column_action; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($recurrings as $recurring) { ?>
      <tr>
        <td class="id">#<?php echo $recurring['id']; ?></td>
        <td class="name"><?php echo $recurring['name']; ?></td>
        <td class="date"><?php echo $recurring['date_added']; ?></td>
        <td class="status"><?php echo $status_types[$recurring['status']]; ?></td>
        <td class="action"><a class="tb_button tb_fixed" href="<?php echo $recurring['href']; ?>" title="<?php echo $button_view; ?>"><i class="fa fa-search"></i></a></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</div>

<div class="pagination"><?php echo str_replace('pagination', 'links', $pagination); ?></div>
      
<?php } else { ?>
      
<p class="tb_empty"><?php echo $text_empty; ?></p>
      
<?php } ?>

<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue tb_button_primary" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
 element_query('#{{widget_dom_id}} table', [1000, 400, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>