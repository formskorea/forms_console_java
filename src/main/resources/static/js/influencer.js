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

    startPage = maxsize > paging_size ? now_page - Math.floor(paging_size / 2) : 1;
    startPage = startPage <= 0 ? 1 : startPage;
    endPage = startPage + paging_size >= maxsize || maxsize <= paging_size ? maxsize : (startPage + paging_size - 1);
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
        url: '/api/influencer/list',
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
                    list_box.find(".item_name").eq(i).html(field.nik + "(" + field.name + ")");
                    list_box.find(".item_mobile").eq(i).html(field.mobile);
                    list_box.find(".item_email").eq(i).html(field.email);
                    list_box.find(".item_level").eq(i).html("lv" + field.level);
                    var status_span = "";
                    switch(field.status) {
                        case 0 :
                            status_span = "<span class=\"badge bg-secondary text-light\">대기</span>";
                            break;
                        case 1 :
                            status_span = "<span class=\"badge bg-success text-light\">정상</span>";
                            break;
                        case 5 :
                            status_span = "<span class=\"badge bg-dark text-light\">탈퇴</span>";
                            break;
                        default :
                            status_span = "<span class=\"badge bg-danger text-light\">차단</span>";
                            break;
                    }
                    list_box.find(".item_status").eq(i).html(status_span);
                    list_box.find(".item_instagram_box").eq(i).addClass("d-none");
                    list_box.find(".item_youtube_box").eq(i).addClass("d-none");
                    list_box.find(".item_blog_box").eq(i).addClass("d-none");
                    list_box.find(".item_shopping_box").eq(i).addClass("d-none");

                    for(var j = 0; j < field.media.length; j++) {
                        switch(field.media[j].type) {
                            case 1 :
                                list_box.find(".item_instagram_box").eq(i).find("a.item_media_link").attr("src", field.media[j].url);
                                list_box.find(".item_instagram_box").eq(i).find("span.item_media_link").html(field.media[j].url);
                                list_box.find(".item_instagram_box").eq(i).find("span.item_follower").html(priceToString(field.media[j].count1));
                                list_box.find(".item_instagram_box").eq(i).find("span.item_follow").html(priceToString(field.media[j].count2));
                                list_box.find(".item_instagram_box").eq(i).find("span.item_upcount").html(priceToString(field.media[j].count3));
                                list_box.find(".item_instagram_box").eq(i).removeClass("d-none");
                                break;
                            case 2 :
                                list_box.find(".item_youtube_box").eq(i).find("a.item_media_link").attr("src", field.media[j].url);
                                list_box.find(".item_youtube_box").eq(i).find("span.item_media_link").html(field.media[j].url);
                                list_box.find(".item_youtube_box").eq(i).find("span.item_follower").html(priceToString(field.media[j].count1));
                                list_box.find(".item_youtube_box").eq(i).find("span.item_follow").html(priceToString(field.media[j].count2));
                                list_box.find(".item_youtube_box").eq(i).find("span.item_upcount").html(priceToString(field.media[j].count3));
                                list_box.find(".item_youtube_box").eq(i).removeClass("d-none");
                                break;
                            case 3 :
                                list_box.find(".item_blog_box").eq(i).find("a.item_media_link").attr("src", field.media[j].url);
                                list_box.find(".item_blog_box").eq(i).find("span.item_media_link").html(field.media[j].url);
                                list_box.find(".item_blog_box").eq(i).find("span.item_follower").html(priceToString(field.media[j].count1));
                                list_box.find(".item_blog_box").eq(i).find("span.item_follow").html(priceToString(field.media[j].count2));
                                list_box.find(".item_blog_box").eq(i).removeClass("d-none");
                                break;
                            case 4 :
                                list_box.find(".item_shopping_box").eq(i).find("a.item_media_link").attr("src", field.media[j].url);
                                list_box.find(".item_shopping_box").eq(i).find("span.item_media_link").html(field.media[j].url);
                                list_box.find(".item_shopping_box").eq(i).removeClass("d-none");
                                break;
                        }
                    }
                    list_box.find(".item_readgo").eq(i).attr("rdata", field.seq);
                    list_box.find(".item_readgo").eq(i).click(function (e) {
                        location.href = "/influencer/read/" + $(this).attr("rdata") + "?keyword=" + $("#search_text").val() + "&page=" + now_page + "&status=" + list_status;
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

    $("#search_button").click(function (e) {
        now_limit = 0;
        now_page = 1;
        loadData();
    });

    $("#inf_addgo").click(function(event){
        location.href = "/influencer/add";
    });

    loadData();
});