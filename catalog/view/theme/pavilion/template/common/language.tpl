<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>
<?php if ($languages && count($languages) > 1): ?>
<?php
$tb_lang_flag = $tbData->common['language_label'] == 'flag' || $tbData->common['language_label'] == 'flag+code' || $tbData->common['language_label'] == 'flag+name';
$tb_lang_code = $tbData->common['language_label'] == 'code' || $tbData->common['language_label'] == 'flag+code';
$tb_lang_name = $tbData->common['language_label'] == 'name' || $tbData->common['language_label'] == 'flag+name';
?>
<div class="tb_widget_language tb_border_str_1">
  <form id="language_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <div id="language_switcher" class="tb_nav">
      <ul class="clearfix">
        <li class="tb_selected<?php if (count($languages) > 1) echo ' tb_multiple'; ?>" aria-haspopup="true">
          <?php foreach ($languages as $language): ?>
          <?php if ($language['code'] == $code): ?>
          <a href="javascript:;" data-language-code="<?php echo $language['code']; ?>">
            <?php if ($tb_lang_flag): ?>
            <img src="<?php echo $tbData->theme_catalog_image_url; ?>flags/<?php echo $language['image']; ?>" width="16" height="16" alt="<?php echo $language['name']; ?>" />
            <?php endif; ?>
            <?php if ($tb_lang_name): ?>
            <?php echo $language['name']; ?>
            <?php endif; ?>
            <?php if ($tb_lang_code): ?>
            <?php echo $language['code']; ?>
            <?php endif; ?>
          </a>
          <?php endif; ?>
          <?php endforeach; ?>
          <?php if (count($languages) > 1): ?>
          <div class="tb_submenu">
            <ul>
              <?php foreach ($languages as $language): ?>
              <?php if ($language['code'] != $code): ?>
              <li>
                <a href="javascript:;" data-language-code="<?php echo $language['code']; ?>">
                  <?php if ($tb_lang_flag): ?>
                  <img src="<?php echo $tbData->theme_catalog_image_url; ?>flags/<?php echo $language['image']; ?>" width="16" height="16" alt="<?php echo $language['name']; ?>" />
                  <?php endif; ?>
                  <?php if ($tb_lang_name): ?>
                  <?php echo $language['name']; ?>
                  <?php endif; ?>
                  <?php if ($tb_lang_code): ?>
                  <?php echo $language['code']; ?>
                  <?php endif; ?>
                </a>
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


