<?php if ($reviews) { $i = 0; $j = count($reviews); ?>
<div class="tb_listing">
  <?php foreach ($reviews as $review) { ?>
  <div class="tb_review<?php if($i == $j-1) echo ' last'; ?>">
    <div class="tb_meta">
      <p class="tb_author"><strong><?php echo $review['author']; ?></strong><small>(<?php echo $review['date_added']; ?>)</small></p>
      <div class="tb_rating_holder">
        <p class="tb_rating tb_rating_5">
          <span class="tb_base"></span>
          <span class="tb_percent" style="width: <?php echo $review['rating'] * 2 ; ?>0%;"></span>
        </p>
        <span class="tb_average"><?php echo $review['rating']; ?>/5</span>
      </div>
    </div>
    <p><?php echo $review['text']; ?></p>
  </div>
  <?php $i++; } ?>
</div>
<span class="clear tb_border_solid tb_border_str_2"></span>
<div class="pagination">
  <?php $pagination = str_replace('pagination', 'links', $pagination); ?>
  <?php $pagination = str_replace('<a', '<a class="tb_bg_str_2 tb_bg_hover_str_3"', $pagination); ?>
  <?php echo $pagination; ?>
</div>
<?php } else { ?>
<p class="tb_empty tb_bg_str_1"><?php echo $text_no_reviews; ?></p>
<?php } ?>
