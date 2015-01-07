<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/return.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/return.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/return.page_content', array('filter' => array('account/return.page_content.filter', 'returns' => &$returns), 'data' => $data)); ?>
<?php if ($returns): ?>
<div class="tb_returns tb_listing tb_inline_view clearfix">
  <?php foreach ($returns as $return): ?>
  <div class="tb_return tb_item<?php echo $return['tb_css_classes']; ?> tb_border_str_2">
    <h3 class="h2"><?php echo $column_return_id; ?> <span class="tb_main_color">#<?php echo $return['return_id']; ?></span></h3>
    <p class="tb_status h2 tb_border_str_2"><?php echo $return['status']; ?></p>
    <dl class="tb_dlist_1">
      <dt><?php echo $column_date_added; ?></dt>
      <dd><?php echo $return['date_added']; ?></dd>
      <dt><?php echo $column_order_id; ?></dt>
      <dd><?php echo $return['order_id']; ?></dd>
      <dt><?php echo $column_customer; ?></dt>
      <dd><?php echo $return['name']; ?></dd>
    </dl>
    <span class="clear tb_border_str_1"></span>
    <div class="tb_summary">
      <div>
        <div class="tb_actions">
          <a class="tb_main_color right" href="<?php echo $return['href']; ?>"><strong><?php echo $button_view; ?></strong></a>
        </div>
      </div>
    </div>
  </div>
  <?php endforeach ?>
</div>

<div class="pagination"><?php echo str_replace('pagination', 'links', $pagination); ?></div>

<?php else: ?>
<p class="tb_text_empty"><?php echo $text_empty; ?></p>
<?php endif; ?>
        
<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .tb_listing', [1200, 600, 300, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>