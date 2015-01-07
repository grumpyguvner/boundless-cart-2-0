<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/return/info.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/return/info.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/return/info.page_content'); ?>
<div class="tb_return_info">

  <h2 class="tb_id left"><?php echo $text_return_id; ?> <span class="tb_main_color">#<?php echo $return_id; ?></span></h2>

  <p class="tb_status h2"><?php echo $text_order_id; ?> <span class="tb_main_color">#<?php echo $order_id; ?></span></p>

  <span class="clear tb_sep tb_border_str_2"></span>
          
  <dl class="tb_dlist_1 tb_sep">
    <dt><?php echo $text_date_ordered; ?></dt>
    <dd><?php echo $date_ordered; ?></dd>
    <dt><?php echo $text_date_added; ?></dt>
    <dd><?php echo $date_added; ?></dd>
  </dl>

  <span class="clear tb_sep tb_border_str_1"></span>
          
  <h2><?php echo $text_product; ?></h2>
          
  <div class="cart-info tb_table_1 tb_open">
    <table>
      <thead>
        <tr>
          <th class="name"><?php echo $column_product; ?></th>
          <th class="model"><?php echo $column_model; ?></th>
          <th class="quantity"><?php echo $column_quantity; ?></th>
          <th class="reason"><?php echo $column_reason; ?></th>
          <th class="opened"><?php echo $column_opened; ?></th>
          <th class="action"><?php echo $column_action; ?></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="name"><strong data-quantity=" x<?php echo $quantity; ?>"><?php echo $product; ?></strong></td>
          <td class="model"><?php echo $model; ?></td>
          <td class="quantity"><?php echo $quantity; ?></td>
          <td class="reason" title="<?php echo $column_reason; ?>"><?php echo $reason; ?></td>
          <td class="opened" title="<?php echo $column_opened; ?>"><?php echo $opened; ?></td>
          <td class="action"><?php echo $action; ?></td>
        </tr>
      </tbody>
    </table>
  </div>

  <?php if ($comment): ?>
  <div id="return_request_comments" class="tb_sep">
    <h2><?php echo $text_comment; ?></h2>
    <p><?php echo $comment; ?></p>
  </div>
  <?php endif; ?>

  <?php if ($histories) { ?>

  <span class="clear tb_sep tb_border_str_1"></span>

  <h2><?php echo $text_history; ?></h2>
  <div class="tb_order_history tb_table_1 tb_open">
    <table class="tb_table_1 tb_open">
      <thead>
        <tr>
          <th class="date"><?php echo $column_date_added; ?></th>
          <th class="status"><?php echo $column_status; ?></th>
          <th class="comment"><?php echo $column_comment; ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($histories as $history) { ?>
        <tr>
          <td class="date"><?php echo $history['date_added']; ?></td>
          <td class="status"><?php echo $history['status']; ?></td>
          <td class="comment"><?php echo $history['comment']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </div>
  <?php } ?>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_continue" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
  </div>

</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .cart-info table', [1000, 400, 0]);
  element_query('#{{widget_dom_id}} .tb_order_history table', [1000, 400, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>