<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>
<ul class="tb_list_1 clearfix">
  <?php if ($tbData->common['manufacturers_enabled']): ?>
  <li><a href="<?php echo $tbData['url']->link('product/manufacturer', '', 'SSL'); ?>"><?php echo $text_manufacturer; ?></a></li>
  <?php endif; ?>
  <?php if ($tbData->common['voucher_enabled']): ?>
  <li><a href="<?php echo $tbData['url']->link('account/voucher', '', 'SSL'); ?>"><?php echo $text_voucher; ?></a></li>
  <?php endif; ?>
  <?php if ($tbData->common['affiliate_enabled']): ?>
  <li><a href="<?php echo $tbData['url']->link('affiliate/account', '', 'SSL'); ?>"><?php echo $text_affiliate; ?></a></li>
  <?php endif; ?>
  <li><a href="<?php echo $tbData['url']->link('product/special', '', 'SSL'); ?>"><?php echo $text_special; ?></a></li>
  <li><a href="<?php echo $tbData['url']->link('information/contact', '', 'SSL'); ?>"><?php echo $text_contact; ?></a></li>
  <?php if ($tbData->common['returns_enabled']): ?>
  <li><a href="<?php echo $tbData['url']->link('account/return/insert', '', 'SSL'); ?>"><?php echo $text_return; ?></a></li>
  <?php endif; ?>
  <li><a href="<?php echo $tbData['url']->link('information/sitemap', '', 'SSL'); ?>"><?php echo $text_sitemap; ?></a></li>
</ul>
