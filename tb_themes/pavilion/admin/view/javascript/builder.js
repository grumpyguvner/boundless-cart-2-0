(function($, tbApp) {

$.fn.proportionPanels = function($container) {

    if (!this.length || typeof $container == 'undefined') return;

    var $wrapper = this;
    var position, aX, $prev_el, $next_el,
        $current_el =  null,
        delay       = 20,
        shift       = Math.round($wrapper.width() * (1/12)),
        min_width   = 2,
        steps       = 0;

    $container.unbind(".proportionPanels");

    $container.bind("mousemove.proportionPanels", function(e) {

        if ($current_el == null) {
            return;
        }

        var delta = e.pageX - aX;

        var doMove = function(steps, direction) {

            var calculateProportion = function(proportion_arr, sequence) {
                var ratio = new Ratio(proportion_arr[0], proportion_arr[1]);

                if ((sequence == "next" && direction == "forward") || (sequence == "prev" && direction == "backward")) {
                    return ratio.subtract(1,12).simplify().toString().replace("/", "_");
                } else
                if ((sequence == "next" && direction == "backward") || (sequence == "prev" && direction == "forward")) {
                    return ratio.add(1,12).simplify().toString().replace("/", "_");
                }
            };

            var next_grid_proportion = calculateProportion($next_el.attr("grid_proportion").split("_"), 'next');
            var prev_grid_proportion = calculateProportion($prev_el.attr("grid_proportion").split("_"), 'prev');

            $next_el.attr("grid_proportion", next_grid_proportion);
            $prev_el.attr("grid_proportion", prev_grid_proportion);

            $next_el.alterClass("tb_grid_*", 'tb_grid_'+ next_grid_proportion);
            $prev_el.alterClass("tb_grid_*", 'tb_grid_' + prev_grid_proportion);

            $next_el.width($next_el.initWidth - shift * steps);
            $prev_el.width($prev_el.initWidth + shift * steps);

            var $cols = $container.find("div.s_builder_col");

            $container.find("div.s_builder_cols_grid_helper > div").eq($cols.index($next_el))
                .alterClass("tb_grid_*", 'tb_grid_'+ next_grid_proportion)
                .find("span").text(next_grid_proportion.replace("_", "/"));
            $container.find("div.s_builder_cols_grid_helper > div").eq($cols.index($prev_el))
                .alterClass("tb_grid_*", 'tb_grid_'+ prev_grid_proportion)
                .find("span").text(prev_grid_proportion.replace("_", "/"));

            $current_el.css('left', position + shift * steps);
        };

        $wrapper.css('cursor', 'e-resize');

        if (delta > delay + (shift * steps) && ($next_el.width() > min_width * shift)) {
            doMove(++steps, 'forward');
        } else
        if (delta < delay + (shift * (steps-1)) && ($prev_el.width() > min_width * shift)) {
            doMove(--steps, 'backward');
        }

    }).bind("mouseleave.proportionPanels mouseup.proportionPanels", function() {
        if ($current_el == null) {
            return;
        }

        $container.find(".s_builder_cols_grid_helper").fadeOut();
        $wrapper.css('cursor', 'default');
        $current_el.removeClass("tb_dragging");
        $current_el = null;
        steps = 0;
    });

    this.find("div.tb_drag_handle").remove();
    this.css("position", "relative");

    if (this.find("> div.s_builder_col").length == 6) {
        return;
    }

    this.find("> div.s_builder_col").each(function() {
        if (!$(this).next("div").is(".tb_drag_handle") && !$(this).is(":last-child")) {
            $('<div class="tb_drag_handle" style="position: absolute;"><div class="tb_drag_area"></div></div>')
                .insertAfter(this)
                .css("left", $(this).position().left + $(this).outerWidth(true))
                .bind("mousedown", function(e) {
                    $current_el = $(this);

                    $current_el.addClass("tb_dragging");

                    $prev_el = $current_el.prev("div");
                    $prev_el.initWidth = $prev_el.outerWidth();

                    $next_el = $current_el.next("div");
                    $next_el.initWidth = $next_el.outerWidth();

                    position = $current_el.position().left;
                    aX = e.pageX;

                    $container.find(".s_builder_cols_grid_helper").fadeIn();
                });
        }
    });
};

function checkLockedWidgets() {
    var currentTab = $("#tb_cp_panel_layout_builder").find("> .tb_tabs > div:visible");

    $("#tb_cp_layout_builder_widgets_panel").find("div.s_builder_row_widgets_listing div.tbWidget").each(function() {
        if ($(this).is(".tbWidgetLocked")) {
            var lockedWidget = currentTab.find('div[name_id="' + $(this).attr("name_id") + '"]');

            if (lockedWidget.length) {
                lockedWidget.addClass("tbWidgetLocked").find("a.tbWidgetDuplicate").hide();
                $(this).draggable("disable");
            } else {
                $(this).draggable("enable");
            }
        }
    });
}

function initWidgetsPanel() {

    var options = {
        helper: "clone",
        connectToSortable: $("#tb_cp_panel_layout_builder").find("div.s_builder_col"),
        handle: "h3"
    };

    $("#tb_cp_layout_builder_widgets_panel").find("div.s_builder_row_widgets_listing div.tbWidget").draggable(options);
    checkLockedWidgets();
}

function initWidget($widget) {

    $widget.find("> div.s_widget_actions a.s_button_remove_widget").bind("click", function() {
        if (confirm('Are you sure?')) {
            $widget.fadeOut(400, function() {
                $widget.remove();
                checkLockedWidgets();
            });
        }

        return false;
    });

    var getAreaSettings = function($editElement) {
        var settings = "";
        var query    = $.jurlp($editElement.attr("href")).query();
        var $inputs  = $("#style_settings_" + query.area_name).find(":input");

        if ($inputs.length && query.area_type == $inputs.filter('input[name="area_type"]').val() && query.area_id == $inputs.filter('input[name="area_id"]').val()) {
            settings = JSON.stringify($inputs.serializeJSON());
        }

        return settings;
    };

    $widget.find("> div.s_widget_actions .tbEditWidget").sModal({
        width:  800,
        height: 620,
        fixed:  false,
        requestMethod: "POST",
        requestData: function() {
            return {
                settings:      $widget.find("> textarea.widget_settings").text(),
                row_settings:  $widget.parents(".tbBuilderRow").first().find(".tbBuilderRowSettings").text(),
                area_settings: getAreaSettings($(this)),
                theme_colors:  JSON.stringify($("#colors_form_rows").find(':input[name^="colors"]').serializeJSON())
            };
        },
        onShow: function(obj) {
            obj.find(".tbWidgetUpdate").bind("click", function() {
                var query = $.jurlp($widget.find("> div.s_widget_actions .tbEditWidget").attr("href")).query();

                $(this).parents("form").first().ajaxSubmit({
                    dataType: 'json',
                    data: {
                        area_name:     $widget.closest(".tbRowsContainer").attr("widget_area"),
                        area_type:     query.area_type,
                        area_id:       query.area_id,
                        row_settings:  $widget.parents(".tbBuilderRow").first().find(".tbBuilderRowSettings").text(),
                        area_settings: getAreaSettings($widget.find("> div.s_widget_actions .tbEditWidget")),
                        theme_colors:  JSON.stringify($("#colors_form_rows").find(':input[name^="colors"]').serializeJSON())
                    },
                    beforeSerialize: function() {
                        obj.find("div.sm_content").first().block({ message: '<h1>Updating block settings</h1>' });
                        for (var instance in CKEDITOR.instances)
                            CKEDITOR.instances[instance].updateElement();
                        $(tbApp).trigger("tbWidget:onUpdate", [$widget]);

                        return true;
                    },
                    success: function(result) {
                        $widget
                            .find("> h3").html(result.title).end()
                            .find("> textarea.widget_settings").text(result.data).end()
                            .find("> input.tbWidgetDirty").val(1);
                        setTimeout(function() {
                            obj.find("div.sm_content").first().unblock();
                            obj.close();
                        },500);
                    }
                });

                return false;
            });

            var initWidgetMainTabs = function($tab, $panel) {

                if ($tab.hasAttr("add_modal_class")) {
                    obj.getContents().addClass("sm_wide");
                } else {
                    obj.getContents().removeClass("sm_wide");
                }

                if ($tab.data("initialized")) {
                    return;
                }

                $tab.data("initialized", true);

                if (!$panel.hasClass("tbWidgetCommonOptions") && !$panel.hasClass("tbNoBeautify")) {
                    beautifyForm($panel);
                    return;
                }

                var update_preview_box = false;
                var initCommonOptionsSection = function($ctab, $cpanel) {
                    if ($ctab.data("initialized")) {
                        return;
                    }

                    beautifyForm($cpanel);

                    tbApp.initStyleSection($ctab.attr("section"), "widget", "widget_data[common]");

                    $ctab.data("initialized", true);

                    if (!update_preview_box) {
                        tbApp.updatePreviewBox("widget");
                    }
                    update_preview_box = true;
                };

                $panel.find("div.tbWidgetCommonOptionsTabs").first().tabs({
                    activate: function(event, ui) {
                        initCommonOptionsSection(ui.newTab.find("a"), ui.newPanel);
                    },
                    create: function(event, ui) {
                        initCommonOptionsSection(ui.tab.find("a"), ui.panel);
                    }
                });
            };

            obj.find("div.tbWidgetMainTabs").first().tabs({
                activate: function(event, ui) {
                    initWidgetMainTabs(ui.newTab.find("a"), ui.newPanel);
                },
                create: function(event, ui) {
                    initWidgetMainTabs(ui.tab.find("a"), ui.panel);
                }
            });
        },
        onClose: function(obj) {
            $(tbApp).trigger("tbWidget:closeForm", [$widget]);
            obj.find("div.colorSelector").each(function() {
                $("#" + $(this).data("colorpickerId")).remove();
            });
            obj.find("div.s_widget_options_holder").first().trigger("closeWindow", [obj]);
        }
    });

    $widget.find("> div.s_widget_actions a.tbWidgetDuplicate").bind("click", function() {
        if (!confirm('Are you sure?')) {
            return false;
        }

        var new_id = $widget.attr("id").replace(/(.*)_(.*)/, "$1_" + tbHelper.generateUniqueId(8));
        var newWidget = $($widget.outerHTML());

        newWidget.attr("id", new_id);
        newWidget.find("div.s_widget").each(function() {
            $(this).attr("id", $(this).attr("id").replace(/(.*)_(.*)/, "$1_" + tbHelper.generateUniqueId(8)));
        });
        newWidget.insertAfter($widget);
        initWidget(newWidget);

        newWidget.find("div.s_widget").each(function() {
            initWidget($(this));
        });

        return false;
    });

    if ($widget.is(".tbGroupWidget")) {
        initGroupWidget($widget);
    }
}

function initGroupWidget($widget) {
    $widget.find("a.s_button_add_subwidgets").bind("click", function() {

        var $div_cols = $widget.parents(".tbBuilderRow").first().find("> div.s_builder_cols").first();

        var disableRow = function() {
            $widget.hide();
            $("#tb_cp_layout_builder_widgets_panel").find("div.s_builder_row_widgets_listing  div.tbGroupWidget").hide();
        };

        var enableRow = function() {
            $widget.show();
            $("#tb_cp_layout_builder_widgets_panel").find("div.s_builder_row_widgets_listing  div.tbGroupWidget").show();
            initWidgetsPanel();
        };

        var $group_widget = $($("#group_widget_template").text()).insertAfter($widget);

        $widget.find("div.s_widget_subwidgets > div.s_widget").each(function() {
            $group_widget.find("div.s_widget_subwidgets").append($(this));
        });

        var $container = $widget.parents(".s_builder_wrap").first();

        $container.find("div.s_builder_col").sortable({
            connectWith: $container.find("div.s_widget_subwidgets, div.s_builder_col")
        });

        $group_widget.find("div.s_widget_subwidgets").sortable({
            connectWith: $container.find("div.s_widget_subwidgets, div.s_builder_col"),
            stop: function(event, ui) {
                if (ui.item.is("[id_prefix]")) {
                    ui.item.attr("id", ui.item.attr("id_prefix") + "_" + tbHelper.generateUniqueId(8));
                    ui.item.removeAttr("id_prefix");
                    initWidget(ui.item);
                    ui.item.attr("new_subwidget", 1);
                    checkLockedWidgets();
                }

                var $panel = $container.parent();

                ui.item.find("a.tbEditWidget").jurlp("query", {
                    area_name: $panel.find('input[name="area_name"]').val(),
                    area_type: $panel.find('input[name="area_type"]').val(),
                    area_id:   $panel.find('input[name="area_id"]').val()
                });
            }
        });

        $("#tb_cp_layout_builder_widgets_panel").find("div.s_builder_row_widgets_listing  div.s_widget").draggable({
            connectToSortable: $container.find("div.s_widget_subwidgets, div.s_builder_col")
        });

        disableRow();

        $group_widget.find("a.button_update").bind("click", function() {
            $group_widget.find("div.s_widget_subwidgets > div.s_widget").each(function() {
                $(this).removeAttr("new_subwidget");
                $widget.find("div.s_widget_subwidgets").append($(this));
            });
            $group_widget.remove();
            enableRow();

            return false;
        });
    });
}

function changeGridProportion($row, columns_num) {

    $row.find("div.s_builder_cols_wrap > div.s_builder_col").alterClass("tb_grid_*");

    var $cols_wrap = $row.find("div.s_builder_cols_wrap").first();
    var proportions = [];

    if (columns_num != 5) {
        for (var i = 1; i <= columns_num; i++) {
            proportions.push("1_" + columns_num);
        }
    } else {
        proportions = ["1_3", "1_6","1_6","1_6","1_6"];
    }

    $.each(proportions, function(index, value) {
        $cols_wrap.find(" > div.s_builder_col").eq(index)
            .addClass("tb_grid_" + value)
            .attr("grid_proportion", value);
        $row.find("div.s_builder_cols_grid_helper > div").eq(index).alterClass("tb_grid_*", "tb_grid_" + value).find("span").text(value.replace("_", "/"));
    });

    if (columns_num > 1 && columns_num < 6) {
        $row.find("div.s_builder_cols_wrap").first().proportionPanels($row);
    } else {
        $row.find("div.tb_drag_handle").remove();
    }
}

function initRow($row, $container) {

    $row.find("a.tbBuilderRowRemove").bind("click", function() {
        if (confirm('Are you sure?')) {
            $row.fadeOut(400, function() {
                var $parent_container = $row.parent("div.builder_container");
                $row.remove();
                reArrangeRows($parent_container);
            });
        }

        return false;
    });

    $row.find("a.tbBuilderRowCustomProportions").bind("click", function() {
        var default_proportions = [];

        $row.find(".s_builder_cols_grid_helper > div > span").each(function() {
            default_proportions.push($(this).text());
        });

        var proportions = prompt("Custom row proportions", default_proportions.join(" + "));

        if (null !== proportions) {

            proportions = proportions.split("+").map(function (str) {
                return str.trim();
            });

            var error = null,
                invalid_fractions = null,
                sum = 0,
                is_12_grid = true;

            if (proportions.length == 1 && proportions[0] == 1) {
                sum = 1;
            } else {
                var valid_fractions = ["1/2", "1/3", "2/3", "1/4", "3/4", "1/5", "2/5", "3/5", "4/5", "1/6", "5/6", "1/8", "3/8", "5/8", "7/8", "1/12", "5/12", "7/12", "11/12"];

                $.each(proportions, function(index, value) {
                    var splited = value.split('/');

                    if (splited.length != 2 || parseInt(splited[0]) != Math.abs(Number(splited[0])) || parseInt(splited[1]) != Math.abs(Number(splited[1])) || splited[0] == 0 || splited[1] == 0) {
                        error = 'Wrong proportion format detected. Each proportion must be defined like x/y, where x and y must be positive integers.';

                        return false;
                    }

                    if (-1 == valid_fractions.indexOf(value)) {
                        error = "Invalid fractions detected:\n";
                        if (null === invalid_fractions) {
                            invalid_fractions = [];
                        }
                        invalid_fractions.push(value);
                    }

                    var numerator   = Number(splited[0]);
                    var denominator = Number(splited[1]);

                    sum += numerator / denominator;

                    if (12 % denominator != 0) {
                        is_12_grid = false;
                    }
                });

                if (sum == 0.9999999999999999) {
                    sum = 1;
                }
            }

            if (null === error && sum != 1) {
                error = 'The sum of the proportions must be equal to 1';
            }

            if (null !== error) {
              if (null !== invalid_fractions) {
                  error += invalid_fractions.join("  ") + "\n Please, refer to the documentation to review which fractions you can use";
              }
              alert(error);

              return false;
            }

            var $col_input = $row.find("div.tb_columns_num input");
            var cols_num = Number($col_input.val());

            if (proportions.length != cols_num) {
                if (proportions.length > cols_num) {
                    for (var i = 0; i < proportions.length - cols_num; i++) {
                        changeColumnsNum($col_input[0], "++");
                    }
                } else {
                    for (var i = 0; i < cols_num - proportions.length; i++) {
                        changeColumnsNum($col_input[0], "--");
                    }
                }
            }

            if (proportions.length == 1 && proportions[0] == 1) {
                return;
            }

            $.each(proportions, function(index, value) {
                $row.find("div.s_builder_cols_wrap").first()
                    .find(" > div.s_builder_col").eq(index)
                    .alterClass("tb_grid_*")
                    .addClass("tb_grid_" + value.replace("/", "_"))
                    .attr("grid_proportion", value.replace("/", "_"));
                $row.find("div.s_builder_cols_grid_helper > div").eq(index).alterClass("tb_grid_*", "tb_grid_" + value.replace("/", "_")).find("span").text(value);
            });

            if (is_12_grid && cols_num < 6) {
                $row.find("div.s_builder_cols_wrap").first().proportionPanels($row);
            } else {
                $row.find("div.tb_drag_handle").remove();
            }
        }

        return false;
    });

    $row.find("a.tbBuilderRowDuplicate").bind("click", function() {
        if (!confirm('Are you sure?')) {
            return false;
        }

        var newRow = $($row.outerHTML());
        var new_id = tbHelper.generateUniqueId(6);

        newRow.attr("id", "row_" + new_id).attr("idstr", new_id);
        newRow.find("div.s_widget").each(function() {
            if ($(this).is(".tbWidgetLocked")) {
                $(this).remove();
            } else {
                $(this).attr("id", $(this).attr("id").replace(/(.*)_(.*)/, "$1_" + tbHelper.generateUniqueId(8)));
            }
        });
        newRow.find('input[id^="columns_num_"]').attr("id", "columns_num_" + new_id);
        newRow.find("a.tbBuilderRowEdit").jurlp("query", {row_id: new_id});
        newRow.find('div[id^="builder_col_"]').each(function() {
            $(this).attr("id", $(this).attr("id").replace(/builder_col_(.*)_(.*)/, "builder_col_$1_" + new_id + "_$2"));
        });

        newRow.insertAfter($row);
        initRow(newRow, $container);
        initWidgetsPanel();
        reArrangeRows($row.parent("div.builder_container"));

        return false;
    });

    $row.find("> div.s_builder_cols div.s_widget").each(function() {
        initWidget($(this));
    });

    var initSortables = function() {

        $container.find("div.s_builder_col").sortable({
            handle: "h3",
            cancel: ".ui-state-disabled",
            connectWith: $container.find("div.s_builder_col"),
            stop: function(event, ui) {
                if (ui.item.is("[id_prefix]")) {
                    ui.item.attr("id", ui.item.attr("id_prefix") + "_" + tbHelper.generateUniqueId(8));
                    ui.item.removeAttr("id_prefix");
                    initWidget(ui.item);
                    checkLockedWidgets();
                }

                var $panel = $container.closest(".tbBuilderPanel");

                ui.item.find("a.tbEditWidget").jurlp("query", {
                    area_name: $panel.find('input[name="area_name"]').val(),
                    area_type: $panel.find('input[name="area_type"]').val(),
                    area_id:   $panel.find('input[name="area_id"]').val()
                });
            }
        }).disableSelection();

        $row.find("div.s_sortable_holder").first().sortable({
            handle: "span.s_drag_area",
            axis: "y"
        });

    };
    initSortables();

    var changeColumnsNum = function(el, operation) {
        if (operation == '++' && el.value < 6) {
            el.value++;
        } else
        if (operation == '--' && el.value > 1) {
            el.value--;
        } else {
            return;
        }
        $(el).attr("value", el.value);

        var cnt = el.value;
        var div_cnt = $row.find("div.s_builder_cols_wrap > div.s_builder_col").length;
        var alter_cnt = Math.abs(parseInt(cnt) - parseInt(div_cnt));

        for (var i = 0; i < alter_cnt; i++) {
            if (cnt > div_cnt) {
                $row.find("div.s_builder_cols_wrap").append('<div class="s_builder_col"></div>');
                $row.find("div.s_builder_cols_grid_helper").append('<div class="tb_grid_1_3"><span>1/3</span></div>');
            } else {
                $row.find("div.s_builder_cols_wrap > div.s_builder_col").eq(div_cnt-i-1).remove();
                $row.find("div.s_builder_cols_grid_helper > div").eq(div_cnt-i-1).remove();
            }
        }

        changeGridProportion($row, cnt);
        if (operation == '++' && el.value <= 6) {
            initWidgetsPanel();
            initSortables();
            $container.find("div.group_widget_container_interface").each(function() {
                $(this).find("a.button_update").trigger("click");
            });
        }
    };

    $row.find("div.tb_columns_num").first().find("a.tb_button_increase").bind("click", function() {
        changeColumnsNum($(this).next("input")[0], "++");
    }).end().find("a.tb_button_decrease").bind("click", function() {
        changeColumnsNum($(this).prev("input")[0], "--");
    });

    var show_drag_handles = true;

    $row.find(".s_builder_col").each(function() {
        if (12 % Number($(this).attr("grid_proportion").split("_")[1]) != 0) {
            show_drag_handles = false;
        }
    });

    if (show_drag_handles) {
        $row.find("div.s_builder_cols_wrap").first().proportionPanels($row);
    }

    var getAreaSettings = function($editElement) {
        var area_settings = "";
        var $inputs = $("#style_settings_" + $container.attr("widget_area")).find(":input");
        var query   = $.jurlp($editElement.attr("href")).query();

        if ($inputs.length && query.area_type == $inputs.filter('input[name="area_type"]').val() && query.area_id == $inputs.filter('input[name="area_id"]').val()) {
            area_settings = JSON.stringify($inputs.serializeJSON());
        }

        return area_settings;
    };

    $row.find("a.tbBuilderRowEdit").first().sModal({
        width:  800,
        height: 620,
        fixed:  false,
        requestMethod: "POST",
        requestData: function() {
            return {
                settings:      $row.find("textarea.tbBuilderRowSettings").text(),
                area_settings: getAreaSettings($(this)),
                theme_colors:  JSON.stringify($("#colors_form_rows").find(':input[name^="colors"]').serializeJSON())
            };
        },
        onShow: function(obj) {
            obj.find("a.update_settings").bind("click", function() {
                obj.find("div.sm_content").first().block({ message: '<h1>Updating row settings</h1>' });

                var query   = $.jurlp($row.find("a.tbBuilderRowEdit").first().attr("href")).query();

                $(this).parents("form").first().ajaxSubmit({
                    data: {
                        area_name:     $container.attr("widget_area"),
                        area_id:       query.area_id,
                        area_type:     query.area_type,
                        area_settings: getAreaSettings($row.find("a.tbBuilderRowEdit").first()),
                        theme_colors:  JSON.stringify($("#colors_form_rows").find(':input[name^="colors"]').serializeJSON())
                    },
                    success: function(data) {
                        $row.find("textarea.tbBuilderRowSettings").text(data);
                        setTimeout(function() {
                            obj.find("div.sm_content").first().unblock();
                            obj.close();
                        },500);
                    }
                });

                return false;
            });

            var $panel = $container.parent();
            var comboBox = tbApp.builderComboBoxFactory($panel, $panel.find(".tbRowsContainer").attr("widget_area"));
            var modalLabel = $panel.find(".tbAreaName").text() + " Area > ";
            var pageType = comboBox.getPageType();

            if (pageType != "") {
                modalLabel += pageType + " ";
            }

            modalLabel += comboBox.getLabel() + " > Row " + $row.find(".row_order").text();
            obj.find(".sm_title span").text(modalLabel);

            var update_preview_box = false;
            var initCommonOptionsSection = function($tab, $panel) {
                if ($tab.data("initialized")) {
                    return;
                }

                beautifyForm($panel);

                if ($tab.attr("section") == "layout") {
                    $panel.find('select[name$="[layout][type]"]').bind("change", function() {

                        var $inputs = $panel.find(".tbPaddingWrap input");

                        $inputs.filter('[name$="[inner_padding]"]').parent().parent().toggle($(this).val() == "separate" || $(this).val() == "no_max_width tb_row_separate");
                        $inputs.filter(':not([name$="[inner_padding]"])').parent().parent().toggle($(this).val() != "separate" && $(this).val() != "no_max_width tb_row_separate");
                    }).trigger("change");
                }

                tbApp.initStyleSection($tab.attr("section"), "widgets_row", "widgets_row");
                $tab.data("initialized", true);

                if (!update_preview_box) {
                    tbApp.updatePreviewBox("widgets_row");
                }

                update_preview_box = true;
            };

            obj.find("div.tbWidgetsRowMainTabs").first().tabs({
                activate: function(event, ui) {
                    initCommonOptionsSection(ui.newTab.find("a"), ui.newPanel);
                },
                create: function(event, ui) {
                    initCommonOptionsSection(ui.tab.find("a"), ui.panel);
                }
            });
        },
        onClose: function(obj) {
            obj.find("div.colorSelector").each(function() {
                $("#" + $(this).data("colorpickerId")).remove();
            });
            obj.find("div.s_widget_options_holder").first().trigger("closeWindow", [obj]);
        }
    });
}

function reArrangeRows($container) {

    var $rows = $container.find("> .tbBuilderRow");

    $rows.each(function() {
        var row_index = $rows.index(this);
        $(this).find("span.row_order").first().text(parseInt(row_index) + 1);
    });
}

var comboBoxConstructor = function($panel, widget_area) {

    return {
        token:       Math.floor((Math.random()*99)+1),
        panel:       $panel,
        widget_area: widget_area,
        contents:    {},
        comboBox:    {},
        pageType:    "",
        currentItem: null,

        create: function() {
            return this;
        },

        afterBuilderTabSave: function(data) {
            if (typeof this.currentItem.key == "undefined" || this.comboBox.getContentsElement().find(".tbModifiedMenu [" + this.currentItem.key + "_id='" + this.currentItem.optionValue + "']").length == 0) {
                this.reloadModified();
            }
            this.panel.find(".tbRecordInfoMessage1").hide();

            if (typeof data.override_msg != "undefined" && data.override_msg != "") {
                this.panel.find(".tbRecordInfoMessage2").show().find(".tbOverrideMsg").text(data.override_msg);
            }
        },

        init: function() {

            var self = this;

            self.contents = this.panel.find(".tbComboBoxRow");
            self.comboBox = self.contents.find("select.tbComboBox").tbComboBox({
                $contents: self.contents,
                select:    $.proxy(self, "_onMenuItemSelect"),
                remove:    $.proxy(self, "_onMenuItemRemove")
            }).data("uiTbComboBox");
            self.checkOpenCartWidgetsMatch();

            if (self.currentItem === null) {
                var area_id = self.comboBox.getContentsElement().find("input[name='area_id']").val();
                var $option = self.comboBox.getContentsElement().find("option[value='" + area_id + "']");

                self.currentItem = {
                    option:      $option[0],
                    key:         self.comboBox.getContentsElement().find("input[name='area_type']").val(),
                    label:       $option.text(),
                    optionValue: area_id,
                    remove:      false,
                    value:       $option.text()
                };
            }

            return self;
        },

        loadSettingsData: function(type, record_id) {

            var self = this;
            var chosen = self.comboBox.parent.exportValue();
            var pageType = self.pageType != "" ? self.pageType + ":" : "";

            self.panel.block();

            return $.get($sReg.get('/tb/url/layoutBuilder/areaBuilder') + "&area_name=" + self.widget_area + "&area_type=" + type + "&area_id=" + record_id, function(data) {
                self.panel.empty().append(data).unblock();
                tbApp.initBuilderTab(self.panel);
                self.comboBox.parent.importValue(chosen);
                self.contents.find(".tbPageType").text(pageType);

                var settings_label;

                if (typeof chosen.custom != "undefined") {
                    settings_label = pageType + " " + chosen.custom;
                } else {
                    settings_label = self.comboBox.element.find('option[value="' + chosen.value + '"]').text();
                }

                self.panel.find(".tbRecordInfoMessage1, .tbRecordInfoMessage2").find(".tbPageDescription").text(settings_label);
            });
        },

        reloadModified: function() {

            var self = this;
            var url = $sReg.get('/tb/url/layoutBuilder/modifiedMenu') + "&area_name=" + self.widget_area + "&record_type=rows";

            $.get(url, function(modified_menu) {
                self.comboBox.modifiedMenu = undefined;
                self.contents.find(".tbModifiedMenu").remove();
                self.contents.append(modified_menu);
            });
        },

        reloadSystemBlocks: function(area_type, area_id) {

            $("#layout_builder_widgets_blocks").block();

            if (typeof area_type == "undefined") {
                area_type = this.comboBox.parent.value();
            }

            if (typeof area_id == "undefined") {
                area_id = this.comboBox.parent.value();
            }

            return $.get($sReg.get('/tb/url/layoutBuilder/systemBlocks') + "&area_name=" + this.widget_area + "&area_type=" + area_type + "&area_id=" + area_id, function(data) {
                if (data.trim() == "") {
                    data = "<p>There are no system blocks for the current area.</p>";
                }
                $("#layout_builder_widgets_blocks").find(".tbSystemWidgetsList").html("<div>" + data + "</div>");
                initWidgetsPanel();
                $("#layout_builder_widgets_blocks").unblock();
            });
        },

        getPageType: function() {
            return this.contents.find(".tbPageType").text();
        },

        getLabel: function() {
            return this.comboBox.label();
        },

        setMenuItem: function(uiItem) {

            if ($(uiItem.element).is("option")) {
                this.pageType = "";
            } else {
                switch (uiItem.key) {
                    case "category":
                        this.pageType = "Category";
                        break;
                    case "page":
                        this.pageType = "Information page";
                        break;
                    case "layout":
                        this.pageType = "Layout";
                        break;
                    case "system":
                        this.pageType = "System page";
                        break;
                }
            }

            this.currentItem = uiItem;
            this.contents.find('input[name="area_id"]').val(uiItem.optionValue);

            return this.reloadSystemBlocks(uiItem.key, uiItem.optionValue);
        },

        checkOpenCartWidgetsMatch: function() {
            $panel.find(".s_widget[id^='Theme_OpenCartWidget']").each(function() {
                var name = $(this).find("> h3").first().text();
                var is_missing = true;

                $("#layout_builder_widgets_modules .tbWidget > h3").each(function() {
                    if ($(this).text() == name) {
                        is_missing = false;
                        return false;
                    }
                });
                if (is_missing) {
                    $(this).addClass("tb_block_missing")
                        .find("> h3").prepend("*missing* ").end()
                        .find(".tbEditWidget, .tbWidgetDuplicate").remove();
                }
            });
        },

        _onMenuItemSelect: function(event, ui) {
            var self = this;

            $.when(this.setMenuItem(ui.item), this.loadSettingsData(ui.item.key, ui.item.optionValue)).done(function() {
                var removed = false;

                $panel.find(".tbBuilderRow").each(function() {
                    var $row = $(this);

                    $row.find(".s_widget").each(function() {
                        var class_name = $(this).attr("id").slice(0, $(this).attr("id").lastIndexOf("_"));

                        if (class_name == 'Theme_SystemWidget' && !$("#layout_builder_widgets_blocks").find(".tbSystemWidgetsList .s_widget[name_id='" + $(this).attr("name_id") + "']").length) {
                            removed = true;
                            $(this).remove();
                        }
                    });
                    if (removed && !$row.find(".s_widget").length) {
                        $row.remove();
                    }
                });
                if (removed) {
                    $panel.find(".tbRecordInfoMessage1 p").append(" The non-compatible system blocks have been removed.");
                }

            });
            ui.context.blur();
        },

        _onMenuItemRemove: function(event, ui) {

            var item = ui.item;
            var self = this;

            if (!confirm('Delete "' + item.label + '" configuraiton. Are you sure ?')) {
                return false;
            }

            var current_key = typeof self.currentItem.key != "undefined" ? self.currentItem.key : item.key;
            var current_value = typeof self.currentItem.optionValue != "undefined" ? self.currentItem.optionValue : item.optionValue;
            var params = {
                area_name         : self.widget_area,
                area_type         : item.key,
                area_id           : item.optionValue,
                current_area_type : current_key,
                current_area_id   : current_value,
                record_type       : "rows"
            };

            $.getJSON($sReg.get('/tb/url/layoutBuilder/removeSettings') + "&" + $.param(params), function(response) {
                if (item.optionValue == ui.context.value() || response.reload == 1) {
                    self.loadSettingsData(current_key, current_value);
                } else {
                    self.reloadModified();
                    ui.context.blur();
                }
            });

            return false;
        }
    }
};

tbApp.builderComboBoxFactoryInstances = [];
tbApp.builderComboBoxFactory = function($panel, widget_area) {

    if (typeof tbApp.builderComboBoxFactoryInstances[widget_area] == "undefined") {
        tbApp.builderComboBoxFactoryInstances[widget_area] = comboBoxConstructor($panel, widget_area).create();
    }

    return tbApp.builderComboBoxFactoryInstances[widget_area];
};

tbApp.builderCollectRowsData = function($panel) {

    var $container = $panel.find("div.builder_container").first();
    var rows = $container.sortable("toArray");
    var data = {};

    data.rows      = [];
    data.area_name = $container.attr("widget_area");
    data.area_type = $panel.find(':input[name="area_type"]').val();
    data.area_id   = $panel.find(':input[name="area_id"]').val();

    $.each(rows, function(index, value) {
        var $row = $("#" + value);
        var columns_data = {};

        $row.find("div.s_builder_col").each(function(iindex) {
            var columns = $(this).sortable("toArray");

            columns_data[iindex] = {};
            columns_data[iindex].widgets = [];
            columns_data[iindex].grid_proportion = $(this).attr("grid_proportion");

            $.each(columns, function(iiindex, vvalue) {

                if (vvalue == "") {
                    // This happens if a group widget is opened
                    return true;
                }

                var $widget = $("#" + vvalue);
                if (!$widget.find("> input.tbWidgetDirty").length) {
                    alert("There is no dirty data indicator field for the widget " + vvalue);
                }
                var widget_data = {
                    id: vvalue,
                    settings: $widget.find("> textarea.widget_settings").text(),
                    is_dirty: $widget.find("> input.tbWidgetDirty").val()
                };

                if ($widget.is(".tbGroupWidget")) {
                    var subwidgets = [];

                    $widget.find("div.s_widget_subwidgets > div.s_widget").each(function() {
                        subwidgets.push({
                            id:       $(this).attr("id"),
                            settings: $(this).find("> textarea.widget_settings").val(),
                            is_dirty: $(this).find("> input.tbWidgetDirty").val()
                        });
                    });

                    if (subwidgets.length) {
                        widget_data.subwidgets = subwidgets;
                    }
                }

                columns_data[iindex].widgets.push(widget_data);
            });
        });

        data.rows.push({
            id:             $row.attr("idstr"),
            columns:        columns_data,
            columns_number: $("#columns_num_" + $row.attr("idstr")).val(),
            settings:       $row.find("textarea.tbBuilderRowSettings").first().text()
        });
    });

    return data;
};

tbApp.initBuilderTab = function($panel) {

    var $container = $panel.find("div.builder_container").first();

    initWidgetsPanel();

    $container.sortable({
        handle: "div.s_builder_row_header > h3",
        stop: function() {
            reArrangeRows($container);
        }
    });

    $container.find("> .tbBuilderRow").each(function() {
        initRow($(this), $container);
    });

    $panel.find(".tbCopyArea").bind("click", function() {
        if (confirm("Are you sure?")) {
            $.getJSON($(this).attr("href"), { new_store_id: $(this).siblings("select").val() });
        }

        return false;
    });

    $panel.find(".tbDeleteArea").bind("click", function() {
        if (confirm("Are you sure?")) {
            var remove_url = $(this).attr("href");
            var comboBox = tbApp.builderComboBoxFactoryInstances[$.jurlp(remove_url).query().area_name];


            $.getJSON(remove_url, function() {
             comboBox.loadSettingsData(comboBox.currentItem.key, comboBox.currentItem.optionValue);
            });
        }

        return false;
    });

    $panel.find(".tbNewWidgetsRow").bind("click", function() {
        var area_name = $panel.find(".tbRowsContainer").attr("widget_area");
        var area_type = $panel.find('input[name="area_type"]').val();
        var area_id   = $panel.find('input[name="area_id"]').val();

        var area_settings = "";
        var $inputs  = $("#style_settings_" + area_name).find(":input");

        if ($inputs.length && area_type == $inputs.filter('input[name="area_type"]').val() && area_id == $inputs.filter('input[name="area_id"]').val()) {
            area_settings = JSON.stringify($inputs.serializeJSON());
        }

        var $add_button = $(this);

        $add_button.after('<span class="tb_loading_inline"></span>');

        $.post($sReg.get('/tb/url/layoutBuilder/getNewWidgetRow') + '&area_name=' + area_name + '&area_type=' + area_type + '&area_id=' + area_id, {
                area_settings: area_settings,
                theme_colors:  JSON.stringify($("#colors_form_rows").find(':input[name^="colors"]').serializeJSON())
            }, function(data) {
                var $row = $(data);

                $row.appendTo($container);
                reArrangeRows($container);
                initRow($row, $container);
                initWidgetsPanel();
                beautifyForm($row);
                $add_button.next('.tb_loading_inline').remove();
            }
        );

        return false;

    });

    var comboBox = tbApp.builderComboBoxFactory($panel, $container.attr("widget_area")).init().comboBox;

    var inherit_key = $panel.find("input[name='inherit_key']").val();

    if (inherit_key != "") {
        $panel.find(".tbRecordInfoMessage1 .tbParentArea")
            .wrap("<a class='tbChangeContent' href='javascript:;'></a>").end()
            .find("a.tbChangeContent").bind("click", function() {

                var inherit_area_type, inherit_area_id, label;

                if (inherit_key.indexOf("category_level_") == 0) {
                    inherit_area_type = 'category';
                    inherit_area_id = inherit_key.substring(9);
                    label = "Level " + inherit_area_id.substring(6) + " categories";
                } else
                if (inherit_key.indexOf("category_global") == 0) {
                    inherit_area_type = 'category';
                    inherit_area_id = 'category_global';
                    label = "All categories";
                } else
                if (inherit_key.indexOf("layout_") == 0) {
                    inherit_area_type = 'layout';
                    inherit_area_id = inherit_key.substring(7);
                    label = $panel.find(".tbLayoutMenu a[layout_id='" + inherit_area_id + "']").text();
                } else
                if (inherit_key.indexOf("global") == 0) {
                    inherit_area_type = 'global';
                    inherit_area_id = 'global';
                    label = "GLOBAL";
                }

                comboBox.parent.value(label, true, inherit_area_id);
                comboBox.parent._trigger("select", null, {
                    item: {
                        element:     null,
                        key:         inherit_area_type,
                        label:       label,
                        optionValue: inherit_area_id,
                        value:       label
                    },
                    context: comboBox
                });
            });
    }
};

tbApp.initBuilderSection = function($tab, $panel) {

    var section = $tab.attr("aria-controls");

    if (!section || $tab.data("initialized") || !/[\S]/.test($("#" + section).html())) {
        return;
    }

    $tab.data("initialized", true);
    tbApp.initBuilderTab($panel);

    $(tbApp).on("tbCp:saveBuilderTab", function(event, config) {

        if (section != config.section) {
            return;
        }

        $(tbApp).trigger("tbCp:builderBeforeSave", [config]);

        $panel.block({ message: '<h1>Saving settings</h1>' }).find("div.group_widget_container_interface").each(function() {
            $(this).find("a.button_update").trigger("click");
        });

        var data = tbApp.builderCollectRowsData($panel);

        $.post($sReg.get('/tb/url/layoutBuilder/saveRows'), data, function(data) {
            $panel.unblock();
            tbApp.builderComboBoxFactory($panel, $panel.find("div.builder_container").first().attr("widget_area")).afterBuilderTabSave(data);
            $(tbApp).trigger("tbCp:builderAfterSave", [data, config]);
        }, "json");
    });

}

})(jQuery, tbApp);