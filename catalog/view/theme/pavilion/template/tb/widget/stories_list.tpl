<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<div class="tb_articles tb_listing tb_compact_view clearfix">

  <?php foreach ($stories as $story): ?>
  <div class="tb_article tb_item">
    <?php if ($story['thumb']): ?>
    <a class="tb_thumb" href="<?php echo $story['url']; ?>">
      <img src="<?php echo $story['thumb']; ?>" width="<?php echo $story['thumb_width']; ?>" height="<?php echo $story['thumb_height']; ?>" alt="<?php echo $story['title']; ?>" />
    </a>
    <?php endif; ?>
    <div class="tb_item_info">
      <h3><a href="<?php echo $story['url']; ?>"><?php echo $story['title']; ?></a></h3>
      <?php if ($show_text): ?>
      <p class="tb_description"><?php echo $story['description']; ?></p>
      <?php endif; ?>
      <div class="tb_meta">
        <?php if ($show_date): ?>
        <p class="tb_date">
          <i class="fa fa-calendar"></i>
          <?php echo $story['date_added']; ?>
        </p><?php endif; ?><?php if ($show_tags && $story['tags']): ?><p class="tb_tags">
          <i class="fa fa-tags"></i>
          <?php $i=1; foreach ($story['tags'] as $tag): ?>
          <a href="<?php echo $tag['url']; ?>"><?php echo $tag['name']; ?></a><?php if ($i < count($story['tags'])): ?>, <?php endif; ?>
          <?php $i++; endforeach; ?>
        </p><?php endif; ?><?php if ($show_comments && $main_settings['comments'] != 'disabled'): ?><p class="tb_commens_count">
          <i class="fa fa-comments"></i>
          <?php if ($main_settings['comments'] == 'disqus'): ?>
          <a href="<?php echo $story['url']; ?>#disqus_thread"></a>
          <?php endif; ?>
          <?php if ($main_settings['comments'] == 'facebook'): ?>
          <a href="<?php echo $story['url']; ?>#comments"><span class="fb-comments-count" data-href="<?php echo $story['url']; ?>"></span></a>
          <?php endif; ?>
        </p>
        <?php endif; ?>
      </div>
    </div>
  </div>
  <?php endforeach; ?>

</div>

<?php if ($show_text || $slider): ?>
<script type="text/javascript">
  tbApp.init<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {

      <?php // ARTICLE SLIDER ?>
      <?php if ($slider): ?>
      tbApp.itemSlider<?php echo $widget->getDomId(); ?> = createItemSlider('#<?php echo $widget->getDomId(); ?>', <?php echo count($stories); ?>, <?php echo $slider_step; ?>, <?php echo $slider_speed; ?>, <?php $slider_pagination ? print '\'#' . $widget->getDomId() . ' .tb_slider_pagination\'' : print 'false' ; ?>, {"1200":{"items_per_row":1,"items_spacing":0}});
      <?php endif; ?>

    });
  }
  <?php if ($slider): ?>
  tbApp.exec<?php echo $widget->getDomId(); ?> = function() {
    tbApp.onScriptLoaded(function() {
      tbApp.itemSlider<?php echo $widget->getDomId(); ?>.refresh();
    });
  }
  <?php endif; ?>
  <?php if (!isset($within_group) || !$within_group): ?>
  tbApp.init<?php echo $widget->getDomId(); ?>();
  <?php if ($slider): ?>
  tbApp.exec<?php echo $widget->getDomId(); ?>();
  <?php endif; ?>
  <?php endif; ?>
</script>
<?php endif; ?>
