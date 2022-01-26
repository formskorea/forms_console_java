$(document).ready(function ($) {
    $("#work_editgo").click(function(e){
        location.href = "/work/edit/" + workno + "?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });
    $("#work_listgo").click(function(e){
        location.href = "/work/list?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });


});