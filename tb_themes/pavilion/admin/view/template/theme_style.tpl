<div class="tb_tabs tb_subpanel_tabs">

  <div class="tb_tabs_nav">
    <ul class="clearfix">
      <li aria-controls="style_settings_common"><a <?php echo $tbGet->styleController->getSectionAttributes('common', 'style_settings_common'); ?> section="common">Common</a></li>
      <li aria-controls="style_settings_wrapper"><a <?php echo $tbGet->styleController->getSectionAttributes('wrapper', 'style_settings_wrapper'); ?> section="wrapper">Wrapper</a></li>
      <li aria-controls="style_settings_header"><a <?php echo $tbGet->styleController->getSectionAttributes('header', 'style_settings_header'); ?> section="header">Header</a></li>
      <li aria-controls="style_settings_menu"><a <?php echo $tbGet->styleController->getSectionAttributes('menu', 'style_settings_menu'); ?> section="menu">Menu</a></li>
      <li aria-controls="style_settings_intro"><a <?php echo $tbGet->styleController->getSectionAttributes('intro', 'style_settings_intro'); ?> section="intro">Intro</a></li>
      <li aria-controls="style_settings_content"><a <?php echo $tbGet->styleController->getSectionAttributes('content', 'style_settings_content'); ?> section="content">Content wrap</a></li>
      <li aria-controls="style_settings_footer"><a <?php echo $tbGet->styleController->getSectionAttributes('footer', 'style_settings_footer'); ?> section="footer">Footer</a></li>
      <li aria-controls="style_settings_bottom"><a <?php echo $tbGet->styleController->getSectionAttributes('bottom', 'style_settings_bottom'); ?> section="bottom">Bottom</a></li>
      <?php $tbData->slotFlag('tb\theme_style.tabs.navigation'); ?>
    </ul>
  </div>

  <div id="style_settings_common" class="tb_subpanel">
    <?php $tbGet->styleController->renderSection('common'); ?>
    <div class="s_submit clearfix">
      <a class="s_button s_red s_h_40 tb_cp_form_submit"><?php echo $text_button_save_settings; ?></a>
    </div>
  </div>

  <div id="style_settings_wrapper" class="tb_subpanel tb_has_sidebar">
    <?php $tbGet->styleController->renderSection('wrapper'); ?>
  </div>

  <div id="style_settings_header" class="tb_subpanel tb_has_sidebar" data-area_id="area_header" data-area_prefix="area">
    <?php $tbGet->styleController->renderSection('header'); ?>
  </div>

  <div id="style_settings_menu" class="tb_subpanel tb_has_sidebar">
    <?php $tbGet->styleController->renderSection('menu'); ?>
  </div>

  <div id="style_settings_intro" class="tb_subpanel tb_has_sidebar">
    <?php $tbGet->styleController->renderSection('intro'); ?>
  </div>

  <div id="style_settings_content" class="tb_subpanel tb_has_sidebar">
    <?php $tbGet->styleController->renderSection('content'); ?>
  </div>

  <div id="style_settings_footer" class="tb_subpanel tb_has_sidebar">
    <?php $tbGet->styleController->renderSection('footer'); ?>
  </div>

  <div id="style_settings_bottom" class="tb_subpanel tb_has_sidebar">
    <?php $tbGet->styleController->renderSection('bottom'); ?>
  </div>

  <?php $tbData->slotFlag('tb\theme_style.tabs.content'); ?>

</div>

<script type="text/javascript">
(function ($, tbApp) {

var initialized_sections = [];

$(document).ready(function() {

  $('#style_common_header_layout').bind('change', function() {
      if ($(this).val() == 3 || $(this).val() == '2_1' || $(this).val() == '2_2' || $(this).val() == '2_3' || $(this).val() == '2_4') {
          $('#tb_cp').removeClass('color_header_welcome_disabled');
          $('#tb_cp').addClass('color_header_top_bar_disabled');
      } else {
          $('#tb_cp').addClass('color_header_welcome_disabled');
          $('#tb_cp').removeClass('color_header_top_bar_disabled');
      }
  }).trigger("change");

  $('#style_common_header_layout').bind('change', function() {
      if ($(this).val() == '2_1' || $(this).val() == '2_2' || $(this).val() == '2_3' || $(this).val() == '2_4' || $(this).val() == '2_5') {
          $('#style_common_menu_height_wrap').removeClass('tb_disabled');
          $('#style_common_menu_padding_wrap').removeClass('tb_disabled');
      } else {
          $('#style_common_menu_height_wrap').addClass('tb_disabled');
          $('#style_common_menu_padding_wrap').addClass('tb_disabled');
      }
  }).trigger("change");

  $('#style_common_header_text_logo').bind('change', function() {
      $('#tb_cp').toggleClass('color_header_site_logo_disabled', !$(this).is(":checked"));
  }).trigger("change");

  $('#style_common_header_sticky').bind('change', function() {
    $('#colors_group_sticky').toggle($(this).is(":checked"));
  }).trigger("change");

  var initSection = function($tab, $panel) {

    var section = $tab.find("a").attr("section");

    if (!section || -1 != initialized_sections.indexOf(section)) {
      return;
    }

    var $section = $("#style_settings_" + section);

    if (!/[\S]/.test($section.html())) {
      return;
    }

    initialized_sections.push(section);

    if (section == "common") {
      beautifyForm($panel);
    } else {
      if (section == "content" || section == "footer" || section == "intro") {
        tbApp.initStyleArea(section);
      } else {
        $section.find("> .tb_tabs").tabs({
          activate: function(event, ui) {
            tbApp.cookie.set("tbStyle" + section + "Tabs", ui.newTab.index());
          },
          active: tbApp.cookie.get("tbStyle" + section + "Tabs", 0),
          create: function() {
            $panel.find("> .tb_tabs > .tb_tabs_nav").first().stickySidebar({
              padding: 30
            });
          }
        });

        tbApp.initBoxShadow(section, "style[" + section + "]");
        tbApp.initBackground(section, "style[" + section + "]");
        tbApp.initBorder(section);
        
        beautifyForm($panel);
        tbApp.updatePreviewBox(section);
      }
    }
  };

  $("#style_settings").find("> .tb_tabs").tabs({
    beforeLoad: function( event, ui ) {
      if (ui.tab.data("loaded")) {
        event.preventDefault();

        return;
      }

      $("#loading_screen").fadeOut("normal");
      $("html").removeClass('blocked');
      ui.panel.addClass("tb_loading");

      ui.jqXHR.success(function() {
        if ($sReg.get('/tb/Theme-Machine-Name') != ui.jqXHR.getResponseHeader("Theme-Machine-Name")) {
          $("body").eq(0).empty();
          location.reload();
        }
        ui.tab.data("loaded", true);
      });
    },
    activate: function(event, ui) {
      initSection(ui.newTab, ui.newPanel);
      tbApp.cookie.set("tbStyleTabs", ui.newTab.index());
    },
    active: tbApp.cookie.get("tbStyleTabs", 0),
    create: function(event, ui) {
      initSection(ui.tab, ui.panel);
    },
    load: function(event, ui) {
      initSection(ui.tab, ui.panel);
      $(ui.panel).removeClass("tb_loading");
    }
  });

});

var initTooltip = function($container, tooltipClass) {
  var options = {
    items: ".tbTooltipItem",
    position: {
      my: "left-1 top",
      at:"right top"
    },
    content: function() {
      return $(this).find(".tbTooltipContent").html();
    }
  };
  if (typeof tooltipClass != "undefined") {
    options.tooltipClass = tooltipClass;
  }
  $container.tooltip(options);
};

})(jQuery, tbApp);

</script>
