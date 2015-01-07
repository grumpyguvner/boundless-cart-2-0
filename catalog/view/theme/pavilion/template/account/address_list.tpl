<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/address.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/address.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/address.page_content', array('filter' => array('account/address.page_content.filter', 'addresses' => &$addresses), 'data' => $data)); ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
<?php } ?>

<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<p><?php echo $text_address_book; ?></p>

<div class="tb_addresses tb_listing tb_inline_view clearfix">
  <?php foreach ($addresses as $result): ?>
  <div class="tb_address tb_item<?php echo $result['tb_css_classes']; ?> tb_address tb_border_str_1">
    <p><?php echo $result['address']; ?></p>
    <div class="tb_actions">
      <a class="tb_button_edit tb_main_color" href="<?php echo $result['update']; ?>"><?php echo $button_edit; ?></a>
      <a class="tb_button_delete tb_main_color" href="<?php echo $result['delete']; ?>"><?php echo $button_delete; ?></a>
    </div>
  </div>
  <?php endforeach; ?>
</div>

<div class="tb_submit clearfix">
  <a class="tb_button tb_button_back tb_button_default tb_bg_str_3" href="<?php echo $back; ?>"><?php echo $button_back; ?></a>
  <a class="tb_button tb_button_submit" href="<?php echo $add; ?>"><?php echo $button_new_address; ?></a>
</div>

<script type="text/javascript">
tbApp.onScriptLoaded(function() {
  element_query('#{{widget_dom_id}} .tb_listing', [1200, 900, 600, 300, 0]);
});
</script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>