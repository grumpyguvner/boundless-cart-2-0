tbApp.initMenu = function($menuContainer, options) {

    var is_dirty = false;

    options = $.extend({
        width:          800,
        margin_left:    -400,
        allow_nesting:  true,
        sticky_sidebar: true
    }, options || {});

    var bindModal = function($menuItem) {

        $menuItem.find(".tbEditMenuItem").bind("click", function() {
            var $output = $(Mustache.render($("#common_modal_dialog_template").text(), {
                width:       options.width,
                margin_left: options.margin_left
            })).appendTo($("body"));

            var $settingsWindow = $output.find(".sm_window").first();
            var type = $menuItem.data("type");
            var manufacturers = $sReg.get("/tb/manufacturers");

            $.each(manufacturers, function(key, val) {
                val.name = tbHelper.unescapeHTML(val.name);
            });
            var $contents = $(Mustache.render($("#store_menu_settings_" + $menuItem.data("type") + "_template").text(), {
                manufacturers: tbHelper.jsonToArray(manufacturers)
            })).appendTo($settingsWindow.find(".sm_content"));

            window.scrollTo(0, 0);

            $settingsWindow.find(".tbUpdateSettings").bind("click", function() {

                is_dirty = true;

                for (var instance in CKEDITOR.instances)
                    CKEDITOR.instances[instance].updateElement();

                if (type == "url" || type == "html" || type == "categories" || type == "home" || type == "manufacturers") {
                    var $inputLabel = $settingsWindow.find("form").find('input[name="label"]');

                    if ($inputLabel.val() == "") {
                        $inputLabel.val("Sample Label");
                    }

                    $menuItem.find("> div h3").text($inputLabel.val());
                }

                $menuItem.data("settings", form2js($settingsWindow.find("form")[0], ".", true, function(node) {
                    var $node = $(node);

                    if ($node.is(":checkbox")) {
                        if ($node.is('[name$="[]"]')) {
                            return $node.is(":checked") ? $node.val() : false;
                        }

                        return {
                            name:  $node.attr("name"),
                            value: $node.is(":checked") ? 1 : 0
                        };
                    }

                    return false;
                }, false));

                $settingsWindow.fadeOut(300, function() {
                    $settingsWindow.parent("div").remove();
                });

                return false;
            });

            $settingsWindow.find("a.sm_closeWindowButton").add($output.find(".sm_overlayBG")).bind("click", function() {
                $settingsWindow.fadeOut(300, function() {
                    $settingsWindow.parent("div").remove();
                });
            });

            if ($menuItem.data("settings")) {
                js2form($settingsWindow.find("form")[0], $menuItem.data("settings"));
            }

            if ($menuItem.data("type") == "manufacturers" || $menuItem.data("type") == "category" || $menuItem.data("type") == "categories") {

                $contents.find('select[name="manufacturers_type"]').bind("change", function() {
                    $contents.find(".tbManufacturersDisplay").toggle($(this).val() == "custom" || $(this).val() == "all");
                    $contents.find(".tbManufacturersListing").toggle($(this).val() == "custom");
                }).trigger("change");

                $contents.find('select[name="manufacturers_display"]').bind("change", function() {
                    $contents.find(".tbImageSize").toggle($(this).val() != "label");
                }).trigger("change");
            }
            
            if ($menuItem.data("type") == "manufacturers") {
                $contents.find('input[name="is_megamenu"]').bind("change", function() {
                    $contents.find(".tbSimpleMenu").toggle(!$(this).is(":checked"));
                    $contents.find(".tbMegaMenu").toggle($(this).is(":checked"));
                }).trigger("change");
            }

            if ($settingsWindow.find("textarea.ckeditor").length) {
                CKEDITOR.replace($settingsWindow.find("textarea").first().attr("name"), {
                    customConfig:              $sReg.get('/tb/url/theme_admin_javascript_url') + 'ckeditor/custom/config.js',
                    contentsCss:               $sReg.get('/tb/url/theme_admin_javascript_url') + 'ckeditor/custom/styles.css',
                    filebrowserBrowseUrl:      $sReg.get('/tb/url/fileManager'),
                    filebrowserImageBrowseUrl: $sReg.get('/tb/url/fileManager'),
                    filebrowserUploadUrl:      null,
                    filebrowserImageUploadUrl: null
                });
            }

            if ($menuItem.data("type") == "html") {
                $settingsWindow.find('select[name="dropdown_width_metric"]').bind("change", function() {
                    if ($(this).val() == "%") {
                        $settingsWindow.find('[name="dropdown_width"]').val("100").attr("disabled", "disabled");
                    } else {
                        $settingsWindow.find('[name="dropdown_width"]').removeAttr("disabled");
                    }
                });

                $settingsWindow.find('[name="dropdown_width"]').numeric(false, function() {
                    $(this).val("300");
                });
            }

            if ($menuItem.data("type") == "category" && $menuItem.data("settings").category_custom_bg) {
                $.ajax({
                    url: $sReg.get("/tb/url/getImagePath") + "&filename=" + encodeURIComponent($menuItem.data("settings").category_custom_bg),
                    dataType: "json",
                    success: function(data) {
                        if (data.path) {
                            $("#menu_category_custom_bg_preview").attr("src", data.path);
                        }
                    }
                });
            }

            if ($menuItem.data("type") == "category" || $menuItem.data("type") == "categories") {
                $settingsWindow.find('input[name="category_thumb"]').bind("change", function() {
                    if (!$(this).is(":checked")) {
                        $settingsWindow.find('input[name="subcategory_hover_thumb"]').removeProp("checked").parents(".tbRow").first().addClass("tb_disabled");
                        $settingsWindow.find(".tbCategoryThumbSize").addClass("tb_disabled");
                    } else {
                        $settingsWindow.find('input[name="subcategory_hover_thumb"]').parents(".tbRow").first().removeClass("tb_disabled");
                        $settingsWindow.find(".tbCategoryThumbSize").removeClass("tb_disabled");
                    }
                }).trigger("change");

                $settingsWindow.find('input[name="is_megamenu"]').bind("change", function() {
                    $settingsWindow.find(".tbMegamenuOption").toggle($(this).is(":checked"));
                }).trigger("change");
            }

            $settingsWindow.show();
            beautifyForm($settingsWindow);
            $settingsWindow.find(".colorSelector").each(function() {
                assignColorPicker($(this));
            });

            if (typeof $menuItem.data("settings").accent_bg != "undefined") {
                $settingsWindow.find('input[name="accent_bg"]')
                    .prev(".colorSelector")
                    .find("div").css("background-color", $menuItem.data("settings").accent_bg);
            }

            if (typeof $menuItem.data("settings").accent_color != "undefined") {
                $settingsWindow.find('input[name="accent_color"]')
                    .prev(".colorSelector")
                    .find("div").css("background-color", $menuItem.data("settings").accent_color);
            }
            
            /*
            function stickymodal($item) {
                var window_height = $(window).height();
                var window_scroll = $(window).scrollTop();
                var body_height   = $('body').height();
                var modal_height  = $item.height();
                var modal_scroll  = $item.scrollTop();

                $item.css('top', window_scroll + 30);

                $(window).scroll(function() {
                    window_scroll = $(window).scrollTop();
                    if (modal_height > window_height) {
                        if (window_height + window_scroll + 30 > modal_height) {
                            $item.css('top', window_scroll + window_height - modal_height - 30);
                        }
                    }
                    if (modal_height <= window_height) {
                        $item.css('top', window_scroll + 30);
                    }
                });

            }
            
            stickymodal($settingsWindow);
            */

            return false;
        });
    };

    $menuContainer.find(".tb_menu_listing ol.tbSortable").nestedSortable({
        items: "li:not(.ui-state-disabled)",
        handle: "h3",
        toleranceElement: '> div',
        maxLevels: 3,
        isAllowed: function(item, parent) {
            var type = item.data("type");

            return parent == null || (type != "category" && type != "html" && type != "home" && type != "categories" && type != "manufacturers");
        }
    }).end()
    .find(".tbMenuTabs").tabs().end()
    .find("input.tbItemFilter").each(function() {
        $(this).fastLiveFilter($(this).parents(".tbMenuItemsTab").first().find(".tbItemsList"));
    }).end()
    .find(".tbAddMenuItem").bind("click", function() {

        is_dirty = true;

        var $section = $(this).parents(".tbLanguagePanel").first();

        var type = $(this).attr("item_id").split("_")[0];
        var title = $(this).parent().text();

        if (type == "custom") {
            var $parentDiv = $(this).parents(".tb_add_menu_custom").first();

            type = $parentDiv.find(":checked").val();
            title = $parentDiv.find(":text").val().trim();

            if (title == "") {
                $parentDiv.find(".tbErrorNotice").show();

                return false;
            } else {
                $parentDiv.find(".tbErrorNotice").hide();
                $parentDiv.find(":text").val("");
            }
        }

        var menuItem = Mustache.render($("#store_menu_template").text(), {
            id:         tbHelper.generateUniqueId(10),
            title:      title,
            no_nesting: type == "category" || type == "html"  || type == "home" || type == "categories" || type == "manufacturers" || false == options.allow_nesting
        });

        var item_id;

        if (type == "url" || type == "html" || type == "home" || type == "categories" || type == "manufacturers") {
            item_id = tbHelper.generateUniqueId(5);
        } else
        if (type == "system") {
            item_id = $(this).attr("item_id").split("_");
            item_id = item_id.slice(1, item_id.length).join("_");
        } else {
            item_id = $(this).attr("item_id").split("_")[1];
        }

        var $menuItem = $(menuItem).appendTo($section.find(".tb_menu_listing ol").first()).data({
            type: type,
            id:   item_id
        });

        var tpl = Mustache.render($("#store_menu_settings_" + type + "_template").text());
        var default_settings = form2js($(tpl).find("form")[0], ".", false, null, false);

        $menuItem.data("settings", default_settings);
        if (type == "url" || type == "html" || type == "categories" || type == "home" || type == "manufacturers") {
            $menuItem.data("settings").label = title;
        }
        bindModal($menuItem);
    }).end()
    .find(".tbLanguagePanel").each(function() {
        var $tabContents = $(this);
        var menuData = JSON.parse($(this).find("textarea.tbMenuData").first().text());

        var buildMenu = function(menuData, parent) {
            $.each(menuData, function(index, value) {
                var title;
                var type = value.data.type;

                if (type == "page" || type == "system" || type == "category") {
                    title = $tabContents.find('[item_id="' + type + '_' + value.data.id + '"]').parent("li").text();
                } else {
                    title = value.data.settings.label;
                }

                var menuItem = Mustache.render($("#store_menu_template").text(), {
                    id:         tbHelper.generateUniqueId(10),
                    title:      title,
                    no_nesting: type == "category" || type == "html" || type == "home" || type == "categories" || type == "manufacturers" || false == options.allow_nesting
                });

                var $toAppend;

                if (typeof parent != "undefined" ) {
                    if (!parent.find("> ol").length) {
                        parent.append("<ol></ol>");
                    }
                    $toAppend = parent.find("> ol");
                } else {
                    $toAppend = $tabContents.find(".tb_menu_listing ol").first();
                }

                var $menuItem = $(menuItem).appendTo($toAppend).data({
                    type: type,
                    id:   value.data.id
                });

                bindModal($menuItem);

                if (typeof value.data.settings != "undefined") {
                    $menuItem.data("settings", value.data.settings);
                }

                if (typeof value.children != "undefined") {
                    buildMenu(value.children, $menuItem);
                }
            });
        };

        buildMenu(menuData);
    }).end()
    .on("click", ".tbRemoveMenuItem", function() {
        $(this).parents("li").first().remove();
        is_dirty = true;
    });

    if (options.sticky_sidebar) {
        $menuContainer.find(".tbMenuTabs").parent().stickySidebar({
            padding: 30
        });
    }

    var updateMenuData = function(tree) {
        $.each(tree, function(index, value) {
            if (typeof value.children != "undefined") {
                updateMenuData(value.children);
            }
            value.data = $("#menu_item_" + value.id).data();
            delete value.id;
            delete value.data.nestedSortableItem;
        });
    };

    var prepareMenuForSave = function() {
        $menuContainer.find(".tb_menu_listing ol.tbSortable").each(function() {
            var $section = $(this).parents(".tbLanguagePanel").first();
            var tree = $(this).nestedSortable("toHierarchy", {startDepthCount: 0});

            updateMenuData(tree);
            $section.find("textarea.tbMenuData").first().text(JSON.stringify(tree));
            $section.find("input[name$='[is_dirty]']").val(is_dirty ? 1 : 0);
        });
    };

    $(tbApp).on("tbCp:afterSave", function(event, eventDispatcher) {
        is_dirty = false;
    });

    return {
        prepareForSave: prepareMenuForSave
    }
};