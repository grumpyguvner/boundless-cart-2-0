<div<?php if (count($languages) > 1) echo ' class="tb_tabs tb_fly_tabs tbLanguageTabs"'; ?>>
  
  <h2>Menu composer</h2>

  <?php if (count($languages) > 1): ?>
  <div class="tb_tabs_nav">
    <ul class="tb_tabs_nav clearfix">
      <?php foreach ($languages as $language): ?>
      <li class="s_language">
        <a href="#menu_builder_language_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>">
          <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
          <?php echo $language['code']; ?>
        </a>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
  <?php endif; ?>

  <?php foreach ($languages as $language): ?>
  <?php $language_id = $language['language_id']; ?>
  <div id="menu_builder_language_<?php echo $language_id; ?>" class="s_language_<?php echo $language['code']; ?> tbLanguagePanel">
    <textarea name="store[menu][tree][<?php echo $language_id; ?>]" class="tbMenuData" style="display: none;"><?php echo $theme_settings['store']['menu']['tree'][$language_id]; ?></textarea>
    <input type="hidden" name="store[menu][is_dirty]" value="0" />
    <div class="tb_wrap">
      <div class="tb_col tb_3_5">
        <div class="tb_menu_listing">
          <ol class="tbSortable"></ol>
        </div>
      </div>
      <div class="tb_col tb_2_5">
        <div class="s_box_1 tb_tabs tb_tabs_inline s_white tbMenuTabs">
          <h3>Add Menu Item</h3>
          <div class="tb_tabs_nav s_h_40 s_4cols">
            <ul>
              <li><a href="#add_menu_custom_<?php echo $language_id; ?>">Custom</a></li>
              <li><a href="#add_menu_page_<?php echo $language_id; ?>">Page</a></li>
              <li><a href="#add_menu_category_<?php echo $language_id; ?>">Category</a></li>
              <li><a href="#add_menu_system_<?php echo $language_id; ?>">System</a></li>
            </ul>
          </div>
          <div id="add_menu_custom_<?php echo $language_id; ?>" class="tb_add_menu_custom">
            <div class="s_row_2">
              <label><span class="right red tbErrorNotice" style="display: none;">Please, enter menu title.</span>Label</label>
              <input type="text" size="30" />
            </div>
            <div class="s_row_2">
              <label class="s_radio">
                <input type="radio" name="store_menu_custom_<?php echo $language_id; ?>" value="url" checked="checked" />
                <span>Static/Url</span>
              </label>
              <label class="s_radio">
                <input type="radio" name="store_menu_custom_<?php echo $language_id; ?>" value="home" />
                <span>Home page</span>
              </label>
              <label class="s_radio">
                <input type="radio" name="store_menu_custom_<?php echo $language_id; ?>" value="html" />
                <span>Custom HTML dropdown</span>
              </label>
              <label class="s_radio">
                <input type="radio" name="store_menu_custom_<?php echo $language_id; ?>" value="categories" />
                <span>All categories dropdown</span>
              </label>
              <label class="s_radio">
                <input type="radio" name="store_menu_custom_<?php echo $language_id; ?>" value="manufacturers" />
                <span>Manufacturers dropdown</span>
              </label>
            </div>
            <br />
            <a class="s_button s_white s_h_30 s_icon_10 s_plus_10 tbAddMenuItem" item_id="custom" href="javascript:;">Add to menu</a>
          </div>
          <div id="add_menu_page_<?php echo $language_id; ?>" class="tb_add_menu_item tbMenuItemsTab">
            <div class="s_row_2">
              <label>Filter:</label>
              <input type="text" class="tbItemFilter tb_1_1 s_mb_20" value="">
            </div>
            <ul class="tbItemsList">
              <?php foreach ($tbData->getInformationPages() as $page): ?>
              <li><a class="s_button_add_subwidgets s_button s_white s_h_20 s_icon_10 s_plus_10 left tbAddMenuItem" href="javascript:;" item_id="page_<?php echo $page['information_id']; ?>"></a><span><?php echo $page['title']; ?></span></li>
              <?php endforeach; ?>
            </ul>
          </div>
          <div id="add_menu_category_<?php echo $language_id; ?>" class="tb_add_menu_item tbMenuItemsTab">
            <div class="s_row_2">
              <label>Filter:</label>
              <input type="text" class="tbItemFilter tb_1_1 s_mb_20" value="">
            </div>
            <ul class="tbItemsList">
              <?php foreach ($tbData->getCategoriesLevel1() as $category): ?>
              <li><a class="s_button_add_subwidgets s_button s_white s_h_20 s_icon_10 s_plus_10 left tbAddMenuItem" href="javascript:;" item_id="category_<?php echo $category['category_id'] ?>"></a><span><?php echo $category['name']; ?></span></li>
              <?php endforeach; ?>
            </ul>
          </div>
          <div id="add_menu_system_<?php echo $language_id; ?>" class="tb_add_menu_item tbMenuItemsTab">
            <div class="s_row_2">
              <label>Filter:</label>
              <input type="text" class="tbItemFilter tb_1_1 s_mb_20" value="">
            </div>
            <ul class="tbItemsList">
              <?php foreach ($tbData->system_menu_pages[$language_id] as $id => $title): ?>
              <li><a class="s_button_add_subwidgets s_button s_white s_h_20 s_icon_10 s_plus_10 left tbAddMenuItem" href="javascript:;" item_id="system_<?php echo $id; ?>"></a><span><?php echo $title; ?></span></li>
              <?php endforeach; ?>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <?php endforeach; ?>
</div>
