<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/tracking.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/tracking.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('affiliate/tracking.page_content'); ?>
<div id="tracking_code">
  <p><?php echo $text_description; ?></p>
  
  <fieldset>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-code"><?php echo $entry_code; ?></label>
      <div class="col-sm-10">
        <textarea cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" id="input-code" class="form-control"><?php echo $code; ?></textarea>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-generator"><span data-toggle="tooltip" title="<?php echo $help_generator; ?>"><?php echo $entry_generator; ?></span></label>
      <div class="col-sm-10">
        <input type="text" name="product" value="" placeholder="<?php echo $entry_generator; ?>" id="input-generator" class="form-control" />
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-link"><?php echo $entry_link; ?></label>
      <div class="col-sm-10">
        <textarea name="link" cols="40" rows="5" placeholder="<?php echo $entry_link; ?>" id="input-link" class="form-control"></textarea>
      </div>
    </div>
  <fieldset>

  <div class="tb_submit clearfix">
    <a class="tb_button tb_button_continue tb_button_primary" href="<?php echo $continue; ?>"><?php echo $button_continue; ?></a>
  </div>
</div>

<script type="text/javascript"><!--
$(document).ready( function() {
    
  $('input[name=\'product\']').autocomplete({
    delay: 500,
    source: function(request, response) {
        $.ajax({
            url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request.term),
            dataType: 'json',
            success: function(json) {
                response($.map(json, function(item) {
                    return {
                        label: item.name,
                        value: item.link
                    }
                }));
            }
        });
      
    },
    select: function(event, ui) {
        $('input[name=\'product\']').attr('value', ui.item.label);
        $('textarea[name=\'link\']').attr('value', ui.item.value);
      
        return false;
    },
    focus: function(event, ui) {
        return false;
    }
  });
    
});
//--></script>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>