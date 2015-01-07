<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<p><?php echo $text_payment_method; ?></p>
<table class="radio tb_sep">
<?php foreach ($payment_methods as $payment_method) { ?>
    <tr class="highlight">
      <td><?php if ($payment_method['code'] == $code || !$code) { ?>
    <?php $code = $payment_method['code']; ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
    <?php } else { ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
        <?php } ?></td>
    <td>
      <label for="<?php echo $payment_method['code']; ?>">
        <?php echo $payment_method['title']; ?>
        <?php if ($payment_method['terms']) { ?>
        (<?php echo $payment_method['terms']; ?>)
        <?php } ?>
      </label>
    </td>
    </tr>
    <?php } ?>
  </table>
<?php } ?>

<h2><?php echo $text_comments; ?></h2>
<div class="form-group tb_full tb_sep">
  <textarea name="comment" rows="8" class="form-control"><?php echo $comment; ?></textarea>
</div>

<div class="tb_submit clearfix">
  <?php if ($text_agree) { ?>
  <div class="checkbox">
    <label>
      <input type="checkbox" name="agree" value="1"<?php if ($agree) { ?> checked="checked"<?php } ?> /> 
      <?php echo $text_agree; ?>
    </label>
  </div>
  <?php } ?>

  <button id="button-payment-method" class="tb_button tb_button_primary" type="button"><?php echo $button_continue; ?></button>
</div>