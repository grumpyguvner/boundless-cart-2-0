<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>
<?php if (count($currencies) > 1): ?>
<div class="tb_widget_currency tb_border_str_1">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
    <div id="currency_switcher" class="tb_nav">
      <ul class="clearfix">
        <li class="tb_selected<?php if (count($currencies) > 1) echo ' tb_multiple'; ?>" aria-haspopup="true">
          <?php foreach ($currencies as $currency): ?>
          <?php if ($currency['code'] == $code): ?>
          <?php
            $currency['symbol_left'] ? $symbol = $currency['symbol_left'] : $symbol = $currency['symbol_right'];
            if ($tbData->common['currency_label'] == 'code') {
              $symbol = $currency['code'];
            }
            if ($tbData->common['currency_label'] == 'title') {
              $symbol = $currency['title'];
            }
          ?>
          <a href="javascript:;" title="<?php echo $currency['title']; ?>" data-currency-code="<?php echo $currency['code']; ?>"><?php echo $symbol; ?></a>
          <?php endif; ?>
          <?php endforeach; ?>
          <?php if (count($currencies) > 1): ?>
          <div class="tb_submenu">
            <ul>
              <?php foreach ($currencies as $currency): ?>
              <?php if ($currency['code'] != $code): ?>
              <?php
                $currency['symbol_left'] ? $symbol = $currency['symbol_left'] : $symbol = $currency['symbol_right'];
                if ($tbData->common['currency_label'] == 'code') {
                  $symbol = $currency['code'];
                }
                if ($tbData->common['currency_label'] == 'title') {
                  $symbol = $currency['title'];
                }
              ?>
              <li>
              <a href="javascript:;" title="<?php echo $currency['title']; ?>" data-currency-code="<?php echo $currency['code']; ?>"><?php echo $symbol; ?></a>
              </li>
              <?php endif; ?>
              <?php endforeach; ?>
            </ul>
          </div>
          <?php endif; ?>
        </li>
      </ul>
    </div>
    <input class="tb_hidden" type="hidden" name="code" value="" />
    <input class="tb_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </form>
</div>
<?php endif; ?>
