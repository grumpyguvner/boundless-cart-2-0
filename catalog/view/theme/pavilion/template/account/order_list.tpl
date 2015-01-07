<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/order.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/order.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/order.page_content', array('filter' => array('account/order.page_content.filter', 'orders' => &$orders), 'data' => $data)); ?>
<?php if ($orders): ?>
<div class="tb_orders tb_listing tb_inline_view clearfix">
  <?php foreach ($orders as $order): ?>
  <div class="tb_order tb_item<?php echo $order['tb_css_classes']; ?> tb_border_str_2">
    <h3 class="h2"><span><?php echo $column_order_id; ?></span> <span class="tb_main_color">#<?php echo $order['order_id']; ?></span></h3>
    <p class="tb_status h2 tb_border_str_2"><?php echo $order['status']; ?></p>
    <dl class="tb_dlist_1">
      <dt><?php echo $column_date_added; ?></dt>
      <dd><?php echo $order['date_added']; ?></dd>
      <dt><?php echo $column_customer; ?></dt>
      <dd><?php echo $order['name']; ?></dd>
      <dt><?php echo $column_product; ?></dt>
      <dd><?php echo $order['products']; ?></dd>
    </dl>
    <span class="clear tb_border_str_1"></span>
    <div class="tb_summary">
      <div>
        <p class="tb_total h2"><?php echo $order['total']; ?></p>
        <div class="tb_actions">
          <a class="tb_details tb_main_color" href="<?php echo $order['href']; ?>"><strong><?php echo $button_view; ?></strong></a>
          <?php /* <a class="tb_reorder tb_main_color" href="<?php echo $order['reorder']; ?>"><strong><?php echo $button_reorder; ?></strong></a> */ ?>
        </div>
      </div>
    </div>
  </div>
  <?php endforeach; ?>
</div>
<div class="pagination"><?php echo $pagination; ?></div>
<?php else: ?>
<p class="tb_empty"><?php echo $text_empty; ?></p>
<?php endif; ?>
        
<div class="tb_submit clearfix">
  <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .tb_listing', [1200, 900, 600, 300, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>