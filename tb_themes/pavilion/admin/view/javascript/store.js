(function($, tbApp) {

tbApp.initRestrictionRows = function ($container, input_property) {
    var restriction_rows_num = $container.find(".tbItemsRestrictionRow").length;

    $container.find(".tbAddItemsRestrictionRow").bind("click", function() {
        var output = Mustache.render($("#store_items_restriction_template").text(), {
            input_property: input_property,
            row_num:        restriction_rows_num++
        });

        $container.find(".tbItemsRestrictionsWrapper").append($(output)).find(".s_spinner").each(function() {
            $(this).spinner({
                mouseWheel: true
            });
        });

        return false;
    });

    $container.on("click", ".tbRemoveItemsRestrictionRow", function() {
        if ($(this).closest(".tbItemsRestrictionRow").siblings().length > 0) {
            $(this).closest(".tbItemsRestrictionRow").remove();
        }
    });
};

tbApp.storeInitProductListing = function($container, input_property) {

    var widgetIconListReplace = function($newIcon, $activeRow) {
        $activeRow.find(".tbIcon").removeClass("s_icon_holder s_h_26").empty().append($newIcon).end()
            .find('input[name*="button_icon"]:hidden').val($newIcon.attr("glyph_value")).end()
            .find(".tbChooseIcon").removeClass("s_plus_10").addClass("s_delete_10 tbRemoveIcon").text("Remove");
    };

    $container.on("click", ".tbChooseIcon", function() {
        if ($(this).hasClass("tbRemoveIcon")) {
            $(this).removeClass("tbRemoveIcon s_delete_10").addClass("s_plus_10").text("Choose")
                .parents(".tbIconRow").first()
                .find('input[name*="button_icon"]:hidden').val("").end()
                .find(".tbIcon").addClass("s_icon_holder s_h_26").empty();
        } else {
            tbApp.openIconManager(widgetIconListReplace, $(this).parents(".tbIconRow").first());
        }
    });

    $container.find(".tbProductWishlistButtonOptionsStyle, .tbProductCompareButtonOptionsStyle, .tbProductCartButtonOptionsStyle").each(function() {
        var $row    = $(this);
        var $select = $(this).find('select');

        $select.bind("change", function() {
            $row.next().toggleClass('tb_disabled', $select.val() == 'plain' || $select.val() == 'icon_plain');
        }).trigger("change");
    });

    $container.find(".tbProductCartButtonOptionsPosition, .tbProductCompareButtonOptionsPosition, .tbProductWishlistButtonOptionsPosition").each(function() {
        var $row    = $(this);
        var $select = $(this).find('select');

        $select.bind("change", function() {
            $row.closest('.tb_wrap').find("> :last-child").toggleClass('tb_disabled', $select.val() == '1' || $select.val() == '2');
        }).trigger("change");
    });

    tbApp.initRestrictionRows($container, input_property);
};

tbApp.storeInitSubcategories = function($container, input_property) {

    tbApp.initRestrictionRows($container, input_property);
};

})(jQuery, tbApp);