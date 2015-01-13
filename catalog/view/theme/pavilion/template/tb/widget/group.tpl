<?php if ($title): ?>
<h2 class="align_<?php echo $title_align; ?>"><?php echo $title; ?></h2>
<?php endif; ?>

<div class="<?php echo $group_classes; ?> clearfix">

  <?php if ($group_type == 'tabs'): ?>
  <nav class="tb_tabs_nav" style="<?php echo $tabs_nav_style; ?>">
    <ul class="clearfix">
      <?php $i = 0; ?>
      <?php foreach ($widget->getSubWidgets() as $id => $subWidget): ?><?php if (isset($subwidgets_content[$id])): ?><li<?php /* if($i == 0) echo ' class="tbActivated"'; */ ?>>
        <a href="{{current_url}}#<?php echo $id; ?>_tab">
          <?php if (isset($tabs[$i]['icon']) && !empty($tabs[$i]['icon'])): ?>
          <span class="tb_icon <?php echo $tabs[$i]['icon']; ?>" style="font-size: <?php echo $tabs[$i]['icon_size']; ?>px;"></span>
          <?php endif; ?>
          <?php if (isset($tabs[$i]['title']) && $tabs[$i]['title']): ?>
          <span><?php echo $tabs[$i]['title']; ?></span>
          <?php elseif ($subWidget->getLangTitle()): ?>
          <span><?php echo $subWidget->getLangTitle(); ?></span>
          <?php elseif (!isset($tabs[$i]['icon']) || !$tabs[$i]['icon']): ?>
          <span><?php echo 'Tab ' . ($i + 1); ?></span>
          <?php endif; ?>
        </a>
      </li><?php $i++; ?><?php endif; ?><?php endforeach; ?>
    </ul>
  </nav>
  <?php endif; ?>

  <div class="tb_<?php echo $group_type; ?>_content">
    <?php $i = 0; ?>
    <?php foreach ($widget->getSubWidgets() as $id => $subWidget): ?>
    <?php if (isset($subwidgets_content[$id])): ?>
    <span class="tb_title<?php /* if($i == 0) echo ' tbActivated'; */ ?>">
      <?php if (isset($tabs[$i]['icon']) && !empty($tabs[$i]['icon'])): ?>
      <?php $has_icon = 1; ?>
      <span class="tb_icon <?php echo $tabs[$i]['icon']; ?>" style="font-size: <?php echo $tabs[$i]['icon_size']; ?>px;"></span>
      <?php else: ?>
      <?php $has_icon = 0; ?>
      <?php endif; ?>
      <?php if (isset($tabs[$i]['title'])): ?>
      <?php echo $tabs[$i]['title']; ?>
      <?php elseif ($subWidget->getLangTitle()): ?>
      <?php echo $subWidget->getLangTitle(); ?>
      <?php elseif (!isset($tabs[$i]['icon']) || !$tabs[$i]['icon']): ?>
      <?php echo 'Tab ' . ($i + 1); ?>
      <?php endif; ?>
    </span>
    <div id="<?php echo $id; ?>_tab" class="has_loading">
      <?php echo $subwidgets_content[$id]; ?>
    </div>
    <?php $i++; ?>
    <?php endif; ?>
    <?php endforeach; ?>
  </div>

  <script type="text/javascript">
  tbApp.onScriptLoaded(function() {

    var initSubwidget = function($tab, $panel) {
      var id = $panel.find("> div").attr("id");
      if (!$tab.data("initialized")) {
        if ("function" == typeof tbApp["init" + id]) {
          tbApp["init" + id]();
        }
        $tab.data("initialized", true);
      }
      if ("function" == typeof tbApp["exec" + id]) {
        tbApp["exec" + id]();
      }
    };

    <?php if ($group_type == 'tabs'): ?>

    $("#<?php echo $widget->getDomId(); ?>").find(".tbWidgetTabs").tabs({
      beforeLoad: function(event) {
        event.preventDefault();
      },
      beforeActivate: function(event, ui) {
          ui.newPanel.css('height', ui.oldPanel.height());
          $("#<?php echo $widget->getDomId(); ?>").css('overflow', 'hidden');
          if (!ui.newTab.hasClass("tbActivated")) {
              ui.newPanel.addClass("tb_loading");
              ui.newPanel.prepend('<i class="fa fa-circle-o-notch fa-spin"></i>');
          }
      },
      activate: function(event, ui) {
          initSubwidget(ui.newTab.find("a"), ui.newPanel);
          if (!ui.newTab.hasClass("tbActivated")) {
              setTimeout(function() {
                  ui.newTab.addClass("tbActivated");
                  ui.newPanel.find("> .fa-spin").remove();
                  ui.newPanel.removeClass("tb_loading");
                  ui.newPanel.find("> *").fadeOut(0).fadeIn(300);
                  var old_h = ui.newPanel.height();
                  ui.newPanel.css('height', '');

                  var new_h = ui.newPanel.height();
                  var diff  = new_h - old_h;

                  ui.newPanel.css('height', old_h);
                  ui.newPanel.animate({height: '+=' + diff}, 300, function(){
                      $("#<?php echo $widget->getDomId(); ?>").css('overflow', '');
                  });
              }, 250);
          } else {
              var old_h = ui.newPanel.height();
              ui.newPanel.css('height', '');

              var new_h = ui.newPanel.height();
              var diff  = new_h - old_h;

              ui.newPanel.css('height', old_h);
              ui.newPanel.animate({height: '+=' + diff}, 300, function(){
                  $("#<?php echo $widget->getDomId(); ?>").css('overflow', '');
              });
          }
      },
      create: function(event, ui) {
        initSubwidget(ui.tab.find("a"), ui.panel);
      },
      <?php if ($auto_height): ?>
      heightStyle: 'auto'
      <?php else: ?>
      heightStyle: 'content'
      <?php endif; ?>
      <?php echo $tabs_transition; ?>
    });
    <?php else: ?>

    $("#<?php echo $widget->getDomId(); ?>").find(".tbWidgetAccordion > .tb_accordion_content").accordion({
      beforeActivate: function(event, ui) {
          ui.newPanel.height(ui.oldPanel.height());
          if (!ui.newHeader.hasClass("tbActivated")) {
              ui.newPanel.addClass("tb_loading");
              ui.newPanel.prepend('<i class="fa fa-circle-o-notch fa-spin"></i>');
          }
      },
      activate: function(event, ui) {
          initSubwidget(ui.newHeader, ui.newPanel);
          if (!ui.newHeader.hasClass("tbActivated")) {
              setTimeout(function() {
                  ui.newHeader.addClass("tbActivated");
                  ui.newPanel.find("> .fa-spin").remove();
                  ui.newPanel.removeClass("tb_loading");
                  ui.newPanel.find("> *").fadeOut(0).fadeIn(300);
                  var old_h = ui.newPanel.height();
                  ui.newPanel.css('height', '');

                  var new_h = ui.newPanel.height();
                  var diff  = new_h - old_h;

                  ui.newPanel.css('height', old_h);
                  <?php if (!$auto_height): ?>
                  ui.newPanel.animate({height: '+=' + diff});
                  <?php endif; ?>
              }, 250);
          } else {
              var old_h = ui.newPanel.height();
              ui.newPanel.css('height', '');

              var new_h = ui.newPanel.height();
              var diff  = new_h - old_h;

              ui.newPanel.css('height', old_h);
              <?php if (!$auto_height): ?>
              ui.newPanel.animate({height: '+=' + diff});
              <?php endif; ?>
          }
      },
      create: function(event, ui) {
          initSubwidget(ui.header, ui.content);
      },
      header: 'span.tb_title',
      <?php if (!$auto_height): ?>autoHeight: false,<?php endif; ?>
      <?php if ($has_icon): ?>icons: false,<?php endif; ?>
      collapsible: true
    });
    <?php endif; ?>
  });
  </script>

</div>

