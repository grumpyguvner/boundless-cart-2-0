<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/newsletter.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/newsletter.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/newsletter.page_content'); ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">

  <fieldset>
    <div class="form-group">
      <label class="col-sm-2 control-label"><?php echo $entry_newsletter; ?></label>
      <div class="col-sm-10">
        <?php if ($newsletter) { ?>
        <label class="radio-inline">
          <input type="radio" name="newsletter" value="1" checked="checked" />
          <?php echo $text_yes; ?> </label>
        <label class="radio-inline">
          <input type="radio" name="newsletter" value="0" />
          <?php echo $text_no; ?></label>
        <?php } else { ?>
        <label class="radio-inline">
          <input type="radio" name="newsletter" value="1" />
          <?php echo $text_yes; ?> </label>
        <label class="radio-inline">
          <input type="radio" name="newsletter" value="0" checked="checked" />
          <?php echo $text_no; ?></label>
        <?php } ?>
      </div>
    </div>
  </fieldset>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_default tb_button_back tb_bg_str_3" href="<?php echo $back; ?>"><?php echo $button_back; ?></a>
    <button class="tb_button tb_button_primary" type="submit"><?php echo $button_continue; ?></button>
  </div>

</form>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>