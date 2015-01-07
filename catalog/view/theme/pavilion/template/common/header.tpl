<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title><?php echo $title; ?></title>
<base href="<?php echo $tbData->base_httpsIf; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="generator" content="<?php echo $tbData['meta_generator']; ?>" />
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php require tb_modification($tbData['root_dir'] . '/catalog/view/theme/' . $tbData['basename'] . '/template/tb/header.tpl'); ?>
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>

<body class="<?php echo $class; ?> <?php echo $tbData->body_class; ?>">

<?php if($tbData->facebook['sdk_enabled']): ?>
<div id="fb-root"></div>
<script type="text/javascript">window.fbAsyncInit = function() { FB.init({<?php if($tbData->facebook['app_id']): ?>appId: '<?php echo $tbData->facebook['app_id']; ?>',<?php endif; ?> status: true, xfbml: true }); }; (function(d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (d.getElementById(id)) {return;} js = d.createElement(s); js.id = id; js.async=true; js.src = "//connect.facebook.net/<?php if($tbData->facebook['locale']) { echo $tbData->facebook['locale']; } else { echo 'en_US'; } ?>/all.js"; fjs.parentNode.insertBefore(js, fjs); }(document, 'script', 'facebook-jssdk'));</script>
<?php endif; ?>

<div id="wrapper" class="tb_row <?php echo $tbData->wrapper_class; ?>">

<div id="header_wrap">

  <header id="header" class="tb_row<?php echo $tbData->header_class . ' tb_style_' . $tbData->style['header_layout']; ?>">
    <div class="tb_wrap">
      <div class="tb_col_1_1">

        <?php // Logo Slot ----------------------------------------------------- ?>

        <?php $tbData->slotStart('common/header.logo'); ?>
        <?php if($tbData->style['text_logo'] == 1): ?>
        <a id="site_logo" class="tb_text" href="<?php echo $home; ?>">
          <?php echo $name; ?>
        </a>
        <?php elseif ($logo): ?>
        <a id="site_logo" href="<?php echo $home; ?>">
          <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
        </a>
        <?php endif; ?>
        <?php $tbData->slotStop(); ?>

        <?php // Search Slot -------------------------------------------------- ?>

        <?php $tbData->slotStart('common/header.search'); ?>
        <?php echo $search; ?>
        <?php $tbData->slotStop(); ?>

        <?php // Cart Menu Slot ----------------------------------------------- ?>

        <?php $tbData->slotStart('common/header.cart_menu'); ?>
        <?php if ($tbData->common['checkout_enabled']): ?>
        <div class="tb_widget_cart">
          <span class="tb_toggle tb_button fa-shopping-cart"></span>
          <?php echo $cart; ?>
        </div>
        <?php endif; ?>
        <?php $tbData->slotStop(); ?>

        <?php // Welcome Slot ------------------------------------------------- ?>

        <?php $tbData->slotStart('common/header.welcome'); ?>
        <div id="welcome_message">
          <p><?php if (!$logged) echo $tbData->text_welcome; else echo $tbData->text_logged; ?></p>
        </div>
        <?php $tbData->slotStop(); ?>

        <?php // Language Slot ------------------------------------------------ ?>

        <?php $tbData->slotStart('common/header.language'); ?>
        <?php echo $language; ?>
        <?php $tbData->slotStop(); ?>

        <?php // Currency Slot ------------------------------------------------ ?>

        <?php $tbData->slotStart('common/header.currency'); ?>
        <?php echo $currency; ?>
        <?php $tbData->slotStop(); ?>

        <?php // System Navigation Slot --------------------------------------- ?>

        <?php $tbData->slotStart('common/header.user_navigation'); ?>
        <div id="user_navigation">
          <nav class="tb_nav">
            <ul class="clearfix">
              <?php if ($tbData->common['wishlist_enabled']): ?>
              <li><a href="<?php echo $wishlist; ?>" id="wishlist_total"><?php echo $text_wishlist; ?></a></li>
              <?php endif; ?>
              <li class="menu_account"><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
              <?php if ($tbData->common['checkout_enabled']): ?>
              <li><a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a></li>
              <li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
              <?php endif; ?>
            </ul>
          </nav>
        </div>
        <?php $tbData->slotStop(); ?>

        <?php // Main Navigation Slot ----------------------------------------- ?>

        <?php $tbData->slotStart('common/header.main_navigation'); ?>
        <div id="main_navigation">
          <span class="tb_toggle tb_button fa-bars"></span>
          <?php if (!$tbData->system['compatibility_menu']): ?>
          <nav class="tb_nav">
            <?php echo $tbData->menuHTML; ?>
          </nav>
          <?php else: ?>
          <?php if ($categories) { ?>
          <nav id="menu" class="navbar">
            <ul class="nav navbar-nav">
              <?php foreach ($categories as $category) { ?>
              <?php if ($category['children']) { ?>
              <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                <div class="dropdown-menu">
                  <div class="dropdown-inner">
                    <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                    <ul class="list-unstyled">
                      <?php foreach ($children as $child) { ?>
                      <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                      <?php } ?>
                    </ul>
                    <?php } ?>
                  </div>
                  <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
              </li>
              <?php } else { ?>
              <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
              <?php } ?>
              <?php } ?>
            </ul>
          </nav>
          <?php } ?>
          <?php endif; ?>
        </div>

        <?php if ($tbData->style['header_sticky']): ?>
        <script type="text/javascript">
        tbApp.onScriptLoaded(function() {
          sticky_header(<?php echo $tbData->style['sticky_logo_show']; ?>);
        });
        </script>
        <?php endif; ?>
        <?php $tbData->slotStop(); ?>

        <?php // Separator border --------------------------------------------- ?>

        <?php $tbData->slotStart('common/header.separator_border'); ?>
        <span class="clear tb_border_str_2"></span>
        <?php $tbData->slotStop(); ?>

        <?php // Separator plain ---------------------------------------------- ?>

        <?php $tbData->slotStart('common/header.separator_plain'); ?>
        <span class="clear"></span>
        <?php $tbData->slotStop(); ?>

        <?php // Header Layout -------------------------------------------- ?>

        <?php foreach ($tbData->header_layout['rows'] as $row): ?>
        <div class="tb_row<?php echo $row['class']; ?>">
          <div class="tb_wrap">
            <?php foreach ($row['columns'] as $column): ?>
            <div class="tb_col_<?php echo $column['width']; ?><?php echo $column['class']; ?>">
              <?php foreach ($column['slots'] as $slot_name): ?>
              <?php $tbData->slotEcho('common/header.' . $slot_name); ?>
              <?php endforeach; ?>
            </div>
            <?php endforeach; ?>
          </div>
        </div>
        <?php endforeach; ?>

      </div>
    </div>
  </header>
  <!-- end of header -->



  <?php $tbData->slotStart('common/header.main_navigation_row'); ?>
  <!-- ********************** -->
  <!--    M A I N   N A V     -->
  <!-- ********************** -->
  <section id="main_navigation_row" class="tb_row<?php echo $tbData->menu_class; ?>">
    <div class="tb_wrap">
      <div class="tb_col_1_1">
        <div class="tb_row tb_row_fixed">
          <div class="tb_wrap">
            <div class="tb_col_1_1">
              <?php $tbData->slotEcho('common/header.main_navigation'); ?>
              <?php if ($tbData->common['checkout_enabled'] && $tbData->menu_row_cart_show): ?>
              <?php $tbData->slotEcho('common/header.cart_menu'); ?>
              <?php endif; ?>
              <?php if ($tbData->menu_row_search_show): ?>
              <?php $tbData->slotEcho('common/header.search'); ?>
              <?php endif; ?>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- end of main navigation -->
  <?php $tbData->slotStop($tbData->menu_row_hide); ?>

</div>


  <?php if (isset($common_error)): ?>
  <!-- ********************** -->
  <!--  S E R V E R   M S G   -->
  <!-- ********************** -->
  <section class="tb_row">
    <div class="tb_wrap">
      <div class="tb_col_1_1">
        <div class="tb_server_msg">
          <?php echo $common_error; ?>
        </div>
      </div>
    </div>
  </section>
  <!-- end of server messages -->
  <?php endif; ?>

<!-- END_COMMON_HEADER -->