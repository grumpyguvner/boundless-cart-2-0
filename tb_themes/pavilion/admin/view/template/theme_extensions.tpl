<h2><span>Extensions</span></h2>

<div id="extensions_listing">

  <table class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr>
        <td><?php echo $text_extensions; ?></td>
        <td><?php echo $text_actions; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($not_installed_extensions as $extension): ?>
      <tr>
        <td><?php echo $extension->getInitOption('title'); ?></td>
        <td><a class="install_button ajax" href="<?php echo $tbUrl->generate('extensions/installExtension', 'name=' . $extension->getName()); ?>"><?php echo $text_install; ?></a></td>
      </tr>
      <?php endforeach; ?>
      <?php foreach ($installed_extensions as $extension): ?>
      <?php if (!$extension->isCoreExtension()): ?>
      <tr>
        <td><?php echo $extension->getInitOption('title'); ?></td>
        <td>
          <?php if ($extension->getInitOption('actions')): ?>
          <?php foreach ($extension->getInitOption('actions') as $action): ?>
          <a class="<?php echo ($action['type'])?>" href="<?php echo $action['url']; ?>"><?php echo $action['title']; ?></a> |
          <?php endforeach; ?>
          <?php endif; ?>
          <a class="uninstall_button ajax" href="<?php echo $tbUrl->generate('extensions/uninstallExtension', 'name=' . $extension->getName()); ?>"><?php echo $text_uninstall; ?></a>
        </td>
      </tr>
      <?php endif; ?>
      <?php endforeach; ?>
    </tbody>
  </table>
   
</div>

<script type="text/javascript">
$("#extensions_listing").delegate("a.ajax", "click", function() {
  $("#extensions_listing").block({ message: "<h1>Loading...</h1>" });
  jQuery.getJSON($(this).attr("href"), function(data) {
    $("#extensions_listing").unblock();
    if (data.reload == 1) {
      location.reload();
    } else
    if (data.success == true) {
      displayAlertSuccess(data.message);
    } else
    if (data.success == false) {
      displayAlertWarning(data.message);
    }
  });

  return false;
});
</script>