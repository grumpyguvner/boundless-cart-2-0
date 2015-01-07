<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>
<ul class="tb_list_1 tb_nav">
  <?php foreach ($menu as $item): ?>
  <li<?php if (!empty($item['css_class'])): ?> class="<?php echo $item['css_class']; ?>"<?php endif; ?>>
    <a href="<?php echo $item['url']; ?>" title="<?php echo $item['url_title']; ?>" target="<?php echo $item['url_target']; ?>"><?php echo $item['label']; ?></a>
  </li>
  <?php endforeach; ?>
</ul>
