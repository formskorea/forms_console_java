$(document).ready(function () {
    $("#inf_editgo").click(function(e){
        location.href = "/influencer/edit/" + infno + "?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });
    $("#inf_listgo").click(function(e){
        location.href = "/influencer/list?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });
});