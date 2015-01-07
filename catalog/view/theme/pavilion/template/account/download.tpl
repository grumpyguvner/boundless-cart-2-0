<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/download.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/download.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/download.page_content'); ?>
<div class="tb_downloads_table tb_sep">
  <table class="tb_table_1">
    <thead>
      <tr>
        <th class="id"><?php echo $column_order_id; ?></th>
        <th class="name"><?php echo $column_name; ?></th>
        <th class="size"><?php echo $column_size; ?></th>
        <th class="date"><?php echo $column_date_added; ?></th>
        <th class="download">&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($downloads as $download): ?>
      <tr>
        <td class="id"><?php echo $download['order_id']; ?></td>
        <td class="name"><?php echo $download['name']; ?></td>
        <td class="size"><?php echo $download['size']; ?></td>
        <td class="date"><?php echo $download['date_added']; ?></td>
        <td class="download"><a class="tb_button tb_button_primary tb_fixed" href="<?php echo $download['href']; ?>" title="<?php echo $button_download; ?>"><i class="fa fa-cloud-download"></i></a></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<div class="pagination">
  <?php echo str_replace('pagination', 'links', $pagination); ?>
  <div class="results"><?php echo $results; ?></div>
</div>

<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>