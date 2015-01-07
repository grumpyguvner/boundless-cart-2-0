<div id="row_<?php echo $id; ?>" class="<?php echo $row_classes; ?>">
  <div class="tb_wrap">
    <?php foreach ($columns as $column): ?>
    <div class="tb_col_<?php echo $column['grid_proportion']; ?>">
      <?php echo $column['html_contents']; ?>
    </div>
    <?php endforeach; ?>
  </div>
</div>