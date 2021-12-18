var list_box = $("#item_box");
var list_item = list_box.html();
var list_status = 1;

function loadData() {
    list_box.html("");
}

function changeStatus(now) {
    console.log(now);
    $("#search_box button.status").each(function (index) {
        var ss_data = $(this).attr("ss-data");
        console.log(ss_data);

        if(ss_data == now) {
            $(this).removeClass("btn-outline-primary");
            $(this).addClass("btn-primary");
        } else {
            $(this).addClass("btn-outline-primary");
            $(this).removeClass("btn-primary");
        }
    });
}

$(document).ready(function () {

    $("#search_box button.status").each(function (index) {
        var buttons = $(this);
        buttons.click(function (e) {
            list_status = $(this).attr("ss-data");
            changeStatus(list_status);
        });
    });

    loadData();
});