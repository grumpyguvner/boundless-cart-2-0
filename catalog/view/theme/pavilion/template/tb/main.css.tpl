<?php
$lang_dir            = $tbData->language_direction;
$base                = $tbData->fonts['body']['line-height'];
$base_font_size      = $tbData->fonts['body']['size'];
$base_h2_size        = isset($tbData->fonts['h2']['size']) ? $tbData->fonts['h2']['size'] : 16;
$submit_button_size  = 36;
$color_bg_str_1      = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.05)';
$color_bg_str_2      = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.1)';
$color_bg_str_3      = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.2)';
$color_bg_str_4      = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.3)';
$color_text_str_1    = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.2)';
$color_text_str_2    = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.3)';
$color_text_str_3    = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.4)';
$color_text_str_4    = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.6)';
$color_text_str_5    = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.8)';
$color_border_str_1  = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.1)';
$color_border_str_2  = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.2)';
$color_border_str_3  = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.4)';
$color_border_str_4  = 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main']['text']['color'], true) . ', 0.6)';
$menu_size           = isset($tbData->fonts['main_navigation']['size']) ? $tbData->fonts['main_navigation']['size'] : $base;
$menu_height         = $tbData->style['menu_height'];
$menu_padding        = $tbData->style['menu_inner_padding'];
$menu_spacing        = $tbData->style['menu_spacing'];
$logo_max_w          = $tbData->style['logo_max_w'];
$logo_max_h          = $tbData->style['logo_max_h'];
$sticky_logo_max_w   = $tbData->style['sticky_logo_max_w'];
$sticky_logo_max_h   = $tbData->style['sticky_logo_max_h'];
?>



/*****************************************************/
/*****   EXTERNAL    *********************************/
/*****************************************************/

<?php echo $external_css; ?>



/*****************************************************/
/*****   R E S E T   *********************************/
/*****************************************************/

*, body, button, input, textarea, select, table, td, th {
  margin: 0;
  padding: 0;
  line-height: inherit;
  font-family: inherit;
  font-size: 100%;
}
html {
  -webkit-text-size-adjust: 100%;
  -ms-text-size-adjust: 100%;
}
body:before {
  content: '';
  display: table;
}
img {
  max-width: 100%;
  line-height: 0;
  font-size: 0;
  -ms-interpolation-mode: bicubic;
}
img:not([height]) {
  height: auto;
}
img,
a img {
  border: 0;
}
a {
  text-decoration: none;
}
a:active {
  background: transparent;
}
a:not([href]) {
  cursor: default;
}
a:before,
a:after
{
  outline: 0 none !important;
}
ul {
  list-style: none;
}
table {
  width: 100%;
  max-width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
  table-layout: fixed;
}
th.left,
th.right,
td.left,
td.right
{
  float: none;
}
a, button, input[type=submit], input[type=reset] {
  cursor: pointer;
}
sup,
sub
{
  line-height: 0;
  font-size: 75%;
}
hr {
  height: 0;
  border: none;
  border-bottom: 1px solid;
  opacity: 0.2;
}
button,
input[type=date],
input[type=time],
input[type=datetime],
input[type=search],
input[type=number],
input[type=submit],
input[type=reset],
input[type="search"]::-webkit-search-cancel-button,
input[type="search"]::-webkit-search-decoration,
input[type=number]::-webkit-inner-spin-button,
input[type=number]::-webkit-outer-spin-button
{
  -webkit-appearance: none;
  -moz-appearance: none;
}
input[type=button]::-moz-focus-inner,
input[type=submit]::-moz-focus-inner,
input[type=reset]::-moz-focus-inner,
button::-moz-focus-inner {
  padding: 0;
  border: 0;
}
abbr {
  cursor: help;
}
iframe,
article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
nav,
section,
summary
{
  display: block;
}

/*** Clearfix ***/

.clearfix:before,
.clearfix:after,
[class*="tb_row_"]:before,
[class*="tb_row_"]:after,
.tb_wrap:after,
.tb_wrap:before,
.tb_item:before,
.tb_item:after,
[class*="tb_widget_"]:before,
[class*="tb_widget_"]:after
{
  content: "";
  display: table;
}
.clearfix:after,
[class*="tb_row_"]:after,
.tb_wrap:after,
.tb_item:after,
[class*="tb_widget_"]:after
{
  clear: both;
}

/*** Bootstrap reset ***/

h1, h2, h3, h4, h5, h6
{
  margin-top: 0;
}
dt, dd {
  line-height: inherit;
}

/*** Jquery UI reset ***/

.tb_tabs,
.tb_tabs > .tb_tabs_nav ul,
.tb_tabs > .tb_tabs_nav li,
.tb_tabs > .tb_tabs_nav li a,
.tb_tabs > .tb_tabs_nav li.ui-tabs-active,
.tb_tabs > .tb_tabs_content .ui-tabs-panel,
.tb_accordion,
.tb_accordion .ui-accordion-header,
.tb_accordion .ui-accordion-header .ui-accordion-header-icon,
.tb_accordion .ui-accordion-icons,
.tb_accordion .ui-accordion-content
{
  margin: 0;
  padding: 0;
}
.tb_tabs .ui-icon,
.tb_accordion .ui-icon
{
  position: static;
  display: inline;
  width: auto;
  height: auto;
  text-indent: 0;
}



/*****************************************************/
/******   B O X    M O D E L   ***********************/
/*****************************************************/

.tb_row,
.tb_wrap,
[class*="tb_col_"],
.tb_item,
.swiper-slide,
.tb_button,
.button,
.btn,
button,
label[class*="checkbox"],
label[class*="radio"],
[type=button],
[type=submit],
.pagination a,
.pagination b,
.tb_listing.tb_inline_view .tb_item,
.tb_megamenu > .tb_submenu > ul > li,
.tb_megamenu .tb_category_info,
.tb_megamenu .tb_category_info + ul,
.tb_megamenu .tb_category_brands,
.tb_megamenu .tb_category_brands + ul,
.tb_slider_pagination span,
blockquote,
input,
select,
textarea,
th,
td,
.tb_widget_site_search,
.tb_gallery.tb_fullscreen
{
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
}



/*****************************************************/
/******   B A S I C    S T Y L E S   *****************/
/*****************************************************/

body {
  font: 13px/20px "Lucida Sans Unicode", "Lucida Grande", Arial, sans-serif;
  <?php if ($lang_dir == 'rtl') echo 'direction: rtl;'; ?>
  overflow-x: hidden;
}
h1,
h2,
.h2,
legend,
.box-heading,
.tb_widget_open_cart .panel-heading
{
  margin-bottom: <?php echo $base; ?>px;
  font-weight: normal;
  font-style: normal;
}
h1 {
  font-size: 26px;
}
h2,
.h2,
legend,
.ui-tabs-nav,
.box-heading,
.tb_widget_open_cart .panel-heading
{
  font-size: 16px;
}
h3,
.h3
{
  margin-bottom: <?php echo $base * 0.5; ?>px;
  font-size: 15px;
  font-weight: normal;
  font-style: normal;
}
h4,
.h4
{
  margin-bottom: <?php echo $base * 0.5; ?>px;
  font-size: 14px;
  font-weight: bold;
  font-style: normal;
}
h5 {
  font-size: 12px;
  font-weight: bold;
  font-style: normal;
}
h6 {
  font-size: 11px;
}
dt {
  <?php if ($lang_dir == 'ltr'): ?>
  clear: left;
  float: left;
  margin-right: 10px;
  <?php else: ?>
  clear: right;
  float: right;
  margin-left: 10px;
  <?php endif; ?>
  font-weight: bold;
}
p small {
  font-size: 75%;
}
blockquote,
p,
ul,
ol,
dl,
address,
blockquote,
table,
hr
{
  margin-bottom: <?php echo $base; ?>px;
}
blockquote:last-child,
p:last-child,
ul:last-child,
ol:last-child,
dl:last-child,
address:last-child,
blockquote:last-child,
table:last-child,
hr:last-child
{
  margin-bottom: 0;
}
table img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
p img,
a img
{
  display: inline-block;
  vertical-align: top;
}
*::-moz-selection,
*::-webkit-selection,
::selection
{
  color: #fff;
}

p img.left {
  margin: 0 <?php echo $base; ?>px <?php echo $base; ?>px 0;
}
p img.right {
  margin: 0 0 <?php echo $base; ?>px <?php echo $base; ?>px;
}
p > img.left:last-child:not([style*="margin-bottom"]), p > img.right:last-child:not([style*="margin-bottom"]) {
  margin-bottom: 0 !important;
}
p:empty,
ul:empty
{
  display: none;
}
a {
  -webkit-transition: color 0.4s, background-color 0.4s;
  transition: color 0.4s, background-color 0.4s;
}

i.fa { vertical-align: initial; }

/*****************************************************/
/******   L A Y O U T   ******************************/
/*****************************************************/

.tb_mb_-50 {margin-bottom: -50px;}
.tb_mb_-45 {margin-bottom: -45px;}
.tb_mb_-40 {margin-bottom: -40px;}
.tb_mb_-35 {margin-bottom: -35px;}
.tb_mb_-30 {margin-bottom: -30px;}
.tb_mb_-25 {margin-bottom: -25px;}
.tb_mb_-20 {margin-bottom: -20px;}
.tb_mb_-15 {margin-bottom: -15px;}
.tb_mb_-10 {margin-bottom: -10px;}
.tb_mb_-5  {margin-bottom: -5px; }
.tb_mb_0  {margin-bottom: 0;   }
.tb_mb_5  {margin-bottom: 5px; }
.tb_mb_10 {margin-bottom: 10px;}
.tb_mb_15 {margin-bottom: 15px;}
.tb_mb_20 {margin-bottom: 20px;}
.tb_mb_25 {margin-bottom: 25px;}
.tb_mb_30 {margin-bottom: 30px;}
.tb_mb_35 {margin-bottom: 35px;}
.tb_mb_40 {margin-bottom: 40px;}
.tb_mb_45 {margin-bottom: 45px;}
.tb_mb_50 {margin-bottom: 50px;}
.tb_ml_-50 {margin-left: -50px;}
.tb_ml_-45 {margin-left: -45px;}
.tb_ml_-40 {margin-left: -40px;}
.tb_ml_-35 {margin-left: -35px;}
.tb_ml_-30 {margin-left: -30px;}
.tb_ml_-25 {margin-left: -25px;}
.tb_ml_-20 {margin-left: -20px;}
.tb_ml_-15 {margin-left: -15px;}
.tb_ml_-10 {margin-left: -10px;}
.tb_ml_-5  {margin-left: -5px; }
.tb_ml_0   {margin-left: 0;   }
.tb_ml_5   {margin-left: 5px; }
.tb_ml_10  {margin-left: 10px;}
.tb_ml_15  {margin-left: 15px;}
.tb_ml_20  {margin-left: 20px;}
.tb_ml_25  {margin-left: 25px;}
.tb_ml_30  {margin-left: 30px;}
.tb_ml_35  {margin-left: 35px;}
.tb_ml_40  {margin-left: 40px;}
.tb_ml_45  {margin-left: 45px;}
.tb_ml_50  {margin-left: 50px;}
.tb_mr_-50 {margin-right: -50px;}
.tb_mr_-45 {margin-right: -45px;}
.tb_mr_-40 {margin-right: -40px;}
.tb_mr_-35 {margin-right: -35px;}
.tb_mr_-30 {margin-right: -30px;}
.tb_mr_-25 {margin-right: -25px;}
.tb_mr_-20 {margin-right: -20px;}
.tb_mr_-15 {margin-right: -15px;}
.tb_mr_-10 {margin-right: -10px;}
.tb_mr_-5  {margin-right: -5px; }
.tb_mr_0   {margin-right: 0;   }
.tb_mr_5   {margin-right: 5px; }
.tb_mr_10  {margin-right: 10px;}
.tb_mr_15  {margin-right: 15px;}
.tb_mr_20  {margin-right: 20px;}
.tb_mr_25  {margin-right: 25px;}
.tb_mr_30  {margin-right: 30px;}
.tb_mr_35  {margin-right: 35px;}
.tb_mr_40  {margin-right: 40px;}
.tb_mr_45  {margin-right: 45px;}
.tb_mr_50  {margin-right: 50px;}
.tb_mt_-50 {margin-top: -50px; }
.tb_mt_-45 {margin-top: -45px; }
.tb_mt_-40 {margin-top: -40px; }
.tb_mt_-35 {margin-top: -35px; }
.tb_mt_-30 {margin-top: -30px; }
.tb_mt_-25 {margin-top: -25px; }
.tb_mt_-20 {margin-top: -20px; }
.tb_mt_-15 {margin-top: -15px; }
.tb_mt_-10 {margin-top: -10px; }
.tb_mt_-5  {margin-top: -5px;  }
.tb_mt_0  {margin-top: 0;}
.tb_mt_5  {margin-top: 5px;}
.tb_mt_10 {margin-top: 10px;}
.tb_mt_15 {margin-top: 15px;}
.tb_mt_20 {margin-top: 20px;}
.tb_mt_25 {margin-top: 25px;}
.tb_mt_30 {margin-top: 30px;}
.tb_mt_35 {margin-top: 35px;}
.tb_mt_40 {margin-top: 40px;}
.tb_mt_45 {margin-top: 45px;}
.tb_mt_50 {margin-top: 50px;}

.tb_pt_5,  .tb_row.tb_pt_5  > .tb_wrap {padding-top: 5px;}
.tb_pt_10, .tb_row.tb_pt_10 > .tb_wrap {padding-top: 10px;}
.tb_pt_15, .tb_row.tb_pt_15 > .tb_wrap {padding-top: 15px;}
.tb_pt_20, .tb_row.tb_pt_20 > .tb_wrap {padding-top: 20px;}
.tb_pt_25, .tb_row.tb_pt_25 > .tb_wrap {padding-top: 25px;}
.tb_pt_30, .tb_row.tb_pt_30 > .tb_wrap {padding-top: 30px;}
.tb_pt_35, .tb_row.tb_pt_35 > .tb_wrap {padding-top: 35px;}
.tb_pt_40, .tb_row.tb_pt_40 > .tb_wrap {padding-top: 40px;}
.tb_pt_45, .tb_row.tb_pt_45 > .tb_wrap {padding-top: 45px;}
.tb_pt_50, .tb_row.tb_pt_50 > .tb_wrap {padding-top: 50px;}
.tb_pr_0  {padding-right: 0;}
.tb_pr_5  {padding-right: 5px;}
.tb_pr_10 {padding-right: 10px;}
.tb_pr_15 {padding-right: 15px;}
.tb_pr_20 {padding-right: 20px;}
.tb_pr_25 {padding-right: 25px;}
.tb_pr_30 {padding-right: 30px;}
.tb_pr_35 {padding-right: 35px;}
.tb_pr_40 {padding-right: 40px;}
.tb_pr_45 {padding-right: 45px;}
.tb_pr_50 {padding-right: 50px;}
.tb_pb_0  {padding-bottom: 0;}
.tb_pb_5,  .tb_row.tb_pb_5  > .tb_wrap {padding-bottom: 5px;}
.tb_pb_10, .tb_row.tb_pb_10 > .tb_wrap {padding-bottom: 10px;}
.tb_pb_15, .tb_row.tb_pb_15 > .tb_wrap {padding-bottom: 15px;}
.tb_pb_20, .tb_row.tb_pb_20 > .tb_wrap {padding-bottom: 20px;}
.tb_pb_25, .tb_row.tb_pb_25 > .tb_wrap {padding-bottom: 25px;}
.tb_pb_30, .tb_row.tb_pb_30 > .tb_wrap {padding-bottom: 30px;}
.tb_pb_35, .tb_row.tb_pb_35 > .tb_wrap {padding-bottom: 35px;}
.tb_pb_40, .tb_row.tb_pb_40 > .tb_wrap {padding-bottom: 40px;}
.tb_pb_45, .tb_row.tb_pb_45 > .tb_wrap {padding-bottom: 45px;}
.tb_pb_50, .tb_row.tb_pb_50 > .tb_wrap {padding-bottom: 50px;}
.tb_pl_0  {padding-left: 0;}
.tb_pl_5  {padding-left: 5px;}
.tb_pl_10 {padding-left: 10px;}
.tb_pl_15 {padding-left: 15px;}
.tb_pl_20 {padding-left: 20px;}
.tb_pl_25 {padding-left: 25px;}
.tb_pl_30 {padding-left: 30px;}
.tb_pl_35 {padding-left: 35px;}
.tb_pl_40 {padding-left: 40px;}
.tb_pl_45 {padding-left: 45px;}
.tb_pl_50 {padding-left: 50px;}

.tb_row,
.tb_wrap
{
  /* clear: both; */
}
body > .tb_row_fixed,
body > .tb_row_full > .tb_row_fixed,
body > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed,
body > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full,
body > .tb_row_full > .tb_row_full > .tb_wrap > .tb_col_1_1:not(.tb_main_col):not(.tb_side_col) > .tb_row_full > .tb_wrap,
body > .tb_row_full > #header_wrap > .tb_row_fixed,
body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed,
body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full,
body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > .tb_col_1_1 > .tb_row_full > .tb_wrap
{
  margin-left: auto;
  margin-right: auto;
}
body > .tb_row_full,
body > .tb_row_full > .tb_row_full,
body > .tb_row_full > .tb_row_full > .tb_wrap > .tb_col_1_1:not(.tb_main_col):not(.tb_side_col) > .tb_row_full,
body > .tb_row_full > #header_wrap > .tb_row_full,
body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > .tb_col_1_1 > .tb_row_full
{
  padding-left: 0;
  padding-right: 0;
}
.tb_row {
  padding-top: 0;
  padding-bottom: 0;
}
.tb_trow {
  display: table-row;
}
.tb_row_fixed {
  max-width: 1000px;
}
.tb_width_1200 .tb_row_fixed {
  max-width: 1200px;
}
.tb_wrap {
  padding-right: 30px;
}
.tb_row_full > .tb_wrap {
  max-width: 1060px;
}
.tb_width_1200 .tb_row_full > .tb_wrap {
  max-width: 1260px;
}
.tb_row_fixed .tb_wrap {
  max-width: none;
  margin-left: -30px;
  margin-right: -30px;
}
[class*="tb_col_"] {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  min-height: 1px;
  padding-left: 30px;
}
.tb_row.tb_reverse > .tb_wrap > [class*="tb_col_"] {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
}
.tb_row_separate > .tb_wrap,
.tb_row_table
{
  display: table;
  width: 100%;
}
.tb_row_table.tb_row_full > .tb_wrap {
  /* position: relative; */
}
.tb_row_separate > .tb_wrap:before,
.tb_row_separate > .tb_wrap:after
{
  content: none;
}
.tb_row_separate > .tb_wrap {
  table-layout: fixed;
  margin-left: auto !important;
  margin-right: auto !important;
  padding: 0;
}
.tb_row_separate > .tb_wrap > [class*="tb_col_"] {
  margin: 0;
  padding: 0;
}
.tb_row_separate > .tb_wrap > [class*="tb_col_"] {
  display: table-cell;
  float: none;
  vertical-align: top;
}
.tb_row_separate > .tb_wrap > [class*="tb_col_"] + [class*="tb_col_"] {
  <?php if ($lang_dir == 'ltr'): ?>
  border-left-width: 1px;
  border-left-style: solid;
  <?php else: ?>
  border-right-width: 1px;
  border-right-style: solid;
  <?php endif; ?>
}
.tb_row_separate.tb_plain > .tb_wrap > [class*="tb_col_"] + [class*="tb_col_"] {
  border-width: 0;
  border-style: none;
}
.tb_ip_10 > .tb_wrap > [class*="tb_col_"] { padding: 10px !important; }
.tb_ip_20 > .tb_wrap > [class*="tb_col_"] { padding: 20px !important; }
.tb_ip_30 > .tb_wrap > [class*="tb_col_"] { padding: 30px !important; }
.tb_ip_40 > .tb_wrap > [class*="tb_col_"] { padding: 40px !important; }
.tb_ip_50 > .tb_wrap > [class*="tb_col_"] { padding: 50px !important; }

.tb_row_table > .tb_wrap > [class*="tb_col_"] {
  display: table-cell;
  float: none;
}
.tb_row_separate > .tb_wrap > .tb_col_auto img,
.tb_row_table > .tb_wrap > .tb_col_auto img,
.tb_row_no_max_width[class] > .tb_wrap
{
  max-width: none;
}
.tb_row_no_max_width > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed,
.tb_row_no_max_width > .tb_wrap > [class*="tb_col_"] > .tb_row_full > .tb_wrap
{
  margin-left: auto;
  margin-right: auto;
}

.tb_gut_0 >  .tb_wrap { padding-right: 0; margin-left: auto; margin-right: auto; }
.tb_gut_10 > .tb_wrap { padding-right: 10px; }
.tb_gut_20 > .tb_wrap { padding-right: 20px; }
.tb_gut_30 > .tb_wrap { padding-right: 30px; }
.tb_gut_40 > .tb_wrap { padding-right: 40px; }
.tb_gut_50 > .tb_wrap { padding-right: 50px; }
.tb_row_full.tb_gut_0  > .tb_wrap { max-width: 1000px; }
.tb_row_full.tb_gut_10 > .tb_wrap { max-width: 1020px; }
.tb_row_full.tb_gut_20 > .tb_wrap { max-width: 1040px; }
.tb_row_full.tb_gut_30 > .tb_wrap { max-width: 1060px; }
.tb_row_full.tb_gut_40 > .tb_wrap { max-width: 1080px; }
.tb_row_full.tb_gut_50 > .tb_wrap { max-width: 1100px; }
.tb_width_1200 .tb_row_full.tb_gut_0  > .tb_wrap { max-width: 1200px; }
.tb_width_1200 .tb_row_full.tb_gut_10 > .tb_wrap { max-width: 1220px; }
.tb_width_1200 .tb_row_full.tb_gut_20 > .tb_wrap { max-width: 1240px; }
.tb_width_1200 .tb_row_full.tb_gut_30 > .tb_wrap { max-width: 1260px; }
.tb_width_1200 .tb_row_full.tb_gut_40 > .tb_wrap { max-width: 1280px; }
.tb_width_1200 .tb_row_full.tb_gut_50 > .tb_wrap { max-width: 1300px; }
.tb_gut_0  > .tb_wrap { margin-left: 0;     margin-right: 0;     }
.tb_gut_10 > .tb_wrap { margin-left: -10px; margin-right: -10px; }
.tb_gut_20 > .tb_wrap { margin-left: -20px; margin-right: -20px; }
.tb_gut_30 > .tb_wrap { margin-left: -30px; margin-right: -30px; }
.tb_gut_40 > .tb_wrap { margin-left: -40px; margin-right: -40px; }
.tb_gut_50 > .tb_wrap { margin-left: -50px; margin-right: -50px; }
.tb_gut_0  > .tb_wrap > [class*="tb_col_"] { padding-left: 0; }
.tb_gut_10 > .tb_wrap > [class*="tb_col_"] { padding-left: 10px; }
.tb_gut_20 > .tb_wrap > [class*="tb_col_"] { padding-left: 20px; }
.tb_gut_40 > .tb_wrap > [class*="tb_col_"] { padding-left: 40px; }
.tb_gut_50 > .tb_wrap > [class*="tb_col_"] { padding-left: 50px; }

.tb_col_1_1,
.tb_col_2_2,
.tb_col_3_3,
.tb_col_4_4,
.tb_col_5_5 { width:100%; }
.tb_col_1_2 { width:50%; }
.tb_col_1_3 { width:33.33333%; }
.tb_col_2_3 { width:66.66666%; }
.tb_col_1_4 { width:25%; }
.tb_col_3_4 { width:75%; }
.tb_col_1_5 { width:20%; }
.tb_col_2_5 { width:40%; }
.tb_col_3_5 { width:60%; }
.tb_col_4_5 { width:80%; }
.tb_col_1_6 { width:16.656%; }
.tb_col_5_6 { width:83.33%; }
.tb_col_1_8 { width:12.5%; }
.tb_col_3_8 { width:37.5%; }
.tb_col_5_8 { width:62.5%; }
.tb_col_7_8 { width:87.5%; }
.tb_col_1_12 { width:8.3333%; }
.tb_col_5_12 { width:41.6666%; }
.tb_col_7_12 { width:58.3333%; }
.tb_col_11_12 { width:91.6666%; }
.tb_col_1_24 { width:4.1666%; }
.tb_col_5_24 { width:20.8333%; }
.tb_col_7_24 { width:29.1666%; }
.tb_col_11_24 { width:45.8333%; }
.tb_col_13_24 { width:54.1666%; }
.tb_col_17_24 { width:70.8333%; }
.tb_col_19_24 { width:79.1666%; }
.tb_col_23_24 { width:95.8333%; }

body > .tb_row_full > .tb_row_full > .tb_wrap,
body > .tb_row_full > .tb_row_full > .tb_wrap > .tb_col_1_1,
body > .tb_row_fixed > .tb_row_full > .tb_wrap,
body > .tb_row_fixed > .tb_row_full > .tb_wrap > .tb_col_1_1,
body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap,
body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > .tb_col_1_1,
body > .tb_row_fixed > #header_wrap > .tb_row_full > .tb_wrap,
body > .tb_row_fixed > #header_wrap > .tb_row_full > .tb_wrap > .tb_col_1_1
{
  float: none;
  width: auto;
  max-width: none;
  margin-left: 0;
  margin-right: 0;
  padding-left: 0;
  padding-right: 0;
}



/*****************************************************/
/******   C O M M O N    S T Y L E S   ***************/
/*****************************************************/

span.required       { font-weight: bold; color: red; }
.tb_small           { font-size: 10px; }
.inline             { display: inline !important; }
a img.inline        { vertical-align: middle; }
.align_left, th.left, td.left    { <?php if ($lang_dir == 'ltr'): ?>text-align: left;<?php else: ?>text-align: right;<?php endif; ?> }
.align_right, th.right, td.right { <?php if ($lang_dir == 'ltr'): ?>text-align: right;<?php else: ?>text-align: left;<?php endif; ?> }
.align_center       { text-align: center; }
.align_justify      { text-align: justify; }
.overflow_text      { overflow: auto; overflow-x: hidden; }
.valign_top         { vertical-align: top !important; }
.valign_middle      { vertical-align: middle !important; }
.valign_bottom      { vertical-align: bottom !important; }
.uppercase          { text-transform: uppercase !important; }
.clear              { clear: both; }
.left               { float: left; }
.right              { float: right; }
.center             { margin-left: auto; margin-right: auto; }
.nofloat            { float: none !important; }
.block, img.center,
.tb_display_block   { display: block !important; }
.inline-block,
.tb_display_inline-block
                    { display: inline-block !important; }
.tb_table           { display: table !important; width: 100%; }
.tb_trow            { display: table-row; }

.none, .ui-tabs-hide, .tb_hidden, .tb_toggle {display: none !important;}
.tb_sep {margin-bottom: <?php echo $base*1.5; ?>px !important;}
.tb_border_solid, span.clear[class*="tb_border_"] { border-bottom-width: 1px; border-bottom-style: solid;  }
.tb_border_dashed, span.clear.tb_border_dashed    { border-bottom-width: 1px; border-bottom-style: dashed; }
.tb_border_dotted, span.clear.tb_border_dotted    { border-bottom-width: 1px; border-bottom-style: dotted; }
.tb_border_double, span.clear.tb_border_double    { border-bottom-width: 1px; border-bottom-style: double; }

br.clear,
span.clear
{
  visibility: visible;
  display: block;
  height: 0;
  line-height: 0;
  font-size: 0;
}

p.tb_empty {
  text-align: center;
  margin-bottom: <?php echo $base * 1.5; ?>px;
  padding: <?php echo $base * 2; ?>px 0;
  font-size: <?php echo $base_font_size * 1.25; ?>px;
}
.help { font-size: <?php echo $base_font_size * 0.85; ?>px; opacity: 0.4; }



/*****************************************************/
/*****   B O O T S T R A P   *************************/
/*****************************************************/

.pull-right {
  float: right;
}
.collapse {
  display: none;
}
.collapse.in {
  display: block;
}
tr.collapse.in {
  display: table-row;
}
tbody.collapse.in {
  display: table-row-group;
}
.collapsing {
  position: relative;
  height: 0;
  overflow: hidden;
  -webkit-transition: height 0.5s ease;
          transition: height 0.5s ease;
}



/*****************************************************/
/*****   F O R M S   *********************************/
/*****************************************************/

button {
}
label {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: 15px;
  <?php else: ?>
  float: right;
  margin-left: 15px;
  <?php endif; ?>
  width: 150px;
}
input[type=text],
input[type=number],
input[type=email],
input[type=tel],
input[type=date],
input[type=datetime],
input[type=color],
input[type=password],
input[type=search],
select,
textarea,
.ui-spinner
{
  max-width: 100%;
  padding: <?php echo $base/4; ?>px;
  border-width: 1px;
  border-style: solid;
  border-radius: 2px;
  -webkit-border-radius: 2px;
  resize: none;
}
input[type=text],
input[type=number],
input[type=email],
input[type=tel],
input[type=date],
input[type=datetime],
input[type=color],
input[type=password],
input[type=search],
select
{
  height: <?php echo $base * 1.5; ?>px;
}
input[type=number] {
  -moz-appearance: textfield;
  -webkit-appearance: textfield;
}
input,
select,
textarea
{
  width: 220px;
}
input[type=radio],
input[type=checkbox],
input[type=submit],
input[type=button],
input[type=file],
input[type=image],
input[size]
{
  width: auto;
}
input:not([type=radio]):not([type=checkbox]),
select,
textarea,
button,
.ui-spinner,
.input-group
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base / 2; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base / 2; ?>px;
  <?php endif; ?>
}
table input:not([type=radio]):not([type=checkbox]):not([size]),
table select,
table textarea,
table button,
table .ui-spinner,
table .input-group
{
  width: auto;
  margin-left: 0;
  margin-right: 0;
}
input + button,
input + .tb_button,
input + .button,
input + .btn
{
  vertical-align: top;
}
input[type=radio],
input[type=checkbox],
input[type=image]
{
  height: auto;
  vertical-align: middle;
}
input[name=captcha] {
  width: 150px;
}
img[src*="captcha"] {
  vertical-align: top;
}
textarea {
  width: 350px;
  padding-bottom: <?php echo $base/2; ?>px !important;
  resize: vertical;
  vertical-align: baseline;
}
select {
  padding: <?php echo $base/4 - 1; ?>px;
}
select[size] {
  height: auto;
}
button {
  height: 40px;
  border: none;
  background: #ddd;
}

input[type=hidden],
.help-block:empty
{
  display: none;
}
input[type=file] {
  font-size: 20px !important;
}
input[type=text]:hover,
input[type=number]:hover,
input[type=email]:hover,
input[type=tel]:hover,
input[type=date]:hover,
input[type=datetime]:hover,
input[type=color]:hover,
input[type=password]:hover,
input[type=search]:hover,
textarea:hover,
select:hover,
input[type=text]:focus,
input[type=number]:focus,
input[type=email]:focus,
input[type=tel]:focus,
input[type=date]:focus,
input[type=datetime]:focus,
input[type=color]:focus,
input[type=password]:focus,
input[type=search]:focus,
textarea:focus,
select:focus,
.ui-spinner:hover,
.ui-spinner:focus
{
  outline: 0 none !important;
}

input:-webkit-autofill,
textarea:-webkit-autofill,
select:-webkit-autofill
{
  background-color: transparent;
}

label.tb_disabled, label.tb_disabled * {
  color: #999 !important;
}
label .tb_legend {
  margin: 0 !important;
  padding-top: 0;
  line-height: 11px;
}

label[class*="checkbox"],
label[class*="radio"]
{
  position: relative;
  display: block;
  width: auto;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: 20px;
  padding: <?php echo $base * 0.25; ?>px 0 <?php echo $base * 0.25; ?>px 20px !important;
  text-align: left;
  <?php else: ?>
  float: right;
  margin-left: 20px;
  padding: <?php echo $base * 0.25; ?>px 20px <?php echo $base * 0.25; ?>px 0 !important;
  text-align: right;
  <?php endif; ?>
  font-size: 13px;
  font-weight: normal;
}
label[class*="checkbox"]:before,
label[class*="radio"]:before
{
  content: '';
  display: none;
}
label[class*="checkbox"] input,
label[class*="radio"] input
{
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
  top: 50%;
  position: absolute;
  margin: -5px 0 0 0 !important;
}
label[class*="checkbox"] input {
  margin: -6px 0 0 0 !important;
}


table.radio {
  width: auto;
  table-layout: auto;
}
table.radio tr td {
  padding: <?php echo $base * 0.75; ?>px 0 0 0;
}
table.radio tr:first-child td
{
  padding: 0;
}
table.radio tr.highlight td {
  padding: <?php echo $base / 4; ?>px 0;
}
table.radio tr.highlight td:first-child {
  width: 10px;
  vertical-align: top;
}
table.radio label {
  width: auto;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.75; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.75; ?>px;
  <?php endif; ?>
}

.input-group {
  position: relative;
  display: inline-block;
  max-width: 100%;
  vertical-align: top;
}
.input-group > *,
.input-group > *[type]
{
  margin-left: 0;
  margin-right: 0;
}
.form-group:before,
.form-group:after
{
  content: '';
  display: table;
}
.form-group:after {
  clear: both;
}
.form-group {
  clear: both;
  margin-top: <?php echo $base; ?>px;
  margin-bottom: <?php echo $base; ?>px;
}
.form-group[style*="display: none"] {
  overflow: hidden;
  clear: both;
  display: block !important;
  float: left;
  height: 0;
  margin-top: -<?php echo $base; ?>px;
}
.form-group:first-child {
  margin-top: 0;
}
.form-group [class*="col-"] {
  padding-left: 0;
  padding-right: 0;
}
.form-group div[class*="col-"] {
  width: auto;
  max-width: 80%;
}
.form-group > label {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 15px;
  <?php else: ?>
  margin-left: 15px;
  <?php endif; ?>
  padding-top: <?php echo $base/4; ?>px;
  padding-bottom: <?php echo $base/4; ?>px;
  vertical-align: baseline;
}
.form-group > label + div[class*="col-"],
.form-group > label + div[class*="col-"] > div
{
  overflow: hidden;
}
.form-group > label + div[class*="col-"]:after,
.form-group > label + div[class*="col-"] > div:after
{
  content: '';
  display: table;
  clear: both;
}
.form-group > label + .tb_full {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 166px;
  <?php else: ?>
  margin-right: 166px;
  <?php endif; ?>
}
.form-group select + .help-block,
.form-group textarea + .help-block
{
  padding-top: <?php echo $base * 0.5; ?>px;
  font-size: <?php echo $base_font_size * 0.85; ?>px;
}
.form-group .help-block .text-danger {
  min-width: 0;
  margin: 0;
  padding: 0;
}
.form-group.tb_style_2 .checkbox > label input[type=checkbox],
.form-group.tb_style_2 .radio > label input[type=radio]
{
  display: none;
}
.form-group.tb_style_2 .checkbox,
.form-group.tb_style_2 .radio
{
  display: block;
  margin-top: -<?php echo $base / 2; ?>px;
  padding-top: 0 !important;
  padding-bottom: 0 !important;
}
.form-group.tb_style_2 .checkbox > label,
.form-group.tb_style_2 .radio > label
{
  display: block;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  min-width: <?php echo $base * 1.5; ?>px;
  text-align: center;
  cursor: pointer;
}
.form-group.tb_style_1 .image + .image {
  margin-top: <?php echo $base * 0.5; ?>px;
}
.form-group .checkbox.image > label input,
.form-group .radio.image > label input
{
  margin-top: 0.24em;
}
.form-group .checkbox.image > label input,
.form-group .radio.image > label input,
.form-group .checkbox.image > label img,
.form-group .radio.image > label img
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base * 0.25; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base * 0.25; ?>px;
  <?php endif; ?>
}
.form-group.tb_style_2 .checkbox.image > label,
.form-group.tb_style_2 .radio.image > label
{
  width: auto;
  height: auto;
  min-width: 0;
  padding: 3px;
  line-height: normal !important;
  cursor: pointer;
}
.form-group.tb_style_2 .radio.image > label img {
  margin: 0;
  padding: 1px;
  vertical-align: top;
  background: #fff;
}
.checkbox,
.radio
{
  display: block;
  float: none;
  padding-top: <?php echo $base * 0.25; ?>px;
  padding-bottom: <?php echo $base * 0.25; ?>px;
}
.checkbox.image,
.radio.image
{
  padding-top: 0;
  padding-bottom: 0;
}
.checkbox > label,
.radio > label
{
  display: inline-block;
  float: none;
  width: auto;
  margin-left: 0;
  margin-right: 0;
}
.checkbox.image > label > *,
.radio.image > label > *
{
  vertical-align: middle;
}
.required > label:before {
  content: "* ";
  font-weight: bold;
  color: #f00;
}
input + .input-group-btn {
  position: absolute;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
}
.input-group input + .input-group-btn {
  <?php if ($lang_dir == 'ltr'): ?>
  right: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  left: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}
table .input-group input + .input-group-btn {
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
}
input + .input-group-btn button {
  width: <?php echo $base * 1.5; ?>px;
  margin: 0;
  padding: 0;
  color: inherit !important;
  <?php if ($lang_dir == 'ltr'): ?>
  border-radius: 0 2px 2px 0;
  <?php else: ?>
  border-radius: 2px 0 0 2px;
  <?php endif; ?>
  box-shadow: none;
  opacity: 0.6;
}
#wrapper input + .input-group-btn button {
  background-color: rgba(0, 0, 0, 0.2) !important;
}
input + .input-group-btn button:hover {
  opacity: 1;
}
.product-info .form-group > label + div {
  overflow: hidden;
}

.form-vertical .form-group > label {
  display: block;
  float: none;
  width: auto;
  padding-top: 0;
  font-weight: bold;
}
.form-vertical .form-group > label,
.form-vertical .form-group input:not([type=radio]):not([type=checkbox]),
.form-vertical .form-group select,
.form-vertical .form-group textarea,
.form-vertical .form-group .ui-spinner,
.form-vertical .form-group .input-group
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 0;
  <?php else: ?>
  margin-left: 0;
  <?php endif; ?>
}
.form-vertical .form-group > .tb_full {
  margin-right: 0;
  margin-left: 0;
}

/*** Pavilion ***/

.tb_full input,
.tb_full select,
.tb_full textarea
{
  width: 100%;
  max-width: none !important;
}
.tb_full input[type=checkbox],
.tb_full input[type=radio]
{
  width: auto;
}

.text-danger,
.error,
.tb_error_msg
{
  display: inline-block;
  min-width: 260px;
  max-width: 100%;
  margin-top: <?php echo $base/4; ?>px;
  margin-bottom: <?php echo $base/4; ?>px;
  font-size: 11px;
  color: red;
  vertical-align: top;
}
.text-danger:before,
.error:before,
.tb_error_msg:before
{
  content: '\f00d\0020\0020';
  position: relative;
  top: -1px;
  font-family: "FontAwesome";
  font-size: 12px;
  vertical-align: top;
}
.text-danger:empty,
.error:empty
{
  display: none;
}
div:not(.input-group) + .text-danger {
  display: block;
  clear: both;
}
fieldset {
  margin-bottom: <?php echo $base * 1.5; ?>px;
  border: none;
}
fieldset legend {
  float: left;
  width: 100%;
  margin-bottom: <?php echo $base * 1.5; ?>px;
}
fieldset legend + * {
  clear: both;
}
fieldset + fieldset {
  margin-top: <?php echo $base * 1.5; ?>px;
}
fieldset + fieldset legend {
  position: relative;
  padding-top: <?php echo $base * 1.5; ?>px;
}
fieldset:last-child,
fieldset > :last-child
{
  margin-bottom: 0;
  padding-bottom: 0;
}
fieldset[class*="tb_col_"] + fieldset[class*="tb_col_"] legend {
  padding-top: 0;
  border-top: 0;
}

.tb_blocked {
  position: relative;
}
.tb_blocked:before {
  content: '';
  position: absolute;
  z-index: 10;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  display: block;
  background-color: #fff;
  opacity: 0.8;
}


/****************************************************/
/***   N E W   B U T T O N S   **********************/
/****************************************************/

.button,
.btn,
button,
[type=button],
[type=submit]
{
  border: none;
}
.button a,
.btn a
{
  color: inherit !important;
}
.tb_button,
.button,
.btn,
button,
[type=button],
[type=submit]
{
  position: relative;
  display: inline-block;
  height: <?php echo $base * 1.5; ?>px;
  padding: 0 <?php echo $base * 0.75; ?>px;
  text-align: center;
  vertical-align: middle;
  border-radius: 3px;
  cursor: pointer !important;
  -webkit-box-shadow: inset 0 -2px 0 rgba(0, 0, 0, 0.15);
          box-shadow: inset 0 -2px 0 rgba(0, 0, 0, 0.15);
}
.tb_button.tb_plain {
  border-radius: 0;
  -webkit-box-shadow: none;
          box-shadow: none;
}
.tb_button.tb_h_20 {
  height: 20px;
  padding: 0 7px;
  line-height: 20px !important;
}
.tb_button.tb_h_24 {
  height: 24px;
  padding: 0 10px;
  line-height: 24px !important;
  font-size: 13px;
}
.tb_button.tb_h_30,
p.tb_h_30
{
  height: 30px;
  padding: 0 12px;
  line-height: 30px !important;
}
.tb_button.tb_h_34 {
  height: 34px;
  padding: 0 15px;
  line-height: 34px !important;
}
.tb_button.tb_h_40 {
  height: 40px;
  padding: 0 20px;
  line-height: 40px !important;
}
.tb_button.tb_h_50 {
  height: 50px;
  padding: 0 25px;
  line-height: 50px !important;
}
.tb_button.tb_h_60 {
  height: 60px;
  padding: 0 25px;
  line-height: 60px !important;
}
.tb_button.tb_h_20.tb_icon_10 {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 18px !important;
  <?php else: ?>
  padding-right: 18px !important;
  <?php endif; ?>
}
.tb_button.tb_h_30.tb_icon_10 {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 24px !important;
  padding-right: 10px !important;
  <?php else: ?>
  padding-right: 24px !important;
  padding-left: 10px !important;
  <?php endif; ?>
}
.tb_button.tb_h_40.tb_icon_16 {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 35px !important;
  <?php else: ?>
  padding-right: 35px !important;
  <?php endif; ?>
}
.tb_button.tb_h_20.tb_icon_10:empty {
  width: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: 0 !important;
  <?php else: ?>
  padding-left: 0 !important;
  <?php endif; ?>
}
.tb_button.tb_h_30.tb_icon_10:empty {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: 4px !important;
  <?php else: ?>
  padding-left: 4px !important;
  <?php endif; ?>
}
.tb_button.tb_h_30.tb_icon_16:empty {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 28px !important;
  padding-right: 0 !important;
  <?php else: ?>
  padding-right: 28px !important;
  padding-left: 0 !important;
  <?php endif; ?>
}
.tb_button.tb_h_30.tb_icon_16:empty:before {
  <?php if ($lang_dir == 'ltr'): ?>
  left: 7px !important
  <?php else: ?>
  right: 7px !important
  <?php endif; ?>
}
.tb_button.tb_fixed,
.tb_button[class*="tb_h_"].tb_fixed,
button.tb_fixed
{
  width: <?php echo $base * 1.5; ?>px;
  padding-left: 0;
  padding-right: 0;
}
.tb_button.tb_h_20.tb_fixed { width: 20px; }
.tb_button.tb_h_24.tb_fixed { width: 24px; }
.tb_button.tb_h_30.tb_fixed { width: 30px; }
.tb_button.tb_h_34.tb_fixed { width: 34px; }
.tb_button.tb_h_40.tb_fixed { width: 40px; }

.tb_button_group,
.btn-group
{
  display: inline-block;
}
.tb_button_group > *,
.btn-group > *
{
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  margin-left: 0 !important;
  margin-right: 0 !important;
}
.tb_button_group > *:not(:first-child):not(:last-child) {
  border-radius: 0;
}
.tb_button_group > :first-child:not(:last-child),
.btn-group > :first-child:not(:last-child)
{
  border-top-right-radius: 0;
  border-bottom-right-radius: 0;
}
.tb_button_group > :last-child:not(:first-child),
.btn-group > :last-child:not(:first-child)
{
  border-top-left-radius: 0;
  border-bottom-left-radius: 0;
}
.tb_button_group > .tb_button_primary + .tb_button_primary:after,
.btn-group > .btn-primary + .btn-primary:after
{
  content: '';
  position: absolute;
  top: 0;
  display: block;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0; 
  border-left: 1px solid; 
  <?php else: ?>
  right: 0;
  border-left: 1px solid; 
  <?php endif; ?>
  height: 100%;
  opacity: 0.15;
}

.tb_button.tb_h_20.tb_icon_10:before   { <?php if ($lang_dir == 'ltr'): ?>        left:  4px  !important;<?php else: ?>        right:  4px !important;<?php endif; ?> }
.tb_button.tb_h_24.tb_icon_10          { <?php if ($lang_dir == 'ltr'): ?>padding-left: 24px  !important;<?php else: ?>padding-right: 24px !important;<?php endif; ?> }
.tb_button.tb_h_24.tb_icon_10:before   { <?php if ($lang_dir == 'ltr'): ?>        left:  7px  !important;<?php else: ?>        right:  7px !important;<?php endif; ?> }
.tb_button.tb_h_24.tb_icon_16          { <?php if ($lang_dir == 'ltr'): ?>padding-left: 29px  !important;<?php else: ?>padding-right: 29px !important;<?php endif; ?> }
.tb_button.tb_h_24.tb_icon_16:before   { <?php if ($lang_dir == 'ltr'): ?>        left:  7px  !important;<?php else: ?>        right:  7px !important;<?php endif; ?> }
.tb_button.tb_h_30.tb_icon_10:before   { <?php if ($lang_dir == 'ltr'): ?>        left: 10px  !important;<?php else: ?>        right: 10px !important;<?php endif; ?> }
.tb_button.tb_h_30.tb_icon_16          { <?php if ($lang_dir == 'ltr'): ?>padding-left: 37px  !important;<?php else: ?>padding-right: 37px !important;<?php endif; ?> }
.tb_button.tb_h_30.tb_icon_16:before   { <?php if ($lang_dir == 'ltr'): ?>        left: 10px  !important;<?php else: ?>        right: 10px !important;<?php endif; ?> }
.tb_button.tb_h_34.tb_icon_10:before   { <?php if ($lang_dir == 'ltr'): ?>        left: 13px  !important;<?php else: ?>        right: 13px !important;<?php endif; ?> }
.tb_button.tb_h_34.tb_icon_16          { <?php if ($lang_dir == 'ltr'): ?>padding-left: 37px  !important;<?php else: ?>padding-right: 37px !important;<?php endif; ?> }
.tb_button.tb_h_34.tb_icon_16:before   { <?php if ($lang_dir == 'ltr'): ?>        left: 13px  !important;<?php else: ?>        right: 13px !important;<?php endif; ?> }
.tb_button.tb_h_40.tb_icon_16          { <?php if ($lang_dir == 'ltr'): ?>padding-left: 40px  !important;<?php else: ?>padding-right: 40px !important;<?php endif; ?> }
.tb_button.tb_h_40.tb_icon_16:before   { <?php if ($lang_dir == 'ltr'): ?>        left: 15px  !important;<?php else: ?>        right: 15px !important;<?php endif; ?> }

a.tb_button:empty { padding: 0 !important; }
a.tb_button.tb_h_20:empty { width: 20px; }
a.tb_button.tb_h_24:empty { width: 24px; }
a.tb_button.tb_h_30:empty { width: 30px; }
a.tb_button.tb_h_34:empty { width: 34px; }
a.tb_button.tb_h_40:empty { width: 40px; }

body [class] [class] [class] .btn-default,
body [class] [class] [class] .tb_button_default
{
  color: inherit !important;
}

.tb_submit,
.buttons
{
  position: relative;
  z-index: 1;
  overflow: hidden;
  clear: both;
  padding-top: <?php echo $base * 1.5 - 1; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
  letter-spacing: <?php echo $base; ?>px;
}
.tb_submit.tb_size_1 {
  padding-top: <?php echo $base - 1; ?>px;
}
.tb_submit:last-child {
  margin-bottom: 0;
}
.tb_submit > *,
.buttons > *
{
  letter-spacing: normal;
  margin-left: 0;
  margin-right: 0;
}
.tb_submit .tb_button:not([class*="tb_h_"]),
.buttons .button,
.buttons .btn,
.buttons button,
.buttons [type=button],
.buttons [type=submit],
#button-cart,
#product_buy_quantity,
#product_buy #input-quantity
{
  height: <?php echo $submit_button_size; ?>px;
  padding: 0 <?php echo $base; ?>px;
  line-height: <?php echo $submit_button_size - 1; ?>px;
}
.tb_submit.tb_size_1 .tb_button,
.tb_submit.tb_size_1 .button
{
  height: 24px;
  height: 24px;
  margin-top: <?php echo ($tbData->calculateLineHeight(24, $base) - 24)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(24, $base) - 24)/2; ?>px;
  padding: 0 10px;
  line-height: 24px !important;
  font-size: 13px;
  text-transform: none;
}
.tb_submit .tb_button_back {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_submit [class*="checkbox"],
.tb_submit .tb_button_forgotten
{
  display: inline-block;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  margin-top: <?php echo ($tbData->calculateLineHeight($submit_button_size, $base) - $base)/2; ?>px;
}
.tb_submit [class*="checkbox"],
.tb_submit [class*="radio"]
{
  margin-top: <?php echo ($tbData->calculateLineHeight($submit_button_size, $base) - $base)/4; ?>px;
}
.pagination + .tb_submit,
.tb_table_1 + .tb_submit,
.pagination + .tb_submit:before,
.tb_table_1 + .tb_submit:before
{
  padding-top: 0;
  border-top-width: 0;
}
.tb_table_1.tb_open + .tb_submit {
  margin-top: -<?php echo $base; ?>px;
  padding-top: <?php echo $base * 1.5; ?>px;
  border-top-width: 1px;
}
.tb_table_1 tbody:first-child tr:first-child td {
  padding-top: 0;
}
.tb_table_1 tbody:first-child td:first-child {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 0;
  <?php else: ?>
  padding-right: 0;
  <?php endif; ?>
}
.tb_table_1 tbody:first-child td:last-child {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: 0;
  <?php else: ?>
  padding-left: 0;
  <?php endif; ?>
}

.tb_server_msg,
.warning,
.alert
{
  cursor: pointer;
  margin-bottom: <?php echo $base * 1.5; ?>px;
  padding: <?php echo $base; ?>px;
  text-align: center;
  font-size: 13px;
  font-weight: bold;
}
.tb_msg_green,
.alert-success
{
  color: green;
  background: #f4fbe4;
  border: 1px solid #e3f5bd;
}
.tb_msg_blue,
.alert-info
{
  color: #506778;
  background: #e9f6ff;
  border: 1px solid #c8e0f0;
}
.tb_msg_yellow {
  color: #726300;
  background: #fffcd9;
  border: 1px solid #f0e190;
}
.tb_msg_red,
.warning,
.alert-danger,
.alert-warning
{
  color: red;
  background: #ffede5;
  border: 1px solid #ffd8c3;
}
.warning img,
.alert .close
{
  display: none;
}



/*****************************************************/
/*****   C O M P O N E N T S   ***********************/
/*****************************************************/


[class*="tb_widget"] {
  position: relative;
  clear: both;
}
[class*="tb_widget"].has_slider.tb_top_nav > h2,
[class*="tb_widget"].has_slider.tb_top_nav > div > h2
{
  padding-right: 60px;
}
[class*="tb_widget"].has_slider.tb_top_nav > h2.align_right,
[class*="tb_widget"].has_slider.tb_top_nav > div > h2.align_right
{
  padding-left: 60px;
}

.tb_row:not(.tb_row_separate):not(.tb_ip_0) > .tb_wrap > [class*="tb_col_"] > [class*="tb_widget"]:not([class*="tb_mb_-"]):last-child,
[class*="tb_widget"] > :last-child {
  margin-bottom: 0;
}


.tb_nav > ul {
  margin-bottom: 0;
  word-spacing: -0.235em;
}
.tb_nav > ul > li,
.tb_nav > ul > li > a
{
  display: inline-block;
  vertical-align: top;
}
.tb_nav li > a {
  position: relative;
}
.tb_nav > ul > li {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base / 2; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base / 2; ?>px;
  <?php endif; ?>
  word-spacing: normal;
}
.tb_nav > ul > li:last-child {
  margin-left: 0 !important;
  margin-right: 0!important;
}
.tb_nav > ul > li.tb_multiple > a {
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base / 2 + 4; ?>px;
  <?php else: ?>
  padding-left: <?php echo $base / 2 + 4; ?>px;
  <?php endif; ?>
}
.tb_nav > ul > li.tb_multiple > a:after {
  direction: ltr;
  content: '\203a';
  position: absolute;
  top: 50%;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
  width: <?php echo $base / 2; ?>px;
  height: <?php echo $base; ?>px;
  margin-top: -<?php echo $base / 2; ?>px;
  line-height: <?php echo $base - 5; ?>px;
  text-align: center;
  font-size: <?php echo $base_font_size * 1.5; ?>px;
  vertical-align: top;
  -webkit-transform: rotate(90deg);
      -ms-transform: rotate(90deg);
          transform: rotate(90deg);
  opacity: 0.4;
}
.tb_lang_rtl .tb_nav > ul > li.tb_multiple > a:after {
  -ms-transform: rotate(-90deg);
}
.tb_nav .tb_submenu > ul.tb_list_1 > li.tb_multiple:after,
.tb_nav .tb_menu_html ul.tb_list_1 > li.tb_multiple:after
{
  content: '\25e2';
  position: absolute;
  top: 50%;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
  width: <?php echo $base / 2; ?>px;
  height: <?php echo $base; ?>px;
  margin-top: -<?php echo $base * 0.5; ?>px;
  line-height: <?php echo $base; ?>px;
  text-align: center;
  vertical-align: top;
  font-size: 0.75em;
  <?php if ($lang_dir == 'ltr'): ?>
  -webkit-transform: rotate(-45deg);
      -ms-transform: rotate(-45deg);
          transform: rotate(-45deg);
  <?php else: ?>
  -webkit-transform: rotate(135deg);
      -ms-transform: rotate(135deg);
          transform: rotate(135deg);
  <?php endif; ?>
  opacity: 0.2;
  cursor: pointer;
}
.tb_nav > ul > li.tb_multiple.tb_hovered > a:after {
  margin-top: -<?php echo $base * 0.75; ?>px;
  opacity: 1;
}
.tb_nav > ul > li.tb_multiple.tb_hovered > a,
#cart.tb_hovered
{
  padding-bottom: <?php echo $base / 2; ?>px;
}
.tb_nav > ul > li.tb_multiple.tb_hovered,
#cart.tb_hovered
{
  margin-bottom: -<?php echo $base / 2; ?>px;
}
.tb_nav > ul > li,
.tb_nav > ul > li > a,
.tb_nav > ul > li > a:after,
#cart,
#cart .heading > a,
#cart .heading > a > *
{
  -webkit-transition: color 0.4s, background-color 0.4s;
  transition: color 0.4s, background-color 0.4s;
}
#main_navigation_row .tb_nav > ul > li.tb_multiple.tb_hovered > a:after {
  margin-top: -<?php echo $base * 0.5; ?>px;
}
#main_navigation_row .tb_nav .tb_multiple.tb_hovered > a,
#main_navigation_row #cart.tb_hovered
{
  margin-bottom: 0;
  padding-bottom: 0;
}
.tb_nav .tb_submenu {
  position: absolute;
  top: 100%;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  text-align: left;
  <?php else: ?>
  right: 0;
  text-align: right;
  <?php endif; ?>
  display: none;
}
.tb_out_of_view_left > .tb_submenu,
#menu .tb_out_of_view_left > div
{
  left: 0 !important;
  right: auto !important;
}
.tb_out_of_view_right > .tb_submenu,
#menu .tb_out_of_view_right > div
{
  left: auto !important;
  right: 0 !important;
}
.tb_nav li.tb_hovered > .tb_submenu,
#menu li.tb_hovered > div
{
  z-index: 50;
  display: block;
}
.tb_nav .tb_submenu ul > li > a {
  display: block;
}
.tb_nav .tb_submenu .tb_submenu {
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 96%;
  <?php else: ?>
  right: 96%;
  <?php endif; ?>
}
.tb_nav li:hover,
.tb_nav li.tb_hovered,
.tb_nav li:hover > a,
#menu li.tb_hovered
{
  position: relative;
}
.tb_nav .tb_submenu {
  min-width: 90px;
  padding: <?php echo $base / 4; ?>px <?php echo $base / 2; ?>px;
  background: #fff;
  border-radius: 2px;
  -webkit-box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
  box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
}
.tb_nav > ul > li.tb_multiple.tb_hovered:after,
#cart.tb_hovered:after
{
  content: '';
  z-index: 60;
  position: absolute;
  top: 100%;
  left: auto;
  right: auto;
  display: block;
  width: 9px;
  height: 9px;
  margin-top: -6px;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 12px;
  <?php else: ?>
  margin-right: 12px;
  <?php endif; ?>
  border-top: 1px solid rgba(0, 0, 0, 0.15);
  border-left: 1px solid rgba(0, 0, 0, 0.15);
  background: #fff;
  background-clip: content-box;
  -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
}
.tb_nav > ul > li.tb_megamenu.tb_multiple.tb_hovered:after {
  top: auto;
}
.tb_nav .tb_megamenu > .tb_submenu {
  max-width: 1000px;
  margin-left: 0 !important;
  margin-right: 0 !important;
}
.tb_width_1200 .tb_nav .tb_megamenu > .tb_submenu {
  max-width: 1200px;
}
.tb_nav .tb_megamenu > .tb_submenu .tb_row_separate > .tb_wrap {
  margin: 0 !important;
  table-layout: fixed;
}
.tb_nav .tb_megamenu > .tb_submenu .tb_row {
  max-height: none !important;
}
.tb_nav .tb_accent_label {
  position: absolute;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: -13px;
  <?php else: ?>
  margin-right: -13px;
  <?php endif; ?>
  padding: 0 3px;
  line-height: 12px;
  white-space: nowrap;
  font-size: 8px;
  font-weight: bold;
  font-family: Arial;
}
.tb_nav > ul > li > a > .tb_accent_label {
  top: 0;
  margin-top: -12px;
}
#main_navigation_row .tb_nav > ul > li > a > .tb_accent_label {
  top: 50%;
  margin-top: -22px;
}
.tb_nav > ul > li.tb_multiple > a > .tb_accent_label {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: -20px;
  <?php else: ?>
  margin-right: -20px;
  <?php endif; ?>
}
.tb_nav .tb_submenu .tb_accent_label {
  top: 50%;
  margin-top: -12px;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 4px;
  <?php else: ?>
  margin-right: 4px;
  <?php endif; ?>
}

<?php if ($tbData->system['compatibility_menu']): ?>
#menu > ul > li,
#menu > ul > li > a
{
  display: block;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
#menu > ul > li:last-child {
  margin-left: 0 !important;
  margin-right: 0!important;
}
#menu > ul > li.tb_hovered {
  margin-bottom: -<?php echo $base / 2; ?>px;
  padding-bottom: <?php echo $base / 2; ?>px;
}
#menu > ul > li > div {
  position: absolute;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
  display: none;
}
#menu > ul > li > div {
  min-width: 90px;
  border-radius: 2px;
  box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
}
#menu > ul > li > div {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
#menu > ul > li > div:before {
  content: '';
  z-index: 6;
  position: absolute;
  top: -6px;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 18px;
  <?php else: ?>
  right: 18px;
  <?php endif; ?>
  display: block;
  width: 9px;
  height: 9px;
  border-top: 1px solid rgba(0, 0, 0, 0.15);
  border-left: 1px solid rgba(0, 0, 0, 0.15);
  background: #fff;
  background-clip: content-box;
  -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
}
<?php endif; ?>

.tb_list_1 {
  list-style: none !important;
}
.tb_list_1 > li,
#menu div > ul > li
{
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base * 0.75; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base * 0.75; ?>px;
  <?php endif; ?>
}
.tb_list_1 > li:before,
#menu div > ul > li:before
{
  position: absolute;
  top: <?php echo $base / 2; ?>px;
  content: '\203a';
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
  display: block;
  width: <?php echo $base / 2; ?>px;
  height: <?php echo $base / 2; ?>px;
  margin-top: -<?php echo $base / 4; ?>px;
  line-height: <?php echo $base / 2 - 4; ?>px;
  font-size: <?php echo $base_font_size + 4; ?>px;
}

.tb_dlist_1 dt {
  width: 40%;
}
.tb_dlist_1 dd:after {
  content: '';
  clear: both;
  display: block;
  height: 0;
  width: 100%;
}
.tb_dlist_1 dt,
.tb_dlist_1 dd
{
  margin-bottom: 0;
}

.tb_icon_10,
.tb_icon_16,
.tb_icon_24,
.tb_icon_32
{
  position: relative;
}
<?php if ($lang_dir == 'ltr'): ?>
.tb_icon_10 {padding-left: 15px !important;}
.tb_icon_16 {padding-left: 25px !important;}
.tb_icon_24 {padding-left: 40px !important;}
.tb_icon_32 {padding-left: 45px !important;}
<?php else: ?>
.tb_icon_10 {padding-right: 15px !important;}
.tb_icon_16 {padding-right: 25px !important;}
.tb_icon_24 {padding-right: 38px !important;}
.tb_icon_32 {padding-right: 45px !important;}
<?php endif; ?>

.tb_icon_10:before,
.tb_icon_16:before,
.tb_icon_24:before,
.tb_icon_32:before
{
  position: absolute;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
  top: 50%;
  display: block;
  text-align: center;
  background-repeat: no-repeat;
  background-position: center;
}
.tb_icon_10:not([class*="fa"]):before,
.tb_icon_16:not([class*="fa"]):before,
.tb_icon_24:not([class*="fa"]):before,
.tb_icon_32:not([class*="fa"]):before
{
  content: '';
}
.tb_icon_10:before {
  width: 10px;
  height: 10px;
  margin-top: -5px;
  line-height: 10px !important;
  font-size: 10px;
}
.tb_icon_16:before {
  width: 16px;
  height: 16px;
  margin-top: -8px;
  line-height: 16px !important;
  font-size: 16px;
}
.tb_icon_24:before {
  width: 24px;
  height: 24px;
  margin-top: -12px;
  line-height: 24px !important;
  font-size: 24px;
}
.tb_icon_32:before {
  width: 32px;
  height: 32px;
  margin-top: -16px;
  line-height: 32px !important;
  font-size: 32px;
}
.tb_icon {
  display: inline-block;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 0.5em;
  <?php else: ?>
  margin-left: 0.5em;
  <?php endif; ?>
  vertical-align: top;
}

.tb_rating_holder {
  margin-bottom: <?php echo $base; ?>px;
}
.tb_rating_holder:last-child {
  margin-bottom: 0;
}
.tb_rating_holder > * {
  display: inline-block;
  vertical-align: top;
}
.tb_rating_holder .tb_average {
  margin-top: -1px;
  font-weight: bold;
  letter-spacing: 1px;
}
.tb_rating_holder .tb_total {
  display: inline-block;
  margin-top: -1px;
  letter-spacing: 0;
  font-weight: normal;
  font-size: 11px;
  vertical-align: top;
  opacity: 0.4;
}
.tb_rating_holder .tb_review_write {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 5px;
  padding-left: 7px;
  border-left-width: 1px;
  border-left-style: solid;
  <?php else: ?>
  margin-right: 5px;
  padding-right: 7px;
  border-right-width: 1px;
  border-right-style: 1px;
  <?php endif; ?>
}
.tb_rating,
.tb_rating *
{
  margin-bottom: 0;
  letter-spacing: 1px;
  font-family: "FontAwesome" !important;
  font-size: 15px;
  -webkit-font-smoothing: antialiased;
  speak: none;
}
.tb_rating {
  position: relative;
  display: inline-block;
  color: #ddd;
  direction: ltr;
}
.tb_rating .tb_base {
  display: block;
}
.tb_rating .tb_base:before,
.tb_rating .tb_percent:before
{
  content: '\f005\f005\f005\f005\f005';
}
.tb_rating .tb_percent {
  position: absolute;
  top: 0;
  bottom: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  direction: rtl;
  <?php endif; ?>
  overflow: hidden;
  display: block;
  color: #ffd200;
}


.tb_thumb {
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_thumb,
.tb_thumb img
{
  display: block;
}
img.tb_thumb,
.tb_thumb img
{
  max-width: 100%;
  height: auto;
  margin-left: auto;
  margin-right: auto;
}

.tb_table_1,
table.tb_table_1
{
  margin-bottom: <?php echo $base * 1.5; ?>px;
  border-collapse: separate;
}
.tb_table_1 table,
.tb_table_1:last-child
{
  margin-bottom: 0;
}
.tb_table_1 th,
.tb_table_1 td
{
  box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.12);
}
.tb_table_1 thead th,
.tb_table_1 thead td
{
  padding: <?php echo $base * 0.5 - 1; ?>px <?php echo $base; ?>px <?php echo $base * 0.5; ?>px <?php echo $base; ?>px;
  text-align: center;
  font-weight: bold;
  border-top: 1px solid #fff;
}
.tb_table_1 thead:first-child th,
.tb_table_1 thead:first-child td
{
  padding-top: <?php echo $base * 0.5; ?>px;
  border-top: none;
}
.tb_table_1 thead th:not(:first-child),
.tb_table_1 thead td:not(:first-child)
{
  <?php if ($lang_dir == 'ltr'): ?>
  box-shadow: inset 1px 0 0 rgba(0, 0, 0, 0.12),
              inset 0 -1px 0 rgba(0, 0, 0, 0.12);
  <?php else: ?>
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, 0.12),
              inset 0 -1px 0 rgba(0, 0, 0, 0.12);
  <?php endif; ?>
}
.tb_table_1 tbody th,
.tb_table_1 tbody td
{
  padding: <?php echo $base * 0.5; ?>px;
  text-align: center;
}
.tb_table_1.tb_open tbody tr:last-child td {
  box-shadow: none;
}
.tb_table_1 tfoot th,
.tb_table_1 tfoot td
{
  box-shadow: none;
}

.tb_listing {
  position: relative;
  clear: both;
  margin-bottom: <?php echo $base * 1.5; ?>px;
}
.tb_listing:last-child {
  margin-bottom: 0;
}

/*** Tabs ***/

.tb_tabs_nav {
  margin-bottom: <?php echo $base; ?>px;
}
.tb_pt_5  > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 0.25; ?>px; }
.tb_pt_10 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 0.5;  ?>px; }
.tb_pt_15 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 0.75; ?>px; }
.tb_pt_25 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 1.25; ?>px; }
.tb_pt_30 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 1.0;  ?>px; }
.tb_pt_35 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 1.75; ?>px; }
.tb_pt_40 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 2;    ?>px; }
.tb_pt_45 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 2.25; ?>px; }
.tb_pt_50 > .tb_tabs .tb_tabs_nav { margin-bottom: <?php echo $base * 2.5;  ?>px; }

.tb_tabs_nav li {
  position: relative;
  z-index: 30;
  display: inline-block;
  vertical-align: top;
}
.tb_tabs_nav li.ui-state-hover {
  z-index: 31;
}
.tb_tabs_nav li.ui-state-active {
  z-index: 32;
}
.tb_tabs_nav li a {
  display: block;
  float: left;
  outline: none;
}
.tb_tabs.tb_ip_0  .tb_tabs_nav li a { padding-left: 0;    padding-right: 0;    }
.tb_tabs.tb_ip_5  .tb_tabs_nav li a { padding-left: 5px;  padding-right: 5px;  }
.tb_tabs.tb_ip_10 .tb_tabs_nav li a { padding-left: 10px; padding-right: 10px; }
.tb_tabs.tb_ip_15 .tb_tabs_nav li a { padding-left: 15px; padding-right: 15px; }
.tb_tabs.tb_ip_20 .tb_tabs_nav li a { padding-left: 20px; padding-right: 20px; }
.tb_tabs.tb_ip_25 .tb_tabs_nav li a { padding-left: 25px; padding-right: 25px; }
.tb_tabs.tb_ip_30 .tb_tabs_nav li a { padding-left: 30px; padding-right: 30px; }
.tb_tabs.tb_ip_35 .tb_tabs_nav li a { padding-left: 35px; padding-right: 35px; }
.tb_tabs.tb_ip_40 .tb_tabs_nav li a { padding-left: 40px; padding-right: 40px; }
.tb_tabs.tb_ip_45 .tb_tabs_nav li a { padding-left: 45px; padding-right: 45px; }
.tb_tabs.tb_ip_50 .tb_tabs_nav li a { padding-left: 50px; padding-right: 50px; }

.tb_tabs_nav li a span.tb_icon {
  width: 1em;
  text-align: center;
}
.tb_tabs_nav li a span.tb_icon:last-child {
  margin-left: 0;
  margin-right: 0;
}

.tb_tabs_content {
  clear: both;
  float: left;
  width: 100%;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
}
.tb_tabs_content > span.tb_title {
  display: none;
}
.tb_tabs_content > div {
  display: none;
  overflow: visible !important;
}
.tb_tabs_content > div:first-child,
.tb_tabs_content > span.tb_title:first-child + div
{
  display: block;
}
.tb_tabs_content [class*="tb_widget"]:not([class*="tb_mb_-"]) {
  margin-bottom: 0;
}
.tb_tabs_content [class*="tb_mb_-"] {
}

.ui-widget-content.tb_loading {
  position: relative;
}
.ui-widget-content.tb_loading > .fa-spin {
  position: absolute !important;
  z-index: 11;
  top: 50%;
  left: 50%;
  margin: -8px 0 0 -8px;
}
.ui-widget-content.tb_loading > *:not(.fa) {
  overflow: hidden;
  visibility: hidden;
  height: 0;
}

.tb_vtabs {
  clear: both;
}
.tb_vtabs.tb_tabs_left {
  direction: ltr;
}
.tb_vtabs.tb_tabs_right {
  direction: rtl;
}
.tb_vtabs .tb_tabs_nav,
.tb_vtabs .tb_tabs_content
{
  display: table-cell;
  float: none;
  direction: <?php echo $lang_dir; ?>;
}
.tb_vtabs .tb_tabs_nav {
  text-align: inherit !important;
  vertical-align: top;
}
.tb_vtabs .tb_tabs_nav ul {
  border-bottom: 0;
}
.tb_vtabs .tb_tabs_nav li,
.tb_vtabs .tb_tabs_nav li a
{
  display: block !important;
  height: auto !important;
}
.tb_vtabs .tb_tabs_nav li {
  display: block;
  float: left;
  clear: left;
}
.tb_vtabs .tb_tabs_nav li a {
  float: none;
  white-space: normal;
}
.tb_vtabs.tb_tabs_left .tb_tabs_content {
  padding-left: 30px;
}
.tb_vtabs.tb_tabs_right .tb_tabs_content {
  padding-right: 30px;
}

/*** Style 1 ***/

.tb_tabs.tb_style_1 .tb_tabs_nav {
  -webkit-border-radius: inherit;
  border-radius: inherit;
}
.tb_tabs.tb_style_1 .tb_tabs_content,
.tb_tabs.tb_style_1 .tb_tabs_nav li
{
  border-width: 1px;
  border-style: solid;
  border-color: transparent;
}
.tb_tabs.tb_style_1 .tb_tabs_nav li a {
  padding-top: <?php echo $base * 0.5 - 1; ?>px;
  padding-bottom: <?php echo $base * 0.5 - 1; ?>px;
  -webkit-transition: color 0.2s ease-in-out;
  transition: color 0.2s ease-in-out;
}

/*** Style 1 horizontal ***/

.tb_htabs.tb_style_1 {
  -webkit-border-radius: inherit inherit 0 0;
  border-radius: inherit inherit 0 0;
}
.tb_htabs.tb_style_1 .tb_tabs_nav > ul {
  border-bottom-width: 1px;
  border-bottom-style: solid;
}
.tb_htabs.tb_style_1 .tb_tabs_nav > ul:not(.ui-widget-header) {
  border-bottom-color: transparent;
}
.tb_htabs.tb_style_1 .tb_tabs_nav li {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: -1px;
  <?php else: ?>
  margin-left: -1px;
  <?php endif; ?>
  border-bottom: 0 none;
}
.tb_htabs.tb_style_1 .tb_tabs_nav li.ui-tabs-active {
  margin-bottom: -1px;
  padding-bottom: 1px;
}
.tb_htabs.tb_style_1 .tb_tabs_content {
  border-top: 0 none;
}

/*** Style 1 vertical ***/

.tb_vtabs.tb_tabs_right.tb_style_1 {
  -webkit-border-radius: inherit;
  border-radius: inherit;
}
.tb_vtabs.tb_tabs_right.tb_style_1 .tb_tabs_nav {
  border-left-width: 1px;
  border-left-style: solid;
}
.tb_vtabs.tb_tabs_left.tb_style_1 .tb_tabs_nav {
  border-right-width: 1px;
  border-right-style: solid;
}
.tb_vtabs.tb_tabs_right.tb_style_1:not(.ui-tabs) .tb_tabs_nav,
.tb_vtabs.tb_tabs_left.tb_style_1:not(.ui-tabs) .tb_tabs_nav
{
  border-left-color: transparent;
  border-right-color: transparent;
}
.tb_vtabs.tb_tabs_right.tb_style_1 .tb_tabs_content {
  border-right: 0 none;
}
.tb_vtabs.tb_tabs_left.tb_style_1 .tb_tabs_content {
  border-left: 0 none;
}

.tb_vtabs.tb_style_1 .tb_tabs_nav li {
  float: none;
  margin-top: -1px;
}
.tb_vtabs.tb_style_1 .tb_tabs_nav li:first-child {
  margin-top: 0;
}
.tb_vtabs.tb_style_1 .tb_tabs_nav li a {
  padding-top: <?php echo $base * 0.5; ?>px;
}
.tb_vtabs.tb_style_1 .tb_tabs_nav li:first-child a {
  padding-top: <?php echo $base * 0.5 - 1; ?>px;
}
.tb_vtabs.tb_tabs_left.tb_style_1 .tb_tabs_nav li {
  border-right: none !important;
}
.tb_vtabs.tb_tabs_right.tb_style_1 .tb_tabs_nav li {
  border-left: none !important;
}
.tb_vtabs.tb_tabs_left.tb_style_1 .tb_tabs_nav li.ui-tabs-active {
  margin-right: -1px;
  padding-right: 1px;
}
.tb_vtabs.tb_tabs_right.tb_style_1 .tb_tabs_nav li.ui-tabs-active {
  margin-left: -1px;
  padding-left: 1px;
}

/*** Style 2 ***/

.tb_tabs.tb_style_2,
.tb_tabs.tb_style_2 .tb_tabs_nav,
.tb_tabs.tb_style_2 .tb_tabs_nav > ul,
.tb_tabs.tb_style_2 .tb_tabs_nav > ul > li,
.tb_tabs.tb_style_2 .tb_tabs_nav > ul > li > a
{
  background-color: transparent !important;
}
.tb_tabs.tb_style_2 .tb_tabs_nav > ul {
  border-bottom: none !important;
}
.tb_tabs.tb_style_2 .tb_tabs_nav li,
.tb_tabs.tb_style_2 .tb_tabs_nav li a
{
  display: inline-block;
  float: none;
}
.tb_tabs.tb_style_2 .tb_tabs_nav li:first-child a {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 0 !important;
  <?php else: ?>
  padding-right: 0 !important;
  <?php endif; ?>
}
.tb_tabs.tb_style_2 .tb_tabs_nav li:last-child a {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: 0 !important;
  <?php else: ?>
  padding-left: 0 !important;
  <?php endif; ?>
}
body #wrapper .tb_tabs.tb_style_2 .tb_tabs_nav li,
body #wrapper .tb_tabs.tb_style_2 .tb_tabs_nav li.ui-state-hover,
body #wrapper .tb_tabs.tb_style_2 .tb_tabs_nav li.ui-state-active
{
  color: inherit !important;
}
.tb_tabs.tb_style_2 .tb_tabs_nav li:first-child ~ li:before {
  content: '\00a0/';
  vertical-align: top;
  font-size: 80%;
  font-weight: normal;
  color: inherit;
  opacity: 0.3;
}

.tb_vtabs.tb_style_2 .tb_tabs_nav li {
  margin-bottom: <?php echo $base / 2; ?>px;
}
.tb_vtabs.tb_style_2 .tb_tabs_nav li a {
  padding-left: 0 !important;
  padding-right: 0 !important;
}
.tb_vtabs.tb_style_2 .tb_tabs_nav li.ui-state-hover {
}
.tb_vtabs.tb_style_2 .tb_tabs_nav li:before {
  content: '';
  display: none;
}

/*** Style 3 ***/

.tb_tabs.tb_style_3 .ui-tabs-nav,
.tb_tabs.tb_style_3 .ui-state-default:not(.ui-state-hover):not(.ui-state-active)
{
  background: transparent !important;
}
.tb_tabs.tb_style_3 .tb_tabs_nav > ul {
  margin: -<?php echo $base * 0.25; ?>px 0;
  border-bottom: none !important;
}
.tb_tabs.tb_style_3 .tb_tabs_nav li {
  border-radius: 2px;
  -webkit-transition: color 0.4s, background-color 0.4s;
          transition: color 0.4s, background-color 0.4s;
}
.tb_tabs.tb_style_3 .tb_tabs_nav li a {
  padding-top: <?php echo $base * 0.25; ?>px;
  padding-bottom: <?php echo $base * 0.25; ?>px;
}

/*** Style 3 horizontal ***/

h2 + .tb_htabs.tb_style_3 .tb_tabs_nav {
  <?php if ($lang_dir == 'ltr'): ?>
  direction: rtl;
  <?php else: ?>
  direction: ltr;
  <?php endif; ?>
}
h2 + .tb_htabs.tb_style_3 .tb_tabs_nav > ul {
  position: absolute;
}



/*** pagination ***/

.pagination {
  overflow: hidden;
  clear: both;
  margin-bottom: <?php echo $base * 1.5; ?>px;
}
.pagination:empty {
  display: none;
}
.pagination .results {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
  font-size: <?php echo $base_font_size - 2; ?>px;
  color: #999;
}
.pagination .links {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.pagination .links,
.pagination .links li,
.pagination .links li a,
.pagination .links li span
{
  display: inline-block;
  margin: 0;
}
.pagination .links {
  padding-left: <?php echo $base * 0.25; ?>px;
  margin-left: -<?php echo $base * 0.25; ?>px;
  margin-right: -<?php echo $base * 0.25; ?>px;
  vertical-align: middle;
}
.pagination .links li,
.pagination .links li a,
.pagination .links li span
{
  width: <?php echo $base * 1.5; ?>px;
  height: <?php echo $base * 1.5; ?>px;
  line-height: <?php echo $base * 1.5; ?>px;
  text-align: center;
  font-weight: normal;
  vertical-align: top;
  -webkit-border-radius: 2px;
          border-radius: 2px;
}
.pagination .links li {
  margin-right: <?php echo $base * 0.25; ?>px;
}
.pagination .links li > a {
  box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.15);
}
.tb_table_1.tb_open + .pagination {
  border-top-width: 1px;
  border-top-style: solid;
}
.tb_table_1.tb_open + .pagination {
  margin-top: -<?php echo $base; ?>px;
  padding-top: <?php echo $base * 1.5 - 1; ?>px;
}


/*** carousel slider ***/

.tb_carousel {
  direction: ltr;
  position: relative;
}
.tb_carousel a,
.tb_carousel img
{
  display: block;
}
.tb_carousel a img {
  margin: 0 auto;
}


/*** Swiper Widget ************************************************/

.tb_listing.tb_slider {
  overflow: hidden;
  position: static;
  margin-top: -60px;
  margin-bottom: -60px;
  padding-top: 60px;
  padding-bottom: 60px;
  padding-left: 0 !important;
  padding-right: 0 !important;
  direction: ltr;
  -webkit-transition: height 0.5s ease-out;
          transition: height 0.5s ease-out;
}
.tb_listing.tb_slider .swiper-container {
  overflow: visible;
}
.swiper-container,
.swiper-container > .swiper-wrapper,
.swiper-container > .swiper-wrapper > .swiper-slide
{
  height: auto !important;
}
.swiper-container > .swiper-wrapper > .swiper-slide {
  direction: <?php echo $lang_dir; ?>;
}
.tb_slider_controls {
  z-index: 40;
  position: absolute;
  right: 0;
  top: 0;
  direction: ltr;
}
.tb_slider_controls .tb_prev,
.tb_slider_controls .tb_next,
.tb_slider_controls .tb_prev:before,
.tb_slider_controls .tb_next:before
{
  display: inline-block;
  text-align: center;
  cursor: pointer;
  outline: none !important;
  font-family: "Entypo" !important;
  font-size: 24px;
  font-weight: normal !important;
  vertical-align: top;
}
.tb_slider_controls .tb_prev,
.tb_slider_controls .tb_next
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base; ?>px;
  <?php endif; ?>
}
.tb_slider_controls .tb_prev:before {
  content: '\E765';
}
.tb_slider_controls .tb_next:before {
  content: '\E766';
}
.tb_slider_controls .tb_disabled {
  opacity: 0.5;
}
.tb_slider_load.tb_side_nav {
  margin-left: <?php echo $base * 2; ?>px;
  margin-right: <?php echo $base * 2 - 1; ?>px;
}
.tb_slider.tb_side_nav {
  margin-left: <?php echo $base * 2; ?>px;
  margin-right: <?php echo $base * 2; ?>px;
}
.tb_slider.tb_side_nav ~ .tb_slider_controls {
  position: static;
  visibility: hidden;
}
.tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev,
.tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next
{
  position: absolute;
  /* top: 50%; */
  margin-top: -<?php echo $base; ?>px;
  margin-left: 0;
  margin-right: 0;
}
.tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 0; }
.tb_pl_5  > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 5px;  }
.tb_pl_10 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 10px; }
.tb_pl_15 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 15px; }
.tb_pl_20 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 20px; }
.tb_pl_25 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 25px; }
.tb_pl_30 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 30px; }
.tb_pl_35 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 35px; }
.tb_pl_40 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 40px; }
.tb_pl_45 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 45px; }
.tb_pl_50 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev { left: 50px; }

.tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 0; }
.tb_pr_5  > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 5px;  }
.tb_pr_10 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 10px; }
.tb_pr_15 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 15px; }
.tb_pr_20 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 20px; }
.tb_pr_25 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 25px; }
.tb_pr_30 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 30px; }
.tb_pr_35 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 35px; }
.tb_pr_40 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 40px; }
.tb_pr_45 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 45px; }
.tb_pr_10 > .tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next { right: 50px; }

.tb_slider.tb_side_nav ~ .tb_slider_controls .tb_prev:before,
.tb_slider.tb_side_nav ~ .tb_slider_controls .tb_next:before
{
  font-size: 28px;
}


.tb_slider_pagination {
  overflow: hidden;
  text-align: center;
  min-height: <?php echo $base; ?>px;
  margin: <?php echo $base; ?>px 0 0 0;
}
.tb_slider_pagination span {
  position: relative;
  z-index: 20;
  display: inline-block;
  width: 8px;
  height: 8px;
  -webkit-border-radius: 50%;
          border-radius: 50%;
  cursor: pointer;
  background: #e3e3e3;
}
.tb_slider_pagination span:hover {
  background: #d9d9d9;
}
.tb_slider_pagination span + span {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base / 4 + 2; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base / 4 + 2; ?>px;
  <?php endif; ?>
}
.tb_slider_pagination.tb_size_2 span.tb_active + span,
.tb_slider_pagination.tb_size_2 span:nth-child(2n+1) + span,
.tb_slider_pagination.tb_size_3 span.tb_active + span,
.tb_slider_pagination.tb_size_3 span.tb_active + span + span,
.tb_slider_pagination.tb_size_3 span:nth-child(3n+1) + span,
.tb_slider_pagination.tb_size_3 span:nth-child(3n+1) + span + span,
.tb_slider_pagination.tb_size_4 span.tb_active + span,
.tb_slider_pagination.tb_size_4 span.tb_active + span + span,
.tb_slider_pagination.tb_size_4 span.tb_active + span + span + span,
.tb_slider_pagination.tb_size_4 span:nth-child(4n+1) + span,
.tb_slider_pagination.tb_size_4 span:nth-child(4n+1) + span + span,
.tb_slider_pagination.tb_size_4 span:nth-child(4n+1) + span + span + span,
.tb_slider_pagination.tb_size_5 span.tb_active + span,
.tb_slider_pagination.tb_size_5 span.tb_active + span + span,
.tb_slider_pagination.tb_size_5 span.tb_active + span + span + span,
.tb_slider_pagination.tb_size_5 span.tb_active + span + span + span + span,
.tb_slider_pagination.tb_size_5 span:nth-child(5n+1) + span,
.tb_slider_pagination.tb_size_5 span:nth-child(5n+1) + span + span,
.tb_slider_pagination.tb_size_5 span:nth-child(5n+1) + span + span + span,
.tb_slider_pagination.tb_size_5 span:nth-child(5n+1) + span + span + span + span,
.tb_slider_pagination.tb_size_6 span.tb_active + span,
.tb_slider_pagination.tb_size_6 span.tb_active + span + span,
.tb_slider_pagination.tb_size_6 span.tb_active + span + span + span,
.tb_slider_pagination.tb_size_6 span.tb_active + span + span + span + span,
.tb_slider_pagination.tb_size_6 span.tb_active + span + span + span + span + span,
.tb_slider_pagination.tb_size_6 span:nth-child(6n+1) + span,
.tb_slider_pagination.tb_size_6 span:nth-child(6n+1) + span + span,
.tb_slider_pagination.tb_size_6 span:nth-child(6n+1) + span + span + span,
.tb_slider_pagination.tb_size_6 span:nth-child(6n+1) + span + span + span + span,
.tb_slider_pagination.tb_size_6 span:nth-child(6n+1) + span + span + span + span + span,
.tb_slider_pagination.tb_size_7 span.tb_active + span,
.tb_slider_pagination.tb_size_7 span.tb_active + span + span,
.tb_slider_pagination.tb_size_7 span.tb_active + span + span + span,
.tb_slider_pagination.tb_size_7 span.tb_active + span + span + span + span,
.tb_slider_pagination.tb_size_7 span.tb_active + span + span + span + span + span,
.tb_slider_pagination.tb_size_7 span.tb_active + span + span + span + span + span + span,
.tb_slider_pagination.tb_size_7 span:nth-child(7n+1) + span,
.tb_slider_pagination.tb_size_7 span:nth-child(7n+1) + span + span + span,
.tb_slider_pagination.tb_size_7 span:nth-child(7n+1) + span + span + span + span,
.tb_slider_pagination.tb_size_7 span:nth-child(7n+1) + span + span + span + span + span,
.tb_slider_pagination.tb_size_7 span:nth-child(7n+1) + span + span + span + span + span + span
{
  display: none;
}
.tb_slider_pagination span.tb_active {
  display: inline-block !important;
  background: #bbb;
}
.tb_slider_pagination .swiper-active-switch {
  padding: 0;
}


.swiper-slide > .tb_item,
.swiper-slide > .tb_thumb,
.owl-item > .tb_item,
.owl-item > .tb_thumb
{
  float: none !important;
  width: auto !important;
  margin: 0 !important;
}
.swiper-slide > img {
  vertical-align: top;
}
.tb_listing.tb_gut_10 > .swiper-container { margin-left: -10px; }
.tb_listing.tb_gut_20 > .swiper-container { margin-left: -20px; }
.tb_listing.tb_gut_30 > .swiper-container { margin-left: -30px; }
.tb_listing.tb_gut_40 > .swiper-container { margin-left: -40px; }
.tb_listing.tb_gut_50 > .swiper-container { margin-left: -50px; }
.tb_listing.tb_gut_10 .swiper-slide { padding-left: 10px; }
.tb_listing.tb_gut_20 .swiper-slide { padding-left: 20px; }
.tb_listing.tb_gut_30 .swiper-slide { padding-left: 30px; }
.tb_listing.tb_gut_40 .swiper-slide { padding-left: 40px; }
.tb_listing.tb_gut_50 .swiper-slide { padding-left: 50px; }
.tb_listing.tb_size_1 .swiper-slide { width: 100%; }
.tb_listing.tb_size_2 .swiper-slide { width: 50%; }
.tb_listing.tb_size_3 .swiper-slide { width: 33.333333%; }
.tb_listing.tb_size_4 .swiper-slide { width: 25%; }
.tb_listing.tb_size_5 .swiper-slide { width: 20%; }
.tb_listing.tb_size_6 .swiper-slide { width: 16.666666%; }
.tb_listing.tb_size_7 .swiper-slide { width: 14.285714%; }
.tb_listing.tb_size_8 .swiper-slide { width: 12.5%;}

.has_slider .tb_listing.tb_list_view > .tb_item:first-child ~ .tb_item,
.has_slider .tb_listing.tb_size_1 > .tb_item:first-child ~ .tb_item,
.has_slider .tb_listing.tb_size_2 > .tb_item:first-child + .tb_item ~ .tb_item,
.has_slider .tb_listing.tb_size_3 > .tb_item:first-child + .tb_item + .tb_item ~ .tb_item,
.has_slider .tb_listing.tb_size_4 > .tb_item:first-child + .tb_item + .tb_item + .tb_item ~ .tb_item,
.has_slider .tb_listing.tb_size_5 > .tb_item:first-child + .tb_item + .tb_item + .tb_item + .tb_item ~ .tb_item,
.has_slider .tb_listing.tb_size_6 > .tb_item:first-child + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item ~ .tb_item,
.has_slider .tb_listing.tb_size_7 > .tb_item:first-child + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item ~ .tb_item,
.has_slider .tb_listing.tb_size_8 > .tb_item:first-child + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item ~ .tb_item
{
  display: none;
}

.tb_slider_init .swiper-slide {
  display: block !important;
}

.noty_close {
  position: absolute;
  display: block;
  width: 18px;
  height: 18px;
}
.noty_close:hover {
  background-position: 0 0;
}


.tb_category_thumb img {
  vertical-align: top;
}

.tb_subcategory {
  overflow: hidden;
}
.tb_subcategory h3 {
  margin: 0;
}
.tb_subcategory h3 + ul {
  padding-top: <?php echo $base * 0.5; ?>px;
}
.tb_subcategories.tb_cstyle_1 .tb_subcategory .tb_thumb {
  margin-bottom: <?php echo $base; ?>px;
}
.tb_subcategories.tb_image_left .tb_subcategory .tb_thumb {
  float: left;
  margin-right: <?php echo $base; ?>px;
  margin-bottom: 0;
}
.tb_subcategories.tb_image_right .tb_subcategory .tb_thumb {
  float: right;
  margin-left: <?php echo $base; ?>px;
  margin-bottom: 0;
}
.tb_subcategories.tb_image_left  .tb_subcategory .tb_thumb ~ *,
.tb_subcategories.tb_image_right .tb_subcategory .tb_thumb ~ *
{
  overflow: hidden;
}
.tb_subcategories.tb_cstyle_4 .tb_subcategory .tb_thumb,
.tb_subcategories.tb_cstyle_5 .tb_subcategory .tb_thumb
{
  margin-bottom: 0;
}
.tb_subcategories.tb_cstyle_4 .tb_subcategory h3,
.tb_subcategories.tb_cstyle_5 .tb_subcategory h3
{
  z-index: 2;
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  font-size: 15px;
}
.tb_subcategories.tb_cstyle_4 .tb_subcategory h3 a,
.tb_subcategories.tb_cstyle_5 .tb_subcategory h3 a
{
  display: block;
  padding: <?php echo $base; ?>px <?php echo $base * 0.5; ?>px;
}
.tb_subcategories.tb_cstyle_4 .tb_subcategory h3 {
  background: rgba(255, 255, 255, 0.7);
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.12);
}
#intro [class] .tb_subcategories.tb_cstyle_4 .tb_subcategory h3 a,
#content [class] .tb_subcategories.tb_cstyle_4 .tb_subcategory h3 a
{
  color: #333 !important;
}
#intro [class] .tb_subcategories.tb_cstyle_4 .tb_subcategory:hover h3 a,
#intro [class] .tb_subcategories.tb_cstyle_4 .tb_subcategory h3:hover a,
#content [class] .tb_subcategories.tb_cstyle_4 .tb_subcategory:hover h3 a,
#content [class] .tb_subcategories.tb_cstyle_4 .tb_subcategory h3:hover a
{
  color: #fff !important;
  background: #333;
}
.tb_subcategories.tb_cstyle_5 .tb_subcategory h3 {
  background: rgba(0, 0, 0, 0.5);
}
#intro [class] .tb_subcategories.tb_cstyle_5 .tb_subcategory h3 a,
#content [class] .tb_subcategories.tb_cstyle_5 .tb_subcategory h3 a
{
  color: #fff !important;
}
#intro [class] .tb_subcategories.tb_cstyle_5 .tb_subcategory:hover h3 a,
#intro [class] .tb_subcategories.tb_cstyle_5 .tb_subcategory h3:hover a,
#content [class] .tb_subcategories.tb_cstyle_5 .tb_subcategory:hover h3 a,
#content [class] .tb_subcategories.tb_cstyle_5 .tb_subcategory h3:hover a
{
  color: #000 !important;
  background: rgba(255, 255, 255, 0.8) !important;
}

.tb_widget_content:hover {
  position: relative !important;
  z-index: 10 !important;
}
/*
.tb_actions {
  direction: ltr;
}
*/
.tb_label_stock_status {
  opacity: 0.5;
}

/*** PRICE ***/

.tb_price .tb_old_price {
  position: relative;
}
.tb_price .tb_old_price:before {
  content: '';
  position: absolute;
  top: 50%;
  left: 0;
  display: block;
  width: 100%;
  margin-top: -1px;
  border-bottom: 1px solid;
}

/*** PRICE TAG ***/


/***** PROCUCT LISTING *************/

.tb_item {
  position: relative;
  z-index: 1;
}
.tb_item:hover {
  z-index: 2;
}
.tb_item .tb_thumb {
  z-index: 2;
}
.tb_item .tb_thumb .tb_front,
.tb_item .tb_thumb .tb_back
{
  margin: 0 !important;
  padding: 0 !important;
}
.tb_item .tb_item_info {
  position: relative;
}
.tb_item .tb_item_info:first-child,
.tb_item .tb_item_info:first-child > :first-child
{
  margin-top: 0 !important;
}
.tb_item .tb_item_info_hover {
  bottom: 0;
  right: 0;
}
.tb_item .tb_item_info_wrap {
  display: table;
  width: 100%;
  height: 100%;
  table-layout: fixed;
}
.tb_item .tb_item_info_wrap > .tb_item_info {
  display: table-cell;
  width: 100%;
  height: 100%;
}
.tb_item .tb_item_info > :last-child {
  margin-bottom: 0 !important;
}



.tb_overlay,
.tb_flip
{
  position: relative;
  -webkit-perspective: 800px;
     -moz-perspective: 800px;
          perspective: 800px;
}
.tb_flip {
  background: transparent !important;
}
.tb_overlay .tb_front,
.tb_overlay .tb_back,
.tb_flip .tb_front,
.tb_flip .tb_back
{
  -webkit-backface-visibility: hidden;
     -moz-backface-visibility: hidden;
          backface-visibility: hidden;
}
.tb_overlay .tb_front,
.tb_overlay .tb_back
{
  -webkit-transition: all 0.6s ease-out;
          transition: all 0.6s ease-out;
}
.tb_flip .tb_front,
.tb_flip .tb_back
{
  -webkit-transition: all 0.5s ease-in-out;
          transition: all 0.5s ease-in-out;
}
.tb_overlay .tb_front,
.tb_flip .tb_front
{
  z-index: 3;
  position: relative;
}
.tb_overlay .tb_back,
.tb_flip .tb_back
{
  z-index: 2;
  position: absolute;
  top: 0;
  left: 0;
  margin: 0 !important;
}
.tb_overlay:hover .tb_back,
.tb_flip:hover .tb_back
{
  z-index: 4;
}
.tb_overlay:hover .tb_front,
.tb_overlay .tb_back
{
  opacity: 0;
}
.tb_overlay .tb_front,
.tb_overlay:hover .tb_back
{
  opacity: 1;
}
.tb_flip .tb_front {
  height: 100%;
  -webkit-transform: rotateY(0deg);
     -moz-transform: rotateY(0deg);
          transform: rotateY(0deg);
}
.tb_flip:hover .tb_front {
  -webkit-transform: rotateY(180deg);
     -moz-transform: rotateY(180deg);
          transform: rotateY(180deg);
}
.tb_flip .tb_back {
  -webkit-transform: rotateY(-180deg);
     -moz-transform: rotateY(-180deg);
          transform: rotateY(-180deg);
}
.tb_flip:hover .tb_back {
  -webkit-transform: rotateY(0);
     -moz-transform: rotateY(0);
          transform: rotateY(0);
}



.tb_product p.tb_model {
  margin-top: -<?php echo $base / 2; ?>px;
  margin-bottom: <?php echo $base / 2; ?>px;
  color: #999;
  font-size: 11px;
}
.tb_product h3 + .tb_price_holder {
  margin-top: -<?php echo $base / 2; ?>px;
}
.tb_product .tb_description {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
.tb_product .tb_description:empty {
  display: none;
}
.tb_product .tb_price_holder.tb_label,
.tb_product .tb_label_special
{
  z-index: 10;
}
.tb_product .tb_label_special,
.tb_product .tb_label_new
{
  position: absolute;
  top: 0;
  left: 0;
  z-index: 2;
  display: block;
  min-width: 32px;
  height: <?php echo $base; ?>px;
  padding: 1px <?php echo $base / 4 + 2; ?>px;
  text-align: center;
  text-shadow: 0 1px 0 rgba(0, 0, 0, 0.2);
  font-weight: 600;
}
.tb_product .tb_label_special > span:before {
  content: '-'
}
.tb_product .tb_label_special > span span {
  font-weight: normal;
}
.tb_product .tb_label_special small {
  display: none;
}
.tb_product .tb_label_new {
  background: #90c819;
  color: #fff;
  text-transform: uppercase;
}
.tb_product .tb_label_special + .tb_label_new {
  top: <?php echo $base + 2; ?>px;
}
.tb_product .tb_rating_holder {
  margin-bottom: 0;
}
.tb_product .tb_button_add_to_cart {
  margin-top: 0;
  margin-bottom: <?php echo $base / 2; ?>px;
}
.tb_product .tb_button_wishlist,
.tb_product .tb_button_compare
{
  color: #999;
}
.tb_product .tb_button_wishlist .tb_add_10 {
  background-color: #ccc;
  background-position: -11px -488px !important;
}
.tb_product .tb_button_compare .tb_add_10 {
  background-color: #ccc;
  background-position: -21px -488px !important;
}
.tb_product .tb_label_stock_status {
  margin-bottom: 0;
  font-size: <?php echo $base_font_size; ?>px;
}
.tb_product .tb_review {
  clear: both;
  padding-top: <?php echo $base * 0.5; ?>px;
}
.tb_listing .tb_item > .tb_thumb_hover {
  display: none;
}
.tb_listing.tb_review_tooltip .tb_price_holder {
  display: table-footer-group;
}
.tb_listing.tb_review_tooltip .tb_review {
  display: table-header-group;
}
.tb_listing.tb_review_tooltip .tb_review > p + .tb_meta {
  padding-left: 0;
  padding-right: 0;
}
.tb_listing.tb_review_tooltip .tb_product .tb_review > p,
.tb_listing.tb_review_tooltip .tb_product .tb_review .tb_author
{
  display: none;
}
.tb_listing.tb_review_tooltip .tb_rating_holder,
.tb_listing.tb_review_tooltip .tb_review p + .tb_meta .tb_rating_holder
{
  margin-top: 0;
  margin-bottom: 0;
  cursor: help;
}
.tb_listing.tb_review_tooltip .tb_rating_holder .tb_rating,
.tb_listing.tb_review_tooltip .tb_rating_holder .tb_rating *
{
  font-size: 12px;
}
.tb_listing.tb_review_tooltip .tb_rating_holder .tb_average {
  margin-top: 0;
  font-weight: normal;
  font-size: 0.85em;
}

/***** PROCUCT list view ******/

.tb_list_view > .tb_item {
  clear: both;
  margin-top: <?php echo $base * 1.5; ?>px;
}
.tb_list_view > .tb_item > .tb_thumb {
  max-width: 50%;
}
.tb_list_view.tb_style_2 {
  margin-bottom: 0;
}
.tb_list_view.tb_style_2 > .tb_item,
.tb_list_view > .tb_item:first-child
{
  margin-top: 0 !important;
}
.tb_list_view .tb_item .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base; ?>px;
  <?php endif; ?>
}
.tb_list_view.tb_gut_10 .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?>margin-right: 10px;<?php else: ?>margin-left: 10px;<?php endif; ?> }
.tb_list_view.tb_gut_20 .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?>margin-right: 20px;<?php else: ?>margin-left: 20px;<?php endif; ?> }
.tb_list_view.tb_gut_30 .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?>margin-right: 30px;<?php else: ?>margin-left: 30px;<?php endif; ?> }
.tb_list_view.tb_gut_40 .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?>margin-right: 40px;<?php else: ?>margin-left: 40px;<?php endif; ?> }
.tb_list_view.tb_gut_50 .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?>margin-right: 50px;<?php else: ?>margin-left: 50px;<?php endif; ?> }

.tb_list_view .tb_item_info {
  overflow: hidden;
}
.tb_list_view .tb_item h3 {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_list_view .tb_item .tb_price_holder {
  margin: 0 0 <?php echo $base * 0.5; ?>px 0;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.tb_list_view .tb_item .tb_description,
.tb_list_view .tb_item .tb_rating_holder,
.tb_list_view .tb_item .tb_actions
{
  clear: both;
}
.tb_list_view .tb_item .tb_actions {
  margin-top: <?php echo $base; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.tb_list_view .tb_item_info > .tb_rating_holder {
  margin-top: -<?php echo $base * 0.5; ?>px;
  margin-bottom: -<?php echo $base * 0.5; ?>px;
}
.tb_list_view .tb_product .tb_button_add_to_cart {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  margin-bottom: 0;
}
.tb_list_view .tb_product .tb_button_add_to_cart .tb_button {
  position: relative;
}
.tb_list_view .tb_product .tb_button_add_to_cart .tb_button.tb_h_24,
.tb_list_view .tb_product .tb_button_add_to_cart .tb_button.tb_h_30
{
  top: <?php echo $base; ?>px;
}
.tb_list_view .tb_product .tb_button_add_to_cart .tb_button.tb_h_24,
.tb_list_view .tb_product .tb_button_add_to_cart .tb_button.tb_h_30
{
  top: <?php echo $base * 0.25; ?>px;
}
.tb_list_view .tb_product .tb_label_stock_status {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_list_view .tb_item.last {
  border-bottom: none;
}


/***** PROCUCT grid view ******/

.tb_grid_view .tb_item .tb_thumb {
  float: none;
  margin-bottom: <?php echo $base; ?>px;
}
.tb_grid_view .tb_item .tb_thumb:last-child {
  margin-bottom: 0;
}
.tb_grid_view .tb_item .tb_thumb_hover {
  width: 100%;
}
.tb_grid_view .tb_product .tb_item_info {
  text-align: center;
}
.tb_grid_view .tb_product .tb_item_info > * + * {
  margin-top: <?php echo $base * 0.5; ?>px;
  margin-bottom: 0;
}
.tb_grid_view .tb_product .tb_item_info h3 {
  margin-bottom: 0;
}
.tb_grid_view .tb_product .tb_item_info h3 + .tb_actions {
  padding-top: <?php echo $base * 0.5; ?>px;
}
.tb_grid_view .tb_product .tb_item_info h3 a {
  display: block;
}
.tb_grid_view .tb_product .tb_item_info .tb_description {
  padding: <?php echo $base * 0.5; ?>px 0;
}
.tb_grid_view .tb_button_add_to_cart {
  margin-bottom: 0;
}
.tb_grid_view .tb_rating_holder .tb_average {
  display: none;
}
.tb_grid_view .tb_product.tb_item_short:hover {
  margin: -20px -10px -21px -10px;
}
.tb_grid_view .tb_product .tb_actions {
  /* overflow: hidden; */
  clear: both;
  width: auto;
  margin-top: 0;
  padding-left: 10px;
  text-align: center;
  font-size: 11px;
  color: #999;
}
.tb_grid_view .tb_product .tb_actions > * {
  margin-right: 10px;
  margin-top: <?php echo $base * 0.5; ?>px;
}
.tb_grid_view .tb_product .tb_actions .tb_button_wishlist,
.tb_grid_view .tb_product .tb_actions .tb_button_compare
{
  display: inline-block;
  white-space: nowrap;
}
.tb_grid_view .tb_item_hovered {
  z-index: 40;
  position: absolute;
  top: -20%;
  left: -10%;
  width: 120%;
  margin-right: -20px;
  margin-left: -20px;
  padding: <?php echo $base; ?>px;
  background: #fff;
  box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
  -o-box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
  -webkit-box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
}
.tb_grid_view.tb_style_1.tb_exclude_thumb .tb_item_hovered {
  top: -10%;
  left: -5%;
  width: 110%;
}
.tb_grid_view.tb_style_1.tb_exclude_thumb .tb_item_hovered .tb_thumb {
  margin-top: -<?php echo $base; ?>px;
  margin-left: -<?php echo $base; ?>px;
  margin-right: -<?php echo $base; ?>px;
}
.tb_grid_view.tb_style_2 .tb_item_hovered,
.tb_grid_view.tb_style_3 .tb_item_hovered
{
  top: -10%;
  left: 0;
  width: 100%;
}
.tb_grid_view .tb_item_hovered * {
  z-index: 40;
}
.tb_grid_view .tb_item_hovered .tb_actions .tb_button_add_to_cart {
  display: block;
}
.tb_grid_view .tb_item_hovered .tb_actions .tb_button_wishlist,
.tb_grid_view .tb_item_hovered .tb_actions .tb_button_compare
{
  display: inline-block;
}

.tb_product .tb_actions > .tb_hidden {
  overflow: hidden;
  display: inline-block !important;
  height: 0;
  opacity: 0;
}
.tb_product:hover .tb_actions > .tb_hidden,
.is_touch .tb_product .tb_actions > .tb_hidden
{
  overflow: visible;
  height: auto;
  opacity: 1;
}
.tb_actions > .tb_position_2 {
  display: inline-block;
}
.tb_actions > .tb_position_3,
.tb_actions > .tb_position_4,
.tb_actions > .tb_position_5
{
  z-index: 5;
  position: absolute;
  top: -<?php echo $base * 3; ?>px;
  -webkit-transition: opacity 0.3s ease-in-out;
          transition: opacity 0.3s ease-in-out
}
.tb_actions > .tb_position_3 .tb_button,
.tb_actions > .tb_position_4 .tb_button,
.tb_actions > .tb_position_5 .tb_button,
.tb_actions > .tb_position_6 .tb_button
{
  margin-top: 0;
  margin-bottom: 0;
}
.tb_product .tb_actions > .tb_position_3 { right: 0;  }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_4 { left: 50%; }
.tb_product .tb_actions > .tb_position_5 { left: 0;   }

.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_20 ~ .tb_position_3 { right: 20px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_24 ~ .tb_position_3 { right: 24px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_30 ~ .tb_position_3 { right: 30px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_34 ~ .tb_position_3 { right: 34px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_40 ~ .tb_position_3 { right: 40px; }

.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_20.tb_hidden ~ .tb_position_3,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_24.tb_hidden ~ .tb_position_3,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_30.tb_hidden ~ .tb_position_3,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_34.tb_hidden ~ .tb_position_3,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_3.tb_h_40.tb_hidden ~ .tb_position_3 { right: 0; }

.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_3.tb_h_20 + .tb_position_3 { right: 20px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_3.tb_h_24 + .tb_position_3 { right: 24px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_3.tb_h_30 + .tb_position_3 { right: 30px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_3.tb_h_34 + .tb_position_3 { right: 34px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_3.tb_h_40 + .tb_position_3 { right: 40px !important; }

.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_20 ~ .tb_position_5 { left: 20px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_24 ~ .tb_position_5 { left: 24px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_30 ~ .tb_position_5 { left: 30px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_34 ~ .tb_position_5 { left: 34px; }
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_40 ~ .tb_position_5 { left: 40px; }

.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_20.tb_hidden ~ .tb_position_5,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_24.tb_hidden ~ .tb_position_5,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_30.tb_hidden ~ .tb_position_5,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_34.tb_hidden ~ .tb_position_5,
.tb_grid_view.tb_buttons_1 .tb_product .tb_actions > .tb_position_5.tb_h_40.tb_hidden ~ .tb_position_5 { left: 0; }

.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_5.tb_h_20 + .tb_position_5 { left: 20px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_5.tb_h_24 + .tb_position_5 { left: 24px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_5.tb_h_30 + .tb_position_5 { left: 30px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_5.tb_h_34 + .tb_position_5 { left: 34px !important; }
.tb_grid_view.tb_buttons_1 .tb_product:hover .tb_actions > .tb_position_5.tb_h_40 + .tb_position_5 { left: 40px !important; }

.tb_grid_view.tb_buttons_2 .tb_product .tb_actions {
  z-index: 5;
  position: absolute;
  left: 0;
  right: 0;
  top: -<?php echo $base * 3; ?>px;
  margin: 0 !important;
  padding: 0 !important;
  word-spacing: -0.26em;
}
.tb_grid_view.tb_buttons_2 .tb_product .tb_actions > * {
  position: static;
  top: 0;
  display: inline-block;
  text-align: center;
  word-spacing: normal;
}
.tb_grid_view.tb_buttons_2 .tb_product .tb_actions .tb_position_3 {
  float: right;
}
.tb_grid_view.tb_buttons_2 .tb_product .tb_actions .tb_position_4 {
  position: static;
}
.tb_grid_view.tb_buttons_2 .tb_product .tb_actions .tb_position_5 {
  float: left;
}


.tb_listing.tb_hover_append:hover {
  z-index: 40 !important;
}
.tb_listing.tb_hover_append.tb_slider {
}
.tb_listing.tb_hover_append .tb_item:hover {
  z-index: auto;
}

/***** Item grid view sizes ******/

.tb_grid_view.tb_size_2.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 10px;<?php else: ?>padding-left: 10px;<?php endif; ?> }
.tb_grid_view.tb_size_2.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 20px;<?php else: ?>padding-left: 20px;<?php endif; ?> }
.tb_grid_view.tb_size_2.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 30px;<?php else: ?>padding-left: 30px;<?php endif; ?> }
.tb_grid_view.tb_size_2.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 40px;<?php else: ?>padding-left: 40px;<?php endif; ?> }
.tb_grid_view.tb_size_2.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 50px;<?php else: ?>padding-left: 50px;<?php endif; ?> }
.tb_grid_view.tb_size_3.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 20px;<?php else: ?>padding-left: 20px;<?php endif; ?> }
.tb_grid_view.tb_size_3.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 40px;<?php else: ?>padding-left: 40px;<?php endif; ?> }
.tb_grid_view.tb_size_3.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 60px;<?php else: ?>padding-left: 60px;<?php endif; ?> }
.tb_grid_view.tb_size_3.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 80px;<?php else: ?>padding-left: 80px;<?php endif; ?> }
.tb_grid_view.tb_size_3.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 100px;<?php else: ?>padding-left: 100px;<?php endif; ?> }
.tb_grid_view.tb_size_4.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 30px;<?php else: ?>padding-left: 30px;<?php endif; ?> }
.tb_grid_view.tb_size_4.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 60px;<?php else: ?>padding-left: 60px;<?php endif; ?> }
.tb_grid_view.tb_size_4.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 90px;<?php else: ?>padding-left: 90px;<?php endif; ?> }
.tb_grid_view.tb_size_4.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 120px;<?php else: ?>padding-left: 120px;<?php endif; ?> }
.tb_grid_view.tb_size_4.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 150px;<?php else: ?>padding-left: 150px;<?php endif; ?> }
.tb_grid_view.tb_size_5.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 40px;<?php else: ?>padding-left: 40px;<?php endif; ?> }
.tb_grid_view.tb_size_5.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 80px;<?php else: ?>padding-left: 80px;<?php endif; ?> }
.tb_grid_view.tb_size_5.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 120px;<?php else: ?>padding-left: 120px;<?php endif; ?> }
.tb_grid_view.tb_size_5.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 160px;<?php else: ?>padding-left: 160px;<?php endif; ?> }
.tb_grid_view.tb_size_5.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 200px;<?php else: ?>padding-left: 200px;<?php endif; ?> }
.tb_grid_view.tb_size_6.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 50px;<?php else: ?>padding-left: 50px;<?php endif; ?> }
.tb_grid_view.tb_size_6.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 100px;<?php else: ?>padding-left: 100px;<?php endif; ?> }
.tb_grid_view.tb_size_6.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 150px;<?php else: ?>padding-left: 150px;<?php endif; ?> }
.tb_grid_view.tb_size_6.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 200px;<?php else: ?>padding-left: 200px;<?php endif; ?> }
.tb_grid_view.tb_size_6.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 250px;<?php else: ?>padding-left: 250px;<?php endif; ?> }
.tb_grid_view.tb_size_7.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 60px;<?php else: ?>padding-left: 60px;<?php endif; ?> }
.tb_grid_view.tb_size_7.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 120px;<?php else: ?>padding-left: 120px;<?php endif; ?> }
.tb_grid_view.tb_size_7.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 180px;<?php else: ?>padding-left: 180px;<?php endif; ?> }
.tb_grid_view.tb_size_7.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 240px;<?php else: ?>padding-left: 240px;<?php endif; ?> }
.tb_grid_view.tb_size_7.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 300px;<?php else: ?>padding-left: 300px;<?php endif; ?> }
.tb_grid_view.tb_size_8.tb_gut_10 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 70px;<?php else: ?>padding-left: 70px;<?php endif; ?> }
.tb_grid_view.tb_size_8.tb_gut_20 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 140px;<?php else: ?>padding-left: 140px;<?php endif; ?> }
.tb_grid_view.tb_size_8.tb_gut_30 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 210px;<?php else: ?>padding-left: 210px;<?php endif; ?> }
.tb_grid_view.tb_size_8.tb_gut_40 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 280px;<?php else: ?>padding-left: 280px;<?php endif; ?> }
.tb_grid_view.tb_size_8.tb_gut_50 { <?php if ($lang_dir == 'ltr'): ?>padding-right: 350px;<?php else: ?>padding-left: 350px;<?php endif; ?> }

.tb_grid_view.tb_size_1 .tb_item { width: 100%; height: auto !important; }
.tb_grid_view.tb_size_2 .tb_item { width: 50%; }
.tb_grid_view.tb_size_3 .tb_item { width: 33.333333%; }
.tb_grid_view.tb_size_4 .tb_item { width: 25%; }
.tb_grid_view.tb_size_5 .tb_item { width: 20%; }
.tb_grid_view.tb_size_6 .tb_item { width: 16.666666%; }
.tb_grid_view.tb_size_7 .tb_item { width: 14.285714%; }
.tb_grid_view.tb_size_8 .tb_item { width: 12.5%;}

.tb_grid_view .tb_item {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: -3000px;
  <?php else: ?>
  float: right;
  margin-left: -3000px;
  <?php endif; ?>
}
.tb_grid_view.tb_size_1 .tb_item,
.tb_grid_view.tb_size_2 .clear2,
.tb_grid_view.tb_size_3 .clear3,
.tb_grid_view.tb_size_4 .clear4,
.tb_grid_view.tb_size_5 .clear5,
.tb_grid_view.tb_size_6 .clear6,
.tb_grid_view.tb_size_7 .clear7,
.tb_grid_view.tb_size_8 .clear8
{
  <?php if ($lang_dir == 'ltr'): ?>
  clear: left;
  <?php else: ?>
  clear: right;
  <?php endif; ?>
}
.tb_grid_view.tb_size_2 .tb_item.clear2 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 50%;<?php else: ?>right: 50%;<?php endif; ?> }
.tb_grid_view.tb_size_3 .tb_item.clear3 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 33.333333%;<?php else: ?>right: 33.333333%;<?php endif; ?> }
.tb_grid_view.tb_size_3 .tb_item.clear3 + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 66.666666%;<?php else: ?>right: 66.666666%;<?php endif; ?> }
.tb_grid_view.tb_size_4 .tb_item.clear4 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 25%;<?php else: ?>right: 25%;<?php endif; ?> }
.tb_grid_view.tb_size_4 .tb_item.clear4 + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 50%;<?php else: ?>right: 50%;<?php endif; ?> }
.tb_grid_view.tb_size_4 .tb_item.clear4 + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 75%;<?php else: ?>right: 75%;<?php endif; ?> }
.tb_grid_view.tb_size_5 .tb_item.clear5 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 20%;<?php else: ?>right: 20%;<?php endif; ?> }
.tb_grid_view.tb_size_5 .tb_item.clear5 + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 40%;<?php else: ?>right: 40%;<?php endif; ?> }
.tb_grid_view.tb_size_5 .tb_item.clear5 + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 60%;<?php else: ?>right: 60%;<?php endif; ?> }
.tb_grid_view.tb_size_5 .tb_item.clear5 + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 80%;<?php else: ?>right: 80%;<?php endif; ?> }
.tb_grid_view.tb_size_6 .tb_item.clear6 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 16.666666%;<?php else: ?>right: 16.666666%;<?php endif; ?> }
.tb_grid_view.tb_size_6 .tb_item.clear6 + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 33.333333%;<?php else: ?>right: 33.333333%;<?php endif; ?> }
.tb_grid_view.tb_size_6 .tb_item.clear6 + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 50%;<?php else: ?>right: 50%;<?php endif; ?> }
.tb_grid_view.tb_size_6 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 66.666666%;<?php else: ?>right: 66.666666%;<?php endif; ?> }
.tb_grid_view.tb_size_6 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 83.333333%;<?php else: ?>right: 83.333333%;<?php endif; ?> }
.tb_grid_view.tb_size_7 .tb_item.clear7 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 14.285714%;<?php else: ?>right: 14.285714%;<?php endif; ?> }
.tb_grid_view.tb_size_7 .tb_item.clear7 + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 28.571428%;<?php else: ?>right: 28.571428%;<?php endif; ?> }
.tb_grid_view.tb_size_7 .tb_item.clear7 + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 42.857142%;<?php else: ?>right: 42.857142%;<?php endif; ?> }
.tb_grid_view.tb_size_7 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 57.142857%;<?php else: ?>right: 57.142857%;<?php endif; ?> }
.tb_grid_view.tb_size_7 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 71.428571%;<?php else: ?>right: 71.428571%;<?php endif; ?> }
.tb_grid_view.tb_size_7 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 85.714285%;<?php else: ?>right: 85.714285%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 12.5%;<?php else: ?>right: 12.5%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 25%;<?php else: ?>right: 25%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 37.5%;<?php else: ?>right: 37.5%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 50%;<?php else: ?>right: 50%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 62.5%;<?php else: ?>right: 62.5%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 75%;<?php else: ?>right: 75%;<?php endif; ?> }
.tb_grid_view.tb_size_8 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item { <?php if ($lang_dir == 'ltr'): ?>left: 87.5%;<?php else: ?>right: 87.5%;<?php endif; ?> }

.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item {
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 70px;<?php else: ?>margin-right: 70px;<?php endif; ?>
}
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item {
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 140px;<?php else: ?>margin-right: 140px;<?php endif; ?>
}
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 210px;<?php else: ?>margin-right: 210px;<?php endif; ?>
}
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 280px;<?php else: ?>margin-right: 280px;<?php endif; ?>
}
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 350px;<?php else: ?>margin-right: 350px;<?php endif; ?>
}
.tb_grid_view.tb_size_7.tb_gut_10 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 60px;<?php else: ?>margin-right: 60px;<?php endif; ?>
}
.tb_grid_view.tb_size_7.tb_gut_20 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 120px;<?php else: ?>margin-right: 120px;<?php endif; ?>
}
.tb_grid_view.tb_size_7.tb_gut_30 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 180px;<?php else: ?>margin-right: 180px;<?php endif; ?>
}
.tb_grid_view.tb_size_7.tb_gut_40 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 240px;<?php else: ?>margin-right: 240px;<?php endif; ?>
}
.tb_grid_view.tb_size_7.tb_gut_50 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 300px;<?php else: ?>margin-right: 300px;<?php endif; ?>
}
.tb_grid_view.tb_size_6.tb_gut_10 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_10 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 50px;<?php else: ?>margin-right: 50px;<?php endif; ?>
}
.tb_grid_view.tb_size_6.tb_gut_20 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_20 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 100px;<?php else: ?>margin-right: 100px;<?php endif; ?>
}
.tb_grid_view.tb_size_6.tb_gut_30 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_30 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 150px;<?php else: ?>margin-right: 150px;<?php endif; ?>
}
.tb_grid_view.tb_size_6.tb_gut_40 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_40 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 200px;<?php else: ?>margin-right: 200px;<?php endif; ?>
}
.tb_grid_view.tb_size_6.tb_gut_50 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_50 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 250px;<?php else: ?>margin-right: 250px;<?php endif; ?>
}
.tb_grid_view.tb_size_5.tb_gut_10 .tb_item.clear5 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_10 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_10 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 40px;<?php else: ?>margin-right: 40px;<?php endif; ?>
}
.tb_grid_view.tb_size_5.tb_gut_20 .tb_item.clear5 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_20 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_20 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 80px;<?php else: ?>margin-right: 80px;<?php endif; ?>
}
.tb_grid_view.tb_size_5.tb_gut_30 .tb_item.clear5 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_30 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_30 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 120px;<?php else: ?>margin-right: 120px;<?php endif; ?>
}
.tb_grid_view.tb_size_5.tb_gut_40 .tb_item.clear5 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_40 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_40 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 160px;<?php else: ?>margin-right: 160px;<?php endif; ?>
}
.tb_grid_view.tb_size_5.tb_gut_50 .tb_item.clear5 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_50 .tb_item.clear6 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_50 .tb_item.clear7 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 200px;<?php else: ?>margin-right: 200px;<?php endif; ?>
}
.tb_grid_view.tb_size_4.tb_gut_10 .tb_item.clear4 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_10 .tb_item.clear5 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_10 .tb_item.clear6 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_10 .tb_item.clear7 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 30px;<?php else: ?>margin-right: 30px;<?php endif; ?>
}
.tb_grid_view.tb_size_4.tb_gut_20 .tb_item.clear4 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_20 .tb_item.clear5 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_20 .tb_item.clear6 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_20 .tb_item.clear7 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 60px;<?php else: ?>margin-right: 60px;<?php endif; ?>
}
.tb_grid_view.tb_size_4.tb_gut_30 .tb_item.clear4 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_30 .tb_item.clear5 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_30 .tb_item.clear6 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_30 .tb_item.clear7 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 90px;<?php else: ?>margin-right: 90px;<?php endif; ?>
}
.tb_grid_view.tb_size_4.tb_gut_40 .tb_item.clear4 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_40 .tb_item.clear5 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_40 .tb_item.clear6 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_40 .tb_item.clear7 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 120px;<?php else: ?>margin-right: 120px;<?php endif; ?>
}
.tb_grid_view.tb_size_4.tb_gut_50 .tb_item.clear4 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_50 .tb_item.clear5 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_50 .tb_item.clear6 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_50 .tb_item.clear7 + .tb_item + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 150px;<?php else: ?>margin-right: 150px;<?php endif; ?>
}
.tb_grid_view.tb_size_3.tb_gut_10 .tb_item.clear3 + .tb_item + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_10 .tb_item.clear4 + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_10 .tb_item.clear5 + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_10 .tb_item.clear6 + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_10 .tb_item.clear7 + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 20px;<?php else: ?>margin-right: 20px;<?php endif; ?>
}
.tb_grid_view.tb_size_3.tb_gut_20 .tb_item.clear3 + .tb_item + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_20 .tb_item.clear4 + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_20 .tb_item.clear5 + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_20 .tb_item.clear6 + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_20 .tb_item.clear7 + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 40px;<?php else: ?>margin-right: 50px;<?php endif; ?>
}
.tb_grid_view.tb_size_3.tb_gut_30 .tb_item.clear3 + .tb_item + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_30 .tb_item.clear4 + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_30 .tb_item.clear5 + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_30 .tb_item.clear6 + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_30 .tb_item.clear7 + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 60px;<?php else: ?>margin-right: 60px;<?php endif; ?>
}
.tb_grid_view.tb_size_3.tb_gut_40 .tb_item.clear3 + .tb_item + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_40 .tb_item.clear4 + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_40 .tb_item.clear5 + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_40 .tb_item.clear6 + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_40 .tb_item.clear7 + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 80px;<?php else: ?>margin-right: 80px;<?php endif; ?>
}
.tb_grid_view.tb_size_3.tb_gut_50 .tb_item.clear3 + .tb_item + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_50 .tb_item.clear4 + .tb_item + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_50 .tb_item.clear5 + .tb_item + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_50 .tb_item.clear6 + .tb_item + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_50 .tb_item.clear7 + .tb_item + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 100px;<?php else: ?>margin-right: 100px;<?php endif; ?>
}
.tb_grid_view.tb_size_2.tb_gut_10 .tb_item.clear2 + .tb_item,
.tb_grid_view.tb_size_3.tb_gut_10 .tb_item.clear3 + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_10 .tb_item.clear4 + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_10 .tb_item.clear5 + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_10 .tb_item.clear6 + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_10 .tb_item.clear7 + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_10 .tb_item.clear8 + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 10px;<?php else: ?>margin-right: 10px;<?php endif; ?>
}
.tb_grid_view.tb_size_2.tb_gut_20 .tb_item.clear2 + .tb_item,
.tb_grid_view.tb_size_3.tb_gut_20 .tb_item.clear3 + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_20 .tb_item.clear4 + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_20 .tb_item.clear5 + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_20 .tb_item.clear6 + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_20 .tb_item.clear7 + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_20 .tb_item.clear8 + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 20px;<?php else: ?>margin-right: 20px;<?php endif; ?>
}
.tb_grid_view.tb_size_2.tb_gut_30 .tb_item.clear2 + .tb_item,
.tb_grid_view.tb_size_3.tb_gut_30 .tb_item.clear3 + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_30 .tb_item.clear4 + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_30 .tb_item.clear5 + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_30 .tb_item.clear6 + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_30 .tb_item.clear7 + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_30 .tb_item.clear8 + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 30px;<?php else: ?>margin-right: 30px;<?php endif; ?>
}
.tb_grid_view.tb_size_2.tb_gut_40 .tb_item.clear2 + .tb_item,
.tb_grid_view.tb_size_3.tb_gut_40 .tb_item.clear3 + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_40 .tb_item.clear4 + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_40 .tb_item.clear5 + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_40 .tb_item.clear6 + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_40 .tb_item.clear7 + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_40 .tb_item.clear8 + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 40px;<?php else: ?>margin-right: 40px;<?php endif; ?>
}
.tb_grid_view.tb_size_2.tb_gut_50 .tb_item.clear2 + .tb_item,
.tb_grid_view.tb_size_3.tb_gut_50 .tb_item.clear3 + .tb_item,
.tb_grid_view.tb_size_4.tb_gut_50 .tb_item.clear4 + .tb_item,
.tb_grid_view.tb_size_5.tb_gut_50 .tb_item.clear5 + .tb_item,
.tb_grid_view.tb_size_6.tb_gut_50 .tb_item.clear6 + .tb_item,
.tb_grid_view.tb_size_7.tb_gut_50 .tb_item.clear7 + .tb_item,
.tb_grid_view.tb_size_8.tb_gut_50 .tb_item.clear8 + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 50px;<?php else: ?>margin-right: 50px;<?php endif; ?>
}
.tb_grid_view.tb_size_2 .tb_item.clear2,
.tb_grid_view.tb_size_3 .tb_item.clear3,
.tb_grid_view.tb_size_4 .tb_item.clear4,
.tb_grid_view.tb_size_5 .tb_item.clear5,
.tb_grid_view.tb_size_6 .tb_item.clear6,
.tb_grid_view.tb_size_7 .tb_item.clear7,
.tb_grid_view.tb_size_8 .tb_item.clear8
{
  <?php if ($lang_dir == 'ltr'): ?>margin-left: 0;<?php else: ?>margin-right: 0;<?php endif; ?>
}
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item + .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_grid_view[class*="tb_size_"].tb_gut_0 .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  left: auto;
  right: auto;
  margin-left: 0;
  margin-right: 0;
}
.tb_grid_view.tb_gut_10.tb_size_1 .tb_item:first-child ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_2 .tb_item:first-child ~ .tb_item.clear2,
.tb_grid_view.tb_gut_10.tb_size_2 .tb_item:first-child ~ .tb_item.clear2 ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_3 .tb_item:first-child ~ .tb_item.clear3,
.tb_grid_view.tb_gut_10.tb_size_3 .tb_item:first-child ~ .tb_item.clear3 ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_4 .tb_item:first-child ~ .tb_item.clear4,
.tb_grid_view.tb_gut_10.tb_size_4 .tb_item:first-child ~ .tb_item.clear4 ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_5 .tb_item:first-child ~ .tb_item.clear5,
.tb_grid_view.tb_gut_10.tb_size_5 .tb_item:first-child ~ .tb_item.clear5 ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_6 .tb_item:first-child ~ .tb_item.clear6,
.tb_grid_view.tb_gut_10.tb_size_6 .tb_item:first-child ~ .tb_item.clear6 ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_7 .tb_item:first-child ~ .tb_item.clear7,
.tb_grid_view.tb_gut_10.tb_size_7 .tb_item:first-child ~ .tb_item.clear7 ~ .tb_item,
.tb_grid_view.tb_gut_10.tb_size_8 .tb_item:first-child ~ .tb_item.clear8,
.tb_grid_view.tb_gut_10.tb_size_8 .tb_item:first-child ~ .tb_item.clear8 ~ .tb_item
{
  margin-top: 10px;
}
.tb_grid_view.tb_gut_20.tb_size_1 .tb_item:first-child ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_2 .tb_item:first-child ~ .tb_item.clear2,
.tb_grid_view.tb_gut_20.tb_size_2 .tb_item:first-child ~ .tb_item.clear2 ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_3 .tb_item:first-child ~ .tb_item.clear3,
.tb_grid_view.tb_gut_20.tb_size_3 .tb_item:first-child ~ .tb_item.clear3 ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_4 .tb_item:first-child ~ .tb_item.clear4,
.tb_grid_view.tb_gut_20.tb_size_4 .tb_item:first-child ~ .tb_item.clear4 ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_5 .tb_item:first-child ~ .tb_item.clear5,
.tb_grid_view.tb_gut_20.tb_size_5 .tb_item:first-child ~ .tb_item.clear5 ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_6 .tb_item:first-child ~ .tb_item.clear6,
.tb_grid_view.tb_gut_20.tb_size_6 .tb_item:first-child ~ .tb_item.clear6 ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_7 .tb_item:first-child ~ .tb_item.clear7,
.tb_grid_view.tb_gut_20.tb_size_7 .tb_item:first-child ~ .tb_item.clear7 ~ .tb_item,
.tb_grid_view.tb_gut_20.tb_size_8 .tb_item:first-child ~ .tb_item.clear8,
.tb_grid_view.tb_gut_20.tb_size_8 .tb_item:first-child ~ .tb_item.clear8 ~ .tb_item
{
  margin-top: 20px;
}
.tb_grid_view.tb_gut_30.tb_size_1 .tb_item:first-child ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_2 .tb_item:first-child ~ .tb_item.clear2,
.tb_grid_view.tb_gut_30.tb_size_2 .tb_item:first-child ~ .tb_item.clear2 ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_3 .tb_item:first-child ~ .tb_item.clear3,
.tb_grid_view.tb_gut_30.tb_size_3 .tb_item:first-child ~ .tb_item.clear3 ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_4 .tb_item:first-child ~ .tb_item.clear4,
.tb_grid_view.tb_gut_30.tb_size_4 .tb_item:first-child ~ .tb_item.clear4 ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_5 .tb_item:first-child ~ .tb_item.clear5,
.tb_grid_view.tb_gut_30.tb_size_5 .tb_item:first-child ~ .tb_item.clear5 ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_6 .tb_item:first-child ~ .tb_item.clear6,
.tb_grid_view.tb_gut_30.tb_size_6 .tb_item:first-child ~ .tb_item.clear6 ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_7 .tb_item:first-child ~ .tb_item.clear7,
.tb_grid_view.tb_gut_30.tb_size_7 .tb_item:first-child ~ .tb_item.clear7 ~ .tb_item,
.tb_grid_view.tb_gut_30.tb_size_8 .tb_item:first-child ~ .tb_item.clear8,
.tb_grid_view.tb_gut_30.tb_size_8 .tb_item:first-child ~ .tb_item.clear8 ~ .tb_item
{
  margin-top: 30px;
}
.tb_grid_view.tb_gut_40.tb_size_1 .tb_item:first-child ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_2 .tb_item:first-child ~ .tb_item.clear2,
.tb_grid_view.tb_gut_40.tb_size_2 .tb_item:first-child ~ .tb_item.clear2 ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_3 .tb_item:first-child ~ .tb_item.clear3,
.tb_grid_view.tb_gut_40.tb_size_3 .tb_item:first-child ~ .tb_item.clear3 ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_4 .tb_item:first-child ~ .tb_item.clear4,
.tb_grid_view.tb_gut_40.tb_size_4 .tb_item:first-child ~ .tb_item.clear4 ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_5 .tb_item:first-child ~ .tb_item.clear5,
.tb_grid_view.tb_gut_40.tb_size_5 .tb_item:first-child ~ .tb_item.clear5 ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_6 .tb_item:first-child ~ .tb_item.clear6,
.tb_grid_view.tb_gut_40.tb_size_6 .tb_item:first-child ~ .tb_item.clear6 ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_7 .tb_item:first-child ~ .tb_item.clear7,
.tb_grid_view.tb_gut_40.tb_size_7 .tb_item:first-child ~ .tb_item.clear7 ~ .tb_item,
.tb_grid_view.tb_gut_40.tb_size_8 .tb_item:first-child ~ .tb_item.clear8,
.tb_grid_view.tb_gut_40.tb_size_8 .tb_item:first-child ~ .tb_item.clear8 ~ .tb_item
{
  margin-top: 40px;
}
.tb_grid_view.tb_gut_50.tb_size_1 .tb_item:first-child ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_2 .tb_item:first-child ~ .tb_item.clear2,
.tb_grid_view.tb_gut_50.tb_size_2 .tb_item:first-child ~ .tb_item.clear2 ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_3 .tb_item:first-child ~ .tb_item.clear3,
.tb_grid_view.tb_gut_50.tb_size_3 .tb_item:first-child ~ .tb_item.clear3 ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_4 .tb_item:first-child ~ .tb_item.clear4,
.tb_grid_view.tb_gut_50.tb_size_4 .tb_item:first-child ~ .tb_item.clear4 ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_5 .tb_item:first-child ~ .tb_item.clear5,
.tb_grid_view.tb_gut_50.tb_size_5 .tb_item:first-child ~ .tb_item.clear5 ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_6 .tb_item:first-child ~ .tb_item.clear6,
.tb_grid_view.tb_gut_50.tb_size_6 .tb_item:first-child ~ .tb_item.clear6 ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_7 .tb_item:first-child ~ .tb_item.clear7,
.tb_grid_view.tb_gut_50.tb_size_7 .tb_item:first-child ~ .tb_item.clear7 ~ .tb_item,
.tb_grid_view.tb_gut_50.tb_size_8 .tb_item:first-child ~ .tb_item.clear8,
.tb_grid_view.tb_gut_50.tb_size_8 .tb_item:first-child ~ .tb_item.clear8 ~ .tb_item
{
  margin-top: 50px;
}

.tb_grid_view[class*="tb_size_"].tb_gut_0 {
  padding-left: 0 !important;
  padding-right: 0 !important;
}

/*** ITEM compact view ********************************************/

.tb_compact_view .tb_item {
  clear: both;
  overflow: hidden;
  margin-top: <?php echo $base; ?>px;
  padding: 0 !important;
  background: transparent;
}
.tb_compact_view .tb_item:first-child {
  margin-top: 0;
}
.tb_compact_view .tb_item .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin: 0 <?php echo $base; ?>px 0 0 !important;
  <?php else: ?>
  float: right;
  margin: 0 0 0 <?php echo $base; ?>px !important;
  <?php endif; ?>
  padding: 0 !important;
}
.tb_compact_view .tb_item .tb_thumb .tb_thumb {
  margin: 0 !important;
}
.tb_compact_view .tb_item .tb_item_info {
  overflow: hidden;
}
.tb_compact_view .tb_item h3,
.tb_compact_view .tb_item .tb_price_holder,
.tb_compact_view .tb_item .tb_price
{
  margin: 0;
  font-size: <?php echo $base_font_size; ?>px;
}
.tb_compact_view .tb_rating_holder .tb_rating,
.tb_compact_view .tb_rating_holder .tb_rating *
{
  font-size: 12px;
}
.tb_compact_view .tb_rating_holder .tb_average {
  margin-top: 0;
  font-weight: normal;
  font-size: 0.85em;
}



/*** ITEM inline view *********************************************/

.tb_listing.tb_inline_view {
  margin-top: -<?php echo $base * 1.5; ?>px;
  padding-left: <?php echo $base * 1.5; ?>px;
}
.tb_listing.tb_inline_view .tb_item {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  width: 50%;
  margin-top: <?php echo $base * 1.5; ?>px;
  margin-left: <?php echo $base * 1.5; ?>px;
}
.tb_listing.tb_inline_view .tb_item.clear2 {
  <?php if ($lang_dir == 'ltr'): ?>
  clear: left;
  <?php else: ?>
  clear: right;
  <?php endif; ?>
  margin-left: -<?php echo $base * 1.5; ?>px;
}

.tb_listing.tb_inline_view.tb_max_w_300,
.tb_listing.tb_inline_view.tb_max_w_600
{
  padding-left: 0;
}
.tb_listing.tb_inline_view.tb_max_w_300 .tb_item,
.tb_listing.tb_inline_view.tb_max_w_600 .tb_item
{
  width: 100%;
  margin-left: 0;
}
.tb_listing.tb_inline_view.tb_min_w_900 {
  padding-left: <?php echo $base * 1.5 * 2; ?>px;
}
.tb_listing.tb_inline_view.tb_min_w_900 .tb_item {
  width: 33.333333%;
}
.tb_listing.tb_inline_view.tb_min_w_900 .tb_item.clear2 {
  clear: none;
  margin-left: <?php echo $base * 1.5; ?>px;
}
.tb_listing.tb_inline_view.tb_min_w_900 .tb_item.clear3 {
  <?php if ($lang_dir == 'ltr'): ?>
  clear: left;
  <?php else: ?>
  clear: right;
  <?php endif; ?>
  margin-left: -<?php echo $base * 1.5 * 2; ?>px;
}


/*****   Listing Style 1   ***************************/

.tb_listing.tb_style_1 .tb_item {
  padding-bottom: 0;
  background-color: transparent;
}
.tb_listing.tb_style_1 .tb_item .tb_front {
  margin-bottom: 0;
  padding-bottom: 0;
}
.tb_listing.tb_style_1 + .pagination {
  padding-top: <?php echo $base * 1.5 - 1; ?>px;
  border-top-width: 1px;
  border-top-style: solid;
}

/*****   Listing Style 2   ***************************/

.tb_listing.tb_style_2 {
  border-top-width: 1px;
  border-top-style: solid;
}
.tb_listing.tb_style_2:first-child {
  border-top-width: 0;
}

/*** List view ***/

.tb_listing.tb_list_view.tb_style_2 > .tb_item {
  border-top-width: 1px;
  border-top-style: solid;
}
.tb_listing.tb_list_view.tb_style_2 > .tb_item:first-child {
  border-top: none;
}

/*** Grid view ***/

.tb_listing.tb_grid_view.tb_style_2 {
  margin-bottom: 0;
  padding-left: 0;
  padding-right: 0;
}
.tb_listing.tb_grid_view.tb_style_2 .tb_item,
.tb_listing.tb_grid_view.tb_style_2[class*="tb_gut_"][class*="tb_size_"] .tb_item,
.tb_listing.tb_grid_view.tb_style_2[class*="tb_gut_"][class*="tb_size_"] .tb_item + .tb_item,
.tb_listing.tb_grid_view.tb_style_2[class*="tb_gut_"][class*="tb_size_"] .tb_item + .tb_item + .tb_item
{
  left: 0 !important;
  right: 0 !important;
  margin-left: 0 !important;
  margin-right: 0 !important;
  margin-top: 0 !important;
}
.tb_listing.tb_grid_view.tb_style_2 .tb_item {
  margin-bottom: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  border-right: 1px solid transparent;
  <?php else: ?>
  border-left: 1px solid transparent;
  <?php endif; ?>
  border-bottom-width: 1px;
  border-bottom-style: solid;
}
.tb_listing.tb_grid_view.tb_style_2 .tb_item:after {
  content: '';
  z-index: 4;
  position: absolute;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  right: -1px;
  <?php else: ?>
  left: -1px;
  <?php endif; ?>
  display: block;
  width: 1px;
  height: 100%;
}

.tb_listing.tb_grid_view.tb_style_2.tb_size_1 .tb_item:last-child,
.tb_listing.tb_grid_view.tb_style_2.tb_size_2 .tb_item.tb_size_2_last,
.tb_listing.tb_grid_view.tb_style_2.tb_size_3 .tb_item.tb_size_3_last,
.tb_listing.tb_grid_view.tb_style_2.tb_size_4 .tb_item.tb_size_4_last,
.tb_listing.tb_grid_view.tb_style_2.tb_size_5 .tb_item.tb_size_5_last,
.tb_listing.tb_grid_view.tb_style_2.tb_size_6 .tb_item.tb_size_6_last,
.tb_listing.tb_grid_view.tb_style_2.tb_size_7 .tb_item.tb_size_7_last,
.tb_listing.tb_grid_view.tb_style_2.tb_size_8 .tb_item.tb_size_8_last,
.tb_listing.tb_grid_view.tb_style_2.tb_slider .tb_item
{
  border-bottom-width: 0;
}
.tb_listing.tb_grid_view.tb_style_2.tb_size_2 .clear2 + .tb_item,
.tb_listing.tb_grid_view.tb_style_2.tb_size_3 .clear3 + .tb_item + .tb_item,
.tb_listing.tb_grid_view.tb_style_2.tb_size_4 .clear4 + .tb_item + .tb_item + .tb_item,
.tb_listing.tb_grid_view.tb_style_2.tb_size_5 .clear5 + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_listing.tb_grid_view.tb_style_2.tb_size_6 .clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_listing.tb_grid_view.tb_style_2.tb_size_7 .clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item,
.tb_listing.tb_grid_view.tb_style_2.tb_size_8 .clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item
{
  <?php if ($lang_dir == 'ltr'): ?>
  border-right-width: 0;
  <?php else: ?>
  border-left-width: 0;
  <?php endif; ?>
}
.tb_listing.tb_grid_view.tb_style_2.tb_size_2 .clear2 + .tb_item:after,
.tb_listing.tb_grid_view.tb_style_2.tb_size_3 .clear3 + .tb_item + .tb_item:after,
.tb_listing.tb_grid_view.tb_style_2.tb_size_4 .clear4 + .tb_item + .tb_item + .tb_item:after,
.tb_listing.tb_grid_view.tb_style_2.tb_size_5 .clear5 + .tb_item + .tb_item + .tb_item + .tb_item:after,
.tb_listing.tb_grid_view.tb_style_2.tb_size_6 .clear6 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item:after,
.tb_listing.tb_grid_view.tb_style_2.tb_size_7 .clear7 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item:after,
.tb_listing.tb_grid_view.tb_style_2.tb_size_8 .clear8 + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item + .tb_item:after
{
  display: none;
}
.tb_listing.tb_grid_view.tb_style_2.tb_size_1 .tb_item {
  border-left-width: 0 !important;
  border-right-width: 0 !important;
}
.tb_listing.tb_grid_view.tb_style_2.tb_size_1 .tb_item:after {
  display: none !important;
}
.tb_pl_10 > .tb_listing.tb_style_2, .tb_pl_10  > .tb_listing.tb_style_2 ~ .tb_slider_pagination { margin-left: -10px; margin-right: -10px; }
.tb_pl_20 > .tb_listing.tb_style_2, .tb_pl_20  > .tb_listing.tb_style_2 ~ .tb_slider_pagination { margin-left: -20px; margin-right: -20px; }
.tb_pl_30 > .tb_listing.tb_style_2, .tb_pl_30  > .tb_listing.tb_style_2 ~ .tb_slider_pagination { margin-left: -30px; margin-right: -30px; }
.tb_pl_40 > .tb_listing.tb_style_2, .tb_pl_40  > .tb_listing.tb_style_2 ~ .tb_slider_pagination { margin-left: -40px; margin-right: -40px; }
.tb_pl_50 > .tb_listing.tb_style_2, .tb_pl_50  > .tb_listing.tb_style_2 ~ .tb_slider_pagination { margin-left: -50px; margin-right: -50px; }
.tb_pt_10 > .tb_listing.tb_style_2:first-child { margin-top: -10px; }
.tb_pt_20 > .tb_listing.tb_style_2:first-child { margin-top: -20px; }
.tb_pt_30 > .tb_listing.tb_style_2:first-child { margin-top: -30px; }
.tb_pt_40 > .tb_listing.tb_style_2:first-child { margin-top: -40px; }
.tb_pt_50 > .tb_listing.tb_style_2:first-child { margin-top: -50px; }

.tb_pb_10 > .tb_listing.tb_style_2:last-child > :last-child,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_2:last-child .tb_size_2_last,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_3:last-child .tb_size_3_last,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_4:last-child .tb_size_4_last,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_5:last-child .tb_size_5_last,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_6:last-child .tb_size_6_last,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_7:last-child .tb_size_7_last,
.tb_pb_10 > .tb_listing.tb_style_2.tb_size_8:last-child .tb_size_8_last
{
  margin-bottom: -10px;
}
.tb_pb_20 > .tb_listing.tb_style_2:last-child > :last-child,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_2:last-child .tb_size_2_last,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_3:last-child .tb_size_3_last,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_4:last-child .tb_size_4_last,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_5:last-child .tb_size_5_last,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_6:last-child .tb_size_6_last,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_7:last-child .tb_size_7_last,
.tb_pb_20 > .tb_listing.tb_style_2.tb_size_8:last-child .tb_size_8_last
{
  margin-bottom: -20px;
}
.tb_pb_30 > .tb_listing.tb_style_2:last-child > :last-child,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_2:last-child .tb_size_2_last,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_3:last-child .tb_size_3_last,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_4:last-child .tb_size_4_last,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_5:last-child .tb_size_5_last,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_6:last-child .tb_size_6_last,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_7:last-child .tb_size_7_last,
.tb_pb_30 > .tb_listing.tb_style_2.tb_size_8:last-child .tb_size_8_last
{
  margin-bottom: -30px;
}
.tb_pb_40 > .tb_listing.tb_style_2:last-child > :last-child,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_2:last-child .tb_size_2_last,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_3:last-child .tb_size_3_last,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_4:last-child .tb_size_4_last,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_5:last-child .tb_size_5_last,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_6:last-child .tb_size_6_last,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_7:last-child .tb_size_7_last,
.tb_pb_40 > .tb_listing.tb_style_2.tb_size_8:last-child .tb_size_8_last
{
  margin-bottom: -40px;
}
.tb_pb_50 > .tb_listing.tb_style_2:last-child > :last-child,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_2:last-child .tb_size_2_last,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_3:last-child .tb_size_3_last,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_4:last-child .tb_size_4_last,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_5:last-child .tb_size_5_last,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_6:last-child .tb_size_6_last,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_7:last-child .tb_size_7_last,
.tb_pb_50 > .tb_listing.tb_style_2.tb_size_8:last-child .tb_size_8_last
{
  margin-bottom: -50px;
}


.tb_listing.tb_style_2.tb_slider {
  position: static;
  overflow: hidden;
  float: none;
  margin-top: -60px;
  margin-bottom: -60px;
  border-top: 0 none !important;
}
.tb_pt_0  > .tb_listing.tb_style_2.tb_slider { margin-top: -60px; }
.tb_pt_10 > .tb_listing.tb_style_2.tb_slider { margin-top: -70px; }
.tb_pt_20 > .tb_listing.tb_style_2.tb_slider { margin-top: -80px; }
.tb_pt_30 > .tb_listing.tb_style_2.tb_slider { margin-top: -90px; }
.tb_pt_40 > .tb_listing.tb_style_2.tb_slider { margin-top: -100px; }
.tb_pt_50 > .tb_listing.tb_style_2.tb_slider { margin-top: -110px; }
.tb_pb_0  > .tb_listing.tb_style_2.tb_slider { margin-bottom: -60px; }
.tb_pb_10 > .tb_listing.tb_style_2.tb_slider { margin-bottom: -70px; }
.tb_pb_20 > .tb_listing.tb_style_2.tb_slider { margin-bottom: -80px; }
.tb_pb_30 > .tb_listing.tb_style_2.tb_slider { margin-bottom: -90px; }
.tb_pb_40 > .tb_listing.tb_style_2.tb_slider { margin-bottom: -100px; }
.tb_pb_50 > .tb_listing.tb_style_2.tb_slider { margin-bottom: -110px; }
.tb_pb_10 > .tb_listing.tb_style_2 ~ .tb_slider_pagination:last-child { margin-top: 10px; margin-bottom: -10px; }
.tb_pb_20 > .tb_listing.tb_style_2 ~ .tb_slider_pagination:last-child { margin-top: 20px; margin-bottom: -20px; }
.tb_pb_30 > .tb_listing.tb_style_2 ~ .tb_slider_pagination:last-child { margin-top: 30px; margin-bottom: -30px; }
.tb_pb_40 > .tb_listing.tb_style_2 ~ .tb_slider_pagination:last-child { margin-top: 40px; margin-bottom: -40px; }
.tb_pb_50 > .tb_listing.tb_style_2 ~ .tb_slider_pagination:last-child { margin-top: 50px; margin-bottom: -50px; }

h2 + .tb_listing.tb_style_2.tb_slider {
  margin-top: -60px !important;
}

.tb_tabs.tb_style_2 .no_title .tb_listing.tb_style_2,
.tb_accordion .no_title .tb_listing.tb_style_2
{
  border-top-width: 1px;
  border-top-style: solid;
}
h2 + .tb_listing.tb_style_2.tb_slider:before,
.tb_tabs.tb_style_2 [class*="tb_widget"] .tb_listing.tb_style_2.tb_slider:first-child:before,
.tb_tabs.tb_style_3 [class*="tb_widget"] .tb_listing.tb_style_2.tb_slider:first-child:before,
.tb_accordion .no_title .tb_listing.tb_style_2.tb_slider:before
{
  content: '';
  height: 1px;
  width: 100%;
  top: 60px;
}
.tb_accordion .no_title {
  position: relative;
}
.tb_listing.tb_style_2.tb_slider .swiper-container {
  overflow: visible;
  margin-right: -2px;
  margin-left: -2px;
}
.tb_listing.tb_style_2.tb_slider .swiper-container .swiper-wrapper {
  <?php if ($lang_dir == 'ltr'): ?>
  border-left-width: 1px;
  border-left-style: solid;
  <?php else: ?>
  border-right-width: 1px;
  border-right-style: solid;
  <?php endif; ?>
}
.tb_listing.tb_style_2.tb_size_1.tb_slider .swiper-container {
  margin-left: 0;
  margin-right: 0;
}
.tb_listing.tb_style_2.tb_size_1.tb_slider .swiper-container .swiper-wrapper {
  border-left: 0;
  border-right: 0;
}
.tb_listing.tb_style_2.tb_slider .swiper-slide {
  padding: 0;
}
.tb_listing.tb_style_2.tb_slider ~ .tb_slider_pagination {
  margin-top: 0;
  padding: <?php echo $base / 2; ?>px 0;
  border-top-width: 1px;
  border-top-style: solid;
}
.tb_pt_0  > .tb_slider_controls, .tb_pt_0  > .tb_tabs .no_title > .tb_slider_controls { top: 0;    }
.tb_pt_5  > .tb_slider_controls, .tb_pt_5  > .tb_tabs .no_title > .tb_slider_controls { top: 5px;  }
.tb_pt_10 > .tb_slider_controls, .tb_pt_10 > .tb_tabs .no_title > .tb_slider_controls { top: 10px; }
.tb_pt_15 > .tb_slider_controls, .tb_pt_15 > .tb_tabs .no_title > .tb_slider_controls { top: 15px; }
.tb_pt_20 > .tb_slider_controls, .tb_pt_20 > .tb_tabs .no_title > .tb_slider_controls { top: 20px; }
.tb_pt_25 > .tb_slider_controls, .tb_pt_25 > .tb_tabs .no_title > .tb_slider_controls { top: 25px; }
.tb_pt_30 > .tb_slider_controls, .tb_pt_30 > .tb_tabs .no_title > .tb_slider_controls { top: 30px; }
.tb_pt_35 > .tb_slider_controls, .tb_pt_35 > .tb_tabs .no_title > .tb_slider_controls { top: 35px; }
.tb_pt_40 > .tb_slider_controls, .tb_pt_40 > .tb_tabs .no_title > .tb_slider_controls { top: 40px; }
.tb_pt_45 > .tb_slider_controls, .tb_pt_45 > .tb_tabs .no_title > .tb_slider_controls { top: 45px; }
.tb_pt_50 > .tb_slider_controls, .tb_pt_50 > .tb_tabs .no_title > .tb_slider_controls { top: 50px; }
.tb_pl_0  > .tb_slider_controls, .tb_pl_0 >  .tb_tabs .no_title > .tb_slider_controls { right: 0;    }
.tb_pl_10 > .tb_slider_controls, .tb_pl_10 > .tb_tabs .no_title > .tb_slider_controls { right: 5px;  }
.tb_pl_20 > .tb_slider_controls, .tb_pl_20 > .tb_tabs .no_title > .tb_slider_controls { right: 15px; }
.tb_pl_30 > .tb_slider_controls, .tb_pl_30 > .tb_tabs .no_title > .tb_slider_controls { right: 25px; }
.tb_pl_40 > .tb_slider_controls, .tb_pl_40 > .tb_tabs .no_title > .tb_slider_controls { right: 35px; }
.tb_pl_50 > .tb_slider_controls, .tb_pl_50 > .tb_tabs .no_title > .tb_slider_controls { right: 45px; }
h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_tabs .no_title > .tb_slider_controls { right:  auto !important; }
.tb_pl_0  > h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_pl_0 >  .tb_tabs .no_title > .tb_slider_controls { left: 0;    }
.tb_pl_10 > h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_pl_10 > .tb_tabs .no_title > .tb_slider_controls { left: 5px;  }
.tb_pl_20 > h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_pl_20 > .tb_tabs .no_title > .tb_slider_controls { left: 15px; }
.tb_pl_30 > h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_pl_30 > .tb_tabs .no_title > .tb_slider_controls { left: 25px; }
.tb_pl_40 > h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_pl_40 > .tb_tabs .no_title > .tb_slider_controls { left: 35px; }
.tb_pl_50 > h2.align_right + .tb_slider_controls, .tb_lang_rtl .tb_pl_50 > .tb_tabs .no_title > .tb_slider_controls { left: 45px; }

.tb_tabs.tb_style_1 .no_title > .tb_slider_controls {
  margin-top: <?php echo $base * 0.5; ?>px;
}
.tb_accordion .no_title .tb_slider_controls {
  top: auto;
  bottom: 100%;
}
.tb_accordion.tb_style_1 .no_title .tb_slider_controls {
  margin-bottom: <?php echo $base * 0.5; ?>px;
}

.tb_listing.tb_grid_view.tb_style_2 .tb_item .tb_actions {
  margin-left: -10px;
  margin-right: -10px;
}

.tb_listing.tb_list_view.tb_style_3.tb_gut_10 .tb_item { margin-top: <?php echo $base / 2; ?>px; }
.tb_listing.tb_list_view.tb_style_3.tb_gut_20 .tb_item { margin-top: <?php echo $base; ?>px; }
.tb_listing.tb_list_view.tb_style_3.tb_gut_30 .tb_item { margin-top: <?php echo $base * 1.5; ?>px; }
.tb_listing.tb_list_view.tb_style_3.tb_gut_40 .tb_item { margin-top: <?php echo $base * 2; ?>px; }
.tb_listing.tb_list_view.tb_style_3.tb_gut_50 .tb_item { margin-top: <?php echo $base * 2; ?>px; }

.tb_listing_options.tb_style_2 {
  background-color: transparent !important;
}

.tb_listing_options.tb_style_3,
.tb_listing.tb_style_3.tb_list_view .tb_item,
.tb_listing.tb_style_3.tb_grid_view.tb_hover_none .tb_item,
.tb_listing.tb_style_3.tb_grid_view.tb_hover_append .tb_item,
.tb_listing.tb_style_3.tb_grid_view.tb_hover_overlay .tb_item,
.tb_listing.tb_style_3.tb_grid_view.tb_hover_flip .tb_item .tb_front
{
  -webkit-box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
          box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
}
.tb_listing.tb_style_3 .tb_item .tb_front {
  min-height: 100%;
}
.tb_listing.tb_style_3.tb_grid_view.tb_hover_flip .tb_item_info_hover {
  -webkit-box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
  box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
}
.tb_widget_product_system .tb_listing.tb_grid_view.tb_style_2 {
  float: none;
}


.tb_product_p_5  .tb_item { padding: 5px;  }
.tb_product_p_10 .tb_item { padding: 10px; }
.tb_product_p_15 .tb_item { padding: 15px; }
.tb_product_p_20 .tb_item { padding: 20px; }
.tb_product_p_25 .tb_item { padding: 25px; }
.tb_product_p_30 .tb_item { padding: 30px; }
.tb_product_p_35 .tb_item { padding: 35px; }
.tb_product_p_40 .tb_item { padding: 40px; }
.tb_product_p_45 .tb_item { padding: 45px; }
.tb_product_p_50 .tb_item { padding: 50px; }

.tb_product_p_5  .tb_item .tb_front, .tb_product_p_5  .tb_item .tb_back { margin: -5px;  padding: 5px  }
.tb_product_p_10 .tb_item .tb_front, .tb_product_p_10 .tb_item .tb_back { margin: -10px; padding: 10px }
.tb_product_p_15 .tb_item .tb_front, .tb_product_p_15 .tb_item .tb_back { margin: -15px; padding: 15px }
.tb_product_p_20 .tb_item .tb_front, .tb_product_p_20 .tb_item .tb_back { margin: -20px; padding: 20px }
.tb_product_p_25 .tb_item .tb_front, .tb_product_p_25 .tb_item .tb_back { margin: -25px; padding: 25px }
.tb_product_p_30 .tb_item .tb_front, .tb_product_p_30 .tb_item .tb_back { margin: -30px; padding: 30px }
.tb_product_p_35 .tb_item .tb_front, .tb_product_p_35 .tb_item .tb_back { margin: -35px; padding: 35px }
.tb_product_p_40 .tb_item .tb_front, .tb_product_p_40 .tb_item .tb_back { margin: -40px; padding: 40px }
.tb_product_p_45 .tb_item .tb_front, .tb_product_p_45 .tb_item .tb_back { margin: -45px; padding: 45px }
.tb_product_p_50 .tb_item .tb_front, .tb_product_p_50 .tb_item .tb_back { margin: -50px; padding: 50px }

.tb_product_p_5.tb_exclude_thumb  .tb_item .tb_thumb { margin: -5px;  }
.tb_product_p_10.tb_exclude_thumb .tb_item .tb_thumb { margin: -10px; }
.tb_product_p_15.tb_exclude_thumb .tb_item .tb_thumb { margin: -15px; }
.tb_product_p_20.tb_exclude_thumb .tb_item .tb_thumb { margin: -20px; }
.tb_product_p_25.tb_exclude_thumb .tb_item .tb_thumb { margin: -25px; }
.tb_product_p_30.tb_exclude_thumb .tb_item .tb_thumb { margin: -30px; }
.tb_product_p_35.tb_exclude_thumb .tb_item .tb_thumb { margin: -35px; }
.tb_product_p_40.tb_exclude_thumb .tb_item .tb_thumb { margin: -40px; }
.tb_product_p_45.tb_exclude_thumb .tb_item .tb_thumb { margin: -45px; }
.tb_product_p_50.tb_exclude_thumb .tb_item .tb_thumb { margin: -50px; }
.tb_grid_view[class*="tb_product_p_"].tb_exclude_thumb .tb_item .tb_thumb:last-child { margin-bottom: 0; }

.tb_grid_view.tb_product_p_5.tb_exclude_thumb  .tb_item .tb_item_info > :first-child { margin-top: 20px; }
.tb_grid_view.tb_product_p_10.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 20px; }
.tb_grid_view.tb_product_p_15.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 20px; }
.tb_grid_view.tb_product_p_20.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 40px; }
.tb_grid_view.tb_product_p_25.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 40px; }
.tb_grid_view.tb_product_p_30.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 60px; }
.tb_grid_view.tb_product_p_35.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 60px; }
.tb_grid_view.tb_product_p_40.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 80px; }
.tb_grid_view.tb_product_p_45.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 80px; }
.tb_grid_view.tb_product_p_50.tb_exclude_thumb .tb_item .tb_item_info > :first-child { margin-top: 80px; }

.tb_list_view.tb_product_p_5.tb_exclude_thumb  .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 5px;  <?php else: ?> margin-left: 5px;  <?php endif; ?> }
.tb_list_view.tb_product_p_10.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 10px; <?php else: ?> margin-left: 10px; <?php endif; ?> }
.tb_list_view.tb_product_p_15.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 15px; <?php else: ?> margin-left: 15px; <?php endif; ?> }
.tb_list_view.tb_product_p_20.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 20px; <?php else: ?> margin-left: 20px; <?php endif; ?> }
.tb_list_view.tb_product_p_25.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 25px; <?php else: ?> margin-left: 25px; <?php endif; ?> }
.tb_list_view.tb_product_p_30.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 30px; <?php else: ?> margin-left: 30px; <?php endif; ?> }
.tb_list_view.tb_product_p_35.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 35px; <?php else: ?> margin-left: 35px; <?php endif; ?> }
.tb_list_view.tb_product_p_40.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 40px; <?php else: ?> margin-left: 40px; <?php endif; ?> }
.tb_list_view.tb_product_p_45.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 45px; <?php else: ?> margin-left: 45px; <?php endif; ?> }
.tb_list_view.tb_product_p_50.tb_exclude_thumb .tb_item .tb_thumb { <?php if ($lang_dir == 'ltr'): ?> margin-right: 50px; <?php else: ?> margin-left: 50px; <?php endif; ?> }

.tb_listing.tb_grid_view.tb_style_3.tb_hover_overlay .tb_item,
.tb_listing.tb_grid_view.tb_style_3.tb_hover_flip .tb_item
{
  background-color: transparent;
}




/***** PROCUCT Side Column ******/

.tb_cart_items {
  width: 100%;
  margin-bottom: 0;
}
.tb_cart_items a.left {
  <?php if ($lang_dir == 'rtl'): ?>
  float: right !important;
  <?php endif; ?>
}
.tb_cart_items td {
  padding: 10px 0;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
  vertical-align: middle;
  font-size: 12px;
  border-top: 1px solid #eee;
}
.tb_cart_items tr:first-child td {
  padding-top: 0;
  border-top: none;
}
.tb_cart_items .tb_cart_number,
.tb_cart_items .tb_cart_price
{
  padding-left: 10px;
  text-align: right;
}
.tb_button_remove,
.tb_button_remove:before,
.noty_close,
.noty_close:before
{
  overflow: hidden;
  display: inline-block;
  text-align: center;
  text-indent: -1000em;
  vertical-align: top;
}
.tb_button_remove:before,
.noty_close:before
{
  content: '+';
  display: block;
  float: left;
  width: 100%;
  height: 100%;
  text-align: center;
  text-indent: 0;
  font-size: 22px;
  font-weight: normal;
  font-family: Arial, sans-serif;
      -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
          transform: rotate(45deg);
}
.tb_button_remove:hover,
.tb_button_remove:hover:before,
.noty_close:hover,
.noty_close:hover:before
{
  color: inherit;
}

.tb_review {
  overflow: hidden;
}
.tb_review .tb_meta {
  line-height: 0;
  text-align: justify;
}
.tb_review .tb_meta:after {
  content: ' ';
  display: inline-block;
  width: 90%;
  height: 0;
  line-height: 0;
  vertical-align: top;
}
.tb_review .tb_author,
.tb_review .tb_rating_holder
{
  display: inline-block;
  line-height: <?php echo $base; ?>px;
  vertical-align: top;
}
.tb_review .tb_author {
  margin-bottom: <?php echo $base * 0.5; ?>px;
}
.tb_review > p:first-child {
  margin-bottom: 0;
}
.tb_review > p + .tb_meta {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 35px;
  <?php else: ?>
  padding-right: 35px;
  <?php endif; ?>
}
.tb_review > p + .tb_meta .tb_author,
.tb_review > p + .tb_meta .tb_rating_holder
{
  margin-top: <?php echo $base * 0.5; ?>px;
  margin-bottom: 0;
}
.tb_review .tb_author {
  min-width: 200px;
}
.tb_review .tb_author small {
  margin-left: 4px;
  font-size: 10px;
  color: #999;
}
.tb_review > p {
  clear: both;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
.tb_review > p:first-child {
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 35px;
  <?php else: ?>
  padding-right: 35px;
  <?php endif; ?>
  font-style: italic;
}
.tb_review > p:first-child:before,
.tb_review > p:first-child:after
{
  position: absolute;
  width: 30px;
  height: 24px;
  line-height: 55px;
  font-family: Arial;
  font-size: 60px;
  font-style: italic;
  color: #000;
  opacity: 0.2;
}
.tb_review > p:first-child:before {
  <?php if ($lang_dir == 'ltr'): ?>
  content: '\201C';
  left: 0;
  <?php else: ?>
  content: '\201D';
  right: 0;
  <?php endif; ?>
  top: 0;
  text-indent: -7px;
}
.tb_listing > .tb_review {
  margin-bottom: 15px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}
.tb_listing > .tb_review:last-child,
.tb_listing > .tb_review.last
{
  margin-bottom: 0 !important;
  padding-bottom: 0 !important;
  border-bottom: none !important;
}

.tb_address {
  padding: <?php echo $base / 2; ?>px <?php echo $base; ?>px;
  font-size: 14px;
  <?php if ($lang_dir == 'ltr'): ?>
  border-left-width: 10px;
  border-left-style: solid;
  <?php else: ?>
  border-right-width: 10px;
  border-right-style: solid;
  <?php endif; ?>
}
.tb_address p:first-line,
p.tb_address:first-line
{
  font-weight: bold;
}
.tb_address .tb_actions a + a {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 10px;
  <?php else: ?>
  margin-right: 10px;
  <?php endif; ?>
}
form.tb_address {
  padding: 11px 20px;
}
.tb_address label,
.tb_address input,
.tb_address select
{
  font-size: 13px;
}

.tb_listing .tb_order,
.tb_listing .tb_return
{
  padding: 1px <?php echo $base; ?>px 0 <?php echo $base; ?>px;
  border-width: 1px;
  border-style: solid;
}
.tb_listing .tb_order h3,
.tb_listing .tb_return h3
{
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_listing .tb_order h3 > span:first-child {
  opacity: 0.6;
}
.tb_listing .tb_order .tb_status,
.tb_listing .tb_return .tb_status
{
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.tb_listing .tb_order > *,
.tb_listing .tb_return > *
{
  margin-left: -<?php echo $base; ?>px;
  margin-right: -<?php echo $base; ?>px;
  padding-left: <?php echo $base; ?>px;
  padding-right: <?php echo $base; ?>px;
}
.tb_listing .tb_order > .h2,
.tb_listing .tb_return > .h2
{
  padding: <?php echo $base / 2; ?>px <?php echo $base; ?>px;
}
.tb_listing .tb_order .tb_status,
.tb_listing .tb_return .tb_status
{
  background: #eee;
  border-bottom-width: 1px;
  border-bottom-style: solid;
}
.tb_listing.tb_max_w_300 .tb_order h3,
.tb_listing.tb_max_w_300 .tb_return h3
{
  margin-bottom: 0;
}
.tb_listing.tb_max_w_300 .tb_order .tb_status,
.tb_listing.tb_max_w_300 .tb_return .tb_status
{
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
.tb_listing.tb_max_w_300 .tb_order .tb_status:before,
.tb_listing.tb_max_w_300 .tb_return .tb_status:before
{
  content: '';
  display: block;
  height: 0;
  line-height: 0;
  clear: both;
}
.tb_listing.tb_max_w_300 .tb_order dl *,
.tb_listing.tb_max_w_300 .tb_return dl *
{
  float: none;
  width: 100%;
}
.tb_listing.tb_max_w_300 .tb_order dl dt,
.tb_listing.tb_max_w_300 .tb_return dl dt
{
  margin-top: <?php echo $base / 2; ?>px;
}
.tb_listing .tb_order .tb_summary,
.tb_listing .tb_return .tb_summary
{
  display: table;
  width: 100%;
  padding-top: <?php echo $base / 2; ?>px;
  padding-bottom: <?php echo $base / 2; ?>px;
}
.tb_listing .tb_order .tb_summary > div,
.tb_listing .tb_return .tb_summary > div
{
  display: table-row;
}
.tb_listing .tb_order .tb_summary > div > *,
.tb_listing .tb_return .tb_summary > div > *
{
  display: table-cell;
  vertical-align: middle;
}
.tb_listing .tb_order .tb_actions,
.tb_listing .tb_return .tb_actions
{
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.tb_listing .tb_order .tb_actions a + a,
.tb_listing .tb_return .tb_actions a + a
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}

.tb_order_info .tb_status,
.tb_return_info .tb_status
{
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}



.tb_cart_holder .tb_totals .tb_total:last-child {
  padding-top: <?php echo $base / 2; ?>px;
  font-size: 15px;
}
.tb_cart_holder .tb_total .left {
  <?php if ($lang_dir == 'rtl'): ?>
  float: right !important;
  <?php endif; ?>
}
.tb_cart_holder .tb_button_cart {
  margin-right: 5px;
}




.tb_info_page ol {
  padding-left: 15px;
  list-style: decimal;
}

/*****************************************************/
/******   O L D    M A R K U P   *********************/
/*****************************************************/

#menu li > div {
  display: none;
  position: absolute;
  top: 100%;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
  padding: <?php echo $base / 2; ?>px <?php echo $base; ?>px;
}
#menu li div ul {
  display: table-cell;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 20px;
  <?php else: ?>
  padding-right: 20px;
  <?php endif; ?>
}
#menu li div ul:first-child {
  padding: 0;
}
#menu li div a {
  display: block;
  width: 140px;
}
#menu .see-all {
  display: none !important;
}
.price-old {
  color: #666;
  text-decoration: line-through;
}
.box .box-heading img {
  display: inline-block;
  vertical-align: top;
}

.buttons table {
  width: 100%;
}

@-webkit-keyframes tb_rotate {
    from {transform: rotate(0deg);}
    to   {transform: rotate(359deg);}
}
@keyframes tb_rotate {
    from {transform: rotate(0deg);}
    to   {transform: rotate(359deg);}
}
i.fa.fa-circle-o-notch.fa-spin {
  position: relative;
  display: inline-block;
  width: 18px;
  height: 18px;
  -webkit-animation-duration: 0.7s;
}
i.fa.fa-circle-o-notch.fa-spin:before,
i.fa.fa-circle-o-notch.fa-spin:after
{
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  display: block;
  border-radius: 50%;
  border-collapse:
}
i.fa.fa-circle-o-notch.fa-spin:after {
  border: 2px solid;
  opacity: 0.2;
}
i.fa.fa-circle-o-notch.fa-spin:before {
  border-top: 2px solid;
  border-right: 2px solid;
  border-bottom: 2px solid transparent;
  border-left: 2px solid  transparent;
  border-collapse: collapse;
  -webkit-animation-name: tb_rotate;
  -webkit-animation-duration: 0.7s;
  -webkit-animation-timing-function: linear;
  -webkit-animation-iteration-count: infinite;
          animation-name: tb_rotate;
          animation-duration: 0.7s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
}
i.fa.fa-circle-o-notch.fa-spin {
  display: inline-block;
  line-height: 16px;
  vertical-align: middle;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base / 2; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base / 2; ?>px;
  <?php endif; ?>
}
select + i.fa.fa-circle-o-notch.fa-spin {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: -<?php echo $base / 4; ?>px;
  <?php else: ?>
  margin-right: -<?php echo $base / 4; ?>px;
  <?php endif; ?>
  margin-top: -0.2em;
}
.tb_button + i.fa.fa-circle-o-notch.fa-spin,
.button + i.fa.fa-circle-o-notch.fa-spin,
.btn + i.fa.fa-circle-o-notch.fa-spin,
button + i.fa.fa-circle-o-notch.fa-spin
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base / 4; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base / 4; ?>px;
  <?php endif; ?>
}

.tb_module_category li > ul {
  display: none;
}
.tb_module_category li > .active {
  font-weight: bold;
}
.tb_module_category li > .active + ul {
  display: block;
}



/*****************************************************/
/******   L A Y O U T   ******************************/
/*****************************************************/

#main_navigation_row.tb_row_full .tb_row,
#main_navigation_row.tb_row_fixed,
#wrapper.tb_row_fixed #main_navigation_row.tb_row_full,
.tbMenuRow,
body > .tb_row_full > #header_wrap > .tb_row_full .tbMenuRow.tb_row_full > .tb_wrap
{
  position: relative;
}
#wrapper.tb_row_fixed #main_navigation_row.tb_row_full .tb_row {
  position: static;
}

#main_navigation_row #main_navigation,
#main_navigation_row #menu,
#main_navigation_row #main_navigation ~ *,
#main_navigation_row #menu ~ *
{
  display: table-cell;
}
#main_navigation_row script {
  display: none !important;
}
#main_navigation,
#menu
{
  width: 100%;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
.align_center > #main_navigation,
.align_center > #menu
{
  width: auto;
}
#main_navigation nav .tb_thumb {
  float: none;
  margin-bottom: <?php echo $base; ?>px;
}
#main_navigation nav .tb_thumb + .tb_description {
}
#main_navigation .tb_nav > ul {
  margin: 0;
}
#main_navigation .tb_nav > ul > li,
#menu > ul > li
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $menu_spacing; ?>px;
  <?php else: ?>
  margin-left: <?php echo $menu_spacing; ?>px;
  <?php endif; ?>
}
.tb_nav .tb_submenu {
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
  width: <?php echo $base * 9; ?>px;
  padding: <?php echo $base / 2; ?>px <?php echo $base; ?>px;
}
#main_navigation .tb_nav .tb_submenu .tb_submenu {
  top: -<?php echo $base * 0.5; ?>px;
  left: 96%;
}
#main_navigation .tb_nav .tb_submenu li a,
#main_navigation .tb_nav .tb_submenu li[class] a,
#menu > ul > li > div ul > li > a
{
  display: block;
  padding: <?php echo $base / 4; ?>px 0;
}
#main_navigation .tb_nav .tb_submenu .tb_list_1 li:before,
#menu div > ul > li:before
{
  position: absolute;
  top: <?php echo $base / 2 + $base / 4; ?>px;
}
#main_navigation .tb_nav .tb_submenu .tb_nosep li a,
#main_navigation .tb_nav .tb_submenu .tb_nosep li[class] a
{
  padding-top: 0;
  padding-bottom: 0;
}
#main_navigation .tb_nav .tb_submenu .tb_nosep li:before,
#main_navigation .tb_nav .tb_submenu .tb_nosep li[class]:before
{
  top: <?php echo $base * 0.5; ?>px;
}
#main_navigation .tb_nav .tb_menu_html.tb_full_menu {
  position: static;
}
#main_navigation .tb_nav .tb_menu_html.tb_full_menu > .tb_submenu {
  left: 0;
  right: 0;
  width: auto !important;
  margin: 0;
  padding: 20px;
}
#menu_home > a:before {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 5px;
  <?php else: ?>
  margin-left: 5px;
  <?php endif; ?>
}


/*** menu style 2 (megamenu) ***/

#main_navigation .tb_nav .tb_megamenu {
  position: static !important;
}
#main_navigation .tb_nav .tb_megamenu li {
  margin: 0;
}
.tb_nav .tb_megamenu > .tb_submenu {
  top: auto;
  left: 0;
  right: 0;
  width: auto;
  padding: 0;
}
body > .tb_row_full > #header_wrap > .tb_row_full .tb_row_full #main_navigation .tb_megamenu > .tb_submenu { left: 30px; right: 30px; }
body > .tb_row_full > #header_wrap > .tb_row_full .tb_row_full.tb_gut_40 #main_navigation .tb_megamenu > .tb_submenu { left: 40px; right: 40px; }
body > .tb_row_full > #header_wrap > .tb_row_full .tb_row_full.tb_gut_50 #main_navigation .tb_megamenu > .tb_submenu { left: 50px; right: 50px; }
.tb_row_table.tb_row_full.tb_gut_10 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu { left: 10px; right: 10px; }
.tb_row_table.tb_row_full.tb_gut_20 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu { left: 20px; right: 20px; }
.tb_row_table.tb_row_full.tb_gut_30 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu { left: 30px; right: 30px; }
.tb_row_table.tb_row_full.tb_gut_40 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu { left: 40px; right: 40px; }
.tb_row_table.tb_row_full.tb_gut_50 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu { left: 50px; right: 50px; }
#main_navigation_row.tb_row_full.tb_ml_10 .tb_megamenu > .tb_submenu,
#main_navigation_row.tb_row_fixed.tb_ml_10 .tb_megamenu > .tb_submenu
{ left: -10px; right: -10px; }
#main_navigation_row.tb_row_full.tb_ml_20 .tb_megamenu > .tb_submenu,
#main_navigation_row.tb_row_fixed.tb_ml_20 .tb_megamenu > .tb_submenu
{ left: -20px; right: -20px; }
#main_navigation_row.tb_row_full.tb_ml_30 .tb_megamenu > .tb_submenu,
#main_navigation_row.tb_row_fixed.tb_ml_30 .tb_megamenu > .tb_submenu
{ left: -30px; right: -30px; }
#main_navigation_row.tb_row_full.tb_ml_40 .tb_megamenu > .tb_submenu,
#main_navigation_row.tb_row_fixed.tb_ml_40 .tb_megamenu > .tb_submenu
{ left: -40px; right: -40px; }
#main_navigation_row.tb_row_full.tb_ml_50 .tb_megamenu > .tb_submenu,
#main_navigation_row.tb_row_fixed.tb_ml_50 .tb_megamenu > .tb_submenu
{ left: -50px; right: -50px; }

body > .tb_row > #header_wrap > .tb_row_fixed .tb_row_table.tb_row_full > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu,
body > .tb_row_fixed > #header_wrap > .tb_row_full .tb_row_table.tb_row_full > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu
{
  left: 0;
  right: 0;
}

#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"]:first-child {
  border-radius: 3px 0 0 3px;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"]:last-child {
  border-radius: 0 3px 3px 0;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul
{
  position: relative;
  clear: none;
  margin: 0;
  padding: <?php echo $base; ?>px <?php echo $base * 0.5; ?>px 0 <?php echo $base * 0.5; ?>px;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_category_info {
  display: inline-block;
  padding: <?php echo $base; ?>px;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_category_info > :last-child {
  margin-bottom: 0 !important;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
  margin-bottom: 0;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories:after {
  content: '';
  clear: both;
  display: table;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories + .tb_category_brands {
  border-top-width: 1px;
  border-top-style: solid;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories .tb_submenu > ul > li {
  z-index: 2;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories .tb_submenu > ul > li.tb_hovered {
  z-index: 3;
}
.tb_nav .tb_images {
  text-align: center;
  margin: -<?php echo $base * 0.5; ?>px -<?php echo $base; ?>px 0 -<?php echo $base; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base; ?>px;
  <?php else: ?>
  padding-left: <?php echo $base; ?>px;
  <?php endif; ?>
}
.tb_nav .tb_images li {
  display: inline-block !important;
  padding-top: <?php echo $base * 0.5; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base; ?>px;
  <?php endif; ?>
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories + .tb_category_brands .tb_images {
  text-align: center;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li:hover
{
  position: static;
  padding: 0 <?php echo $base * 0.5; ?>px <?php echo $base; ?>px <?php echo $base * 0.5; ?>px;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li:before,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li:after
{
  display: none;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > strong,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_letter > strong,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > a
{
  display: block;
  margin-bottom: <?php echo $base / 2; ?>px;
  padding: 0;
  text-transform: uppercase;
  font-weight: bold;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > .tb_submenu {
  position: static;
  display: block;
  width: auto;
  margin-left: 0 !important;
  margin-right: 0 !important;
  padding: 0;
  background-color: transparent;
  border: none;
  -webkit-box-shadow: none;
     -moz-box-shadow: none;
          box-shadow: none;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_list_1 li:before,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_letter > .tb_list_1 li:before,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > .tb_submenu > .tb_list_1 li:before
{
  top: <?php echo $base / 2; ?>px;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_list_1 li > a,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_letter > .tb_list_1 li > a,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > .tb_submenu a
{
  padding: 0;
}
#main_navigation .tb_nav .tb_megamenu h3 {
  margin-bottom: <?php echo $base; ?>px;
  font-size: 18px;
  font-weight: 600;
}
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > .tb_submenu > .tb_list_1 li:hover{
  padding-bottom: 0;
}

#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_list_1,
#main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_listing > .tb_item > .tb_letter
{
  margin-bottom: <?php echo $base * 0.5; ?>px;
}
.tb_menu_brands.tb_megamenu .tb_submenu {
  padding: <?php echo $base; ?>px <?php echo $base; ?>px <?php echo $base * 0.5; ?>px <?php echo $base; ?>px;
}



/******   P R O D U C T    P A G E   *****************/

#product {
  position: relative;
}

#product h1 + #review_aggregate {
  margin-bottom: <?php echo $base; ?>px;
}
#product_info + #review_aggregate {
  margin-top: <?php echo $base * 0.5; ?>px;
}
#product .tb_tabs.tb_style_2 .tb_tabs_nav > ul > li {
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
.tb_share_box,
.tb_share_box *
{
  -webkit-transition: none;
  transition: none;
}
.tb_share_box {
  margin-top: -<?php echo $base / 2; ?>px;
}
.tb_share_box > * {
  display: inline-block;
  vertical-align: top;
  margin-top: <?php echo $base / 2; ?>px;
}
.tb_share_box > * + * {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base / 2; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base / 2; ?>px;
  <?php endif; ?>
}
.tb_share_box > * > *,
.tb_share_box > * > *[class],
.tb_share_box .tb_facebook > a > span
{
  vertical-align: top !important;
}
.tb_share_box .tb_stumbleupon iframe {
  margin-top: 1px !important;
}
.tb_share_box .tb_linkedin > span {
  height: 20px;
}
.tb_share_box .tb_linkedin > span > span:first-child > span > a > span > span {
  margin-top: -1px !important;
}
.tb_share_box .tb_linkedin > span > span:first-child + span > span > span {
  margin-top: -2px !important;
}

#product_share:first-child h3 {
  display: none;
}
#product_share .tb_plusone,
#product_share .tb_plusone div {
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  width: 70px !important;
}
#product_share .tb_plusone iframe {
  width: 70px !important;
}
#product_share .addthis_counter {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 10px;
  <?php else: ?>
  margin-left: 10px;
  <?php endif; ?>
}
#product_share .addthis_toolbox > * {
  padding: 0;
}
#product_share .addthis_toolbox > *,
#product_share .addthis_toolbox > * + *
{
  display: inline-block;
  vertical-align: top;
}
#product #review .pagination {
  margin-top: <?php echo $base * 1.5; ?>px;
  margin-bottom: 0;
  min-height: <?php echo $base * 1.5; ?>px;
}
#product #review .pagination .links {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 20px;
  <?php else: ?>
  margin-left: 20px;
  <?php endif; ?>
}
#product #review .pagination .results {
  float: none;
}
#product #review + span.clear {
  margin-top: -<?php echo $base * 1.5; ?>px;
}
#product #review + span.clear + .tb_button {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
}
#product #review .tb_empty {
  float: left;
  width: 100%;
}
#product_discounts {
  margin: <?php echo $base * 0.5; ?>px 0 <?php echo $base * 1.5; ?>px 0;
}
#product_discounts h3 {
  margin-bottom: <?php echo $base; ?>px;
}
#product_discounts table th,
#product_discounts table td
{
  padding-top: <?php echo $base / 4; ?>px;
  padding-bottom: <?php echo $base / 4 - 1; ?>px;
}
.tb_tabs_content #product_discounts {
  margin: 0;
}
.tb_tabs_content #product_discounts h3 {
  display: none;
}

#product_options {
  overflow: hidden;
  margin-bottom: <?php echo $base * 1.5; ?>px;
  padding: 0 <?php echo $base; ?>px;
}
#product_options h3 {
  display: none;
}

#product_add_to_cart_form {
  position: relative;
  display: table;
  width: 100%;
}
#product_buy .tb_purchase_button,
#product_buy .tb_actions
{
  display: table-cell;
  vertical-align: middle;
}
#product_buy .tb_purchase_button {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
#product_buy .tb_actions {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
#product_buy .tb_purchase_button > * {
  display: inline-block;
  float: none;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 5px;
  <?php else: ?>
  margin-left: 5px;
  <?php endif; ?>
  vertical-align: middle;
}
#product_buy .tb_actions:first-child > * {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: <?php echo $base; ?>px;
  <?php else: ?>
  float: right;
  margin-left: <?php echo $base; ?>px;
  <?php endif; ?>
}
#product_buy .tb_purchase_button label {
  display: none;
  width: auto;
  height: 30px;
  line-height: 30px;
  font-size: 16px;
}
#product_buy .tb_purchase_button input {
  width: 35px;
  padding: 0;
  text-align: center;
  font-size: 16px;
}
#product_buy .tb_bgr {
  z-index: 1;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.12;
}
#product_buy .tb_purchase_info {
  clear: both;
  padding-top: <?php echo $base * 0.5; ?>px;
  text-align: center;
  font-size: 11px;
}
#product_buy .tb_actions > * {
  white-space: nowrap;
}

#product_price {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
#product_price .tb_price {
  margin-bottom: 0;
}
#product_price .tb_price > span[itemprop=price] {
  line-height: 30px;
  font-size: 24px;
}
#product_price .tb_old_price {
  display: inline-block;
  line-height: 20px;
  font-size: 16px;
  opacity: 0.5;
}
#product_price .tb_old_price + span {
  display: block;
}
#product_price p.tb_price_tax,
#product_price p.tb_reward_points
{
  margin-bottom: 0;
}
#product_price p.tb_reward_points {
  opacity: 0.6;
}
#product_price p.tb_reward_points small {
  font-size: 10px;
}
#product_price p.tb_price_tax {
  opacity: 0.8;
}
#product_price p.tb_price_tax,
#product_price p.tb_price_tax *
{
  font-size: 11px !important;
}

.tb_product_images .tb_zoom_box {
  position: absolute;
  z-index: 9;
  top: 0;
  left: 0;
  right: 0;
  display: block;
  max-height: 100%;
}
.is_touch .tb_product_images .tb_zoom_box {
  display: none;
}
.tb_product_images .tb_zoom_click {
  cursor: url('<?php echo $theme_catalog_image_url; ?>cursor_zoom.cur'), auto !important;
}
.tb_product_images .tb_zoom_click.tb_zoomed {
  cursor: url('<?php echo $theme_catalog_image_url; ?>cursor_zoom_out.cur'), auto !important;
}
.tb_product_images .tb_zoom_mouseover {
  cursor: move;
}
.tb_product_images_preview {
  position: relative;
  margin-bottom: <?php echo $base * 1.5; ?>px;
}
.tb_product_images_preview > img {
  vertical-align: top;
}
.tb_product_images_preview .tb_slider_controls {
  position: static;
}
.tb_product_images_preview .tb_slider_controls > a {
  z-index: 2;
  position: absolute;
  top: 50%;
  margin: 0;
  margin-top: -<?php echo $base; ?>px;
  padding: <?php echo $base / 2; ?>px;
  background: #fff;
  opacity: 0;
}
.tb_product_images_preview:hover .tb_slider_controls > a {
  opacity: 1;
}
.tb_product_images_preview .tb_slider_controls .tb_prev {
  left: 0;
}
.tb_product_images_preview .tb_slider_controls .tb_next {
  right: 0;
}
.tb_product_images_preview .tb_slider_pagination {
  padding: <?php echo $base / 2; ?>px 0;
}
.tb_product_images_thumbs {
  position: relative;
  float: left;
  width: 100%;
}
#product_image_preview {
  display: block;
}
#product_images_thumbs > a {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base; ?>px;
  <?php endif; ?>
}
#product_images_thumbs > a:last-child {
  margin-bottom: 0;
}
#product_images_thumbs > a:first-child:last-child {
  display: none;
}

#product .tb_tabs_content > div > h2:first-child {
  display: none;
}

#product_tags h2 {
  margin-bottom: 0;
}
.tb_product_description + #product_tags {
  margin-top: <?php echo $base; ?>px;
}
#product_tags li {
  display: inline-block;
  <?php if ($lang_dir == 'ltr'): ?>
  margin: <?php echo $base; ?>px 10px 0 0;
  <?php else: ?>
  margin: <?php echo $base; ?>px 0 0 10px;
  <?php endif; ?>
  vertical-align: top;
}
#product_tags a {
  display: block;
  float: left;
  height: 20px;
  line-height: 19px;
  white-space: nowrap;
  font-size: 11px;
  <?php if ($lang_dir == 'ltr'): ?>
  padding: 0 10px 0 15px;
  background: url(<?php echo $theme_catalog_image_url; ?>tag.png) no-repeat center left;
  <?php else: ?>
  padding: 0 15px 0 10px;
  background: url(<?php echo $theme_catalog_image_url; ?>rtl/tag.png) no-repeat center right;
  <?php endif; ?>
}




/******   A C C O U N T   ****************************/

#new_customer fieldset,
#login_form fieldset
{
  min-height: <?php echo $base * 11; ?>px;
}

.tb_reward_points th.date,
.tb_transactions th.date {
  white-space: nowrap;
}
.tb_reward_points_total,
.tb_balance_total
{
  display: inline-block;
  margin-top: -0.07em;
  vertical-align: top;
  font-size: <?php echo $base_font_size * 1.5; ?>px;
}



.tb_product_row {
  position: relative;
  clear: both;
}
#return-product .tb_product_row:first-child {
  margin-top: 0 !important;
  border-top: 1px solid #eee;
}
<?php if ($lang_dir == 'rtl'): ?>
#return-product .tb_product_row .tb_button_1_small.tb_ddd_bgr {
  float: left;
  margin-left: 0;
}
<?php endif; ?>


/******   C A R T   **********************************/

.cart-info table {
  margin-bottom: 0;
  table-layout: auto;
}
.cart-info table img {
  display: inline-block;
  vertical-align: top;
}
.cart-info table .return,
.cart-info table .image
{
  width: 10px;
}
.cart-info table .return img
{
  vertical-align: text-top;
}
.cart-info table tbody td {
  padding: <?php echo $base; ?>px <?php echo $base * 0.5; ?>px;
}
.cart-info table tbody td:first-child {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base; ?>px;
  <?php endif; ?>
}
.cart-info table tbody td:last-child {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base; ?>px;
  <?php else: ?>
  padding-left: <?php echo $base; ?>px;
  <?php endif; ?>
}
.cart-info table .image img {
  max-width: <?php echo $base * 4; ?>px;
}
.cart-info table .name {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
.cart-info table .name > a {
  font-size: <?php echo $base_font_size + 1; ?>px;
  font-weight: bold;
}
.cart-info table .name div,
.cart-info table .name > small
{
  font-size: <?php echo $base_font_size; ?>px;
}
.cart-info table .name > small {
  opacity: 0.6;
}
.cart-info table tbody .quantity {
  white-space: nowrap;
  word-spacing: -0.3em;
}
.cart-info table tbody .quantity input {
  margin-left: 0;
  margin-right: 0;
}
.cart-info table tbody .quantity input[type=text],
.cart-info table tbody .quantity input[type=number]
{
  width: <?php echo $base * 2; ?>px;
  text-align: center;
}
.cart-info table tbody .quantity > * {
  vertical-align: top;
}
.cart-info table tbody .action a {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}
.cart-info + .cart-total {
  margin-top: <?php echo $base; ?>px;
}
.cart-total table {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
  width: 300px;
}
.cart-total table td {
  padding: 0 !important;
  vertical-align: top;
}
.cart-total td:first-child {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
.cart-total td:first-child + td {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.cart-total tr:last-child td {
  padding-top: <?php echo $base * 0.5; ?>px !important;
  line-height: <?php echo $base * 1.5; ?>px;
  font-size: <?php echo ceil($base_font_size * 1.35); ?>px;
}

#cart_modules .ui-state-default,
#cart_modules .ui-state-default *
{
  color: inherit !important;
}
#cart_modules .ui-accordion-content {
  margin: 0;
  padding: <?php echo $base * 1.5; ?>px 0;
}
#cart_modules .ui-accordion-content-active:last-child {
  padding-bottom: <?php echo $base * 1.5; ?>px;
  border-bottom: 1px solid #ddd;
}
#cart_modules > h2,
#cart_modules > div
{
  border-top-color:  transparent !important;
  border-left-color:  transparent !important;
  border-right-color: transparent !important;
}

/******   P A Y M E N T S   **************************/

.cart-discounts > div {
  padding: <?php echo $base; ?>px;
  border-width: 5px;
  border-style: solid;
}


/*****************************************************/
/*****   P A V I L I O N    S T Y L E S   ************/
/*****************************************************/

#header_wrap.tb_header_visible > :last-child {
  margin-bottom: 0;
}
#header_wrap.tb_header_overlay {
  position: absolute;
  z-index: 50;
  top: 0;
  left: 0;
  right: 0;
}
#header > .tb_wrap,
#header > .tb_wrap > [class*="tb_col"],
#header > .tb_wrap > [class*="tb_col"] > .tb_row
{
  border-top-left-radius: inherit;
  border-top-right-radius: inherit;
}
.tb_widget_cart,
.tb_widget_site_search,
.tb_widget_currency,
.tb_widget_language,
#welcome_message,
#user_navigation,
#site_logo,
#main_navigation
{
  display: inline-block;
  vertical-align: top;
}
.valign_middle > .tb_widget_cart,
.valign_middle > .tb_widget_site_search,
.valign_middle > .tb_widget_currency,
.valign_middle > .tb_widget_language,
.valign_middle > #welcome_message,
.valign_middle > #user_navigation,
.valign_middle > #site_logo,
.valign_middle > #main_navigation
{
  vertical-align: initial;
}
.tb_widget_cart:hover {
  z-index: 50;
}
#header.tb_style_1 #user_navigation + span.clear {
  margin-top: <?php echo $base * 0.5; ?>px;
}
#header.tb_style_1 #user_navigation + span.clear + #main_navigation {
  margin-top: <?php echo $base * 0.5; ?>px;
}
#header.tb_style_3 .tb_widget_currency,
#header.tb_style_3 .tb_widget_language,
#header.tb_style_3 .tb_widget_site_search,
#header[class*="tb_style_2_"] .tb_widget_currency,
#header[class*="tb_style_2_"] .tb_widget_language,
#header[class*="tb_style_2_"] .tb_widget_site_search
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.5; ?>px;
  margin-right: 0;
  <?php else: ?>
  margin-right: <?php echo $base * 0.5; ?>px;
  margin-left: 0;
  <?php endif; ?>
  vertical-align: middle;
}
#header.tb_style_2 #main_navigation,
#header.tb_style_3 #main_navigation
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $menu_spacing * 2; ?>px;
  <?php else: ?>
  margin-left: <?php echo $menu_spacing * 2; ?>px;
  <?php endif; ?>
}
#header[class*="tb_style_2_"] #welcome_message,
#header[class*="tb_style_2_"] #user_navigation
{
  display: block;
}
#header[class*="tb_style_2_"] + #main_navigation_row {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
#header[class*="tb_style_2_"] + #main_navigation_row .tb_widget_cart .heading h4 {
  display: inline-block;
  vertical-align: top;
}
#header[class*="tb_style_2_"] + #main_navigation_row .tb_widget_cart .heading h4 {
  display: inline-block;
  vertical-align: top;
}
#header[class*="tb_style_2_"] .tb_widget_site_search + span.clear {
  margin-bottom: <?php echo $base; ?>px;
}
#header.tb_style_2_1 + #main_navigation_row > .tb_wrap > .tb_col_1_1 > .tb_row > .tb_wrap > .tb_col_1_1 {
  display: table;
}
#header.tb_style_2_1 .tb_widget_site_search + span.clear {
  margin-bottom: <?php echo $base; ?>px;
}
#header.tb_style_2_1 .tb_widget_site_search + span.clear + #welcome_message {
  margin-bottom: <?php echo $base * 0.25; ?>px;
}
#header.tb_style_2_1 .tb_widget_cart {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  margin-left: <?php echo $base; ?>px;
  <?php else: ?>
  float: left;
  margin-right: <?php echo $base; ?>px;
  <?php endif; ?>
  margin-top: <?php echo $base * 0.5; ?>px;
  margin-bottom: <?php echo $base * 0.5; ?>px;
}
#header.tb_style_2_3 #user_navigation + span.clear {
  margin-bottom: <?php echo $base; ?>px;
}
#header.tb_style_2_3 .tb_widget_currency,
#header.tb_style_2_3 .tb_widget_language,
#header.tb_style_2_3 .tb_widget_site_search
{
  vertical-align: top;
}
#header.tb_style_2_3 .tb_widget_cart {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}
#header.tb_style_2_3 + #main_navigation_row .tb_widget_site_search {
  margin-top: <?php echo ($menu_height - $base * 1.5) / 2; ?>px;
}
#header.tb_style_2_3 + #main_navigation_row .tb_widget_site_search .tb_search_wrap {
  min-width: 180px;
}
#header.tb_style_2_5 .tb_widget_site_search
{
  display: block;
  width: auto;
  margin: 0 <?php echo $base * 1.5; ?>px;
}
<?php if ($lang_dir == 'rtl'): ?>
#header .tbSystemRow .align_right[class*="tb_col"] {
  text-align: left;
}
<?php endif; ?>


#bottom > .tb_wrap,
#bottom > .tb_wrap > [class*="tb_col"],
#bottom > .tb_wrap > [class*="tb_col"] > .tb_row
{
  border-bottom-left-radius: inherit;
  border-bottom-right-radius: inherit;
}


.tb_grid_view .tb_item .tb_price .tb_decimal_point,
.tb_list_view .tb_item .tb_price .tb_decimal_point,
.tb_price.tb_fancy .tb_decimal_point
{
  display: none;
}
.tb_grid_view .tb_item .tb_price .tb_decimal,
.tb_list_view .tb_item .tb_price .tb_decimal,
.tb_price.tb_fancy .tb_decimal
{
  position: relative;
  top: -0.25em;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 1px;
  <?php else: ?>
  margin-right: 1px;
  <?php endif; ?>
  font-size: 0.6em;
  vertical-align: top;
}


.tb_sticky_container[class] {
  z-index: 50;
  position: fixed !important;
  top: 0;
  margin: 0;
  padding: 20px 0 !important;
  border-top: 0 none !important;
  border-bottom: 0 none !important;
  box-shadow:
    0 1px 0 rgba(0, 0, 0, 0.08),
    0 0 20px rgba(0, 0, 0, 0.12) !important;
}
.tb_sticky_container.tb_row_full {
  left: 0;
  right: 0;
}
#wrapper.tb_row_fixed .tb_sticky_container,
#header.tb_row_fixed + .tb_sticky_container,
.tb_sticky_container.tb_row_fixed
{
  left: 50%;
  width: 1000px;
  margin-left: -500px !important;
  padding-left: 30px;
  padding-right: 30px;
}
.tb_width_1200 #wrapper.tb_row_fixed .tb_sticky_container,
.tb_width_1200 #header.tb_row_fixed + .tb_sticky_container,
.tb_width_1200 .tb_sticky_container.tb_row_fixed
{
  width: 1200px;
  margin-left: -600px !important;
}
.tb_sticky_container[class] .tb_menu_home,
.tb_sticky_container[class] span.clear,
.tb_sticky_container[class] .tb_widget_cart,
.tb_sticky_container[class] .tb_widget_site_search,
.tb_sticky_container[class] .tb_widget_currency,
.tb_sticky_container[class] .tb_widget_language,
.tb_sticky_container[class] #welcome_message,
.tb_sticky_container[class] #user_navigation,
.tb_sticky_container[class] #site_logo
{
  display: none !important;
}
.tb_sticky_container[class] > .tb_wrap,
.tb_sticky_container[class] > .tb_wrap > [class*="tb_col_"],
.tb_sticky_container[class] > .tb_wrap > [class*="tb_col_"] > .tb_row[class],
.tb_sticky_container[class] > .tb_wrap > [class*="tb_col_"] > .tb_row[class] > .tb_wrap,
.tb_sticky_container[class] > .tb_wrap > [class*="tb_col_"] > .tb_row[class] > .tb_wrap > [class*="tb_col_"]
{
  float: none;
  width: auto;
  height: auto;
  min-height: 0;
  margin-top: 0;
  margin-bottom: 0;
  padding-top: 0;
  padding-bottom: 0;
}
.tb_sticky_container .tbNavContainer,
.tb_sticky_container .tbNavContainerCol
{
  display: block !important;
  text-align: initial;
}
#wrapper.tb_row_fixed .tb_sticky_container .tbNavContainer,
#header.tb_row_fixed + .tb_sticky_container .tbNavContainer,
.tb_sticky_container.tb_row_fixed .tbNavContainer
{
  padding-left: 30px !important;
  padding-right: 30px !important;
}
.tb_sticky_container .tbNavContainerCol > .tbCloned,
.tb_sticky_container .tbNavContainerCol > #site_logo,
.tb_sticky_container .tbNavContainerCol > #main_navigation
{
  display: table-cell !important;
  float: none !important;
  vertical-align: middle !important;
}
.tb_sticky_container #site_logo img {
  max-width: none;
  <?php if ($sticky_logo_max_w): ?>max-width:  <?php echo $sticky_logo_max_w; ?>px;<?php endif; ?>
  <?php if ($sticky_logo_max_h): ?>max-height: <?php echo $sticky_logo_max_h; ?>px;<?php endif; ?>
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base * 1.5; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base * 1.5; ?>px;
  <?php endif; ?>
}
.tb_sticky_container #site_logo.tb_text {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base * 1.5; ?>px;
  <?php else: ?>
  padding-left: <?php echo $base * 1.5; ?>px;
  <?php endif; ?>
}
.tb_sticky_container #main_navigation {
  width: 100%;
  border: none !important;
}
.tb_sticky_container #main_navigation > .tb_nav {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 30px;
  <?php else: ?>
  margin-left: 30px;
  <?php endif; ?>
}
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered {
  padding-bottom: <?php echo $base * 0.25; ?>px !important;
}
.tb_sticky_container #cart.tb_hovered {
  padding-bottom: <?php echo $base / 2; ?>px !important;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered {
  margin-bottom: -<?php echo $base * 0.25; ?>px !important;
}
.tb_sticky_container #cart.tb_hovered {
  margin-bottom: -<?php echo $base / 2; ?>px !important;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li > a {
  height: auto !important;
  <?php if ($menu_padding > 0): ?>
  padding-left: <?php echo $tbData->calculateLineHeight($menu_size, $base) * 0.5; ?>px !important;
  padding-right: <?php echo $tbData->calculateLineHeight($menu_size, $base) * 0.5; ?>px !important;
  <?php else: ?>
  padding-left: 0 !important;
  padding-right: 0 !important;
  <?php endif; ?>
  line-height: <?php echo $tbData->calculateLineHeight($menu_size, $base) + $base * 0.5; ?>px !important;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li > a:after {
  <?php if ($menu_padding > 0): ?>
  <?php if ($lang_dir == 'ltr'): ?>
  right: <?php echo $tbData->calculateLineHeight($menu_size, $base) * 0.5 - 1; ?>px;
  <?php else: ?>
  left: <?php echo $tbData->calculateLineHeight($menu_size, $base) * 0.5 - 1; ?>px;
  <?php endif; ?>
  <?php else: ?>
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0 !important;
  <?php else: ?>
  left: 0 !important;
  <?php endif; ?>
  <?php endif; ?>
}
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple > a {
  <?php if ($menu_padding > 0): ?>
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $tbData->calculateLineHeight($menu_size, $base) * 0.5 + $base * 0.5 + 4; ?>px !important;
  <?php else: ?>
  padding-left: <?php echo $tbData->calculateLineHeight($menu_size, $base) * 0.5 + $base * 0.5 + 4; ?>px !important;
  <?php endif; ?>
  <?php else: ?>
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base * 0.5 + 4; ?>px !important;
  <?php else: ?>
  padding-left: <?php echo $base * 0.5 + 4; ?>px !important;
  <?php endif; ?>
  <?php endif; ?>
}
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered > a {
  padding-bottom: 0 !important;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered > a:after {
  margin-top: -<?php echo $base * 0.5; ?>px !important;
}
#main_navigation_row.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered:after,
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered :after,
.tb_sticky_container #cart.tb_hovered:after
{
  margin-top: -6px !important;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 12px;
  <?php else: ?>
  margin-right: 12px;
  <?php endif; ?>
}
#main_navigation_row.tb_sticky_container.tb_row_full[class*="tb_ml_"] .tb_megamenu > .tb_submenu,
#main_navigation_row.tb_sticky_container.tb_row_fixed[class*="tb_ml_"] .tb_megamenu > .tb_submenu
{
  left: 0;
  right: 0;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li > .tb_submenu,
.tb_sticky_container #cart .tb_submenu
{
  margin-top: 0 !important;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_megamenu > .tb_submenu {
  margin-top: <?php echo $base * 0.25; ?>px !important;
}
#main_navigation_row.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_megamenu.tb_multiple.tb_hovered:after,
.tb_sticky_container #main_navigation .tb_nav > ul > li.tb_megamenu.tb_multiple.tb_hovered:after
{
  margin-top: <?php echo $base * 0.25 - 6; ?>px !important;
}
.tb_sticky_container #main_navigation .tb_nav > ul > li > a > .tb_accent_label {
  top: 0;
  margin-top: -<?php echo $menu_height * 0.22; ?>px;
}
.tb_sticky_container .tb_widget_site_search.tbCloned {
  min-width: 180px;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: 20px;
  <?php else: ?>
  padding-left: 20px;
  <?php endif; ?>
}
.tb_sticky_container .tb_widget_cart.tbCloned .tb_toggle {
  display: block !important;
  width: <?php echo $base * 1.5; ?>px;
  height: <?php echo $base * 1.5; ?>px;
  padding: 0;
}
.tb_sticky_container .tb_widget_cart.tbCloned .tb_toggle:before {
  width: 100%;
  line-height: <?php echo $base * 1.5 - 1; ?>px;
  font-size: 16px;
}
.tb_sticky_container .tb_widget_cart.tbCloned .heading {
  display: none;
}
.tb_sticky_container .tb_widget_cart.tbCloned #cart {
  margin-top: -<?php echo $base * 1.5; ?>px;
  padding-top: <?php echo $base * 1.5; ?>px;
  background-color: transparent !important;
}
.tb_sticky_container .tb_widget_cart.tbCloned #cart.tb_hovered:after {
  margin-left: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 50%;
  margin-left: -5px !important;
  margin-right: 0 !important;
  <?php else: ?>
  right: 50%;
  margin-right: -5px !important;
  margin-left: 0 !important;
  <?php endif; ?>
}

#header [class*="tb_widget"] {
  margin-bottom: 0;
}
#header #user_navigation + #main_navigation {
  margin-top: <?php echo $base / 2 - 1; ?>px;
  padding-top: <?php echo $base / 2 - 1; ?>px;
  border-top-width: 1px;
  border-top-style: solid;
}
#header #main_navigation .tb_nav .tb_megamenu.tb_multiple.tb_hovered:after {
  top: auto;
}


#main_navigation .tb_menu_home [class*="fa-"]:before {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base * 0.25; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base * 0.25; ?>px;
  <?php endif; ?>
  font-size: 15px;
}
#main_navigation .tb_menu_home [class*="fa-"]:empty:before {
  margin-right: 0;
  margin-left: 0;
}

#user_navigation + .tb_widget_language,
#user_navigation + .tb_widget_currency
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base / 2; ?>px;
  padding-left: <?php echo $base / 2; ?>px;
  border-left-width: 1px;
  border-left-style: solid;
  <?php else: ?>
  margin-right: <?php echo $base / 2; ?>px;
  padding-right: <?php echo $base / 2; ?>px;
  border-right-width: 1px;
  border-right-style: solid;
  <?php endif; ?>
}
.tb_widget_currency + .tb_widget_language,
.tb_widget_currency + .tb_widget_site_search,
.tb_widget_language + .tb_widget_site_search,
#welcome_message + .tb_widget_currency,
#welcome_message + .tb_widget_language
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base / 2; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base / 2; ?>px;
  <?php endif; ?>
}
.tb_widget_currency .tb_submenu,
.tb_widget_language .tb_submenu
{
  width: 100px;
  padding: <?php echo $base * 0.25; ?>px <?php echo $base * 0.5; ?>px;
}




#site_logo {
  max-width: 100%;
}
#site_logo img {
  <?php if ($logo_max_w): ?>max-width:  <?php echo $logo_max_w; ?>px;<?php endif; ?>
  <?php if ($logo_max_h): ?>max-height: <?php echo $logo_max_h; ?>px;<?php endif; ?>
  vertical-align: top;
}


#welcome_message p {
  margin-bottom: 0;
  font-size: 11px;
}

#language_switcher li {
  white-space: nowrap;
}
#language_switcher li a img {
  margin-top: -3px;
  vertical-align: middle;
}


.tb_widget_site_search {
  display: inline-block;
  width: 180px;
  max-width: 100%;
  vertical-align: top;
}
.tb_widget_site_search .tb_search_wrap {
  position: relative;
}
.tb_widget_site_search .tb_search_button {
  position: absolute;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
  display: block;
  width: <?php echo $base * 1.5; ?>px;
  height: <?php echo $base * 1.5; ?>px;
  line-height: <?php echo $base * 1.5; ?>px;
  text-align: center;
}
.tb_widget_site_search input {
  float: none;
  width: 100%;
  margin: 0;
}

.tb_widget_site_search + .tb_widget_cart {
  margin-top: <?php echo $base / 2; ?>px;
}

#cart_modules > h2,
.checkout .checkout-heading,
.panel-group > .panel > .panel-heading
{
  text-transform: none !important;
  letter-spacing: 0 !important;
  line-height: <?php echo $tbData->calculateLineHeight($base_font_size + 1, $base); ?>px;
  font-size: <?php echo $base_font_size + 1; ?>px !important;
}

#copy,
#payment_images
{
  display: table-cell;
  vertical-align: middle;
}
#copy {
  width: 25%;
  font-size: 11px;
}
#payment_images {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
  word-spacing: -0.25em;
}
#payment_images .tb_payment {
  display: inline-block;
  word-spacing: normal;
  vertical-align: middle;
}
#payment_images .tb_payment img {
  display: inline-block;
  vertical-align: top;
}
#payment_images .tb_payment table {
  width: auto;
}
#payment_images .tb_payment + .tb_payment {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}



/*****************************************************/
/*****   P A G E S   *********************************/
/*****************************************************/


/******   Shopping Cart   ****************************/

#shopping_cart #cart_form {
  margin-bottom: 3px;
}
#cart_form .tb_table_1 {
  margin-bottom: 0;
}
#apply_coupon,
#apply_voucher,
#apply_reward,
#apply_shipping
{
  margin: 0;
}
#apply_coupon label,
#apply_voucher label,
#apply_reward label
{
  display: block;
  float: none;
  width: auto;
}
#apply_coupon input[type=text],
#apply_voucher input[type=text],
#apply_reward input[type=text]
{
  margin-top: <?php echo $base / 2; ?>px;
}
#apply_coupon .tb_button,
#apply_voucher .tb_button,
#apply_reward .tb_button
{
  height: <?php echo $base * 1.5; ?>px;
  margin-top: <?php echo $base / 2; ?>px;
  padding: 0 <?php echo $base / 2; ?>px;
  line-height: <?php echo $base * 1.5; ?>px;
  vertical-align: bottom;
}
#apply_shipping fieldset {
  margin-bottom: 0;
}
#apply_shipping .tb_submit {
  margin: 0;
  padding-top: 0;
  border-top: none;
}
#shipping_quote table {
  width: 100% !important;
}
#shipping_quote table.radio {
  max-width: 500px;
}
#apply_shipping .tb_button,
#shipping_quote .button
{
  margin-top: <?php echo $base; ?>px;
}
#apply_shipping .tb_button {
  margin-top: 0;
}


/******   C H E C K O U T   **************************/

.panel-group > .panel > .panel-heading
{
  position: relative;
  cursor: default !important;
}
.panel-group > .panel > .panel-heading > .panel-title,
.panel-group > .panel > .panel-heading > .panel-title > a
{
  padding: <?php echo $base * 0.5; ?>px <?php echo $base; ?>px <?php echo $base * 0.5 - 1; ?>px <?php echo $base; ?>px;
}
.panel-group > .panel > .panel-heading > .panel-title {
  margin: 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.12) !important;
}
.panel-group > .panel > .panel-heading > .panel-title > a {
  display: block;
  margin: -<?php echo $base * 0.5; ?>px -<?php echo $base; ?>px -<?php echo $base * 0.5 - 1; ?>px -<?php echo $base; ?>px;
}
.panel-group > .panel > .panel-heading > .panel-title i {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
  opacity: 0.8;
}
.panel-group > .panel > .panel-heading > .panel-title .collapsed i {
  -webkit-transform: rotate(-90deg);
      -ms-transform: rotate(-90deg);
          transform: rotate(-90deg);
}
.panel-group > .panel >.panel-collapse .panel-body {
  padding: <?php echo $base * 1.5; ?>px 0;
}
.panel-group > .panel:last-child >.panel-collapse .panel-body {
  padding-bottom: 0;
}
.tb_new_customer_box,
.tb_login_box
{
  min-height: <?php echo $base * 11; ?>px;
}
.checkout select[size] {
  width: 100%;
  margin-bottom: <?php echo $base / 2; ?>px;
}
#payment-new,
#shipping-new
{
  margin-bottom: <?php echo $base * 1.5; ?>px;
}

/******   C A R T    M O D U L E   *******************/

#cart {
  z-index: 5;
  position: relative;
}
#cart .heading {
  white-space: nowrap;
}
#cart .heading,
#cart .heading *
{
  margin-bottom: 0;
}
#cart .heading > a > * {
  display: inline-block;
  vertical-align: top;
}
#cart .heading .tb_icon {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 0.3em;
  <?php else: ?>
  margin-left: 0.3em;
  <?php endif; ?>
}
#cart .heading .tb_icon:before {
  margin-top: -1px;
  vertical-align: top;
  font-size: 18px;
}
#cart .heading .tb_label {
  text-transform: uppercase;
  font-size: <?php echo $base_font_size; ?>px;
}
#main_navigation_row #cart .heading > a > span {
  font-size: inherit;
}
#main_navigation_row #cart .heading .tb_total {
  margin-top: -0.2em;
  line-height: 1.2em;
  vertical-align: middle;
}
#cart .heading .tb_items {
  opacity: 0.7;
}
#cart .heading .tb_total {
  font-size: 18px;
}
#cart .heading .tb_label + .tb_total,
#cart .heading .tb_items + .tb_total
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 0.5em;
  padding-left: 0.5em;
  border-left-width: 1px;
  border-left-style: solid;
  <?php else: ?>
  margin-right: 0.5em;
  padding-right: 0.5em;
  border-right-width: 1px;
  border-right-style: solid;
  <?php endif; ?>
}
#cart h4 {
  margin-bottom: 0;
}
#cart > a {
  display: inline-block;
  color: #fff;
  text-shadow: 0 1px 0 rgba(0, 0, 0, 0.2);
  vertical-align: top;
}
#cart > a > * {
  display: block;
}
#cart > a > :first-child {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: -5px;
  <?php else: ?>
  margin-right: -5px;
  <?php endif; ?>
}
#cart > a > .tb_label {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  line-height: 15px;
}
#cart .tb_items_count {
  display: block;
  font-size: 11px;
}
#cart .tb_grand_total {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  padding-left: 15px;
  <?php else: ?>
  float: left;
  padding-right: 15px;
  <?php endif; ?>
  line-height: 30px;
  font-size: 18px;
}
#cart .tb_grand_total:last-child {
  padding: 0;
}
#cart .tb_submenu {
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  right: auto;
  <?php else: ?>
  left: auto;
  right: 0;
  <?php endif; ?>
  width: 350px;
  display: none;
  padding: <?php echo $base; ?>px;
}
#cart .tb_submenu h3 {
  margin-bottom: <?php echo $base; ?>px;
}
#cart.tb_hovered .tb_submenu {
  display: block;
}
#cart .tb_submit {
  margin-top: <?php echo $base; ?>px;
  padding-top: <?php echo $base; ?>px;
  text-align: center;
}
#cart .tb_button {
  text-transform: none;
}
.mini-cart-info {
  margin-bottom: <?php echo $base; ?>px;
}
.mini-cart-info table {
  table-layout: auto;
}
.mini-cart-info .image img {
  max-width: <?php echo $base * 3; ?>px;
}
.mini-cart-info .name > a {
  font-size: <?php echo $base_font_size; ?>px !important;
}
.mini-cart-info table tbody td {
  padding-top: <?php echo $base / 2; ?>px;
  padding-bottom: <?php echo $base / 2 - 1; ?>px;
}
.mini-cart-total table {
  float: none !important;
  width: 100% !important;
}
.mini-cart-total tr:last-child td {
  line-height: <?php echo $base; ?>px;
  font-size: <?php echo $base_font_size * 1.15; ?>px;
}



/******   B R A N D S   ******************************/

.tb_alphabet_index {
  padding: <?php echo $base / 2; ?>px <?php echo $base; ?>px;
  border-bottom-width: 1px;
  border-bottom-style: solid;
}
.tb_alphabet_index p > * {
  display: inline-block;
  line-height: <?php echo $base; ?>px;
  vertical-align: top;
}
.tb_alphabet_index p > b {
  text-transform: uppercase;
  letter-spacing: 2px;
  font-weight: normal;
  font-size: 11px;
  color: #999;
}
.tb_alphabet_index a {
  padding: 0 5px;
  text-align: center;
  font-size: 15px;
}
.manufacturer-list {
  position: relative;
  clear: both;
  overflow: hidden;
  padding: <?php echo $base; ?>px 0;
}
.manufacturer-list:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  display: block;
  width: 100%;
  border-bottom-width: 1px;
  border-bottom-style: solid;
  opacity: 0.1;
}
.manufacturer-list:last-child:after {
  border-bottom: none;
}
.manufacturer-heading {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: <?php echo $base; ?>px;
  <?php else: ?>
  float: right;
  margin-left: <?php echo $base; ?>px;
  <?php endif; ?>
  width: 50px;
  text-align: center;
  font-size: 24px;
}
.manufacturer-content {
  overflow: hidden;
}
.manufacturer-content ul {
  display: inline-block;
  width: 24.99999%;
  margin-bottom: 0;
  vertical-align: top;
}



/******   C O M P A R E   ****************************/

#compare .tb_product_thumb img {
  margin: 0 auto;
}
#compare .tb_rating {
  vertical-align: text-top;
}
#compare .tb_rating_holder .tb_total {
  display: block;
}
.compare-info tbody td:first-child {
  text-align: inherit;
  font-weight: bold;
}
.compare-info tbody:last-child td {
  padding-top: <?php echo $base; ?>px;
  padding-bottom: 0;
  border-bottom: 0;
}



/******   A D V A N C E D    S E A R C H   ***********/

#adv_search_box input[type=text],
#adv_search_box select,
#adv_search_box a.tb_button_1
{
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: 10px;
  <?php else: ?>
  float: right;
  margin-left: 10px;
  <?php endif; ?>
}
#adv_search_box select {
  width: 150px;
}
#adv_search_box .tb_button_1 {
  width: 80px;
  margin-left: 0;
}
#adv_search_box .tb_button_1 .tb_text {
  text-align: center;
}
#adv_search_box > :last-child {
  margin-bottom: 0;
}


/******   S I T E M A P   ****************************/

.tb_sitemap {
  -webkit-column-count: 3;
     -moz-column-count: 3;
       -o-column-count: 3;
          column-count: 3;
}


/*****************************************************/
/******    B L O C K S    ****************************/
/*****************************************************/

[class*="tb_widget_"]:empty {
  display: none;
}

/******    Banners    ********************************/

.tb_widget_banner {
  position: relative;
  overflow: hidden;
  padding: 0 !important;
}
.tb_widget_banner.tb_pl_5  .tb_banner { padding: 0 5px;  }
.tb_widget_banner.tb_pl_10 .tb_banner { padding: 0 10px; }
.tb_widget_banner.tb_pl_15 .tb_banner { padding: 0 15px; }
.tb_widget_banner.tb_pl_20 .tb_banner { padding: 0 20px; }
.tb_widget_banner.tb_pl_25 .tb_banner { padding: 0 25px; }
.tb_widget_banner.tb_pl_30 .tb_banner { padding: 0 30px; }
.tb_widget_banner.tb_pl_35 .tb_banner { padding: 0 35px; }
.tb_widget_banner.tb_pl_40 .tb_banner { padding: 0 40px; }
.tb_widget_banner.tb_pl_45 .tb_banner { padding: 0 45px; }
.tb_widget_banner.tb_pl_50 .tb_banner { padding: 0 50px; }
.tb_widget_banner.tb_pt_5  .tb_banner { padding-top: 5px;  }
.tb_widget_banner.tb_pt_10 .tb_banner { padding-top: 10px; }
.tb_widget_banner.tb_pt_15 .tb_banner { padding-top: 15px; }
.tb_widget_banner.tb_pt_20 .tb_banner { padding-top: 20px; }
.tb_widget_banner.tb_pt_25 .tb_banner { padding-top: 25px; }
.tb_widget_banner.tb_pt_30 .tb_banner { padding-top: 30px; }
.tb_widget_banner.tb_pt_35 .tb_banner { padding-top: 35px; }
.tb_widget_banner.tb_pt_40 .tb_banner { padding-top: 40px; }
.tb_widget_banner.tb_pt_45 .tb_banner { padding-top: 45px; }
.tb_widget_banner.tb_pt_50 .tb_banner { padding-top: 50px; }
.tb_widget_banner.tb_pb_5  .tb_banner { padding-bottom: 5px;  }
.tb_widget_banner.tb_pb_10 .tb_banner { padding-bottom: 10px; }
.tb_widget_banner.tb_pb_15 .tb_banner { padding-bottom: 15px; }
.tb_widget_banner.tb_pb_20 .tb_banner { padding-bottom: 20px; }
.tb_widget_banner.tb_pb_25 .tb_banner { padding-bottom: 25px; }
.tb_widget_banner.tb_pb_30 .tb_banner { padding-bottom: 30px; }
.tb_widget_banner.tb_pb_35 .tb_banner { padding-bottom: 35px; }
.tb_widget_banner.tb_pb_40 .tb_banner { padding-bottom: 40px; }
.tb_widget_banner.tb_pb_45 .tb_banner { padding-bottom: 45px; }
.tb_widget_banner.tb_pb_50 .tb_banner { padding-bottom: 50px; }

.tb_widget_banner .tb_banner,
.tb_widget_banner .tb_image,
.tb_widget_banner .tb_image:before,
.tb_widget_banner > a
{
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  display: block;
  -webkit-transition: all 0.3s ease-out;
          transition: all 0.3s ease-out;
}
.tb_widget_banner .tb_banner {
  z-index: 2;
}
.tb_widget_banner .tb_banner .tb_text_wrap {
  display: table;
  width: 100%;
  height: 100%;
}
.tb_widget_banner .tb_banner .tb_text {
  display: table-cell;
  width: 100%;
  height: 100%;
}
.tb_widget_banner .tb_banner .tb_text span {
  display: block;
}
.tb_widget_banner .tb_banner .tb_text span + span {
  margin-top: <?php echo $base * 0.5; ?>px;
}
.tb_widget_banner .tb_image {
  z-index: 1;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.tb_widget_banner a {
  z-index: 3;
}
.tb_widget_banner .tb_image:before {
  content: '';
  opacity: 0;
}
.tb_widget_banner:hover .tb_image.tb_hover_zoom {
    -ms-transform: scale(1.15);
-webkit-transform: scale(1.15);
        transform: scale(1.15);
}
.tb_widget_banner:hover .tb_image.tb_hover_color:before {
  opacity: 0.6;
}
.tb_widget_banner .tb_ratio {
  visibility: hidden;
  display: block;
  margin: 0 auto;
}
.tb_widget_banner .tb_ratio.tb_no_max_height {
  width: 100%;
}

/******    Breadcrumbs    ****************************/

.breadcrumbs li {
  display: inline-block;
}
.breadcrumbs li + li:before {
  content: '\203A';
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 0.2em;
  margin-right: 0.4em;
  <?php else: ?>
  margin-left: 0.4em;
  margin-right: 0.2em;
  <?php endif; ?>
}


/******    Call To Action   **************************/

.tb_widget_call_to_action {
  position: relative;
}
.tb_widget_call_to_action .tb_button span {
  vertical-align: top;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base / 2; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base / 2; ?>px;
  <?php endif; ?>
}
.tb_widget_call_to_action .tb_description.tb_button_left  + .tb_button_holder .tb_button,
.tb_widget_call_to_action .tb_description.tb_button_right + .tb_button_holder .tb_button
{
  position: absolute;
  top: 50%;
  margin-left: 0;
  margin-right: 0;
}
.tb_widget_call_to_action .tb_description.tb_button_left  + .tb_button_holder .tb_button.tb_h_30,
.tb_widget_call_to_action .tb_description.tb_button_right + .tb_button_holder .tb_button.tb_h_30
{
  margin-top: -15px;
}
.tb_widget_call_to_action .tb_description.tb_button_left  + .tb_button_holder .tb_button.tb_h_40,
.tb_widget_call_to_action .tb_description.tb_button_right + .tb_button_holder .tb_button.tb_h_40
{
  margin-top: -20px;
}
.tb_widget_call_to_action .tb_description.tb_button_left  + .tb_button_holder .tb_button.tb_h_50,
.tb_widget_call_to_action .tb_description.tb_button_right + .tb_button_holder .tb_button.tb_h_50
{
  margin-top: -25px;
}
.tb_widget_call_to_action .tb_description.tb_button_left  + .tb_button_holder .tb_button.tb_h_60,
.tb_widget_call_to_action .tb_description.tb_button_right + .tb_button_holder .tb_button.tb_h_60
{
  margin-top: -30px;
}
.tb_widget_call_to_action .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 0; }
.tb_widget_call_to_action.tb_pl_5  .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 5px;  }
.tb_widget_call_to_action.tb_pl_10 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 10px; }
.tb_widget_call_to_action.tb_pl_15 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 15px; }
.tb_widget_call_to_action.tb_pl_20 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 20px; }
.tb_widget_call_to_action.tb_pl_25 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 25px; }
.tb_widget_call_to_action.tb_pl_30 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 30px; }
.tb_widget_call_to_action.tb_pl_35 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 35px; }
.tb_widget_call_to_action.tb_pl_40 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 40px; }
.tb_widget_call_to_action.tb_pl_45 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 45px; }
.tb_widget_call_to_action.tb_pl_50 .tb_description.tb_button_left  + .tb_button_holder .tb_button { left: 50px; }
.tb_widget_call_to_action .tb_description.tb_button_right + .tb_button_holder .tb_button { right: 0; }
.tb_widget_call_to_action.tb_pl_5  .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 5px;  }
.tb_widget_call_to_action.tb_pl_10 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 10px; }
.tb_widget_call_to_action.tb_pl_15 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 15px; }
.tb_widget_call_to_action.tb_pl_20 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 20px; }
.tb_widget_call_to_action.tb_pl_25 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 25px; }
.tb_widget_call_to_action.tb_pl_30 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 30px; }
.tb_widget_call_to_action.tb_pl_35 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 35px; }
.tb_widget_call_to_action.tb_pl_40 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 40px; }
.tb_widget_call_to_action.tb_pl_45 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 45px; }
.tb_widget_call_to_action.tb_pl_50 .tb_description.tb_button_right  + .tb_button_holder .tb_button { right: 50px; }

.tb_widget_call_to_action .tb_description.tb_button_bottom + .tb_button_holder {
  padding-top: <?php echo $base * 1.5; ?>px;
  text-align: center;
}
.tb_widget_call_to_action hr {
  margin-left: 15%;
  margin-right: 15%;
}
.tb_widget_call_to_action .tb_description :last-child {
  margin-bottom: 0 !important;
}

/******    Category    *******************************/

.tb_widget_categories .h2,
.tb_widget_categories .h3,
.tb_widget_categories .h4
{
  display: block;
}
.tb_widget_categories h2,
.tb_widget_categories h2 + .tb_list_1,
.tb_widget_categories h2 + ul > li:last-child > ul,
.tb_widget_categories h2 + ul > li:last-child > h3:last-child
{
  margin-bottom: <?php echo $base; ?>px;
}
.tb_widget_categories h3,
.tb_widget_categories h3 + .tb_list_1,
.tb_widget_categories h4,
.tb_widget_categories h4 + .tb_list_1
{
  margin-bottom: <?php echo $base * 0.5; ?>px;
}
.tb_widget_categories > ul > li:last-child > .h2:last-child,
.tb_widget_categories > ul > li:last-child > .h3:last-child,
.tb_widget_categories > ul > li:last-child > .h4:last-child,
.tb_widget_categories > ul > li:last-child > .tb_list_1,
.tb_widget_categories > ul > li:last-child > ul > li:last-child > .tb_list_1:last-child
{
  margin-bottom: 0;
}
.tb_widget_categories > ul:last-child {
  margin-bottom: 0 !important;
}
.tb_widget_categories li.tb_active > span a {
  font-weight: bold;
}
.tb_widget_categories .tb_toggle {
  display: block !important;
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
  width: <?php echo $base; ?>px;
  height: <?php echo $base; ?>px;
  line-height: <?php echo $base; ?>px;
  text-align: center;
  font-size: 17px;
  cursor: pointer;
}
.tb_widget_categories .tb_toggle:before {
  content: '+'
}
.tb_widget_categories .tb_show > .tb_toggle:before {
  content: '-'
}
.tb_widget_categories .tb_accordion h2 {
  position: static;
}
.tb_widget_categories .tb_accordion > ul.tb_hide {
}
.tb_widget_categories .tb_accordion > ul.tb_hide {
}

/******    Facebook / Twitter box   ******************/

.tb_widget_facebook_likebox .tb_fb_likebox.tb_default {
  border: 1px solid;
  padding: <?php echo $base * 1.5; ?>px;
}
.tb_widget_facebook_likebox h2 + .tb_fb_likebox.tb_default {
  margin-top: <?php echo $base; ?>px;
}
.tb_widget_facebook_likebox .tb_fb_likebox.tb_default .tb_social_box_wrap {
  overflow: hidden;
}
.tb_widget_facebook_likebox .tb_fb_likebox.tb_default .fb_iframe_widget {
  display: block;
}
.tb_widget_facebook_likebox .tb_fb_likebox.tb_default span {
  display: block;
  width: auto !important;
  margin: -10px;
}
.tb_widget_facebook_likebox .tb_fb_likebox.tb_default iframe {
  width: 100% !important;
  position: static !important;
}

/** custom FB box **/

.tb_social_box .tb_social_button {
  position: absolute;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
  margin-top: <?php echo ($tbData->calculateLineHeight($base_h2_size, $base) - 20) * 0.5; ?>px;
}
h2.align_right + .tb_social_box .tb_social_button {
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  right: auto;
  <?php else: ?>
  right: 0;
  left: auto;
  <?php endif; ?>
}
.tb_pt_5  > .tb_social_box .tb_social_button { top: 5px;  }
.tb_pt_10 > .tb_social_box .tb_social_button { top: 10px; }
.tb_pt_15 > .tb_social_box .tb_social_button { top: 15px; }
.tb_pt_20 > .tb_social_box .tb_social_button { top: 20px; }
.tb_pt_25 > .tb_social_box .tb_social_button { top: 25px; }
.tb_pt_30 > .tb_social_box .tb_social_button { top: 30px; }
.tb_pt_35 > .tb_social_box .tb_social_button { top: 35px; }
.tb_pt_40 > .tb_social_box .tb_social_button { top: 40px; }
.tb_pt_45 > .tb_social_box .tb_social_button { top: 45px; }
.tb_pt_50 > .tb_social_box .tb_social_button { top: 50px; }
.tb_pl_5  > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 5px;<?php else: ?>left: 5px;<?php endif; ?>   }
.tb_pl_10 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 10px;<?php else: ?>left: 10px;<?php endif; ?> }
.tb_pl_15 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 15px;<?php else: ?>left: 15px;<?php endif; ?> }
.tb_pl_20 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 20px;<?php else: ?>left: 20px;<?php endif; ?> }
.tb_pl_25 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 25px;<?php else: ?>left: 25px;<?php endif; ?> }
.tb_pl_30 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 30px;<?php else: ?>left: 30px;<?php endif; ?> }
.tb_pl_35 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 35px;<?php else: ?>left: 35px;<?php endif; ?> }
.tb_pl_40 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 40px;<?php else: ?>left: 40px;<?php endif; ?> }
.tb_pl_45 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 45px;<?php else: ?>left: 45px;<?php endif; ?> }
.tb_pl_50 > .tb_social_box .tb_social_button { <?php if ($lang_dir == 'ltr'): ?>right: 50px;<?php else: ?>left: 50px;<?php endif; ?> }

.tb_social_box .tb_social_button > div,
.tb_social_box .tb_social_button > div > span,
.tb_social_box .tb_social_button > div > iframe
{
  display: inline-block !important;
  height: 20px !important;
  vertical-align: top !important;
}
.tb_social_box .tb_social_button > div {
  margin-top: -3px;
  vertical-align: middle !important;
}
.tb_tw_follow_box .tb_tw_follow > div {
  overflow: hidden;
  height: 18px !important;
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 2px;
}
.tb_tw_follow_box .tb_tw_follow > div > iframe {
  margin: -1px;
}


.tb_fb_likebox.tb_custom > div > div > div,
.tb_fb_likebox.tb_custom ._4s7c
{
  height: auto !important;
}
.tb_fb_likebox.tb_custom .hidden_elem {
  display: none !important;
}
.tb_fb_likebox.tb_custom .lfloat {
  float: left;
}
.tb_fb_likebox.tb_custom .rfloat {
  float: right;
}
.tb_social_box img {
  display: block;
}
.tb_social_box .tb_profile .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base; ?>px;
  <?php endif; ?>
}
.tb_social_box .tb_profile h3 {
  margin-bottom: 0;
}
.tb_social_box .tb_profile h3 small {
  font-size: <?php echo $base_font_size; ?>px;
  opacity: 0.8;
}
.tb_fb_likebox.tb_custom ._8o,
.tb_fb_likebox.tb_custom  ._8o .img
{
  display: block;
}
.tb_fb_likebox.tb_custom ._8r {
  margin: 0 <?php echo $base / 2; ?>px 0 0;
}
.tb_fb_likebox.tb_custom ._8u > * {
  display: inline;
}
.tb_social_box .plm {
  overflow: hidden;
  clear: both;
  padding: 0 0 <?php echo $base * 0.5; ?>px 0;
}
.tb_social_box .tb_profile + .plm {
  clear: none;
  margin-top: <?php echo $base * 0.25; ?>px;
}
.tb_fb_likebox.tb_custom .plm a {
  font-weight: bold;
}

/*** facepile ***/

.tb_social_box .uiList {
  overflow: hidden;
  clear: both;
  display: block;
  margin-top: -<?php echo $base; ?>px;
  text-align: justify;
  letter-spacing: 10px;
}
.tb_social_box.tb_show_title .uiList {
  margin-top: -<?php echo $base * 0.5; ?>px;
}
.tb_social_box .tb_profile + .plm + .uiList {
  margin-top: 0;
}
.tb_social_box.tb_show_title .tb_profile + .plm + .uiList {
  margin-top: <?php echo $base * 0.5; ?>px;
}
.tb_social_box .uiList:after {
  content: '';
  display: inline-block;
  width: 100%;
}
.tb_social_box .uiList li {
  display: inline-block;
  width: 50px;
  padding-top: <?php echo $base; ?>px;
  vertical-align: top;
}
.tb_social_box.tb_show_border .uiList li {
  width: 60px;
}
.tb_social_box.tb_show_title .uiList li {
  padding-top: <?php echo $base * 0.5; ?>px;
}
.tb_social_box .uiList li img {
  display: block;
}
.tb_social_box.tb_show_title .uiList li .link:after {
  content: attr(title);
  overflow: hidden;
  display: block;
  width: 100%;
  max-width: 100%;
  height: <?php echo $base; ?>px;
  text-align: center;
  word-spacing: 0;
  letter-spacing: 0;
  font-size: 10px;
}
.tb_social_box .uiList li img {
  width: 100%;
  height: auto;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
}
.tb_social_box.tb_show_border .uiList li img {
  padding: 5px;
  background: #fff;
}
.tb_social_box.tb_max_w_200 .tb_fb_like {
  position: static;
  margin: 0 0 <?php echo $base * 0.5; ?>px 0;
}
.tb_social_box.tb_max_w_200 .plm {
  margin-top: 0;
}

/******    Fire Slider  ******************************/

.tb_widget_fire_slider {
  position: static;
}
.tb_widget_fire_slider .tb_placeholder {
  display: none;
}
.mightySlider {
  direction: ltr;
}
.mSCaption {
  direction: <?php echo $lang_dir; ?>;
}
.mightySlider.fullwidth + .tb_placeholder {
  display: block;
}
.mightySlider.fullwidth {
  position: absolute;
  left: 0;
  right: 0;
}
.mightySlider.fullwidth .frame {
  width: 100%;
}
body > .tb_widget_fire_slider {
  margin: 0;
}
#header_wrap.tb_header_overlay + .tb_widget_fire_slider {
  margin-top: 0;
}

/******    Gallery   *********************************/

.tb_gallery {
  position: relative;
  overflow: hidden;
}
.tb_gallery.tb_grid_view a {
  position: relative;
  display: block;
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_gallery.tb_grid_view a span {
  position: absolute;
  top: 50%;
  left: 50%;
  width: <?php echo $base; ?>px;
  height: <?php echo $base; ?>px;
  margin: -<?php echo $base * 0.5; ?>px 0 0 -<?php echo $base * 0.5; ?>px;
  text-align: center;
  text-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  font-size: 25px;
  color: #fff;
  opacity: 0;
  -webkit-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.tb_gallery.tb_grid_view a:hover span {
  display: block;
  opacity: 1;
}
.tb_gallery.tb_slide_view .fotorama > a > img {
  width: auto;
}
.tb_gallery .tb_fullscreen_button {
  position: absolute;
  z-index: 10;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  right: -<?php echo $base * 2; ?>px;
  <?php else: ?>
  left: -<?php echo $base * 2; ?>px;
  <?php endif; ?>
  width: <?php echo $base * 2; ?>px;
  height: <?php echo $base * 2; ?>px;
  line-height: <?php echo $base * 2; ?>px;
  text-align: center;
  font-size: 18px;
  -webkit-transition: all 0.2s ease-in-out;
          transition: all 0.2s ease-in-out;
}
.tb_gallery .tb_fullscreen_button:before {
  vertical-align: top;
}
.tb_gallery:hover .tb_fullscreen_button,
.is_touch .tb_gallery .tb_fullscreen_button
{
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
}
.tb_gallery.tb_fullscreen {
  position: fixed;
  z-index: 100;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;
  padding: <?php echo $base * 2.5; ?>px 0;
}
.tb_gallery.tb_fullscreen:after {
  content: '';
  position: absolute;
  z-index: 1;
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  background: #000;
  opacity: 0.8;
}
.tb_gallery.tb_fullscreen .fotorama {
  position: relative;
  z-index: 2;
}
.tb_gallery.tb_fullscreen .fotorama__nav-wrap {
  height: 0;
  margin-top: -10px;
  padding-top: 50px;
  overflow: visible;
}
.tb_gallery.tb_inline .fotorama__nav--dots {
  height: <?php echo $base; ?>px;
  padding-top: <?php echo $base * 0.5; ?>px;
}
.tb_gallery.tb_inline .fotorama__nav--dots .fotorama__nav__shaft {
  margin-top: -<?php echo $base * 0.25; ?>px;
}
.tb_gallery .fotorama__dot {
  width: <?php echo $base / 2 - 2; ?>px !important;
  height: <?php echo $base / 2 - 2; ?>px !important;
  border: none;
  -webkit-border-radius: <?php echo $base / 4; ?>px;
  border-radius: <?php echo $base / 4; ?>px;
}
.tb_gallery.tb_fullscreen .fotorama__nav.fotorama__nav--dots {
  position: absolute;
  bottom: 0;
}
.tb_gallery.tb_fullscreen .tb_close {
  position: absolute;
  z-index: 3;
  top: 0;
  right: 0;
  display: block;
  width: 50px;
  height: 50px;
  outline: 0 none !important;
}
.tb_gallery.tb_fullscreen .tb_close:before {
  content: '+';
  display: block;
  line-height: 50px;
  text-align: center;
  font-size: 42px;
  color: inherit;
      -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
          transform: rotate(45deg);
}

/******    Google maps   *****************************/

.tb_map_wrap > span.tb_loading_wrap {
  position: absolute;
  top: 50%;
  left: 50%;
  display: block;
  margin-top: -8px;
  margin-left: -8px;
}
.tb_map_wrap > span.tb_loading_wrap > * {
  margin: 1px 0 0 0;
}
.tb_widget_google_maps.tb_full {
  position: static;
}
.tb_widget_google_maps.tb_full .tb_map_holder {
  position: absolute;
  left: 0;
}
.tb_map_holder {
  overflow: hidden;
  position: relative;
  width: 100%;
  height: 100%;
}
.tb_map_holder.tb_style_2 {
  z-index: 1;
  -webkit-box-shadow: 5px 5px 0 0 rgba(0, 0, 0, 0.1);
  box-shadow: 5px 5px 0 0 rgba(0, 0, 0, 0.1);
}
.tb_map_holder.tb_style_2:before {
  -webkit-box-shadow:
    0 1px 0 0 rgba(255, 255, 255, 0.5) inset,
    0 -10px 20px 0 rgba(0, 0, 0, 0.1) inset;
  box-shadow:
    0 1px 0 0 rgba(255, 255, 255, 0.5) inset,
    0 -10px 20px 0 rgba(0, 0, 0, 0.1) inset;
}
.tb_map iframe {
  display: block;
  width: 100%;
}

/******    Icon List   *******************************/

.tb_icon_list ul {
  margin-bottom: 0;
}
.tb_icon_list li .tb_icon_wrap {
  text-align: center;
}
.tb_icon_list li .tb_icon {
  margin: 0;
}
.tb_icon_list.tb_description_tooltip .tb_description_wrap {
  display: none !important;
}
.tb_icon_list.tb_description_tooltip span.tb_icon {
  cursor: help;
}
.tb_icon_list .tb_icon.tb_style_1 {
  border-radius: 3px;
  -webkit-box-shadow: inset 0 -2px 0 rgba(0, 0, 0, 0.2);
  box-shadow: inset 0 -2px 0 rgba(0, 0, 0, 0.2);
}
.tb_icon_list .tb_icon.tb_style_1:before {
  margin-top: -1px;
}
.tb_icon_list .tb_icon.tb_style_2 {
  border-radius: 100px;
}
.tb_icon_list .tb_icon.tb_style_4,
.tb_icon_list .tb_icon.tb_style_5
{
  border-width: 2px;
  border-style: solid;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
  background-color: transparent !important;
}
.tb_icon_list .tb_icon.tb_style_5 {
  -webkit-border-radius: 50%;
          border-radius: 50%;
}
.tb_icon_list .tb_icon.tb_style_4:hover,
.tb_icon_list .tb_icon.tb_style_5:hover
{
  border-color: transparent !important;
}
.tb_icon_list .tb_icon.tb_style_4:before,
.tb_icon_list .tb_icon.tb_style_5:before
{
  margin-top: -2px;
}

/*** Inline view ***/

.tb_icon_list.tb_inline_view {
  margin-top: -<?php echo $base; ?>px;
}
.tb_icon_list.tb_inline_view li,
.tb_icon_list.tb_inline_view li .tb_icon_wrap,
.tb_icon_list.tb_inline_view li .tb_description_wrap
{
  display: inline-block;
  vertical-align: top;
}
.tb_icon_list.tb_inline_view li {
  margin-top: <?php echo $base; ?>px;
}
.tb_icon_list.tb_inline_view li .tb_icon {
  vertical-align: middle;
}
.tb_icon_list.tb_inline_view li .tb_icon {
  margin-top: 0 !important;
}
.tb_icon_list.tb_inline_view li:first-child .tb_icon_wrap {
}
.tb_icon_list.tb_inline_view.align_justify > ul {
  line-height: 0;
  text-align: justify;
}
.tb_icon_list.tb_inline_view.align_justify > ul:after {
  content: ' ';
  display: inline-block;
  width: 99%;
  vertical-align: top;
}

/*** List view ***/

.tb_icon_list.tb_list_view ul {
  display: table;
  width: 100%;
}
.tb_icon_list.tb_list_view li {
  display: table-row;
}
.tb_icon_list.tb_list_view li > * {
  display: table-cell;
  padding-bottom: <?php echo $base; ?>px;
  vertical-align: middle;
}
.tb_icon_list.tb_list_view li:last-child > * {
  padding-bottom: 0;
}
.tb_icon_list.tb_list_view li .tb_icon {
  display: block;
  margin: 0 auto;
}
.tb_icon_list.tb_list_view li .tb_description {
  display: inline-block;
  width: 100%;
}
.tb_icon_list.tb_list_view.tb_description_right ul {
  direction: ltr;
}
.tb_icon_list.tb_list_view.tb_description_left ul {
  direction: rtl;
}
.tb_icon_list.tb_list_view.tb_description_left li,
.tb_icon_list.tb_list_view.tb_description_right li
{
  <?php if ($lang_dir == 'ltr'): ?>
  direction: ltr;
  <?php else: ?>
  direction: rtl;
  <?php endif; ?>
}
.tb_icon_list.tb_list_view.tb_description_right li .tb_description_wrap {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 1em;
  <?php else: ?>
  padding-right: 1em;
  <?php endif; ?>
}
.tb_icon_list.tb_list_view.tb_description_left li .tb_description_wrap {
  padding-right: 15px;
}
.tb_icon_list.tb_list_view.tb_icons_top li .tb_icon {
  vertical-align: top;
}
.tb_icon_list.tb_list_view.tb_icons_top li .tb_icon_wrap {
  vertical-align: top;
}

/*** Grid view ***/

.tb_icon_list.tb_grid_view li {
  direction: ltr;
}
.tb_icon_list.tb_grid_view li .tb_icon_wrap {
  text-align: center;
}
.tb_icon_list.tb_grid_view li .tb_icon_wrap .tb_icon {
  margin: 0 !important;
}
.tb_icon_list.tb_grid_view .tb_description_wrap {
  <?php if ($lang_dir == 'ltr'): ?>
  direction: ltr;
  <?php else: ?>
  direction: rtl;
  <?php endif; ?>
}
.tb_icon_list.tb_grid_view.tb_description_bottom li {
  text-align: center;
}
.tb_icon_list.tb_grid_view.tb_description_bottom li .tb_icon_wrap {
  margin: 0 auto 20px auto;
}
.tb_icon_list.tb_grid_view.tb_description_right li,
.tb_icon_list.tb_grid_view.tb_description_left li
{
  position: relative;
}
.tb_icon_list.tb_grid_view.tb_description_right .tb_icon_wrap,
.tb_icon_list.tb_grid_view.tb_description_left .tb_icon_wrap
{
  position: absolute;
  top: 50%;
  margin-left: 0;
  margin-right: 0;
}
.tb_icon_list.tb_grid_view.tb_description_left .tb_icon_wrap {
  right: 0;
}
.tb_icon_list.tb_grid_view.tb_description_bottom .tb_icon {
  margin: 0;
}
.tb_icon_list.tb_grid_view.tb_icons_top .tb_icon_wrap {
  top: 0;
  margin-top: 0 !important;
}

/******    Latest Reviews   **************************/

.tb_widget_latest_reviews .tb_item {
  background-color: transparent !important;
}
.tb_widget_latest_reviews .tb_slider > .tb_item ~ .tb_item {
  display: none;
}

/******    Latest Tweets   ***************************/

.tb_widget_latest_tweets > iframe {
  <?php if ($lang_dir == 'rtl'): ?>
  float: left !important;
  <?php endif; ?>
  margin-top: <?php echo ($tbData->calculateLineHeight($base_h2_size, $base) - 20) * 0.5; ?>px;
}
.tb_tweet {
  -webkit-box-shadow: none !important;
          box-shadow: none !important;
}
.tb_tweet h3 {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base * 3; ?>px;
  <?php else: ?>
  padding-left: <?php echo $base * 3; ?>px;
  <?php endif; ?>
}
.tb_tweet h3 small {
  vertical-align: top;
  font-size: 11px;
  font-weight: normal;
}
.tb_tweet .tb_status {
  margin-bottom: 0;
}
.tb_tweet .tb_date {
  position: absolute;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
}
.tb_tweet .tb_actions {
  position: absolute;
  bottom: <?php echo $base; ?>px;
  left: <?php echo $base; ?>px;
  right: <?php echo $base; ?>px;
  display: none;
}
.tb_tweet:hover .tb_actions {
  display: block;
}
.tb_listing.tb_has_hover > .tb_tweet:hover {
  margin: -<?php echo $base; ?>px -<?php echo $base; ?>px -<?php echo $base * 2.5; ?>px -<?php echo $base; ?>px !important;
  padding: <?php echo $base; ?>px;
  background: #fff;
  border-radius: 2px;
  box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2) !important;
}
.tb_listing.tb_has_hover > .tb_tweet + .tb_tweet:hover {
  margin-top: 0 !important;
}
.tb_listing.tb_has_hover > .tb_tweet:first-child:hover {
  margin-top: -<?php echo $base; ?>px;
}
.tb_listing.tb_has_hover > .tb_tweet:hover {
  padding-bottom: <?php echo $base * 2.5; ?>px;
}

.tb_listing.tb_style_1 > .tb_tweet .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  margin: 0 <?php echo $base; ?>px 0 0;
  <?php else: ?>
  margin: 0 0 0 <?php echo $base; ?>px;
  <?php endif; ?>
}
.tb_listing.tb_style_1 > .tb_tweet .tb_thumb img {
  width: <?php echo $base * 3; ?>px;
}

.tb_tweets .tb_tweet + .tb_tweet {
  margin-top: <?php echo $base; ?>px !important;
}
.tb_tweets.tb_style_2,
.tb_tweets.tb_style_2 > .tb_tweet
{
  border: none !important;
}
.tb_listing.tb_style_2 > .tb_tweet .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  margin: 0 <?php echo $base * 0.5; ?>px 0 0;
  <?php else: ?>
  margin: 0 0 0 <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}
.tb_listing.tb_style_2 > .tb_tweet .tb_thumb img {
  width: <?php echo $base * 2; ?>px;
}
.tb_listing.tb_style_2 > .tb_tweet .tb_item_info {
  overflow: visible;
}
.tb_listing.tb_style_2 > .tb_tweet h3 small {
  display: block;
}
.tb_listing.tb_style_2 > .tb_tweet .tb_status {
  clear: both;
}

.tb_listing.tb_style_3 .tb_tweet .tb_item_info {
  overflow: visible;
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 3; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 3; ?>px;
  <?php endif; ?>
}
.tb_listing.tb_style_3 .tb_tweet .tb_item_info:before {
  content: '\201C';
  <?php if ($lang_dir == 'ltr'): ?>
  left: -<?php echo $base * 3; ?>px;
  <?php else: ?>
  right: -<?php echo $base * 3; ?>px;
  <?php endif; ?>
  position: absolute;
  top: -<?php echo $base * 0.5; ?>px;
  width: 35px;
  height: 50px;
  line-height: 100px;
  text-align: center;
  font-size: 100px;
  font-family: Arial;
  font-style: normal;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=15)";
  opacity: 0.15;
}
.tb_listing.tb_style_3 .tb_tweet .tb_status,
.tb_listing.tb_style_3 .tb_tweet .tb_date
{
  position: static;
  display: inline;
}

/******    Manufacturers    **************************/

.tb_widget_manufacturers {
  -webkit-transition: height 0.5s ease-in-out;
          transition: height 0.5s ease-in-out;
}

/******    Menu    ***********************************/

.tb_widget_menu .tb_selected {
  font-weight: bold;
}

/******    Separator   *******************************/

.tb_widget_separator .tb_separator {
  overflow: hidden;
  position: relative;
}
.tb_widget_separator .tb_title {
  z-index: 2;
  position: relative;
  display: inline-block;
  padding: 0 <?php echo $base; ?>px;
  vertical-align: top;
}
.tb_widget_separator .tb_title [class*="tb_border"] {
  width: 1000px;
}
.tb_widget_separator .tb_title .tb_position_left {
  left: -1000px;
}
.tb_widget_separator .tb_title .tb_position_right {
  right: -1000px;
}
.tb_widget_separator .tb_title [class*="tb_border"] {
  z-index: 1;
  position: absolute;
  top: 50%;
}
.tb_widget_separator .tb_separator > [class*="tb_border"] {
  left: 0;
  width: 100%;
}

/******    Stories   *********************************/

.tb_article .tb_thumb {
  max-width: 100% !important;
  margin-bottom: <?php echo $base; ?>px;
}
.tb_thumb_top .tb_thumb {
  float: none;
  margin-left: 0 !important;
  margin-right: 0 !important;
}
.tb_thumb_left .tb_thumb {
  float: left;
  margin-right: 20px;
  margin-bottom: 0;
}
.tb_thumb_right .tb_thumb {
  float: right;
  margin-left: 20px;
  margin-bottom: 0;
}
.tb_article .tb_meta {
  margin-left: -<?php echo $base * 0.75; ?>px;
  margin-right: -<?php echo $base * 0.75; ?>px;
  margin-bottom: <?php echo $base * 0.5; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base * 0.75; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base * 0.75; ?>px;
  <?php endif; ?>
}
.tb_article .tb_meta > * {
  position: relative;
  display: inline-block;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base * 0.75; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base * 0.75; ?>px;
  <?php endif; ?>
  margin-bottom: <?php echo $base * 0.5; ?>px;
  vertical-align: top;
}
.tb_article .tb_meta > * + * {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base * 0.75; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base * 0.75; ?>px;
  <?php endif; ?>
}
.tb_article .tb_meta > * + *:before {
  content: '';
  position: absolute;
  top: 2px;
  bottom: 2px;
  left: 0;
  display: inline-block;
  <?php if ($lang_dir == 'ltr'): ?>
  border-left: 1px solid;
  <?php else: ?>
  border-right: 1px solid;
  <?php endif; ?>
  opacity: 0.2;
}
.tb_article .tb_meta .fa {
  margin-right: 0.2em;
  vertical-align: top;
  font-size: 14px;
}
.tb_article .tb_meta + .tb_text_wrap {
  position: relative;
  margin-top: <?php echo $base; ?>px;
  padding-top: <?php echo $base * 1.5; ?>px;
}
.tb_article .tb_meta + .tb_text_wrap:after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  display: block;
  width: 100%;
  height: 0;
  border-bottom: 1px solid;
  opacity: 0.15;
}
.tb_article .tb_item_info > .tb_meta:last-child {
  margin-bottom: -10px !important;
}
.tb_article .tb_read_more {
  display: block;
  margin-top: <?php echo $base * 0.5; ?>px;
  font-weight: 600;
}
.tb_article .tb_read_more span {
  vertical-align: top;
  font-size: 1.2em;
}
.tb_article .tb_comments {
  position: relative;
  padding-top: <?php echo $base * 1.5; ?>px;
}
.tb_articles + .pagination {
  margin-bottom: 0;
  padding-top: <?php echo $base * 1.5; ?>px;
  border-top-width: 1px;
  border-top-style: solid;
}
.tb_listing .tb_article .tb_description {
  overflow: hidden;
}
.tb_list_view .tb_article + .tb_article {
  margin-top: <?php echo $base * 1.5; ?>px;
  padding-top: <?php echo $base * 1.5; ?>px;
}
.tb_list_view .tb_article .tb_thumb:before {
  content: '\f0c1';
  position: absolute;
  z-index: 2;
  top: 50%;
  left: 50%;
  display: block;
  width: 60px;
  height: 60px;
  margin: -30px 0 0 -30px;
  line-height: 60px;
  text-align: center;
  text-shadow: 0 1px 0 rgba(0, 0, 0, 0.15);
  font-family: FontAwesome;
  font-size: 28px;
  color: #fff;
  opacity: 0;
  border-radius: 50%;
  background-color: rgba(0, 0, 0, 0.6);
  -webkit-transition: all 0.3s;
          transition: all 0.3s;
}
.tb_list_view .tb_article .tb_thumb:hover:before {
  opacity: 1;
}
.tb_list_view .tb_article .tb_meta + .tb_description {
  margin-top: 0;
  padding-top: 0;
}
.tb_list_view .tb_article .tb_meta + .tb_description:after {
  content: none;
}
.tb_list_view.tb_thumb_left .tb_article .tb_thumb ~ .tb_description,
.tb_list_view.tb_thumb_right .tb_article .tb_thumb ~ .tb_description
{
  clear: none;
}
.tb_compact_view .tb_article h3 + .tb_description,
.tb_compact_view .tb_article h3 + .tb_meta
{
  margin-top: <?php echo $base * 0.5; ?>px;
}
.tb_compact_view .tb_article .tb_description {
  margin-bottom: <?php echo $base * 0.5; ?>px;
}
.tb_compact_view .tb_article .tb_meta {
  margin-left: -<?php echo $base * 0.5; ?>px;
  margin-right: -<?php echo $base * 0.5; ?>px;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}
.tb_compact_view .tb_article .tb_meta > * {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}
.tb_compact_view .tb_article .tb_meta > * + * {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: <?php echo $base * 0.5; ?>px;
  <?php else: ?>
  padding-right: <?php echo $base * 0.5; ?>px;
  <?php endif; ?>
}


/******    Tabs / Accordion   ************************/

.tb_widget_group.tb_tabs_style_3 {
  position: static;
}
<?php if ($lang_dir == 'ltr'): ?>
.tb_widget_group.tb_tabs_right { direction: rtl; }
<?php endif; ?>
<?php if ($lang_dir == 'rtl'): ?>
.tb_widget_group.tb_tabs_left  { direction: ltr; }
<?php endif; ?>

.tb_widget_group [class*="tb_widget"]:hover {
  z-index: auto;
}
.tb_widget_group.tb_tabs_horizontal.tb_tabs_style_2 > h2,
.tb_widget_group.tb_tabs_horizontal.tb_tabs_style_3 > h2
{
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
}
.tb_widget_group h2 + .tb_tabs.tb_htabs .tb_tabs_nav {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.tb_widget_group.tb_pl_5  .tb_tabs.tb_style_1 { margin-left:  -5px; margin-right:  -5px; }
.tb_widget_group.tb_pl_10 .tb_tabs.tb_style_1 { margin-left: -10px; margin-right: -10px; }
.tb_widget_group.tb_pl_15 .tb_tabs.tb_style_1 { margin-left: -15px; margin-right: -15px; }
.tb_widget_group.tb_pl_20 .tb_tabs.tb_style_1 { margin-left: -20px; margin-right: -20px; }
.tb_widget_group.tb_pl_25 .tb_tabs.tb_style_1 { margin-left: -25px; margin-right: -25px; }
.tb_widget_group.tb_pl_30 .tb_tabs.tb_style_1 { margin-left: -30px; margin-right: -30px; }
.tb_widget_group.tb_pl_35 .tb_tabs.tb_style_1 { margin-left: -35px; margin-right: -35px; }
.tb_widget_group.tb_pl_40 .tb_tabs.tb_style_1 { margin-left: -40px; margin-right: -40px; }
.tb_widget_group.tb_pl_45 .tb_tabs.tb_style_1 { margin-left: -45px; margin-right: -45px; }
.tb_widget_group.tb_pl_50 .tb_tabs.tb_style_1 { margin-left: -50px; margin-right: -50px; }
.tb_widget_group.tb_pt_5  .tb_tabs.tb_style_1 .tb_tabs_content { padding-top:  4px; }
.tb_widget_group.tb_pt_10 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top:  9px; }
.tb_widget_group.tb_pt_15 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 14px; }
.tb_widget_group.tb_pt_20 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 19px; }
.tb_widget_group.tb_pt_25 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 24px; }
.tb_widget_group.tb_pt_30 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 29px; }
.tb_widget_group.tb_pt_35 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 34px; }
.tb_widget_group.tb_pt_40 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 39px; }
.tb_widget_group.tb_pt_45 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 44px; }
.tb_widget_group.tb_pt_50 .tb_tabs.tb_style_1 .tb_tabs_content { padding-top: 49px; }
.tb_widget_group.tb_pb_5  .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom:  -5px; padding-bottom:  4px; }
.tb_widget_group.tb_pb_10 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -10px; padding-bottom:  9px; }
.tb_widget_group.tb_pb_15 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -15px; padding-bottom: 14px; }
.tb_widget_group.tb_pb_20 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -20px; padding-bottom: 19px; }
.tb_widget_group.tb_pb_25 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -25px; padding-bottom: 24px; }
.tb_widget_group.tb_pb_30 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -30px; padding-bottom: 29px; }
.tb_widget_group.tb_pb_35 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -35px; padding-bottom: 34px; }
.tb_widget_group.tb_pb_40 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -40px; padding-bottom: 39px; }
.tb_widget_group.tb_pb_45 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -45px; padding-bottom: 44px; }
.tb_widget_group.tb_pb_50 .tb_tabs.tb_style_1 .tb_tabs_content { margin-bottom: -50px; padding-bottom: 49px; }
.tb_widget_group.tb_pl_5  .tb_tabs.tb_style_1 .tb_tabs_content { padding-left:  5px; padding-right:  5px; }
.tb_widget_group.tb_pl_10 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 10px; padding-right: 10px; }
.tb_widget_group.tb_pl_15 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 15px; padding-right: 15px; }
.tb_widget_group.tb_pl_20 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 20px; padding-right: 20px; }
.tb_widget_group.tb_pl_25 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 25px; padding-right: 25px; }
.tb_widget_group.tb_pl_30 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 30px; padding-right: 30px; }
.tb_widget_group.tb_pl_35 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 35px; padding-right: 35px; }
.tb_widget_group.tb_pl_40 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 40px; padding-right: 40px; }
.tb_widget_group.tb_pl_45 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 45px; padding-right: 45px; }
.tb_widget_group.tb_pl_50 .tb_tabs.tb_style_1 .tb_tabs_content { padding-left: 50px; padding-right: 50px; }

.tb_widget_group.tb_pt_5  .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top:  -5px; margin-bottom:  5px; }
.tb_widget_group.tb_pt_10 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -10px; margin-bottom: 10px; }
.tb_widget_group.tb_pt_15 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -15px; margin-bottom: 15px; }
.tb_widget_group.tb_pt_20 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -20px; margin-bottom: 20px; }
.tb_widget_group.tb_pt_25 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -25px; margin-bottom: 25px; }
.tb_widget_group.tb_pt_30 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -30px; margin-bottom: 30px; }
.tb_widget_group.tb_pt_35 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -35px; margin-bottom: 35px; }
.tb_widget_group.tb_pt_40 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -40px; margin-bottom: 40px; }
.tb_widget_group.tb_pt_45 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -45px; margin-bottom: 45px; }
.tb_widget_group.tb_pt_50 .tb_htabs.tb_style_1 .tb_tabs_nav { margin-top: -50px; margin-bottom: 50px; }
.tb_widget_group.tb_pt_5  .tb_htabs.tb_style_1 .tb_tabs_content { margin-top:  -5px; }
.tb_widget_group.tb_pt_10 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -10px; }
.tb_widget_group.tb_pt_15 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -15px; }
.tb_widget_group.tb_pt_20 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -20px; }
.tb_widget_group.tb_pt_25 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -25px; }
.tb_widget_group.tb_pt_30 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -30px; }
.tb_widget_group.tb_pt_35 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -35px; }
.tb_widget_group.tb_pt_40 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -40px; }
.tb_widget_group.tb_pt_45 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -45px; }
.tb_widget_group.tb_pt_50 .tb_htabs.tb_style_1 .tb_tabs_content { margin-top: -50px; }

.tb_widget_group.tb_pt_5  .tb_vtabs.tb_style_1 { margin-top:  -5px; }
.tb_widget_group.tb_pt_10 .tb_vtabs.tb_style_1 { margin-top: -10px; }
.tb_widget_group.tb_pt_15 .tb_vtabs.tb_style_1 { margin-top: -15px; }
.tb_widget_group.tb_pt_20 .tb_vtabs.tb_style_1 { margin-top: -20px; }
.tb_widget_group.tb_pt_25 .tb_vtabs.tb_style_1 { margin-top: -25px; }
.tb_widget_group.tb_pt_30 .tb_vtabs.tb_style_1 { margin-top: -30px; }
.tb_widget_group.tb_pt_35 .tb_vtabs.tb_style_1 { margin-top: -35px; }
.tb_widget_group.tb_pt_40 .tb_vtabs.tb_style_1 { margin-top: -40px; }
.tb_widget_group.tb_pt_45 .tb_vtabs.tb_style_1 { margin-top: -45px; }
.tb_widget_group.tb_pt_50 .tb_vtabs.tb_style_1 { margin-top: -50px; }
.tb_widget_group.tb_pb_5  .tb_vtabs.tb_style_1 { margin-bottom:  -5px; }
.tb_widget_group.tb_pb_10 .tb_vtabs.tb_style_1 { margin-bottom: -10px; }
.tb_widget_group.tb_pb_10 .tb_vtabs.tb_style_1 { margin-bottom: -15px; }
.tb_widget_group.tb_pb_20 .tb_vtabs.tb_style_1 { margin-bottom: -20px; }
.tb_widget_group.tb_pb_25 .tb_vtabs.tb_style_1 { margin-bottom: -25px; }
.tb_widget_group.tb_pb_30 .tb_vtabs.tb_style_1 { margin-bottom: -30px; }
.tb_widget_group.tb_pb_35 .tb_vtabs.tb_style_1 { margin-bottom: -35px; }
.tb_widget_group.tb_pb_40 .tb_vtabs.tb_style_1 { margin-bottom: -40px; }
.tb_widget_group.tb_pb_45 .tb_vtabs.tb_style_1 { margin-bottom: -45px; }
.tb_widget_group.tb_pb_50 .tb_vtabs.tb_style_1 { margin-bottom: -50px; }

.tb_widget_group[class*="tb_tabs"] .has_slider {
  float: none;
}
.tb_widget_group[class*="tb_tabs"] .has_slider.no_title {
  position: static;
}

/******    Text    ***********************************/

.tb_text_wrap ul,
.tb_text_wrap ol
{
  list-style-position: inside;
}
.tb_text_wrap ul {
  list-style-type: disc;
}
.tb_text_wrap blockquote {
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  padding: <?php echo $base * 0.75; ?>px <?php echo $base; ?>px <?php echo $base * 0.75; ?>px <?php echo $base * 4 - 5; ?>px;
  <?php else: ?>
  padding: <?php echo $base * 0.75; ?>px <?php echo $base * 4 - 5; ?>px <?php echo $base * 0.75; ?>px <?php echo $base; ?>px;
  <?php endif; ?>
  line-height: <?php echo $base * 1.5; ?>px;
  font-size: <?php echo $base_font_size * 1.3; ?>px;
  font-style: italic;
}
.tb_text_wrap blockquote:before {
  <?php if ($lang_dir == 'ltr'): ?>
  content: '\201C';
  left: <?php echo $base; ?>px;
  <?php else: ?>
  content: '\201D';
  right: <?php echo $base; ?>px;
  <?php endif; ?>
  position: absolute;
  top: <?php echo $base / 4; ?>px;
  width: 35px;
  height: 50px;
  line-height: 100px;
  text-align: center;
  font-size: 100px;
  font-family: Arial;
  font-style: normal;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=20)";
  opacity: 0.2;
}
.tb_text_wrap blockquote:after {
  content: '';
  position: absolute;
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  border-right: 5px solid;
  <?php else: ?>
  right: 0;
  border-left: 5px solid;
  <?php endif; ?>
  width: 0;
  height: 100%;
  opacity: 0.2
}
.tb_text_wrap blockquote.left {
  margin: 0 <?php echo $base; ?>px <?php echo $base; ?>px 0;
}
.tb_text_wrap blockquote.right {
  margin: 0 0 <?php echo $base; ?>px <?php echo $base; ?>px;
}
.tb_text_wrap > :last-child {
  margin-bottom: 0;
}



/*****************************************************/
/******   C O L O R S   ******************************/
/*****************************************************/

.tb_red            { color: red; }

/*** Text strength 1 *********************************/

.tb_text_str_1,
.tb_text_hover_str_1:hover
{
  color: <?php echo $color_text_str_1; ?> !important;
}

/*** Text strength 2 *********************************/

.tb_text_str_2,
.tb_text_hover_str_2:hover
{
  color: <?php echo $color_text_str_2; ?> !important;
}

/*** Text strength 3 *********************************/

.tb_text_str_3,
.tb_text_hover_str_3:hover
{
  color: <?php echo $color_text_str_3; ?> !important;
}

/*** Text strength 4 *********************************/

.tb_text_str_4,
.tb_text_hover_str_4:hover
{
  color: <?php echo $color_text_str_4; ?> !important;
}

/*** Text strength 5 *********************************/

.tb_text_str_5,
.tb_text_hover_str_5:hover,
.tb_widget_text blockquote
{
  color: <?php echo $color_text_str_5; ?> !important;
}

/*** Border strength 1 *******************************/

.tb_border_str_1,
.tb_border_hover_str_1:hover,
.cart-discounts > div
{
  border-color: <?php echo $color_border_str_1; ?>;
}

/*** Border strength 2 *******************************/

.tb_border_str_2,
.tb_border_hover_str_2:hover
{
  border-color: <?php echo $color_border_str_2; ?>;
}

/*** Border strength 3 *******************************/

.tb_border_str_3,
.tb_border_hover_str_3:hover
{
  border-color: <?php echo $color_border_str_3; ?>;
}

/*** Border strength 4 *******************************/

.tb_border_str_4,
.tb_border_hover_str_4:hover
{
  border-color: <?php echo $color_border_str_4; ?>;
}

/*** Background strength 1 ***************************/

.tb_bg_str_1,
.tb_bg_hover_str_1,
.tb_widget_text blockquote
{
  background-color: <?php echo $color_bg_str_1; ?>;
}

/*** Background strength 2 ***************************/

.tb_bg_str_2,
.tb_bg_hover_str_2:hover,
.tb_table_1 thead > *
{
  background-color: <?php echo $color_bg_str_2; ?>;
}

/*** Background strength 3 ***************************/

.tb_bg_str_3,
.tb_bg_hover_str_3:hover
{
  background-color: <?php echo $color_bg_str_3; ?>;
}

/*** Background strength 4 ***************************/

.tb_bg_str_4,
.tb_bg_hover_str_4:hover
{
  background-color: <?php echo $color_bg_str_4; ?>;
}

/*** Header colors ***********************************/

#main_navigation .tb_row_separate > .tb_wrap > [class*="tb_col_"] {
  border-color: <?php echo 'rgba(' . TB_Utils::hex2rgb($tbData->colors['main_navigation_submenu']['text']['color'], true) . ', 0.17)'; ?>;
}

.tb_submit:before,
.buttons:before,
fieldset + fieldset legend:before,
.tb_list_view .tb_article + .tb_article:before
{
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  display: table;
  width: 100%;
  border-top: 1px solid;
  opacity: 0.2;
}

<?php echo $global_colors_css; ?>



/*****************************************************/
/******   T Y P O G R A P H Y   **********************/
/*****************************************************/

h1 {
  line-height: <?php echo $base * 1.5; ?>px;
}
p.tb_empty {
  line-height: <?php echo $tbData->calculateLineHeight($base_font_size * 1.25, $base); ?>px;
}
.tb_button,
.button,
.btn,
button,
[type=button],
[type=submit]
{
  line-height: <?php echo $base * 1.5; ?>px;
  -webkit-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.tb_button.tb_h_20 {
  margin-top: <?php echo ($tbData->calculateLineHeight(20, $base) - 20)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(20, $base) - 20)/2; ?>px;
}
.tb_button.tb_h_24 {
  margin-top: <?php echo ($tbData->calculateLineHeight(24, $base) - 24)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(24, $base) - 24)/2; ?>px;
}
.tb_button.tb_h_30,
p.tb_h_30
{
  margin-top: <?php echo ($tbData->calculateLineHeight(30, $base) - 30)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(30, $base) - 30)/2; ?>px;
}
.tb_button.tb_h_34 {
  margin-top: <?php echo ($tbData->calculateLineHeight(34, $base) - 34)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(34, $base) - 34)/2; ?>px;
}
.tb_button.tb_h_40 {
  margin-top: <?php echo ($tbData->calculateLineHeight(40, $base) - 40)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(40, $base) - 40)/2; ?>px;
}
.tb_button.tb_h_50 {
  margin-top: <?php echo ($tbData->calculateLineHeight(50, $base) - 50)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(50, $base) - 50)/2; ?>px;
}
.tb_button.tb_h_60 {
  margin-top: <?php echo ($tbData->calculateLineHeight(60, $base) - 60)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight(60, $base) - 60)/2; ?>px;
}
.tb_button.tb_no_text[class*="tb_icon"].tb_h_20 { width: 20px; }
.tb_button.tb_no_text[class*="tb_icon"].tb_h_24 { width: 24px; }
.tb_button.tb_no_text[class*="tb_icon"].tb_h_30 { width: 30px; }
.tb_button.tb_no_text[class*="tb_icon"].tb_h_34 { width: 34px; }
.tb_button.tb_no_text[class*="tb_icon"].tb_h_40 { width: 40px; }
.tb_button.tb_no_text[class*="tb_icon"].tb_h_50 { width: 50px; }
.tb_button.tb_no_text[class*="tb_icon"].tb_h_60 { width: 60px; }

.tb_button.tb_no_text[class*="tb_icon"] {
  text-indent: -1000em;
  padding: 0 !important;
  text-align: center;
}
.tb_button.tb_no_text[class*="tb_icon"]:before {
  text-indent: 0;
  left: 0 !important;
  right: 0 !important;
  width: 100% !important;
  margin-left: 0 !important;
  margin-right: 0 !important;
}
.tb_button.tb_no_text > span {
  overflow: hidden;
  z-index: 5;
  position: absolute;
  left: 0;
  right: 0;
  bottom: 100%;
  height: 0;
  margin: 0 -80px 0 -80px;
  line-height: <?php echo $base + 10; ?>px;
  text-align: center;
  text-indent: 0;
  font-size: 0;
  opacity: 0;
  -webkit-transition: opacity 0.3s ease-in-out, margin 0.3s ease-in-out;
          transition: opacity 0.3s ease-in-out, margin 0.3s ease-in-out;
}
.tb_button.tb_no_text:hover > span {
  overflow: visible;
  display: block;
  height: auto;
  margin-bottom: 10px;
  opacity: 1;
}
.tb_button.tb_no_text > span:before {
  content: attr(data-tooltip);
  display: inline-block;
  padding: 4px 7px;
  line-height: <?php echo $base; ?>px;
  text-transform: none;
  font-size: <?php echo $base_font_size; ?>px;
  white-space: nowrap;
  vertical-align: top;
  color: #333;
  background: #fff;
  border-radius: 2px;
  -webkit-box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
  box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
}
.tb_button.tb_no_text > span:after {
  content: '';
  z-index: 60;
  position: absolute;
  top: 100%;
  left: 50%;
  right: auto;
  display: block;
  width: 9px;
  height: 9px;
  margin-top: -6px;
  margin-left: -5px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.15);
  border-right: 1px solid rgba(0, 0, 0, 0.15);
  background: #fff;
  background-clip: content-box;
  -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
}
.tb_submit .tb_button:not([class*="tb_h_"]),
.buttons .button,
.buttons .btn,
.buttons button,
.buttons [type=button],
.buttons [type=submit],
#button-cart,
#product_buy #input-quantity
{
  margin-top: <?php echo ($tbData->calculateLineHeight($submit_button_size, $base) - $submit_button_size)/2; ?>px;
  margin-bottom: <?php echo ($tbData->calculateLineHeight($submit_button_size, $base) - $submit_button_size)/2; ?>px;
}
.pagination .results {
  line-height: <?php echo $base * 1.5; ?>px;
}
.pagination .results:first-child {
  line-height: <?php echo $base; ?>px;
}
.pagination .links a,
.pagination .links b
{
  line-height: <?php echo $base * 1.5; ?>px;
}
.tb_slider_controls .tb_prev,
.tb_slider_controls .tb_next
{
  line-height: <?php echo $base; ?>px;
}
.tb_compact_view .tb_item h3,
.tb_compact_view .tb_item .tb_price_holder,
.tb_compact_view .tb_item .tb_price
{
  line-height: <?php echo $base; ?>px;
}
.form-group.tb_style_2 .checkbox > label,
.form-group.tb_style_2 .radio > label
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin: <?php echo $base / 2; ?>px <?php echo $base / 2; ?>px 0 0;
  <?php else: ?>
  margin: <?php echo $base / 2; ?>px 0 0 <?php echo $base / 2; ?>px;
  <?php endif; ?>
  height: <?php echo $base * 1.5; ?>px;
  line-height: <?php echo $base * 1.5; ?>px;
}
.form-group.tb_style_2 .checkbox > label span,
.form-group.tb_style_2 .radio > label span
{
  display: none;
}



/*****************************************************/
/******   S T Y L E   ********************************/
/*****************************************************/

#main_navigation .tb_nav > ul > li > a,
#menu > ul > li > a
{
  line-height: <?php echo $tbData->calculateLineHeight($menu_size, $base); ?>px;
}
#main_navigation_row #menu > ul > li.tb_hovered {
  margin-bottom: 0;
  padding-bottom: 0;
}
#main_navigation_row #main_navigation .tb_nav > ul > li > a,
#main_navigation_row #menu > ul > li > a,
#main_navigation_row #cart .heading
{
  height: <?php echo $menu_height; ?>px;
  line-height: <?php echo $menu_height; ?>px;
  padding: 0 <?php echo $menu_padding; ?>px;
}
#main_navigation_row #main_navigation .tb_nav > ul > li.tb_multiple > a {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: <?php echo $base / 2 + 3 + $menu_padding; ?>px;
  <?php else: ?>
  padding-left: <?php echo $base / 2 + 3 + $menu_padding; ?>px;
  <?php endif; ?>
}
#main_navigation_row #main_navigation .tb_nav > ul > li.tb_multiple > a:after {
  <?php if ($lang_dir == 'ltr'): ?>
  right: <?php echo $menu_padding - 1; ?>px;
  <?php else: ?>
  left: <?php echo $menu_padding - 1; ?>px;
  <?php endif; ?>
}
#main_navigation_row #main_navigation .tb_nav > ul > li > .tb_submenu,
#main_navigation_row #menu > ul > li > div,
#main_navigation_row #cart .tb_submenu
{
  margin-top: <?php echo ($tbData->calculateLineHeight($menu_size, $base) - $menu_height) * 0.5 + $base * 0.5; ?>px;
}
#main_navigation_row #main_navigation .tb_nav .tb_multiple.tb_hovered:after,
#main_navigation_row #cart.tb_hovered:after
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $menu_padding + 10; ?>px;
  <?php else: ?>
  margin-right: <?php echo $menu_padding + 10; ?>px;
  <?php endif; ?>
  margin-top: <?php echo ($tbData->calculateLineHeight($menu_size, $base) - $menu_height) * 0.5 + $base * 0.5 - 6; ?>px;
}
#main_navigation_row #main_navigation .tb_nav .tb_multiple.tb_hovered.tb_out_of_view_right:after,
#main_navigation_row #cart.tb_hovered.tb_out_of_view_right:after
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 0;
  margin-right: <?php echo $menu_padding + 10; ?>px;
  <?php else: ?>
  margin-right: 0;
  margin-left: <?php echo $menu_padding + 10; ?>px;
  <?php endif; ?>
}
#menu .tb_out_of_view_right > div:before {
  left: auto;
  right: 18px;
}
#wrapper.tb_row_full > #content.tb_row_full.tb_single_col > .tb_wrap > .tb_main_col > .tb_row_full > .tb_wrap {
  margin-left: auto;
  margin-right: auto;
}

.tb_side_col,
#content > .tb_wrap > .tb_main_col
{
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  <?php else: ?>
  float: right;
  <?php endif; ?>
  padding-left: 0;
}
.tb_main_col {
  width: 100% !important;
}
.tb_side_col {
  position: relative;
}
#content > .tb_wrap {
  margin: 0 auto !important;
  padding-left: 0;
  padding-right: 0;
}
.tb_width_1000 #content.tb_row_full > .tb_wrap {
  max-width: 1000px;
}
.tb_width_1200 #content.tb_row_full > .tb_wrap {
  max-width: 1200px;
}
#content.tb_row_full.tb_single_col > .tb_wrap {
  max-width: none;
}
#content.tb_row_content_separate > .tb_wrap {
  margin-left: 0;
  margin-right: 0;
}
#content.tb_row_content_separate > .tb_wrap > [class*="tb_col_"] {
  border-color: #ddd;
  border-style: solid;
  border-width: 0;
}



/*****************************************************/
/******   C A T E G O R I E S   **********************/
/*****************************************************/

.tb_listing_options {
  position: relative;
  clear: both;
}
.tb_listing_options .tb_view_mode,
.tb_listing_options .tb_listing_limit,
.tb_listing_options .tb_listing_sort,
.tb_listing_options .tb_compare_total,
.tb_listing_options h4,
.tb_listing_options select
{
  display: inline-block;
  vertical-align: top;
}
.tb_listing_options h4,
.tb_listing_options label,
.tb_listing_options select
{
  vertical-align: middle;
}
.tb_listing_options h4,
.tb_listing_options label
{
  float: none;
  margin: 0;
}
.tb_listing_options select {
  height: <?php echo $base * 1.5 - 6; ?>px;
  margin: 0;
  margin-top: 3px;
  margin-bottom: 3px;
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 2px;
  <?php else: ?>
  margin-right: 2px;
  <?php endif; ?>
  padding: <?php echo $base / 4 - 4; ?>px;
}
.tb_listing_options .tb_col_1_2:first-child {
  padding-top: <?php echo $base / 4; ?>px;
  padding-bottom: <?php echo $base / 4; ?>px;
}
.tb_listing_options .tb_col_1_2 + .tb_col_1_2 {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: right;
  <?php else: ?>
  text-align: left;
  <?php endif; ?>
}
.tb_listing_limit + .tb_listing_sort {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.75; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.75; ?>px;
  <?php endif; ?>
}
.tb_listing_sort select {
  width: 120px;
}
.tb_listing_limit select {
  width: 50px;
}
.tb_view_mode ul {
  word-spacing: normal;
}
.tb_view_mode .tb_icon_16 {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 20px !important;
  <?php else: ?>
  padding-right: 20px !important;
  <?php endif; ?>
}
.tb_view_mode .tb_button_grid > a:before,
.tb_view_mode .tb_button_list > a:before
{
  font-family: "FontAwesome";
  font-size: 14px;
  line-height: <?php echo $base - 1; ?>px !important;
}
.tb_view_mode .tb_button_grid > a:before {
  content: '\f009'
}
.tb_view_mode .tb_button_list > a:before {
  content: '\f00b'
}
.tb_view_mode + .tb_compare_total {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.75; ?>px;
  padding-left: <?php echo $base * 0.75; ?>px;
  border-left-width: 1px;
  border-left-style: solid;
  <?php else: ?>
  margin-right: <?php echo $base * 0.75; ?>px;
  padding-right: <?php echo $base * 0.75; ?>px;
  border-right-width: 1px;
  border-right-style: solid;
  <?php endif; ?>
}

.tb_listing_options.tb_style_1,
.tb_listing_options.tb_style_3
{
  margin-bottom: <?php echo $base * 1.5; ?>px;
  padding: <?php echo $base / 2; ?>px <?php echo $base; ?>px;
}
.tb_listing_options.tb_style_1 select {
  background-color: #fff;
}
.tb_listing_options.tb_style_1 + .tb_listing.tb_grid_view.tb_gut_10 { margin-top: -<?php echo $base; ?>px; }
.tb_listing_options.tb_style_1 + .tb_listing.tb_grid_view.tb_gut_20 { margin-top: -<?php echo $base * 0.5; ?>px; }
.tb_listing_options.tb_style_1 + .tb_listing.tb_grid_view.tb_gut_40 { margin-top: <?php echo $base * 0.5; ?>px; }
.tb_listing_options.tb_style_1 + .tb_listing.tb_grid_view.tb_gut_50 { margin-top: <?php echo $base; ?>px; }
.tb_listing_options.tb_style_3 + .tb_listing.tb_grid_view.tb_gut_10 { margin-top: -<?php echo $base; ?>px; }
.tb_listing_options.tb_style_3 + .tb_listing.tb_grid_view.tb_gut_20 { margin-top: -<?php echo $base * 0.5; ?>px; }
.tb_listing_options.tb_style_3 + .tb_listing.tb_grid_view.tb_gut_40 { margin-top: <?php echo $base * 0.5; ?>px; }
.tb_listing_options.tb_style_3 + .tb_listing.tb_grid_view.tb_gut_50 { margin-top: <?php echo $base; ?>px; }

.tb_pt_10 > .tb_listing_options.tb_style_2 { padding-bottom: 10px; }
.tb_pt_20 > .tb_listing_options.tb_style_2 { padding-bottom: 20px; }
.tb_pt_30 > .tb_listing_options.tb_style_2 { padding-bottom: 30px; }
.tb_pt_40 > .tb_listing_options.tb_style_2 { padding-bottom: 40px; }
.tb_pt_50 > .tb_listing_options.tb_style_2 { padding-bottom: 50px; }
.tb_row.tb_pl_10 > .tb_wrap > [class*='tb_col'] > .tb_widget_system > .pagination, .tb_pt_10 > .tb_listing.tb_style_2 + .pagination { padding-top: 9px !important; }
.tb_row.tb_pl_20 > .tb_wrap > [class*='tb_col'] > .tb_widget_system > .pagination, .tb_pt_20 > .tb_listing.tb_style_2 + .pagination { padding-top: 19px !important; }
.tb_row.tb_pl_30 > .tb_wrap > [class*='tb_col'] > .tb_widget_system > .pagination, .tb_pt_30 > .tb_listing.tb_style_2 + .pagination { padding-top: 29px !important; }
.tb_row.tb_pl_40 > .tb_wrap > [class*='tb_col'] > .tb_widget_system > .pagination, .tb_pt_40 > .tb_listing.tb_style_2 + .pagination { padding-top: 39px !important; }
.tb_row.tb_pl_50 > .tb_wrap > [class*='tb_col'] > .tb_widget_system > .pagination, .tb_pt_50 > .tb_listing.tb_style_2 + .pagination { padding-top: 49px !important; }

.tb_listing.tb_style_2 + .pagination {
  float: left;
  width: 100%;
  margin: 0;
  padding-bottom: 0 !important;
  border-top-width: 1px;
  border-top-style: solid;
}
.tb_pl_10 > .tb_listing.tb_style_2 + .pagination { margin-left: -10px; margin-right: -10px; padding-left: 10px; padding-right: 10px; }
.tb_pl_20 > .tb_listing.tb_style_2 + .pagination { margin-left: -20px; margin-right: -20px; padding-left: 20px; padding-right: 20px; }
.tb_pl_30 > .tb_listing.tb_style_2 + .pagination { margin-left: -30px; margin-right: -30px; padding-left: 30px; padding-right: 30px; }
.tb_pl_40 > .tb_listing.tb_style_2 + .pagination { margin-left: -40px; margin-right: -40px; padding-left: 40px; padding-right: 40px; }
.tb_pl_50 > .tb_listing.tb_style_2 + .pagination { margin-left: -50px; margin-right: -50px; padding-left: 50px; padding-right: 50px; }


/*****************************************************/
/******   J Q U E R Y     N O T Y   ******************/
/*****************************************************/
.noty_modal {
  position: fixed;
  z-index: 9999998;
  top: 0;
  left: 0;
  width: 120%;
  height: 120%;
  background: #fff;
  opacity: 0.9;
}
.noty_cont,
.noty_bar
{
  position: fixed;
  z-index: 9999999;
  width: 300px;
  margin: 0;
}
.noty_bar {
  display: none;
  width: 100%;
}
.noty_layout_topRight     { right: 15px; }
.noty_layout_topLeft      { left: 15px;  }
.noty_layout_bottomLeft   { left: 15px; bottom: 0;  }
.noty_layout_bottomRight  { right: 15px; bottom: 0; }
.noty_layout_topCenter    { left: 50%; margin-left: -150px; }
.noty_layout_bottomCenter { left: 50%; bottom: 0; margin-left: -150px; }

.noty_cont .noty_bar {
  position: static;
  margin: 0;
}
.noty_bar .noty_close {
  cursor: pointer;
}


.noty_message {
  position: relative;
  margin: <?php echo $base * 0.75; ?>px 0;
  padding: <?php echo $base * 0.75; ?>px;
  border-radius: 2px;
  -webkit-box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
  box-shadow:
    0 1px 0 0 rgba(0, 0, 0, 0.1),
    0 0 0 1px rgba(0, 0, 0, 0.08),
    0 1px 5px 0 rgba(0, 0, 0, 0.2);
}
.noty_text:after {
  content: '';
  display: table;
  clear: both;
}
.noty_text .tb_icon {
  font-size: 19px;
}
.noty_text .tb_thumb {
  <?php if ($lang_dir == 'ltr'): ?>
  float: left;
  margin-right: <?php echo $base; ?>px;
  <?php else: ?>
  float: right;
  margin-left: <?php echo $base; ?>px;
  <?php endif; ?>
  height: <?php echo $base * 3; ?>px;
}
.noty_text .tb_thumb img {
  width: auto;
  height: 100%;
}
.noty_text h3 {
  margin-bottom: <?php echo $base; ?>px;
}
.noty_text p {
  overflow: hidden;
}
.noty_text p a {
  font-weight: 600;
}
.noty_buttons {
  text-align: center;
  padding-top: <?php echo $base; ?>px;
}
.noty_buttons button {
  margin-top: <?php echo $base * 0.5; ?>px;
}
.noty_buttons button + button {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: <?php echo $base * 0.25; ?>px;
  <?php else: ?>
  margin-right: <?php echo $base * 0.25; ?>px;
  <?php endif; ?>
}
.noty_message h2 {
  margin-left: 5px;
  margin-right: 5px;
  padding-top: 0;
  padding-bottom: 0;
  line-height: 20px;
  font-size: 18px;
  font-weight: normal;
}
.noty_message .noty_close {
  z-index: 100;
  top: 10px;
  <?php if ($lang_dir == 'ltr'): ?>
  right: 10px;
  <?php else: ?>
  left: 10px;
  <?php endif; ?>
}
.noty_message .noty_close:after {
  display: none;
}
.noty_message h3 {
  font-weight: normal;
}
.noty_message .tb_icon {
  width: 1.3em;
  height: 1.3em;
  margin-top: -0.22em;
  line-height: 1.3em;
  font-size: inherit;
  border-radius: 50%;
  vertical-align: middle;
}
.noty_message .tb_icon:before {
  font-size: 0.8em;
}


/*****************************************************/
/******   J Q U E R Y     U I   **********************/
/*****************************************************/

.ui-autocomplete-input {
  position: relative;
}
.tb_jquery_ui .ui-icon {
  display: block;
  text-indent: -666px;
  overflow: hidden;
  background-repeat: no-repeat;
}

/*** Tooltip ***/

.ui-tooltip {
  z-index: 1000;
  position: absolute;
}

/*** Dialog ***/

.ui-dialog-content .tb_submit {
  margin: 0 -2em -2em -2em;
  padding: 2em;
}
.ui-dialog-content ul:not([class]),
.ui-dialog-content ul:not([class]) li
{
  list-style: disc;
  <?php if ($lang_dir == 'ltr'): ?>
  padding-left: 1em;
  <?php else: ?>
  padding-right: 1em;
  <?php endif; ?>
}
.ui-dialog-content ul:not([class]) li {
  margin-bottom: <?php echo $base * 0.5; ?>px;
}
.ui-dialog-content ul:not([class]) li:last-child {
  margin-bottom: 0;
}

/*** Input Spinner ***/

.ui-spinner {
  position: relative;
  <?php if ($lang_dir == 'ltr'): ?>
  padding: 0 <?php echo $base * 1.25; ?>px 0 <?php echo $base * 0.25; ?>px;
  border-right: none !important;
  <?php else: ?>
  padding: 0 <?php echo $base * 0.25; ?>px 0 <?php echo $base * 1.25; ?>px;
  border-left: none !important;
  <?php endif; ?>
}
.ui-spinner .ui-spinner-input {
  <?php if ($lang_dir == 'ltr'): ?>
  margin: -1px 0 -1px -1px !important;
  <?php else: ?>
  margin: -1px -1px -1px 0 !important;
  <?php endif; ?>
  padding-left: 0 !important;
  padding-right: 0 !important;
  border: none !important;
  background: none transparent !important;
  -webkit-box-shadow: none !important;
          box-shadow: none !important;
}
.ui-spinner .ui-spinner-button {
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  left: auto;
  -webkit-box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.1) inset, 1px 0 0 rgba(0, 0, 0, 0.07) inset;
          box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.1) inset, 1px 0 0 rgba(0, 0, 0, 0.07) inset;
  <?php else: ?>
  left: 0;
  right: auto;
  -webkit-box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.1) inset, -1px 0 0 rgba(0, 0, 0, 0.07) inset;
          box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.1) inset, -1px 0 0 rgba(0, 0, 0, 0.07) inset;
  <?php endif; ?>
  width: <?php echo $base; ?>px;
  height: 50%;
  margin-top: 0 !important;
  margin-bottom: 0 !important;
  cursor: pointer !important;
  background-color: rgba(0, 0, 0, 0.07) !important;
}
#wrapper #content .ui-spinner .ui-spinner-button:hover,
#wrapper #content .ui-spinner .ui-spinner-button.ui-state-hover,
#wrapper #content .ui-spinner .ui-spinner-button.ui-state-hover:hover
{
  background-color: rgba(0, 0, 0, 0.15) !important;
}
.ui-spinner .ui-spinner-up {
  top: 0;
  <?php if ($lang_dir == 'ltr'): ?>
  border-radius: 0 2px 0 0;
  <?php else: ?>
  border-radius: 2px 0 0 0;
  <?php endif; ?>
}
.ui-spinner .ui-spinner-down {
  bottom: -1px;
  padding-bottom: 1px;
  <?php if ($lang_dir == 'ltr'): ?>
  border-radius: 0 0 2px 0;
  <?php else: ?>
  border-radius: 0 0 0 2px;
  <?php endif; ?>
}

/*** Accordion ***/

.tb_accordion_content > div {
  display: none;
}
.tb_accordion_content > span.tb_title:first-child + div,
.tb_accordion > h2:first-child + div
{
  display: block;
}
.tb_accordion .tb_title,
.tb_accordion > h2,
.checkout-heading,
.panel-group > .panel > .panel-heading
{
  position: relative;
  z-index: 30;
  display: block;
  outline: none !important;
  cursor: pointer;
}
.tb_accordion .ui-accordion-header .ui-icon,
.checkout-heading:before
{
  display: inline-block;
  width: 0.8em;
  text-align: center;
  font-weight: normal;
  font-family: "FontAwesome";
  vertical-align: top;
}
.tb_accordion .ui-accordion-header .ui-icon:before,
.checkout-heading:before
{
  <?php if ($lang_dir == 'ltr'): ?>
  content: '\f105';
  <?php else: ?>
  content: '\f104';
  <?php endif; ?>
  float: none;
  margin-bottom: -0.056em;
  padding-top: 0.055em;
  vertical-align: top;
}
.checkout-heading:before
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: <?php echo $base * 0.25; ?>px;
  <?php else: ?>
  margin-left: <?php echo $base * 0.25; ?>px;
  <?php endif; ?>
  padding-top: 0;
}
.tb_accordion .ui-accordion-header.ui-state-active .ui-icon:before,
.checkout-heading.tb_opened:before
{
  <?php if ($lang_dir == 'ltr'): ?>
  -webkit-transform: rotate(90deg);
      -ms-transform:  rotate(90deg);
          transform: rotate(90deg);
  <?php else: ?>
  -webkit-transform: rotate(-90deg);
      -ms-transform:  rotate(-90deg);
          transform: rotate(-90deg);
  <?php endif; ?>
  margin-top: 0;
}
.tb_accordion [class*="tb_widget"] {
  margin-bottom: 0;
}

/*** Accordion style 1 ***/

.tb_accordion.tb_style_1 .tb_title,
.tb_accordion.tb_style_1 > h2,
.tb_accordion.tb_style_1 .tb_title + div,
.tb_accordion.tb_style_1 > h2 + div
{
  border-width: 1px;
  border-style: solid;
  border-color: transparent;
}
.tb_accordion.tb_style_1 .tb_title,
.tb_accordion.tb_style_1 > h2,
.checkout-heading
{
  padding: <?php echo $base / 2 - 1; ?>px <?php echo $base; ?>px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.12) !important;
}
.tb_accordion.tb_style_1 .tb_title + div,
.tb_accordion.tb_style_1 > h2 + div
{
  border-top-width: 0;
}
.tb_accordion.tb_style_1 .tb_title + div:not(:last-child),
.tb_accordion.tb_style_1 > h2 + div:not(:last-child)
{
  border-bottom-color: transparent !important;
}
.tb_accordion.tb_style_1 .ui-accordion-content[style*="display: none"] + .ui-accordion-header {
  border-top-color: transparent !important;
}
.tb_accordion.tb_style_1.tb_ip_0  .tb_title, .tb_accordion.tb_style_1.tb_ip_0  > h2, .tb_accordion.tb_style_1.tb_ip_0  .ui-accordion-header { padding-left: 0;    padding-right: 0;    }
.tb_accordion.tb_style_1.tb_ip_5  .tb_title, .tb_accordion.tb_style_1.tb_ip_5  > h2, .tb_accordion.tb_style_1.tb_ip_5  .ui-accordion-header { padding-left: 5px;  padding-right: 5px;  }
.tb_accordion.tb_style_1.tb_ip_10 .tb_title, .tb_accordion.tb_style_1.tb_ip_10 > h2, .tb_accordion.tb_style_1.tb_ip_10 .ui-accordion-header { padding-left: 10px; padding-right: 10px; }
.tb_accordion.tb_style_1.tb_ip_15 .tb_title, .tb_accordion.tb_style_1.tb_ip_15 > h2, .tb_accordion.tb_style_1.tb_ip_15 .ui-accordion-header { padding-left: 15px; padding-right: 15px; }
.tb_accordion.tb_style_1.tb_ip_20 .tb_title, .tb_accordion.tb_style_1.tb_ip_20 > h2, .tb_accordion.tb_style_1.tb_ip_20 .ui-accordion-header { padding-left: 20px; padding-right: 20px; }
.tb_accordion.tb_style_1.tb_ip_25 .tb_title, .tb_accordion.tb_style_1.tb_ip_25 > h2, .tb_accordion.tb_style_1.tb_ip_25 .ui-accordion-header { padding-left: 25px; padding-right: 25px; }
.tb_accordion.tb_style_1.tb_ip_30 .tb_title, .tb_accordion.tb_style_1.tb_ip_30 > h2, .tb_accordion.tb_style_1.tb_ip_30 .ui-accordion-header { padding-left: 30px; padding-right: 30px; }
.tb_accordion.tb_style_1.tb_ip_35 .tb_title, .tb_accordion.tb_style_1.tb_ip_35 > h2, .tb_accordion.tb_style_1.tb_ip_35 .ui-accordion-header { padding-left: 35px; padding-right: 35px; }
.tb_accordion.tb_style_1.tb_ip_40 .tb_title, .tb_accordion.tb_style_1.tb_ip_40 > h2, .tb_accordion.tb_style_1.tb_ip_40 .ui-accordion-header { padding-left: 40px; padding-right: 40px; }
.tb_accordion.tb_style_1.tb_ip_45 .tb_title, .tb_accordion.tb_style_1.tb_ip_45 > h2, .tb_accordion.tb_style_1.tb_ip_45 .ui-accordion-header { padding-left: 45px; padding-right: 45px; }
.tb_accordion.tb_style_1.tb_ip_50 .tb_title, .tb_accordion.tb_style_1.tb_ip_50 > h2, .tb_accordion.tb_style_1.tb_ip_50 .ui-accordion-header { padding-left: 50px; padding-right: 50px; }

/*** Accordion style 2 ***/

.tb_accordion.tb_style_2 .tb_title,
.tb_accordion.tb_style_2 > h2
{
  padding-top: <?php echo $base * 0.25; ?>px;
  padding-bottom: <?php echo $base * 0.25; ?>px;
}

.tb_accordion.tb_style_2 .ui-accordion-header {
  background-color: transparent !important;
}




/*  -------------------------------------------------------------------------------------  */
/*  ---   Desktop and tablet   ----------------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---   Min width: 768px   ------------------------------------------------------------  */

@media only screen and (min-width: 768px) {
  .tb_products.tb_grid_view .tb_item[style*="height"],
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_item_info
  {
    display: -moz-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;
    -webkit-flex-direction: column;
       -moz-flex-direction: column;
        -ms-flex-direction: column;
            flex-direction: column;
  }
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_thumb {
    -webkit-box-flex: 0 0 auto;
       -moz-box-flex: 0 0 auto;
        -webkit-flex: 0 0 auto;
                flex: 0 0 auto;
  }
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_item_info,
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_item_info_active
  {
    -webkit-box-flex: 1;
       -moz-box-flex: 1;
        -webkit-flex: 1;
                flex: 1;
  }
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_item_info_hover,
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_item_info .tb_description,
  .tb_products.tb_grid_view .tb_item[style*="height"] .tb_item_info .tb_price_holder
  {
    -webkit-box-flex: 1 0 auto;
       -moz-box-flex: 1 0 auto;
        -webkit-flex: 1 0 auto;
                flex: 1 0 auto;
  }
}




/*  -------------------------------------------------------------------------------------  */
/*  ---   Desktop   ---------------------------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---   Min width: 1000px   -----------------------------------------------------------  */

@media only screen and (min-width: 1021px) {
}



/*  -------------------------------------------------------------------------------------  */
/*  ---   Small Desktop and tablet landscape layout   -----------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---   Min width: 1000px / Max width: 1280px   ---------------------------------------  */

@media only screen and (min-width: 1081px) and (max-width: 1240px) {

  body.tb_width_1200 > .tb_row_fixed,
  body.tb_width_1200 > .tb_row_full > .tb_row_fixed,
  body.tb_width_1200 > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed
  {
    margin-left: 30px !important;
    margin-right: 30px !important;
  }
  body.tb_width_1200 > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full
  {
    padding-left: 30px !important;
    padding-right: 30px !important;
  }

  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table {
    margin-left: 0 !important;
    margin-right: 0 !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table,
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table > .tb_wrap {
    margin-left: 0 !important;
    margin-right: 0 !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_table.tb_gut_0 > .tb_wrap {
    margin-left: 30px !important;
    margin-right: 30px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_table.tb_gut_10 > .tb_wrap {
    margin-left: 20px !important;
    margin-right: 20px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_table.tb_gut_20 > .tb_wrap {
    margin-left: 10px !important;
    margin-right: 10px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_table.tb_gut_40 > .tb_wrap {
    margin-left: -10px !important;
    margin-right: -10px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_table.tb_gut_50 > .tb_wrap {
    margin-left: -20px !important;
    margin-right: -20px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_0 > .tb_wrap {
    margin-left: 0 !important;
    margin-right: 0 !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_10 > .tb_wrap {
    margin-left: -10px !important;
    margin-right: -10px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_20 > .tb_wrap {
    margin-left: -20px !important;
    margin-right: -20px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full > .tb_wrap {
    margin-left: -30px !important;
    margin-right: -30px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_40 > .tb_wrap {
    margin-left: -40px !important;
    margin-right: -40px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_50 > .tb_wrap {
    margin-left: -50px !important;
    margin-right: -50px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_10 > .tb_wrap #main_navigation .tb_nav .tb_megamenu > .tb_submenu,
  body.tb_width_1200 > .tb_row_full > .tb_row_full .tb_row_full #main_navigation .tb_megamenu > .tb_submenu
  {
    left: 0 !important;
    right: 0 !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_20 > .tb_wrap #main_navigation .tb_nav .tb_megamenu > .tb_submenu {
    left: 10px !important;
    right: 10px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_30 > .tb_wrap #main_navigation .tb_nav .tb_megamenu > .tb_submenu {
    left: 20px !important;
    right: 20px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_40 > .tb_wrap #main_navigation .tb_nav .tb_megamenu > .tb_submenu {
    left: 30px !important;
    right: 30px !important;
  }
  body.tb_width_1200 #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_50 > .tb_wrap #main_navigation .tb_nav .tb_megamenu > .tb_submenu {
    left: 40px !important;
    right: 40px !important;
  }
  body.tb_width_1200 #wrapper.tb_row_fixed .tb_sticky_container,
  body.tb_width_1200 #wrapper #header.tb_row_fixed + .tb_sticky_container,
  body.tb_width_1200 #wrapper .tb_sticky_container.tb_row_fixed
  {
    left: 30px !important;
    right: 30px !important;
    width: auto !important;
    margin: 0 !important;
  }

}



/*  -------------------------------------------------------------------------------------  */
/*  ---  Tablet portrait mode       -----------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---  Min width: 768px / Max width: 1080px    ----------------------------------------  */

@media only screen and (min-width: 768px) and (max-width: 1080px) {

  body > .tb_row_fixed,
  body > .tb_row_full > .tb_row_fixed,
  body > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed,
  body > .tb_row_full > #header_wrap > .tb_row_fixed,
  body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed
  {
    margin-left: 30px !important;
    margin-right: 30px !important;
  }
  body > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full,
  body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full
  {
    padding-left: 30px !important;
    padding-right: 30px !important;
  }

  .tb_row_full > .tb_wrap,
  .tb_row_full.tb_gut_30 > .tb_wrap { margin-left: -30px; margin-right: -30px; }
  .tb_row_full.tb_gut_0  > .tb_wrap { margin-left: 0;      margin-right: 0;    }
  .tb_row_full.tb_gut_10 > .tb_wrap { margin-left: -10px; margin-right: -10px; }
  .tb_row_full.tb_gut_20 > .tb_wrap { margin-left: -20px; margin-right: -20px; }
  .tb_row_full.tb_gut_40 > .tb_wrap { margin-left: -40px; margin-right: -40px; }
  .tb_row_full.tb_gut_50 > .tb_wrap { margin-left: -50px; margin-right: -50px; }

  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table,
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table > .tb_wrap {
    margin-left: 0 !important;
    margin-right: 0 !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_10 > .tb_wrap {
    margin-left: 20px !important;
    margin-right: 20px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_20 > .tb_wrap {
    margin-left: 10px !important;
    margin-right: 10px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_40 > .tb_wrap {
    margin-left: -10px !important;
    margin-right: -10px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table.tb_gut_50 > .tb_wrap {
    margin-left: -20px !important;
    margin-right: -20px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_0 > .tb_wrap {
    margin-left: 0 !important;
    margin-right: 0 !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_10 > .tb_wrap {
    margin-left: -10px !important;
    margin-right: -10px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_20 > .tb_wrap {
    margin-left: -20px !important;
    margin-right: -20px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full > .tb_wrap {
    margin-left: -30px !important;
    margin-right: -30px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_40 > .tb_wrap {
    margin-left: -40px !important;
    margin-right: -40px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full.tb_gut_50 > .tb_wrap {
    margin-left: -50px !important;
    margin-right: -50px !important;
  }
  #wrapper > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed.tb_row_table > .tb_wrap #main_navigation .tb_nav .tb_megamenu > .tb_submenu {
    left: 30px !important;
    right: 30px !important;
  }
  body > .tb_row > #header_wrap > .tb_row_fixed .tb_row_table.tb_row_full.tb_gut_10 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu,
  body > .tb_row_fixed > #header_wrap > .tb_row .tb_row_table.tb_row_full.tb_gut_10 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu
  {
    left: -20px;
    right: -20px;
  }
  body > .tb_row > #header_wrap > .tb_row_fixed .tb_row_table.tb_row_full.tb_gut_20 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu,
  body > .tb_row_fixed > #header_wrap > .tb_row .tb_row_table.tb_row_full.tb_gut_20 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu
  {
    left: -10px;
    right: -10px;
  }
  body > .tb_row > #header_wrap > .tb_row_fixed .tb_row_table.tb_row_full.tb_gut_40 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu,
  body > .tb_row_fixed > #header_wrap > .tb_row .tb_row_table.tb_row_full.tb_gut_40 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu
  {
    left: 10px;
    right: 10px;
  }
  body > .tb_row > #header_wrap > .tb_row_fixed .tb_row_table.tb_row_full.tb_gut_50 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu,
  body > .tb_row_fixed > #header_wrap > .tb_row .tb_row_table.tb_row_full.tb_gut_50 > .tb_wrap > [class*="tb_col_"] .tb_nav .tb_megamenu > .tb_submenu
  {
    left: 20px;
    right: 20px;
  }

  #site_logo img {
    max-width: 160px;
  }
  body[class] #wrapper.tb_row_fixed .tb_sticky_container,
  body[class] #wrapper #header.tb_row_fixed + .tb_sticky_container,
  body[class] #wrapper .tb_sticky_container.tb_row_fixed
  {
    left: 30px !important;
    right: 30px !important;
    width: auto !important;
    margin: 0 !important;
  }

}



/*  -------------------------------------------------------------------------------------  */
/*  ---  Mobile Layout                          -----------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---  Max width: 767px                       -----------------------------------------  */

@media only screen and (max-width: 767px) {

  /*** hide some elements ***/

  #main_navigation > .tb_nav,
  #main_navigation_row #menu,
  #menu,
  #menu > ul > li > div:before,
  #cart .heading,
  #header[class] .tb_widget_language,
  #header[class] .tb_widget_currency,
  #header[class] #user_navigation,
  #header[class] #welcome_message,
  .tb_widget_site_search > .tb_search_wrap,
  .tb_widget_cart > #cart,
  #view_mode,
  #menu_home,
  #shopping_cart .tb_cell_name,
  #wishlist .tb_cell_name,
  .cart-info table .name div + small
  {
    display: none;
  }

  /*** typo & spacing ***/

  body {
    font-size: 14px;
  }
  thead {
    font-size: 13px;
  }
  .tb_table_1 thead th,
  .tb_table_1 tbody td
  {
    padding-left: <?php echo $base / 2; ?>px;
    padding-right: <?php echo $base / 2; ?>px;
  }

  /*** layout ***/

  .tb_wrap,
  [class*="tb_col_"],
  .tb_main_col,
  .tb_side_col,
  .tb_widget_site_search,
  .tb_row_table > .tb_wrap > [class*="tb_col_"],
  .tb_row_separate > .tb_wrap
  {
    clear: both;
    left: auto !important;
    right: auto !important;
    display: block !important;
    float: none !important;
    width: auto !important;
    min-width: 0 !important;
    margin-left: 0 !important;
    margin-right: 0 !important;
    padding-left: 0 !important;
    padding-right: 0 !important;
  }
  .tb_row_table,
  #content.tb_row_separate > .tb_wrap > [class*="tb_col_"]
  {
    display: block;
    width: auto;
  }
  .tb_row_content_separate > .tb_wrap > [class*="tb_col_"] {
    margin: 0;
  }
  .tb_row_separate > .tb_wrap > [class*="tb_col_"],
  #content.tb_row_content_separate > .tb_wrap > [class*="tb_col_"]
  {
    border-top-width: 1px;
    border-top-style: solid;
  }
  .tb_row_separate > .tb_wrap > [class*="tb_col_"]:first-child,
  #content.tb_row_content_separate > .tb_wrap > [class*="tb_col_"]:first-child
  {
    border-top-width: 0;
  }
  .tb_row_separate > .tb_wrap > [class*="tb_col_"] + [class*="tb_col_"],
  #content.tb_row_content_separate > .tb_wrap > [class*="tb_col_"]
  {
    border-left-width: 0 !important;
    border-right-width: 0 !important;
  }
  .tb_row_separate > .tb_wrap > .tb_col_auto img,
  .tb_row_table > .tb_wrap > .tb_col_auto img
  {
    max-width: 100%;
  }
  body > .tb_row_fixed,
  body > .tb_row_full > .tb_row_fixed,
  body > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed,
  body > .tb_row_full > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full > .tb_wrap,
  body > .tb_row_full > #header_wrap > .tb_row_fixed,
  body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_fixed,
  body > .tb_row_full > #header_wrap > .tb_row_full > .tb_wrap > [class*="tb_col_"] > .tb_row_full > .tb_wrap
  {
    margin-left: 20px !important;
    margin-right: 20px !important;
  }
  [class*="tb_col_"] {
    margin-bottom: 30px;
  }
  [class*="tb_col_"]:last-child {
    margin-bottom: 0;
  }
  .tb_row.tb_reverse > .tb_wrap > [class*="tb_col_"] {
    <?php if ($lang_dir == 'ltr'): ?>
    float: left;
    <?php else: ?>
    float: right;
    <?php endif; ?>
  }
  #wrapper {
    position: relative;
    width: auto;
    box-shadow: none !important;
    -webkit-box-shadow: none !important;
  }

  /*** Forms ***/

  input[type=text],
  input[type=number],
  input[type=email],
  input[type=tel],
  input[type=date],
  input[type=datetime],
  input[type=color],
  input[type=password],
  input[type=search],
  textarea
  {
    padding: <?php echo $base / 2 - 1; ?>px;
  }
  select {
    padding: <?php echo $base / 2 - 2; ?>px;
  }
  input[type=text],
  input[type=number],
  input[type=email],
  input[type=tel],
  input[type=date],
  input[type=datetime],
  input[type=color],
  input[type=password],
  input[type=search],
  select
  {
    height: <?php echo $base * 2; ?>px;
  }
  textarea {
    width: 100%;
  }
  input[type=checkbox],
  input[type=radio],
  input[type=checkbox] ~ input[type=checkbox],
  input[type=checkbox] ~ input[type=radio],
  input[type=radio] ~ input[type=checkbox],
  input[type=radio] ~ input[type=radio]
  {
    margin-left: 0;
    margin-right: 0;
  }
  input[type=checkbox]:first-child + label ~ label,
  input[type=radio]:first-child + label ~ label
  {
    display: inline-block;
    margin-top: <?php echo $base / 2; ?>px;
  }
  input[type=checkbox] + label + br,
  input[type=radio] + label + br
  {
    display: block;
  }
  input[type=checkbox] + label + br:last-child,
  input[type=radio] + label + br:last-child
  {
    margin-bottom: <?php echo $base / 2; ?>px !important;
  }
  table.form td:first-child {
    padding-top: <?php echo $base / 2; ?>px;
    padding-bottom: <?php echo $base + $base / 2; ?>px;
  }
  table.form td > input[type=checkbox]:first-child + label,
  table.form td > input[type=radio]:first-child + label
  {
    margin-top: <?php echo $base / 2; ?>px;
  }
  table.radio {
    width: 100%;
  }
  .text-danger,
  .error,
  .tb_error_msg
  {
    min-width: 0;
  }

  /*** Components ***/

  .tb_gallery.tb_fullscreen {
    padding: 0;
  }
  .tb_htabs.tb_style_2 .tb_tabs_nav li,
  .tb_htabs.tb_style_2 .tb_tabs_nav li a
  {
    display: block;
  }
  .tb_htabs.tb_style_2 .tb_tabs_nav li > a {
    padding-left: 0;
    padding-right: 0;
  }
  .tb_htabs.tb_style_2 .tb_tabs_nav li:before {
    display: none;
  }
  .tb_htabs.tb_style_2 .tb_tabs_nav li:not(:last-child) > a:after {
    content: '____';
    display: block;
    margin-top: -0.7em;
    margin-bottom: 0.3em;
    letter-spacing: -0.25em;
    opacity: 0.3;
  }

  /*** Header ***/

  #header span.clear {
    display: none;
  }
  #header {
    position: static !important;
  }
  #header *,
  #main_navigation_row *
  {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
  }
  #header .tb_row,
  #header .tb_wrap,
  #main_navigation_row,
  #main_navigation_row .tb_row,
  #main_navigation_row .tb_wrap
  {
    position: static !important;
    margin: 0 !important;
    padding: 0 !important;
    border: none !important;
    box-shadow: none !important;
  }
  #header [class*="tb_col_"],
  #main_navigation_row [class*="tb_col_"]
  {
    height: auto;
    min-height: 0;
    margin-bottom: 0;
    <?php if ($lang_dir == 'ltr'): ?>
    text-align: left;
    <?php else: ?>
    text-align: right;
    <?php endif; ?>
  }
  #header .tbLogoRow > .tb_wrap {
    height: 50px;
    padding-top: 25px !important;
    padding-bottom: 25px !important;
    <?php if ($lang_dir == 'ltr'): ?>
    padding-left: 25px !important;
    padding-right: <?php echo $base * 6 + 60; ?>px !important;
    <?php else: ?>
    padding-right: 25px !important;
    padding-left: <?php echo $base * 6 + 60; ?>px !important;
    <?php endif; ?>
    box-sizing: content-box;
    -moz-box-sizing: content-box;
    -webkit-box-sizing: content-box;
  }
  body > .tb_row_fixed:not(.tb_pl_0) > #header_wrap > #header.tb_row_full .tbLogoRow > .tb_wrap {
    padding-left: 0 !important;
    padding-right: 0 !important;
  }
  #header .tb_row.tbCloned {
    margin-top: -20px !important;
    padding: 10px 25px 20px 25px !important;
    text-align: center;
  }
  #header .tbSystemRow.tbCloned {
    margin-top: 0 !important;
    padding: 10px 25px !important;
  }
  #header .tbCloned > * {
    display: inline-block !important;
    vertical-align: top !important;
  }
  #header .tbCloned > :first-child {
    margin: 0;
  }
  #header .tbCloned > * + a {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: <?php echo $base * 0.5; ?>px;
    <?php else: ?>
    margin-right: <?php echo $base * 0.5; ?>px;
    <?php endif; ?>
  }
  #site_logo {
    line-height: 50px;
  }
  #site_logo img {
    max-height: 50px;
    vertical-align: middle;
  }
  .tb_widget_site_search,
  .tb_widget_cart,
  #main_navigation
  {
    position: absolute;
    top: 30px;
    left: 20px !important;
    right: 20px !important;
    width: auto !important;
    margin: 0 !important;
    padding: 0 !important;
    border: none !important;
  }
  #menu {
    width: auto !important;
  }
  #wrapper.tbSystemBefore .tb_widget_site_search,
  #wrapper.tbSystemBefore .tb_widget_cart,
  #wrapper.tbSystemBefore #main_navigation
  {
    top: <?php echo $base + 50; ?>px;
  }
  #wrapper.tb_row_fixed .tb_widget_site_search,
  #wrapper.tb_row_fixed .tb_widget_cart,
  #wrapper.tb_row_fixed #main_navigation
  {
    left: 0 !important;
    right: 0 !important;
  }
  #main_navigation .tb_nav,
  .tb_widget_site_search .tb_search_wrap,
  #cart
  {
    display: none;
  }
  #main_navigation .tb_nav.tb_active,
  #menu.tb_active,
  #main_navigation_row #menu.tb_active,
  .tb_widget_site_search .tb_search_wrap.tb_active,
  #cart.tb_active
  {
    display: block;
  }
  .tb_widget_site_search .tb_toggle,
  .tb_widget_cart .tb_toggle,
  #main_navigation > .tb_toggle
  {
    position: absolute;
    top: 0;
    <?php if ($lang_dir == 'ltr'): ?>
    right: 0;
    <?php else: ?>
    left: 0;
    <?php endif; ?>
    display: block !important;
    width: <?php echo $base * 2; ?>px;
    height: <?php echo $base * 2; ?>px;
    padding: 0;
    text-align: center;
  }
  #wrapper.tb_row_fixed #header .tb_toggle,
  #wrapper.tb_row_fixed #main_navigation_row .tb_toggle,
  #header.tb_row_fixed .tb_toggle,
  #header.tb_row_fixed + #main_navigation_row .tb_toggle
  {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-right: 20px;
    <?php else: ?>
    margin-left: 20px;
    <?php endif; ?>
  }
  #main_navigation > .tb_toggle {
    <?php if ($lang_dir == 'ltr'): ?>
    right: <?php echo $base * 2 + 10; ?>px;
    <?php else: ?>
    left: <?php echo $base * 2 + 10; ?>px;
    <?php endif; ?>
  }
  .tb_widget_cart .tb_toggle {
    <?php if ($lang_dir == 'ltr'): ?>
    right: <?php echo $base * 4 + 20; ?>px;
    <?php else: ?>
    left: <?php echo $base * 4 + 20; ?>px;
    <?php endif; ?>
  }
  .tb_widget_site_search .tb_toggle:before,
  #main_navigation > .tb_toggle:before,
  .tb_widget_cart .tb_toggle:before
  {
    width: 100%;
    line-height: <?php echo $base * 2 - 1; ?>px;
    font-size: 18px;
  }
  .tb_widget_site_search input {
    <?php if ($lang_dir == 'ltr'): ?>
    float: left;
    <?php else: ?>
    float: right;
    <?php endif; ?>
    width: 100%;
    margin: 0 !important;
  }
  .tb_widget_site_search .tb_search_button {
    position: static;
    <?php if ($lang_dir == 'ltr'): ?>
    float: left;
    margin-left: -40px;
    <?php else: ?>
    float: right;
    margin-right: -40px;
    <?php endif; ?>
    width: 40px;
    height: 40px;
    line-height: 40px;
  }

  /*** Navigation ***/

  #main_navigation .tb_nav > ul > li.tb_multiple.tb_hovered:after,
  #cart.tb_hovered:after
  {
    display: none;
  }
  #main_navigation .tb_nav,
  #main_navigation #menu,
  #cart .tb_submenu,
  .tb_widget_site_search .tb_search_wrap
  {
    position: absolute;
    z-index: 1000;
    left: 0;
    right: 0;
    top: <?php echo $base * 3; ?>px;
    margin: 0 !important;
    padding: 20px;
    background: #fff;
    border-radius: 2px;
    -webkit-box-shadow:
      0 1px 0 0 rgba(0, 0, 0, 0.1),
      0 0 0 1px rgba(0, 0, 0, 0.08),
      0 1px 5px 0 rgba(0, 0, 0, 0.2);
    box-shadow:
      0 1px 0 0 rgba(0, 0, 0, 0.1),
      0 0 0 1px rgba(0, 0, 0, 0.08),
      0 1px 5px 0 rgba(0, 0, 0, 0.2);
  }

  #main_navigation .tb_thumb {
    display: none;
  }
  #main_navigation .tb_nav ul,
  #main_navigation .tb_nav li,
  #main_navigation .tb_nav a,
  #main_navigation .tb_nav .tb_submenu,
  #main_navigation #menu ul,
  #main_navigation #menu a,
  #main_navigation #menu div
  {
    left: 0 !important;
    right: 0 !important;
    clear: both !important;
    float: none !important;
    display: block;
    width: auto !important;
    margin: 0 !important;
    padding: 0 !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    border: none !important;
  }
  #main_navigation #menu li {
    float: none;
    width: auto;
    margin: 0 0 20px 0 !important;
    padding-top: 0 !important;
    padding-bottom: 0 !important;
  }
  #main_navigation #menu li li {
    margin-bottom: 10px !important;
  }
  #main_navigation #menu li:last-child,
  #main_navigation #menu li li:last-child
  {
    margin-bottom: 0 !important;
  }
  #main_navigation .tb_nav > ul > li,
  #main_navigation #menu > ul > li,
  #main_navigation .tb_nav .tb_megamenu,
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li
  {
    position: relative !important;
  }
  #main_navigation .tb_nav li.tb_multiple > a {
    <?php if ($lang_dir == 'ltr'): ?>
    clear: left !important;
    margin-right: 40px !important;
    <?php else: ?>
    clear: right !important;
    margin-left: 40px !important;
    <?php endif; ?>
  }
  #main_navigation .tb_nav li.tb_multiple > .tb_toggle {
    position: absolute;
    z-index: 10000;
    top: 15px !important;
    bottom: auto !important;
    <?php if ($lang_dir == 'ltr'): ?>
    right: 0 !important;
    left: auto !important;
    <?php else: ?>
    left: 0 !important;
    right: auto !important;
    <?php endif; ?>
    display: block !important;
    width: 30px;
    height: 30px;
    margin: 0 !important;
    line-height: 30px;
    text-align: center;
    font-size: 18px;
    background: #eee;
    cursor: pointer;
  }
  #main_navigation .tb_nav li.tb_multiple:first-child > .tb_toggle {
    top: -5px !important;
  }
  #main_navigation .tb_nav li.tb_multiple li.tb_multiple > .tb_toggle,
  #main_navigation .tb_nav li.tb_multiple li.tb_multiple:first-child > .tb_toggle
  {
    top: 5px !important;
    <?php if ($lang_dir == 'ltr'): ?>
    right: 5px !important;
    <?php else: ?>
    left: 5px !important;
    <?php endif; ?>
    width: 20px;
    height: 20px;
    line-height: 20px;
  }
  #main_navigation .tb_nav li.tb_multiple > .tb_toggle:before {
    content: '+';
  }
  #main_navigation .tb_nav li.tb_multiple > .tb_toggle.tb_active:before {
    content: '-';
  }
  #main_navigation .tb_nav > ul > li .tb_submenu,
  #main_navigation .tb_nav > ul > li.tb_hovered > .tb_submenu,
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > .tb_submenu
  {
    display: none;
  }
  #main_navigation .tb_nav > ul > li.tb_active > .tb_submenu,
  #main_navigation li.tb_active > .tb_submenu,
  #main_navigation #menu div
  {
    display: block !important;
  }
  #main_navigation #menu div {
    position: static;
  }
  #main_navigation #menu div ul + ul {
    margin-top: <?php echo $base * 0.5; ?>px !important;
  }
  #main_navigation .tb_nav .tb_images {
    text-align: center !important;
    margin: -<?php echo $base * 0.5; ?>px -<?php echo $base; ?>px 0 -<?php echo $base; ?>px !important;
    <?php if ($lang_dir == 'ltr'): ?>
    padding-right: <?php echo $base; ?>px !important;
    <?php else: ?>
    padding-left: <?php echo $base; ?>px !important;
    <?php endif; ?>
  }
  #main_navigation .tb_nav .tb_images li {
    display: inline-block !important;
    padding-top: <?php echo $base * 0.5; ?>px !important;
    <?php if ($lang_dir == 'ltr'): ?>
    padding-left: <?php echo $base; ?>px !important;
    <?php else: ?>
    padding-right: <?php echo $base; ?>px !important;
    <?php endif; ?>
  }
  #main_navigation .tb_nav > ul > li {
    margin-top: 20px !important;
    padding-top: 20px !important;
  }
  #main_navigation .tb_nav > ul > li:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    display: block;
    width: 100%;
    height: 1px;
    opacity: 0.16;
  }
  #main_navigation .tb_nav > ul > li > a {
    height: auto !important;
    line-height: <?php echo $base; ?>px !important;
  }
  #main_navigation .tb_nav > ul > li.tb_hovered > a,
  #main_navigation .tb_nav > ul > li:hover > a,
  #main_navigation .tb_nav > ul > li > a:hover
  {
    color: inherit !important;
    background-color: transparent;
  }
  #main_navigation .tb_nav > ul > li:first-child {
    margin-top: 0 !important;
    padding-top: 0 !important;
  }
  #main_navigation .tb_nav > ul > li:first-child:before {
    display: none;
  }
  #main_navigation .tb_nav > ul > li > a,
  #main_navigation #menu > ul > li > a {
    font-size: 16px;
  }
  #main_navigation .tb_nav .tb_submenu,
  #main_navigation #menu div
  {
    position: static;
    padding-top: 10px !important;
  }
  #main_navigation .tb_nav .tb_submenu .tb_submenu {
    padding-top: 0 !important;
  }
  #main_navigation .tb_nav .tb_submenu ul > li > a {
    padding-top: 5px !important;
    padding-bottom: 5px !important;
  }
  #main_navigation .tb_nav > ul > li > .tb_submenu > ul > li:last-child > a,
  #main_navigation .tb_nav > ul > li > .tb_submenu > ul > li:last-child > .tb_submenu > ul > li:last-child > a,
  #main_navigation .tb_nav > ul > li > .tb_submenu > ul > li:last-child > .tb_submenu > ul > li:last-child > .tb_submenu > ul > li:last-child > a,
  #main_navigation li.tb_megamenu > .tb_submenu > ul > li:last-child  > .tb_submenu > ul > li:last-child > a
  {
    padding-bottom: 0 !important;
  }
  #main_navigation .tb_nav > ul > li > .tb_submenu > ul > li:last-child > .tb_submenu,
  #main_navigation .tb_nav > ul > li > .tb_submenu > ul > li:last-child > .tb_submenu > ul > li:last-child > .tb_submenu,
  #main_navigation .tb_nav > ul > li > .tb_submenu > ul > li:last-child > .tb_submenu > ul > li:last-child > .tb_submenu > ul > li:last-child > .tb_submenu
  {
    padding-top: <?php echo $base * 0.25; ?>px !important;
  }
  #main_navigation li.tb_megamenu > .tb_submenu {
  }
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li {
    padding-left: 0 !important;
    padding-right: 0 !important;
  }
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"] > ul > li > a {
    text-transform: none;
  }
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_subcategories .tb_thumb {
    float: none;
  }
  #main_navigation .tb_nav > ul > li.tb_megamenu > .tb_submenu > ul > li:first-child {
    padding-top: 0 !important;
  }
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu > .tb_row > .tb_wrap > [class*="tb_col_"],
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu .tb_category_brands
  {
    border: none transparent;
  }
  #main_navigation .tb_nav ul.tb_list_1 > li {
    <?php if ($lang_dir == 'ltr'): ?>
    padding-left: <?php echo $base * 0.75; ?>px !important;
    <?php else: ?>
    padding-right: <?php echo $base * 0.75; ?>px !important;
    <?php endif; ?>
  }
  #main_navigation .tb_nav ul.tb_list_1 > li:before {
    top: <?php echo $base / 2 + $base / 4; ?>px !important;
  }
  #menu div > ul > li:before {
    top: <?php echo $base / 2; ?>px !important;
  }
  #main_navigation .tb_nav .tb_multiple > a:after,
  #main_navigation .tb_category_info,
  .tb_nav .tb_megamenu.tb_multiple:after,
  .tb_nav > ul > li > .tb_submenu:before
  {
    display: none !important;
  }
  #cart.tb_hovered {
    margin-bottom: 0;
    padding-bottom: 0;
  }
  #cart .tb_submenu {
    display: block;
    width: auto;
  }
  #main_navigation .tb_nav .tb_megamenu > .tb_submenu > ul > li.clear5:before,
  #main_navigation .tb_nav .tb_megamenu .tb_category_info + ul > li.clear4:before
  {
    display: none;
  }
  #main_navigation .tb_menu_brands .tb_item {
    display: inline;
    float: none;
    width: auto;
  }
  #main_navigation .tb_menu_brands .tb_letter {
    float: left;
    width: 50%;
  }
  #main_navigation .tb_nav .tb_submenu > ul.tb_list_1 > li.tb_multiple:after,
  #main_navigation .tb_nav .tb_menu_html ul.tb_list_1 > li.tb_multiple:after,
  #main_navigation .tb_category_brands
  {
    display: none !important;
  }

  /*** Footer ***/

  #copy {
    text-align: center;
  }

  /*** Product ***/

  #product_price {
    text-align: initial;
  }

  /*** Cart ***/

  .cart-content {
    width: 100%;
  }
  .cart-info table thead tr .action,
  .cart-info table thead tr .image,
  .cart-info table thead tr .stock,
  .cart-info table thead tr .action,
  .cart-info table thead tr .quantity,
  .cart-info table thead tr .total,
  .cart-info .model,
  .cart-info .price
  {
    display: none !important;
  }
  .cart-info table thead {
    display: table;
    width: 100%;
  }
  .cart-info table thead tr .name {
    width: 100%;
    box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.12);
  }
  .cart-info table,
  .cart-info table tbody,
  .cart-info table tbody tr,
  .cart-info table tbody th,
  .cart-info table tbody td
  {
    display: block;
    border-width: 0;
    border-style: none;
    box-shadow: none;
  }
  .cart-info table,
  .cart-info table tbody,
  .cart-info table tbody tr,
  .cart-info table tbody th,
  .cart-info table tbody td,
  .cart-info table tbody td:first-child,
  .cart-info table tbody td:last-child,
  .cart-info.tb_open table tbody tr:last-child td
  {
    padding: 0;
    text-align: inherit;
  }
  .cart-info table tbody tr {
    position: relative;
    margin-bottom: <?php echo $base; ?>px;
    <?php if ($lang_dir == 'ltr'): ?>
    padding: 0 130px <?php echo $base; ?>px 0;
    <?php else: ?>
    padding: 0 0 <?php echo $base; ?>px 130px;
    <?php endif; ?>
    box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.12);
  }
  .cart-info table tbody tr:last-child {
    margin-bottom: 0;
  }
  .cart-info.tb_open table tbody tr:last-child {
    padding-bottom: 0;
    border-bottom-width: 0;
    box-shadow: none;
  }
  .cart-info table tbody tr:after {
    content: '';
    clear: both;
    display: table;
  }
  .cart-info table tbody tr:first-child {
    margin-top: <?php echo $base; ?>px;
  }
  .cart-info table tbody .image {
    float: left;
    width: auto;
    <?php if ($lang_dir == 'ltr'): ?>
    margin-right: <?php echo $base; ?>px;
    <?php else: ?>
    margin-left: <?php echo $base; ?>px;
    <?php endif; ?>
    padding: 0 !important;
  }
  .cart-info table tbody .name,
  .cart-info table tbody .total,
  .wishlist-info table tbody .price
  {
    width: 100%;
  }
  .cart-info table tbody .name strong:after {
    content: attr(data-quantity);
    font-weight: normal;
  }
  .cart-info table tbody .quantity,
  .cart-info table tbody .action,
  .cart-info table tbody .return
  {
    position: absolute;
    top: 0;
    <?php if ($lang_dir == 'ltr'): ?>
    right: 0;
    text-align: right;
    <?php else: ?>
    left: 0;
    text-align: left;
    <?php endif; ?>
    width: 40px;
  }
  .cart-info table tbody .action,
  .cart-info table tbody .quantity
  {
    width: auto;
  }
  .cart-info table tbody .quantity input {
    margin-bottom: 10px;
    text-align: center;
    line-height: <?php echo $base * 1.5; ?>px;
  }
  .cart-info table tbody .quantity input[type=image] {
    display: none;
  }
  .cart-info table tbody .quantity .tb_button,
  .cart-info table tbody .quantity .button,
  .cart-info table tbody .quantity button,
  .cart-info table tbody .action .tb_button,
  .cart-info table tbody .action .button,
  .cart-info table tbody .action button
  {
    width: <?php echo $base * 2; ?>px;
    height: <?php echo $base * 2; ?>px;
    padding: <?php echo $base * 0.25; ?>px;
  }
  .cart-info table tbody .return {
    top: <?php echo $base * 1.5; ?>px;
  }
  .cart-info table tbody .total,
  .wishlist-info table tbody .price
  {
    display: block !important;
  }
  .cart-info table tbody .total,
  .wishlist-info table tbody td.price
  {
    padding-top: <?php echo $base * 0.5; ?>px !important;
    font-size: <?php echo $base_font_size * 1.25; ?>px;
  }
  .cart-info table tbody .remove {
    position: absolute;
    top: <?php echo $base * 1.5; ?>px;
    <?php if ($lang_dir == 'ltr'): ?>
    right: 0;
    <?php else: ?>
    left: 0;
    <?php endif; ?>
  }
  .cart-info table tbody .remove > * {
    margin: 0;
  }
  .cart-total,
  .cart-total table {
    float: none;
    width: 100%;
  }
  #apply_coupon .tb_button,
  #apply_voucher .tb_button,
  #apply_reward .tb_button,
  #apply_shipping .tb_button,
  #apply_shipping .button
  {
    height: <?php echo $base * 2; ?>px;
    padding: 0 <?php echo $base; ?>px;
    line-height: <?php echo $base * 2; ?>px;
  }

  /*** Downloads ***/

  .tb_downloads_table table thead,
  .tb_downloads_table table thead tr
  {
    position: relative;
    display: block;
  }
  .tb_downloads_table table tbody,
  .tb_downloads_table table tbody tr,
  .tb_downloads_table table tbody th,
  .tb_downloads_table table tbody td
  {
    display: block;
    border-width: 0;
    border-style: none;
    padding: 0;
  }
  .tb_downloads_table table tbody tr {
    position: relative;
    overflow: hidden;
    clear: both;
    margin: <?php echo $base / 2; ?>px 0 0 0;
    padding: 0 0 <?php echo $base / 2; ?>px 0;
    border-bottom-style: solid;
    border-bottom-width: 1px;
  }
  .tb_downloads_table table tbody tr .name {
    font-weight: bold;
  }

  /*** Checkout ***/

  .checkout-heading a {
    display: block;
    position: static;
  }
  .payment table {
    font-size: 12px;
  }
  .payment td {
    padding-bottom: <?php echo $base / 2; ?>px;
  }
  .payment input[type=text],
  .payment input[type=password],
  .payment select
  {
    display: inline-block;
  }

  /*** Login ***/

  #new_customer fieldset,
  #login_form fieldset
  {
    min-height: 0;
  }
  #login_form .tb_button_forgotten {
    display: table-footer-group;
    float: none;
  }
  #login_form .tb_button {
    display: table-header-group;
    float: none;
  }

  /*** Orders ***/

  .tb_order_info .tb_id,
  .tb_order_info .tb_status
  {
    float: none;
    <?php if ($lang_dir == 'ltr'): ?>
    text-align: left;
    <?php else: ?>
    text-align: right;
    <?php endif; ?>
  }
  .tb_order_info .tb_id {
    margin-bottom: <?php echo $base / 2; ?>px;
  }
  .tb_order_products .quantity {
    display: none;
  }

  /*** Returns ***/

  #return_request_info table {
    font-size: 11px;
  }

  /*** Sitemap ***/

  #sitemap .tb_list_1 {
    column-count: 1;
    -moz-column-count: 1;
    -webkit-column-count: 1;
    -o-column-count: 1;
  }

  /*** Widgets ***/

  .tb_icon_list h2 {
    margin-bottom: 10px;
  }
  .tb_widget_call_to_action .tb_description {
    margin-bottom: 20px;
    padding: 0 !important;
  }
  .tb_widget_call_to_action .tb_button {
    position: static !important;
    margin: 0 !important;
  }

  /*** Common styles ***/

  select {
    max-width: 99% !important;
  }
  .tb_full {
    clear: both;
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: 0 !important;
    <?php else: ?>
    margin-right: 0 !important;
    <?php endif; ?>
  }
  .tb_total.left,
  .tb_total.right
  {
    width: auto !important;
    clear: none !important;
  }
  table .tb_hidden {
    display: block !important;
  }
  table .tb_hidden.inline {
    display: inline !important;
  }
  .tb_cell_image {
    width: 200px;
  }
  .tb_cell_select {
    width: 16px;
  }
  .tb_cell_id {
    max-width: 20px;
  }
  .tb_cell_price,
  .tb_cell_total,
  .tb_cell_quantity
  {
    width: 60px;
  }
  .tb_cell_image strong {
    display: block;
    padding: 5px 0;
    text-align: center;
    font-size: 14px;
  }
  .tb_cell_select .tb_icon_16 {
    display: block;
    width: 16px;
    padding: 0 !important;
    text-indent: -1000em;
  }
  .tb_cell_image .tb_button_add_to_cart {
    font-size: 12px;
  }
  .tb_cell_quantity input[type=text] {
    min-width: 90%;
    margin-bottom: <?php echo $base / 2; ?>px;
    margin-right: 0;
  }
  #shopping_cart .tb_cell_quantity {
    display: table-cell !important;
  }
  .pagination {
    text-align: center;
  }
  .pagination * {
    float: none !important;
  }
  .pagination .links {
    float: none;
    margin-bottom: <?php echo $base / 2; ?>px;
  }
  .tb_item .tb_actions {
    display: block !important;
    font-size: 13px !important;
  }

  .swiper-slide > .tb_item {
    float: none !important;
    width: auto !important;
    margin: 0 !important;
  }



  .tb_submit,
  .buttons,
  .tb_table_1.tb_open + .tb_submit
  {
    text-align: inherit;
    margin-top: 0;
    padding-top: <?php echo $base * 1.5 - 11; ?>px;
  }
  .tb_submit,
  .buttons
  {
    <?php if ($lang_dir == 'ltr'): ?>
    direction: rtl;
    text-align: left;
    <?php else: ?>
    direction: ltr;
    text-align: right;
    <?php endif; ?>
  }
  .tb_submit > *,
  .buttons > *
  {
    <?php if ($lang_dir == 'ltr'): ?>
    direction: ltr;
    <?php else: ?>
    direction: rtl;
    <?php endif; ?>
  }
  .tb_submit .tb_button,
  .buttons input[type=submit],
  .buttons input[type=button]
  .buttons button,
  .buttons .button,
  .buttons .btn
  {
    float: none;
    margin-top: <?php echo ($tbData->calculateLineHeight($submit_button_size, $base) - $submit_button_size)/2 + $base / 2; ?>px;
  }
  .tb_submit .checkbox,
  .tb_submit .radio
  {
    display: block;
    width: 100%;
    margin-left: 0;
    margin-right: 0;
    margin-top: 0;
    margin-bottom: <?php echo $base; ?>px;
  }
  .tb_submit i.fa.fa-circle-o-notch.fa-spin,
  .buttons i.fa.fa-circle-o-notch.fa-spin
  {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: <?php echo $base * 0.5; ?>px;
    <?php else: ?>
    margin-right: <?php echo $base * 0.5; ?>px;
    <?php endif; ?>
    vertical-align: middle;
  }
  .tb_submit .tb_button_forgotten {
    display: block;
    float: none;
    margin: 0 0 <?php echo $base; ?>px; 0;
  }

  .buttons input[type=submit],
  .buttons input[type=button],
  .buttons button
  {
    line-height: 30px !important;
    border-radius: 0 !important;
    -webkit-border-radius: 0 !important;
    -webkit-appearance: none;
  }

  .tb_orders_listing {
    <?php if ($lang_dir == 'ltr'): ?>
    padding-left: 0 !important;
    <?php else: ?>
    padding-right: 0 !important;
    <?php endif; ?>
  }
  .noty_cont {
    position: static;
    width: auto;
    height: auto;
  }
  .noty_bar {
    position: fixed !important;
    top: 15px;
    left: 15px;
    right: 15px;
    bottom: 15px;
    width: auto;
  }
  .noty_message {
    margin: 0;
  }

  #copy,
  #payment_images
  {
    display: block;
    width: 100%;
    text-align: center;
  }


}


/*  -------------------------------------------------------------------------------------  */
/*  ---  Mobile landscape mode  ---------------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---  Min width: 480px / Max width: 767px    -----------------------------------------  */

@media only screen and (min-width: 480px) and (max-width: 767px) {

  /*** Forms ***/

  #categories > ul > li {
    width: 33.33%;
  }

  /*** Item listing ***/

  .tb_list_view > .tb_item > .tb_thumb {
    max-width: 40%;
  }
  .tb_list_view .tb_item .tb_description {
    overflow: hidden;
    max-height: <?php echo $base * 3; ?>px;
  }

  /*** Downloads ***/

  .tb_downloads_table table thead tr th {
    display: none;
    white-space: nowrap;
    border-left-width: 0;
    border-right-width: 0;
  }
  .tb_downloads_table table .id,
  .tb_downloads_table table .quantity
  {
    position: absolute;
    top: 0;
    display: block;
    background: none;
    border: none;
  }
  .tb_downloads_table table .id {
    <?php if ($lang_dir == 'ltr'): ?>
    left: 0;
    padding-left: <?php echo $base / 2; ?>px;
    <?php else: ?>
    right: 0;
    padding-right: <?php echo $base / 2; ?>px;
    <?php endif; ?>
  }
  .tb_downloads_table table .quantity {
    <?php if ($lang_dir == 'ltr'): ?>
    right: 0;
    padding-right: <?php echo $base / 2; ?>px;
    <?php else: ?>
    left: 0;
    padding-left: <?php echo $base / 2; ?>px;
    <?php endif; ?>
  }
  .tb_downloads_table table .name {
    display: block;
    padding: 0 20%;
    text-align: center;
  }

  #main_navigation .tb_menu_brands .tb_letter {
    float: left;
    width: 33.3333%;
  }

}


/*  -------------------------------------------------------------------------------------  */
/*  ---  Mobile portrait mode  ----------------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---  Max width: 480px  --------------------------------------------------------------  */

@media only screen and (max-width: 479px) {

  /*** Forms ***/

  label,
  input:not([type=radio]):not([type=checkbox]),
  select,
  textarea,
  #country_id,
  #zone_id,
  select[name="customer_group_id"],
  table.form td,
  table.form td:first-child
  {
    width: 100%;
    margin-left: 0;
    margin-right: 0;
  }
  input[type=checkbox] + label + br:last-child,
  input[type=radio] + label + br:last-child
  {
    display: none;
  }
  table.form,
  table.form thead,
  table.form tbody,
  table.form tr,
  table.form td
  {
    display: block;
  }
  table.form td:first-child {
    padding-bottom: <?php echo $base / 4; ?>px !important;
  }
  .form-group > label + div[class*="col-"],
  .form-group > label + div[class*="col-"] > div
  {
    clear: both;
  }

  /*** Item listing ***/

  .tb_list_view > .tb_item > .tb_thumb {
    float: none;
    max-width: none;
    margin: 0 auto 20px auto !important;
  }
  .tb_list_view .tb_item_info {
    clear: both;
  }
  .tb_grid_view .tb_product .tb_item_info .tb_description {
    display: none;
  }

  /*** Cart ***/

  .cart-info table thead td.name {
    display: block;
    text-align: center;
  }
  .cart-info table tbody tr {
    padding-left: 0;
    padding-right: 0;
  }
  .cart-info table tbody .image,
  .cart-info table tbody .name,
  .cart-info table tbody .total,
  .wishlist-info table tbody td.price,
  .cart-info table tbody .quantity,
  .cart-info table tbody .stock,
  .cart-info table tbody .action
  {
    position: static;
    float: none;
    width: 100%;
    margin: 0;
    padding: 0;
    text-align: center !important;
  }
  .cart-info table tbody .name {
    margin: <?php echo $base; ?>px 0 0 0;
  }
  .cart-info table tbody .image,
  .cart-info table tbody .stock,
  .cart-info table tbody .total,
  .wishlist-info table tbody td.price
  {
    margin-top: 0;
  }
  .cart-info table tbody .image img {
    max-width: none;
  }
  .cart-info table tbody .quantity {
    padding-top: <?php echo $base * 0.5; ?>px;
  }
  .cart-info table tbody .quantity input {
    margin-bottom: 0;
  }
  .cart-info table tbody .quantity a,
  .cart-info table tbody .action a
  {
    display: inline-block;
    width: auto;
  }
  .cart-info table tbody .remove {
    position: absolute;
    top: 0;
    <?php if ($lang_dir == 'ltr'): ?>
    right: 0;
    <?php else: ?>
    left: 0;
    <?php endif; ?>
  }

  /*** Downloads ***/

  .tb_downloads_table table thead tr th,
  .tb_downloads_table table .id,
  .tb_downloads_table table .quantity
  {
    display: none;
  }
  .tb_downloads_table table thead tr .name {
    display: block;
    border-left-width: 0;
    border-right-width: 0;
  }

}



/*  -------------------------------------------------------------------------------------  */
/*  ---  Mobile tiny  -------------------------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */
/*  ---  Max width: 360px  --------------------------------------------------------------  */

@media only screen and (max-width: 359px) {

  /*** Header ***/

  #header,
  #main_navigation_row
  {
    position: relative !important;
  }
  #header.tb_mb_5  + #main_navigation_row { margin-top: -5px !important;  margin-bottom: 5px !important;  }
  #header.tb_mb_10 + #main_navigation_row { margin-top: -10px !important; margin-bottom: 10px !important; }
  #header.tb_mb_15 + #main_navigation_row { margin-top: -15px !important; margin-bottom: 15px !important; }
  #header.tb_mb_20 + #main_navigation_row { margin-top: -20px !important; margin-bottom: 20px !important; }
  #header.tb_mb_25 + #main_navigation_row { margin-top: -25px !important; margin-bottom: 25px !important; }
  #header.tb_mb_30 + #main_navigation_row { margin-top: -30px !important; margin-bottom: 30px !important; }
  #header.tb_mb_35 + #main_navigation_row { margin-top: -35px !important; margin-bottom: 35px !important; }
  #header.tb_mb_40 + #main_navigation_row { margin-top: -40px !important; margin-bottom: 40px !important; }
  #header.tb_mb_45 + #main_navigation_row { margin-top: -45px !important; margin-bottom: 45px !important; }
  #header.tb_mb_50 + #main_navigation_row { margin-top: -50px !important; margin-bottom: 50px !important; }

  #header .tbLogoRow > .tb_wrap,
  #header .tbLogoRow > .tb_wrap > [class*="tb_col_"],
  #header #site_logo
  {
    height: auto !important;
  }
  #site_logo {
    line-height: normal;
  }
  #header .tbLogoRow > .tb_wrap {
    padding-left: 0 !important;
    padding-right: 0 !important;
  }
  #site_logo {
    display: block;
    margin-left: 0;
    margin-right: 0;
    margin-bottom: 60px;
    text-align: center;
  }
  #header .tbLogoRow + .tb_row.tbCloned {
    margin-top: -70px !important;
    padding-bottom: 80px !important;
  }
  #header #main_navigation,
  #header .tb_widget_site_search,
  #header .tb_widget_cart
  {
    top: auto !important;
    bottom: 20px !important;
  }
  #main_navigation_row #main_navigation,
  #main_navigation_row .tb_widget_site_search,
  #main_navigation_row .tb_widget_cart
  {
    top: -<?php echo $base; ?>px !important;
  }

  #header .tb_toggle,
  #main_navigation_row .tb_toggle
  {
    bottom: 0;
    top: auto !important;
    <?php if ($lang_dir == 'ltr'): ?>
    left: 50% !important;
    right: auto !important;
    <?php else: ?>
    right: 50% !important;
    left: auto !important;
    <?php endif; ?>
  }
  #main_navigation > .tb_toggle {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: -80px;
    <?php else: ?>
    margin-right: -80px;
    <?php endif; ?>
  }
  .tb_widget_cart .tb_toggle {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: -20px;
    <?php else: ?>
    margin-right: -20px;
    <?php endif; ?>
  }
  .tb_widget_site_search .tb_toggle {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: 40px;
    <?php else: ?>
    margin-right: 40px;
    <?php endif; ?>
  }
  #main_navigation .tb_nav,
  #main_navigation #menu,
  #cart .tb_submenu,
  .tb_widget_site_search .tb_search_wrap
  {
    top: <?php echo $base; ?>px;
  }
  #header.tb_row_fixed .tb_widget_site_search,
  #header.tb_row_fixed .tb_widget_cart,
  #header.tb_row_fixed #main_navigation
  {
    left: 0 !important;
    right: 0 !important;
  }
  .tb_grid_view .tb_product .tb_item_info .tb_description {
    display: none;
  }
  select + i.fa.fa-circle-o-notch.fa-spin {
    <?php if ($lang_dir == 'ltr'): ?>
    margin-left: -<?php echo $base * 1.5 + 16; ?>px;
    <?php else: ?>
    margin-right: -<?php echo $base * 1.5 + 16; ?>px;
    <?php endif; ?>
    vertical-align: middle;
  }

}





/*  -------------------------------------------------------------------------------------  */
/*  ---  Retina displays                        -----------------------------------------  */
/*  ---  Overrides styles for devices with a    -----------------------------------------  */
/*  ---  device-pixel-ratio of 2+, such as iPhone 4     ---------------------------------  */

@media
  only screen and (-webkit-min-device-pixel-ratio: 2),
  only screen and (min-device-pixel-ratio: 2) {

  body {
  }

}


/*  -------------------------------------------------------------------------------------  */
/*  ---  Element queries  ---------------------------------------------------------------  */
/*  -------------------------------------------------------------------------------------  */

/*  ---  Categories  --------------------------------------------------------------------  */

.tb_listing_options.tb_max_w_650 [class*="tb_col_"],
.tb_listing_options.tb_max_w_350 [class*="tb_col_"]
{
  width: 100%;
  margin-bottom: 0;
  text-align: inherit;
}
.tb_listing_options.tb_max_w_650 [class*="tb_col_"]:last-child > :last-child,
.tb_listing_options.tb_max_w_350 [class*="tb_col_"]:last-child > :last-child
{
  <?php if ($lang_dir == 'ltr'): ?>
  margin-right: 0;
  <?php else: ?>
  margin-left: 0;
  <?php endif; ?>
}
.tb_listing_options.tb_max_w_650 [class*="tb_col_"] + [class*="tb_col_"] {
  margin-top: <?php echo $base / 2; ?>px !important;
}
.tb_listing_options.tb_max_w_650 [class*="tb_col_"] > * {
  <?php if ($lang_dir == 'ltr'): ?>
  margin: 0 <?php echo $base; ?>px 0 0;
  <?php else: ?>
  margin: 0 0 0 <?php echo $base; ?>px;
  <?php endif; ?>
}
.tb_listing_options.tb_max_w_350 [class*="tb_col_"] > * {
  display: block;
  margin: 0 0 <?php echo $base; ?>px 0;
  padding: 0;
  border: 0;
}
.tb_listing_options.tb_max_w_350 [class*="tb_col_"]:last-child > :last-child {
  margin-bottom: 0;
}
.tb_listing_options.tb_max_w_350 select {
  <?php if ($lang_dir == 'ltr'): ?>
  float: right;
  <?php else: ?>
  float: left;
  <?php endif; ?>
  width: 40%;
}

/*  ---  Product  -----------------------------------------------------------------------  */

#review_aggregate.tb_max_w_280 .tb_rating_holder .tb_review_write {
  margin: 0;
  padding: 0;
  border: none;
}
#product_options.tb_max_w_300 .option b,
#product_options.tb_max_w_300 .option .required
{
  float: none;
  margin-bottom: <?php echo $base * 0.5; ?>px;
  padding-top: 0;
  padding-bottom: 0;
}
#product_options.tb_max_w_300 .option .required {
  <?php if ($lang_dir == 'ltr'): ?>
  padding-right: 0;
  <?php else: ?>
  padding-left: 0;
  <?php endif; ?>
}
#product_options.tb_max_w_300 .option b {
  max-width: none;
}
#product_options.tb_max_w_300 .tb_checkbox_row .tb_group,
#product_options.tb_max_w_300 .tb_radio_row .tb_group
{
  padding-top: 0;
  padding-bottom: 0;
}
#product_options.tb_max_w_300 .option .tb_group,
#product_options.tb_max_w_300 #profile-description
{
  float: none;
  width: auto;
  margin-left: 0;
  margin-right: 0;
}
#product_options.tb_max_w_300 .option + .error {
  <?php if ($lang_dir == 'ltr'): ?>
  margin-left: 0;
  padding-left: 0;
  <?php else: ?>
  margin-right: 0;
  padding-right: 0;
  <?php endif; ?>
}
#product_options.tb_max_w_300 .option input[type=button] {
  float: none;
}

#product_buy.tb_max_w_400 .tb_purchase_button,
#product_buy.tb_max_w_400 .tb_actions,
#product_buy.tb_max_w_400 .tb_purchase_info
{
  display: block;
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}
#product_buy.tb_max_w_400 .tb_actions {
  margin-top: <?php echo $base / 2; ?>px;
  margin-left: -<?php echo $base / 2; ?>px;
  margin-right: -<?php echo $base / 2; ?>px;
  padding-left: <?php echo $base / 2; ?>px;
}
#product_buy.tb_max_w_400 .tb_actions .tb_button_wishlist,
#product_buy.tb_max_w_400 .tb_actions .tb_button_compare
{
  display: inline-block;
  margin-right: <?php echo $base / 2; ?>px;
}

/*  ---  Tables  ------------------------------------------------------------------------  */

table.tb_max_w_400 thead,
table.tb_max_w_400 thead tr
{
  overflow: hidden;
  display: block;
}
table.tb_max_w_400 thead tr th {
  display: none;
  border-left-width: 0;
  border-right-width: 0;
  box-shadow: none;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
}
table.tb_max_w_400,
table.tb_max_w_400 tbody,
table.tb_max_w_400 tbody tr,
table.tb_max_w_400 tbody th,
table.tb_max_w_400 tbody td,
.tb_table_1.tb_max_w_400 tbody tr:last-child td,
.tb_table_1 table.tb_max_w_400 tbody tr:last-child td
{
  display: block;
  box-shadow: none;
  padding: 0;
}
.tb_table_1 table.tb_max_w_400 tbody tr,
table.tb_table_1.tb_max_w_400 tbody tr
{
  position: relative;
  padding-top: <?php echo $base; ?>px;
  padding-bottom: <?php echo $base; ?>px;
  box-shadow: 0 1px 0 rgba(0, 0, 0, 0.11);
}
.tb_table_1.tb_open table.tb_max_w_400 tbody tr:last-child,
.tb_table_1.tb_open.tb_max_w_400 tbody tr:last-child
{
  padding-bottom: 0;
  box-shadow: none;
}
table.tb_max_w_400 tbody tr:after {
  content: '';
  clear: both;
  display: table;
}
table.tb_max_w_400 tbody td {
  <?php if ($lang_dir == 'ltr'): ?>
  text-align: left;
  <?php else: ?>
  text-align: right;
  <?php endif; ?>
}

/*** Order info ***/

.tb_order_statuses table.tb_max_w_400 th.comment {
  display: block;
}
.tb_order_statuses table.tb_max_w_400 .date {
  font-weight: bold;
}

/*** Return info ***/

.cart-info table.tb_max_w_400 td.name {
  float: none;
  font-weight: bold;
}
.cart-info table.tb_max_w_400 .reason:before,
.cart-info table.tb_max_w_400 .opened:before
{
  content: attr(title)': ';
}

/*** Transactions / Reward points / Recurring payments ***/

.tb_transactions table.tb_max_w_400 thead tr th.description,
.tb_reward_points table.tb_max_w_400 thead tr th.description,
.tb_recurring_payments table.tb_max_w_400 thead tr th.name
{
  display: block;
  box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.12);
}
.tb_transactions table.tb_max_w_400 .date,
.tb_reward_points table.tb_max_w_400 .date
{
  font-weight: bold;
}
.tb_reward_points table.tb_max_w_400 .points:before {
  content: attr(title)': ';
  font-weight: bold;
}

.tb_recurring_payments table.tb_max_w_400 .id,
.tb_recurring_payments table.tb_max_w_400 .action
{
  position: absolute;
  top: 0;
}
.tb_recurring_payments table.tb_max_w_400 .id {
  <?php if ($lang_dir == 'ltr'): ?>
  left: 0;
  <?php else: ?>
  right: 0;
  <?php endif; ?>
}
.tb_recurring_payments table.tb_max_w_400 .action {
  <?php if ($lang_dir == 'ltr'): ?>
  right: 0;
  <?php else: ?>
  left: 0;
  <?php endif; ?>
}
.tb_recurring_payments table.tb_max_w_400 tbody tr {
  padding-left: <?php echo $base * 1.5; ?>px;
  padding-right: <?php echo $base * 1.5; ?>px;
}
.tb_recurring_payments table.tb_max_w_400 .name {
  display: table-header-group;
  font-weight: bold;
}
.tb_recurring_payments table.tb_max_w_400 tbody td {
  display: table-footer-group;
}
