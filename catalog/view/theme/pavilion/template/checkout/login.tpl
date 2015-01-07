<div class="tb_wrap">

  <div class="tb_col_1_2">
    <div class="tb_new_customer_box tb_sep">
      <h2><?php echo $text_new_customer; ?></h2>
      <p><?php echo $text_checkout; ?></p>
      <div class="form-group">
        <div class="radio">
          <label>
            <?php if ($account == 'register') { ?>
            <input type="radio" name="account" value="register" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="account" value="register" />
            <?php } ?>
            <?php echo $text_register; ?></label>
        </div>
        <?php if ($checkout_guest) { ?>
        <div class="radio">
          <label>
            <?php if ($account == 'guest') { ?>
            <input type="radio" name="account" value="guest" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="account" value="guest" />
            <?php } ?>
            <?php echo $text_guest; ?></label>
        </div>
        <?php } ?>
      </div>
      <p><?php echo $text_register_account; ?></p>
    </div>
    <div class="tb_submit clearfix">
      <a id="button-account" class="tb_button" data-loading-text="<?php echo $text_loading; ?>"><?php echo $button_continue; ?></a>
    </div>
  </div>

  <div class="tb_col_1_2">
    <fieldset class="tb_login_box form-vertical">
      <legend><?php echo $text_returning_customer; ?></legend>
      <p><?php echo $text_i_am_returning_customer; ?></p>
      <div class="form-group">
        <label class="control-label" for="input-email"><strong><?php echo $entry_email; ?></strong></label>
        <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
      </div>
      <div class="form-group">
        <label class="control-label" for="input-password"><strong><?php echo $entry_password; ?></strong></label>
        <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
      </div>
    </fieldset>
    <div class="tb_submit clearfix">
      <a class="tb_button_forgotten" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
      <a id="button-login" class="tb_button tb_button_login"><?php echo $button_login; ?></a>
    </div>

  </div>

</div>