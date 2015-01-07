<?php if ($products): ?>

<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<?php require tb_modification(dirname(__FILE__) . '/_list_products.tpl'); ?>

<?php endif; ?>
