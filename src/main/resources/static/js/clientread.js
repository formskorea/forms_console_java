$(document).ready(function () {
    $("#cl_editgo").click(function(e){
        location.href = "/client/edit/" + infno + "?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });
    $("#cl_listgo").click(function(e){
        location.href = "/client/list?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });
});