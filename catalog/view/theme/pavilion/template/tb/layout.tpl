<?php // ------------------------------------------------------------- ?>
<?php // ---   HEADER   ---------------------------------------------- ?>
<?php // ------------------------------------------------------------- ?>
<?php $tbData->slotEcho('oc_header'); ?>
<?php // ---   end HEADER   ------------------------------------------ ?>


<?php // ------------------------------------------------------------- ?>
<?php // ---   INTRO   ----------------------------------------------- ?>
<?php // ------------------------------------------------------------- ?>
<?php if ($tbData->hasArea('intro')): ?>
<section id="intro" class="<?php echo $tbData->intro_css_classes; ?>">
  <div class="tb_wrap">
    <div class="tb_col_1_1">
      <?php echo $tbData->getArea('intro'); ?>
    </div>
  </div>
</section>
<?php endif; ?>
<?php // ---   end INTRO   ------------------------------------------- ?>


<?php // ------------------------------------------------------------- ?>
<?php // ---   CONTENT   --------------------------------------------- ?>
<?php // ------------------------------------------------------------- ?>
<?php if ($tbData->hasArea('content') || $tbData->hasArea('column_left') || $tbData->hasArea('column_right')): ?>
<section id="content" class="<?php echo $tbData->getContentCssClasses(); ?>">
  <div class="tb_wrap">

    <div class="tb_main_col tb_col_1_1">
      <?php echo $tbData->getArea('content'); ?>
    </div>

    <?php // ------------------------------------------------------------- ?>
    <?php // ---   LEFT COLUMN   ----------------------------------------- ?>
    <?php // ------------------------------------------------------------- ?>
    <?php if ($tbData->hasArea('column_left')): ?>
    <aside id="left_col" class="tb_side_col tb_col_1_1">
      <?php echo $tbData->getArea('column_left'); ?>
    </aside>
    <?php endif; ?>
    <?php // ---   end LEFT COLUMN   ------------------------------------- ?>


    <?php // ------------------------------------------------------------- ?>
    <?php // ---   RIGHT COLUMN   ---------------------------------------- ?>
    <?php // ------------------------------------------------------------- ?>
    <?php if ($tbData->hasArea('column_right')): ?>
    <aside id="right_col" class="tb_side_col tb_col_1_1">
      <?php echo $tbData->getArea('column_right'); ?>
    </aside>
    <?php endif; ?>
    <?php // ---   end RIGHT COLUMN   ------------------------------------ ?>

  </div>
</section>
<?php endif; ?>
<?php // ---   end CONTENT   ----------------------------------------- ?>


<?php // ------------------------------------------------------------- ?>
<?php // ---   FOOTER   ---------------------------------------------- ?>
<?php // ------------------------------------------------------------- ?>
<?php if ($tbData->hasArea('footer')): ?>
<section id="footer" class="<?php echo $tbData->footer_css_classes; ?>">
  <div class="tb_wrap">
    <div class="tb_col_1_1">
      <?php echo $tbData->getArea('footer'); ?>
    </div>
  </div>
</section>
<?php endif; ?>
<?php // ---   end FOOTER   ------------------------------------------ ?>


<?php // ------------------------------------------------------------- ?>
<?php // ---   BOTTOM   ---------------------------------------------- ?>
<?php // ------------------------------------------------------------- ?>
<?php $tbData->slotEcho('oc_footer'); ?>
<?php // ---   end BOTTOM   ------------------------------------------ ?>