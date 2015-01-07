<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/reward.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/reward.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/reward.page_content'); ?>
<p class="tb_reward_points"><?php echo $text_total; ?> <strong class="tb_reward_points_total tb_main_color"><?php echo $total; ?></strong></p>

<div class="tb_reward_points tb_table_1">
  <table>
    <thead>
      <tr>
        <th class="date"><?php echo $column_date_added; ?></th>
        <th class="description"><?php echo $column_description; ?></th>
        <th class="points"><?php echo $column_points; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php if ($rewards) { ?>
      <?php foreach ($rewards  as $reward) { ?>
      <tr>
        <td class="date"><?php echo $reward['date_added']; ?></td>
        <td class="description"><?php if ($reward['order_id']) { ?>
          <a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
          <?php } else { ?>
          <?php echo $reward['description']; ?>
          <?php } ?>
        </td>
        <td class="points" title="<?php echo $column_points; ?>"><?php echo $reward['points']; ?></td>
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
    
<div class="pagination"><?php echo str_replace('pagination', 'links', $pagination); ?></div>

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
