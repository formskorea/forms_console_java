var list_box = $("#item_box");
var list_item = list_box.html();
var loading_box = $("#loading_box");
var empty_box = $("#empty_box");
var page_box = $("#page_box");
var list_status = 1;
var now_limit = 0;
var now_length = 10;
var now_page = 1;
var paging_size = 5;

list_box.html("");
page_box.html("");

function paging(maxsize) {
    var startPage	= 1,
        endPage		= 1,
        html = "";

    startPage = now_page - Math.floor(paging_size / 2);
    startPage = startPage <= 0 ? 1 : startPage;
    endPage = startPage + paging_size >= maxsize ? maxsize : (startPage + paging_size - 1);
    startPage = maxsize == endPage && (maxsize - paging_size) > 1 ? maxsize - paging_size : startPage;

    for(var i = startPage; i <= endPage; i++) {
        html += "<li class=\"page-item "+ (i == now_page ? "active" : "") +"\"><a href=\"#\" class='page-link' aria-label=\"" + i + "\">"+ i +"</a></li>";
    }

    //nav add
    if(maxsize > paging_size) {
        if(startPage != 1) {
            html = "<li class='page-item'><a href=\"#\" class='page-link' aria-label=\"Previous\">이전</a></li>" + html;
        }
        if(endPage != maxsize) {
            html = html + "<li class='page-item'><a href=\"#\" class='page-link' aria-label=\"Next\">다음</a></li>";
        }
    }
    html = "<ul class=\"pagination justify-content-center\">"+ html +"</ul>";
    page_box.append(html);
    page_box.find("a").unbind("click");
    page_box.find("a").click(function(e){
        e.preventDefault();
        var type = $(this).attr("aria-label");
        console.log(type);
        switch(type) {
            case "Previous" :
                var count = now_page - Math.ceil(paging_size / 2);
                now_page = count <= 0 ? 1 : count;
                break;
            case "Next" :
                var count = now_page + Math.ceil(paging_size / 2);
                now_page = count > maxsize ? maxsize : count;
                break;
            default :
                now_page = parseInt(type);
                break;
        }

        now_limit = (now_page - 1) * now_length;
        loadData();
    });
}

function loadData() {
    list_box.html("");
    page_box.html("");
    empty_box.addClass("d-none");
    loading_box.removeClass("d-none");
    $.ajax({
        url: '/api/work/list',
        type: 'POST',
        data: JSON.stringify({'status' : list_status, 'limit' : now_limit, 'length' : now_length, 'page' : now_page, 'keyword' : $("#search_text").val()}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        console.log(data);
        if(data.status == 200) {
            if(data.result.total > 0) {
                for(var i = 0; i < data.result.list.length; i++) {
                    var field = data.result.list[i];
                    list_box.append(list_item);
                    list_box.find(".item_title").eq(i).html(field.title);
                    list_box.find(".item_companyname").eq(i).html(field.comname + "(" + field.cname + ")");
                    list_box.find(".item_companytel").eq(i).html(field.cmobile);
                    list_box.find(".item_companyemail").eq(i).html(field.cemail);
                    list_box.find(".item_totalprice").eq(i).html(comma(field.totalprice) + "원");
                    var status_span = "";
                    var day_span = "";
                    switch(field.status) {
                        case 0 :
                            status_span = "<span class=\"badge bg-secondary text-light\">모집</span>";
                            day_span = field.rstart + " ~ " + field.rend;
                            break;
                        case 1 :
                            status_span = "<span class=\"badge bg-success text-light\">진행</span>";
                            day_span = field.start + " ~ " + field.end;
                            break;
                        case 5 :
                            status_span = "<span class=\"badge bg-dark text-light\">대기</span>";
                            day_span = field.start + " ~ " + field.end;
                            break;
                        default :
                            status_span = "<span class=\"badge bg-danger text-light\">취소</span>";
                            day_span = field.start + " ~ " + field.end;
                            break;
                    }
                    list_box.find(".item_status").eq(i).html(status_span);
                    list_box.find(".item_days").eq(i).html(day_span);

                    var count = [0, 0, 0, 0];

                    for(var j = 0; j < field.infos.length; j++) {
                        count[field.infos[j].mtype]++;
                    }

                    list_box.find(".item_instagram_count").eq(i).html(count[1] + "명");
                    list_box.find(".item_youtube_count").eq(i).html(count[2] + "명");
                    list_box.find(".item_blog_count").eq(i).html(count[3] + "명");
                    list_box.find(".item_readgo").eq(i).attr("rdata", field.seq);
                    list_box.find(".item_readgo").eq(i).click(function (e) {
                        location.href = "/work/read/" + $(this).attr("rdata") + "?keyword=" + $("#search_text").val() + "&page=" + now_page + "&status=" + list_status;
                    });
                }

                paging(data.result.max_page);

                $('body').tooltip({
                    selector: '[data-bs-toggle="tooltip"]'
                });
            } else {
                empty_box.removeClass("d-none");
            }
        } else {
            showModal(data.message);
        }

        loading_box.addClass("d-none");
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
        loading_box.addClass("d-none");
    });

}

function changeStatus(now) {
    $("#search_box button.status").each(function (index) {
        var ss_data = $(this).attr("ss-data");
        if(ss_data == now) {
            $(this).removeClass("btn-outline-primary");
            $(this).addClass("btn-primary");
        } else {
            $(this).addClass("btn-outline-primary");
            $(this).removeClass("btn-primary");
        }
    });
}

$(document).ready(function(){

    $("#search_box button.status").each(function (index) {
        var buttons = $(this);
        buttons.click(function (e) {
            list_status = $(this).attr("ss-data");
            changeStatus(list_status);
        });
    });

    $("#search_button").click(function (e) {
        loadData();
    });

    loadData();

    $("#work_addgo").click(function (e){
        location.href="/work/add";
    });
});