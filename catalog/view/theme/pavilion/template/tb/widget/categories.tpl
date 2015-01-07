<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<ul<?php if ($level_1_style == 'list') echo ' class="tb_list_1"'; ?>>
  <?php foreach ($tbData->getCategoriesTree() as $category): ?>
  <?php
    // Level 1
    $has_submenu = $category['children'] && ($level_2 == 'show' || $level_2 == 'accordion' || $level_2 == 'toggle' || $category['category_id'] == $tbData->category_id || in_array($tbData->category_id, $category['successor_ids']));
    $is_active   = $tbData->category_id && ($category['category_id'] == $tbData->category_id || $category['category_id'] == $tbData->category_top_id);
    $class       = $level_2 == 'accordion' || $level_2 == 'toggle' ? 'tb_expandable' : '';
    $class      .= $level_2 == 'accordion' ? ' tb_accordion' : '';
    $class      .= $level_2 == 'toggle' ? ' tb_toggable' : '';
    $class      .= $is_active || $category['category_id'] == $tbData->category_id || in_array($tbData->category_id, $category['successor_ids']) ? ' tb_active' : '';
    $class       = $class ? ' class="' . trim($class) . '"' : '';
  ?>
  <?php if (($level_1 != 'hide' || $is_active) && (!$respect_top || $category['top'])): ?>
  <li<?php echo $class; ?>>
    <?php if ($level_2 == 'accordion' || $level_2 == 'toggle'): ?>
    <span class="tb_toggle tb_bg_str_2 tb_bg_hover_str_3 tb_color_str_4"></span>
    <?php endif; ?>
    <?php if ($level_1_style != 'hide'): ?>
    <?php if ($level_1_style != 'list'): ?>
    <<?php echo $level_1_style; ?>><a href="<?php echo $category['url']; ?>"><?php echo $category['name']; ?></a></<?php echo $level_1_style; ?>>
    <?php else: ?>
    <span><a href="<?php echo $category['url']; ?>"><?php echo $category['name']; ?></a></span>
    <?php endif; ?>
    <?php endif; ?>
    <?php if ($has_submenu): ?>
    <ul<?php if ($level_2_style == 'list') echo ' class="tb_list_1"'; ?>>
      <?php foreach ($category['children'] as $child): ?>
      <?php
        // Level 2
        $has_submenu = $child['children'] && ($level_3 == 'show' || $child['category_id'] == $tbData->category_id || in_array($tbData->category_id, $child['children_ids']));
        $is_active   = $tbData->category_id && ($child['category_id'] == $tbData->category_id || $child['category_id'] == $tbData->category_parent_id);
        $class       = '';
        $class      .= $is_active || ($child['category_id'] == $tbData->category_id || in_array($tbData->category_id, $child['children_ids'])) ? ' tb_active' : '';
        $class       = $class ? ' class="' . trim($class) . '"' : '';
      ?>
      <li<?php echo $class; ?>>
        <?php if ($level_2_style != 'list'): ?>
        <<?php echo $level_2_style; ?>><a href="<?php echo $child['url']; ?>"><?php echo $child['name']; ?></a></<?php echo $level_2_style; ?>>
        <?php else: ?>
        <span><a href="<?php echo $child['url']; ?>"><?php echo $child['name']; ?></a></span>
        <?php endif; ?>
        <?php if ($has_submenu): ?>
        <ul<?php if ($level_3_style == 'list') echo ' class="tb_list_1"'; ?>>
          <?php foreach ($child['children'] as $grandchild): ?>
          <?php
            // Level 3
            $is_active  = $grandchild['category_id'] == $tbData->category_id;
          ?>
          <li<?php if ($is_active): ?> class="tb_active"<?php endif; ?>>
            <?php if ($level_3_style != 'list'): ?>
            <<?php echo $level_3_style; ?>><a href="<?php echo $grandchild['url']; ?>"><?php echo $grandchild['name']; ?></a></<?php echo $level_3_style; ?>>
            <?php else: ?>
            <span><a href="<?php echo $grandchild['url']; ?>"><?php echo $grandchild['name']; ?></a></span>
            <?php endif; ?>
          </li>
          <?php endforeach; ?>
        </ul>
        <?php endif; ?>
      </li>
      <?php endforeach; ?>
    </ul>
  <?php endif; ?>
  </li>
  <?php endif; ?>
  <?php endforeach; ?>
</ul>

<?php if ($level_2 == 'accordion' || $level_2 == 'toggle'): ?>
<script>
tbApp.onScriptLoaded(function() {

    $c = $('#<?php echo $widget_dom_id; ?>');

    if ($c.find('.tb_expandable.tb_active').length) {
        $c.find('.tb_expandable:not(.tb_active) > ul').hide();
        $c.find('.tb_expandable.tb_active').addClass('tb_show');
    }
    else {
        $c.find('.tb_expandable:not(:first-child) > ul').hide();
        $c.find('.tb_expandable:first-child').addClass('tb_show');
    }

    <?php if ($level_2 == 'accordion'): ?>
    $c.find('.tb_accordion > .tb_toggle').bind("click", function() {
        if(!$(this).parent().hasClass('tb_show')) {
            $c.find(".tb_accordion > ul:visible").slideUp().parent('li').removeClass("tb_show");
            $(this).parent().addClass("tb_show").find('> ul').slideDown();
        }
    });
    <?php endif; ?>

    <?php if ($level_2 == 'toggle'): ?>
    $c.find('.tb_toggable > .tb_toggle').bind("click", function() {
        if(!$(this).parent().hasClass('tb_show')) {
            $(this).parent().addClass('tb_show').find('> ul').slideDown();
        } else {
            $(this).parent().removeClass('tb_show').find('> ul').slideUp();
        }
    });
    <?php endif; ?>

});
</script>
<?php endif; ?>