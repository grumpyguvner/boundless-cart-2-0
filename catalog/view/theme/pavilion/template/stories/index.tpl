<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('stories/index.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('stories/index.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('stories/index.page_content'); ?>
<div class="tb_articles tb_listing tb_list_view tb_thumb_<?php echo $settings['thumbnail_position']; ?> clearfix">
  <?php foreach ($stories as $story): ?>
  <div class="tb_article tb_item">
    <h2><a href="<?php echo $story['url']; ?>"><?php echo $story['title']; ?></a></h2>
    <div class="tb_meta">
      <p class="tb_date"><i class="fa fa-calendar"></i> <?php echo $story['date_added']; ?></p><?php if ($story['tags']): ?><p class="tb_tags">
        <i class="fa fa-tags"></i>
        <?php $i=1; foreach ($story['tags'] as $tag): ?>
        <a href="<?php echo $tag['url']; ?>"><?php echo $tag['name']; ?></a><?php if ($i < count($story['tags'])): ?>, <?php endif; ?>
        <?php $i++; endforeach; ?>
      </p><?php endif; ?><?php if ($settings['comments'] != 'disabled'): ?><p class="tb_commens_count">
        <i class="fa fa-comments"></i>
        <?php if ($settings['comments'] == 'disqus'): ?>
        <a href="<?php echo $story['url']; ?>#disqus_thread"></a>
        <?php endif; ?>
        <?php if ($settings['comments'] == 'facebook'): ?>
        <a href="<?php echo $story['url']; ?>#comments"><span class="fb-comments-count" data-href="<?php echo $story['url']; ?>"></span></a>
        <?php endif; ?>
      </p>
      <?php endif; ?>
    </div>
    <?php if ($story['thumb']): ?>
    <a class="tb_thumb" href="<?php echo $story['url']; ?>"><img src="<?php echo $story['thumb']; ?>" alt="<?php echo $story['title']; ?>" /></a>
    <?php endif; ?>
    <div class="tb_description tb_text_wrap">
      <?php echo $story['description']; ?>
      <a class="tb_read_more tb_main_color" href="<?php echo $story['url']; ?>"><?php echo $text_read_more; ?> <span>&rsaquo;</span></a>
    </div>
  </div>
  <?php endforeach; ?>

  <?php if (!$stories): ?>
  <p class="tb_empty"><?php echo $text_no_articles; ?></p>
  <?php endif; ?>
</div>

<div class="pagination tb_border_str_2"><?php echo $pagination; ?></div>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>