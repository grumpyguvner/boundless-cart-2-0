<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>
<!-- BEGIN_COMMON_FOOTER -->
<footer id="bottom" class="tb_row<?php echo $tbData->bottom_class; ?>">
  <div class="tb_wrap">
    <div class="tb_col_1_1">
      <div class="tb_row tb_row_full">
        <div class="tb_wrap">
          <div class="tb_col_1_1">
            <div class="tb_table">
              <p id="copy"><?php echo $powered; ?></p>
              <?php if ($tbData->payment_images): ?>
              <div id="payment_images">
                <?php foreach($tbData->payment_images['rows'] as $payment): ?>
                <div class="tb_payment">
                  <?php if ($payment['type'] == 'image'): ?>
                  <?php if ($payment['link_url']): ?>
                  <a href="<?php echo $payment['link_url'];?>" target="<?php echo $payment['link_target'];?>">
                    <img src="<?php echo $payment['http_file']; ?>"<?php if($payment['width']): ?> width="<?php echo $payment['width']; ?>" height="<?php echo $payment['height']; ?>"<?php endif; ?> alt="" />
                  </a>
                  <?php else: ?>
                  <img src="<?php echo $payment['http_file']; ?>"<?php if($payment['width']): ?> width="<?php echo $payment['width']; ?>" height="<?php echo $payment['height']; ?>"<?php endif; ?> alt="" />
                  <?php endif; ?>
                  <?php else: ?>
                  <?php echo html_entity_decode($payment['seal_code'], ENT_COMPAT, 'UTF-8'); ?>
                  <?php endif; ?>
                </div>
                <?php endforeach; ?>
              </div>
              <?php endif; ?>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</footer>

</div>

<?php foreach ($tbData->getJavascriptResources('external') as $resource): ?>
<script type="text/javascript" src="<?php echo $resource['url']; ?>"></script>
<?php endforeach; ?>

<?php if ($tbData->common['custom_javascript']): ?>
<script type="text/javascript">
  <?php echo $tbData->common['custom_javascript']; ?>
</script>
<?php endif; ?>

</body>
</html>
