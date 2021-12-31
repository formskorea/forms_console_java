function showSearchClient() {
    $("#fmc_searchclient").modal("show");
}

function showSearchInf() {
    $("#fmc_searchinf").modal("show");
}

//#######################################
//          influencer
//#######################################
var i_list_box = $("#inf_item_box");
var i_list_item = i_list_box.html();
var i_loading_box = $("#inf_loading_box");
var i_empty_box = $("#inf_empty_box");
var i_add_box = $("#inf_additem_box");
var i_now_limit = 0;
var i_now_length = 10;
var i_now_page = 1;
var i_fulllist = new Array();
var i_selectlist = new Array();
var work_influencer_list = $("#work_influencer_list");
var work_influencer_item = work_influencer_list.html();

i_list_box.html("");
work_influencer_list.html("");

function i_loadData() {
    if (i_now_page == 1) {
        i_list_box.html("");
        i_fulllist = new Array();
    }
    i_add_box.addClass("d-none");
    i_empty_box.addClass("d-none");
    i_loading_box.removeClass("d-none");

    var jsongo = {
        'status': 1,
        'limit': i_now_limit,
        'length': i_now_length,
        'page': i_now_page,
        'keyword': $("#inf_search_text").val()
    };
    if ($("#work_media_select1").is(":checked")) {
        jsongo.media1 = 1;
    }
    if ($("#work_media_select2").is(":checked")) {
        jsongo.media2 = 1;
    }
    if ($("#work_media_select3").is(":checked")) {
        jsongo.media3 = 1;
    }

    $.ajax({
        url: '/api/influencer/list',
        type: 'POST',
        data: JSON.stringify(jsongo),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        console.log(data);
        if (data.status == 200) {
            if (data.result.total > 0) {
                for (var i = 0; i < data.result.list.length; i++) {
                    var field = data.result.list[i];
                    i_fulllist.push(field);

                    i_list_box.append(i_list_item);
                    i_list_box.find(".inf_item_name").eq(i_now_limit + i).html(field.nik + "(" + field.name + ")");
                    i_list_box.find(".inf_item_mobile").eq(i_now_limit + i).html(field.mobile);
                    i_list_box.find(".inf_item_email").eq(i_now_limit + i).html(field.email);
                    i_list_box.find(".inf_item_level").eq(i_now_limit + i).html("lv" + field.level);
                    i_list_box.find(".inf_item_status").eq(i_now_limit + i).find("input").attr("id", "inf_item_select" + field.seq);
                    i_list_box.find(".inf_item_status").eq(i_now_limit + i).find("label").attr("for", "inf_item_select" + field.seq);
                    i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).addClass("d-none");
                    i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).addClass("d-none");
                    i_list_box.find(".inf_item_blog_box").eq(i_now_limit + i).addClass("d-none");
                    i_list_box.find(".inf_item_shopping_box").eq(i_now_limit + i).addClass("d-none");
                    for (var j = 0; j < field.media.length; j++) {
                        switch (field.media[j].type) {
                            case 1 :
                                i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).find("a.inf_item_media_link").attr("src", field.media[j].url);
                                i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).find("span.inf_item_media_link").html(field.media[j].url);
                                i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).find("span.inf_item_follower").html(priceToString(field.media[j].count1));
                                i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).find("span.inf_item_follow").html(priceToString(field.media[j].count2));
                                i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).find("span.inf_item_upcount").html(priceToString(field.media[j].count3));
                                i_list_box.find(".inf_item_instagram_box").eq(i_now_limit + i).removeClass("d-none");
                                break;
                            case 2 :
                                i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).find("a.inf_item_media_link").attr("src", field.media[j].url);
                                i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).find("span.inf_item_media_link").html(field.media[j].url);
                                i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).find("span.inf_item_follower").html(priceToString(field.media[j].count1));
                                i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).find("span.inf_item_follow").html(priceToString(field.media[j].count2));
                                i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).find("span.inf_item_upcount").html(priceToString(field.media[j].count3));
                                i_list_box.find(".inf_item_youtube_box").eq(i_now_limit + i).removeClass("d-none");
                                break;
                            case 3 :
                                i_list_box.find(".inf_item_blog_box").eq(i_now_limit + i).find("a.inf_item_media_link").attr("src", field.media[j].url);
                                i_list_box.find(".inf_item_blog_box").eq(i_now_limit + i).find("span.inf_item_media_link").html(field.media[j].url);
                                i_list_box.find(".inf_item_blog_box").eq(i_now_limit + i).find("span.inf_item_follower").html(priceToString(field.media[j].count1));
                                i_list_box.find(".inf_item_blog_box").eq(i_now_limit + i).find("span.inf_item_follow").html(priceToString(field.media[j].count2));
                                i_list_box.find(".inf_item_blog_box").eq(i_now_limit + i).removeClass("d-none");
                                break;
                            case 4 :
                                i_list_box.find(".inf_item_shopping_box").eq(i_now_limit + i).find("a.inf_item_media_link").attr("src", field.media[j].url);
                                i_list_box.find(".inf_item_shopping_box").eq(i_now_limit + i).find("span.inf_item_media_link").html(field.media[j].url);
                                i_list_box.find(".inf_item_shopping_box").eq(i_now_limit + i).removeClass("d-none");
                                break;
                        }
                    }
                }

                $('body').tooltip({
                    selector: '[data-bs-toggle="tooltip"]'
                });

                if ((i_now_page == 1 && i_now_length < data.result.total) || (i_now_page < data.result.max_page)) {
                    i_add_box.removeClass("d-none");
                }
                console.log(i_fulllist);
            } else {
                if (i_now_page == 1) {
                    i_empty_box.removeClass("d-none");
                }
            }
        } else {
            showModal(data.message);
        }

        i_loading_box.addClass("d-none");
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
        i_loading_box.addClass("d-none");
    });
}

function i_select() {
    var check_count = 0;
    for (var i = 0; i < i_fulllist.length; i++) {
        if (i_list_box.find(".inf_item_status").eq(i).find("input").is(":checked")) {
            check_count++;
            var isCheck = false;
            for (var j = 0; j < i_selectlist.length; j++) {
                if (i_fulllist[i].seq == i_selectlist[j].seq) {
                    isCheck = true;
                    break;
                }
            }
            if (!isCheck) {
                i_selectlist.push(i_fulllist[i]);
            }
        }
    }

    if (check_count == 0) {
        showModal("선택된 인플루언서가 없습니다.");
    } else {
        i_selectlistmake();
        $("#fmc_searchinf").modal("hide");
    }
}

function i_delete(num) {
    i_selectlist.splice(num, 1);
    console.log(i_selectlist);
    i_selectlistmake();
    i_totalprice();
}

function i_totalprice() {
    var total = 0;

    for (var i = 0; i < i_selectlist.length; i++) {
        var field = i_selectlist[i];
        for (var j = 0; j < field.media.length; j++) {
            if (field.media[j].checked) {
                total += field.media[j].price *= 1;
            }
        }
    }

    if (total > 0) {
        $("#work_item_totalprice").html(comma(total));
    } else {
        $("#work_item_totalprice").html("0");
    }
}

function i_selectlistmake() {
    if (i_selectlist.length <= 0) {
        work_influencer_list.addClass("d-none");
    } else {
        work_influencer_list.html("");

        for (var i = 0; i < i_selectlist.length; i++) {
            var field = i_selectlist[i];

            work_influencer_list.append(work_influencer_item);
            work_influencer_list.find(".inf_item_name").eq(i).html(field.nik + "(" + field.name + ")");
            work_influencer_list.find(".inf_item_mobile").eq(i).html(field.mobile);
            work_influencer_list.find(".inf_item_email").eq(i).html(field.email);
            work_influencer_list.find(".inf_item_level").eq(i).html("lv" + field.level);
            work_influencer_list.find(".inf_item_delete").eq(i).attr("wdata", String(i));
            work_influencer_list.find(".inf_item_delete").eq(i).click(function (e) {
                var data = $(this).attr("wdata");
                i_delete(data *= 1);
            });

            work_influencer_list.find(".inf_item_instagram_box").eq(i).addClass("d-none");
            work_influencer_list.find(".inf_item_youtube_box").eq(i).addClass("d-none");
            work_influencer_list.find(".inf_item_blog_box").eq(i).addClass("d-none");

            for (var j = 0; j < field.media.length; j++) {
                var fiedlsub = field.media[j];

                if (!fiedlsub.price) {
                    fiedlsub.price = 0;
                }
                if (!fiedlsub.checked) {
                    fiedlsub.checked = false;
                }

                switch (fiedlsub.type) {
                    case 1 :
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find("a.inf_item_media_link").attr("src", fiedlsub.url);
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find("span.inf_item_media_link").html(fiedlsub.url);
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).removeClass("d-none");
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_select input").attr("id", "inf_item_select1_" + field.seq);
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_select label").attr("for", "inf_item_select1_" + field.seq);
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_price").attr("wdata", String(i) + "_" + String(j));
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_price").bind('keyup keydown', function (e) {
                            $(this).val(comma($(this).val()));
                            var location = $(this).attr("wdata").split("_");
                            i_selectlist[location[0] *= 1].media[location[1] *= 1].price = uncomma($(this).val());
                            i_totalprice();
                        });
                        if (fiedlsub.price) {
                            work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_price").val(comma(fiedlsub.price));
                        }
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_select input").attr("wdata", String(i) + "_" + String(j));
                        work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_select input").click(function (e) {
                            var location = $(this).attr("wdata").split("_");
                            i_selectlist[location[0] *= 1].media[location[1] *= 1].checked = $(this).is(":checked");
                            i_totalprice();
                        });
                        if (fiedlsub.checked) {
                            work_influencer_list.find(".inf_item_instagram_box").eq(i).find(".work_item_select input").attr("checked", true);
                        }

                        break;
                    case 2 :
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find("a.inf_item_media_link").attr("src", fiedlsub.url);
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find("span.inf_item_media_link").html(fiedlsub.url);
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).removeClass("d-none");
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_select input").attr("id", "inf_item_select_2_" + field.seq);
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_select label").attr("for", "inf_item_select_2_" + field.seq);
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_price").attr("wdata", String(i) + "_" + String(j));
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_price").bind('keyup keydown', function (e) {
                            $(this).val(comma($(this).val()));
                            var location = $(this).attr("wdata").split("_");
                            i_selectlist[location[0] *= 1].media[location[1] *= 1].price = uncomma($(this).val());
                            i_totalprice();
                        });
                        if (fiedlsub.price) {
                            work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_price").val(comma(fiedlsub.price));
                        }
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_select input").attr("wdata", String(i) + "_" + String(j));
                        work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_select input").click(function (e) {
                            var location = $(this).attr("wdata").split("_");
                            i_selectlist[location[0] *= 1].media[location[1] *= 1].checked = $(this).is(":checked");
                            i_totalprice();
                        });
                        if (fiedlsub.checked) {
                            work_influencer_list.find(".inf_item_youtube_box").eq(i).find(".work_item_select input").attr("checked", true);
                        }
                        break;
                    case 3 :
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find("a.inf_item_media_link").attr("src", fiedlsub.url);
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find("span.inf_item_media_link").html(fiedlsub.url);
                        work_influencer_list.find(".inf_item_blog_box").eq(i).removeClass("d-none");
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_select input").attr("id", "inf_item_select_3_" + field.seq);
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_select label").attr("for", "inf_item_select_3_" + field.seq);
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_price").attr("wdata", String(i) + "_" + String(j));
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_price").bind('keyup keydown', function (e) {
                            $(this).val(comma($(this).val()));
                            var location = $(this).attr("wdata").split("_");
                            i_selectlist[location[0] *= 1].media[location[1] *= 1].price = uncomma($(this).val());
                            i_totalprice();
                        });
                        if (fiedlsub.price) {
                            work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_price").val(comma(fiedlsub.price));
                        }
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_select input").attr("wdata", String(i) + "_" + String(j));
                        work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_select input").click(function (e) {
                            var location = $(this).attr("wdata").split("_");
                            i_selectlist[location[0] *= 1].media[location[1] *= 1].checked = $(this).is(":checked");
                            i_totalprice();
                        });
                        if (fiedlsub.checked) {
                            work_influencer_list.find(".inf_item_blog_box").eq(i).find(".work_item_select input").attr("checked", true);
                        }
                        break;
                }
            }
        }

        work_influencer_list.removeClass("d-none");
    }
}


//#######################################
//          Client
//#######################################
var c_list_box = $("#cl_item_box");
var c_list_item = c_list_box.html();
var c_loading_box = $("#cl_loading_box");
var c_empty_box = $("#cl_empty_box");
var c_add_box = $("#cl_additem_box");
var c_now_limit = 0;
var c_now_length = 10;
var c_now_page = 1;
var c_fulllist = new Array();
var c_selectlist = {};

c_list_box.html("");

function c_loadData() {
    if (c_now_page == 1) {
        c_list_box.html("");
        c_fulllist = new Array();
    }
    c_add_box.addClass("d-none");
    c_empty_box.addClass("d-none");
    c_loading_box.removeClass("d-none");

    var jsongo = {
        'status': 1,
        'limit': c_now_limit,
        'length': c_now_length,
        'page': c_now_page,
        'keyword': $("#cl_search_text").val()
    };

    $.ajax({
        url: '/api/client/list',
        type: 'POST',
        data: JSON.stringify(jsongo),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        console.log(data);
        if (data.status == 200) {
            if (data.result.total > 0) {
                for (var i = 0; i < data.result.list.length; i++) {
                    var field = data.result.list[i];
                    c_fulllist.push(field);

                    c_list_box.append(c_list_item);
                    c_list_box.find(".cl_item_name").eq(c_now_limit + i).html(field.name);
                    c_list_box.find(".cl_item_mobile").eq(c_now_limit + i).html(field.mobile);
                    c_list_box.find(".cl_item_email").eq(c_now_limit + i).html(field.email);
                    c_list_box.find(".cl_item_level").eq(c_now_limit + i).html("lv" + field.level);
                    c_list_box.find(".cl_item_status").eq(c_now_limit + i).find("input").attr("id", "cl_item_select" + field.seq);
                    c_list_box.find(".cl_item_status").eq(c_now_limit + i).find("label").attr("for", "cl_item_select" + field.seq);

                    c_list_box.find(".cl_item_companyname").eq(i).html(field.company.comname);
                    c_list_box.find(".cl_item_companytel").eq(i).html(field.company.tel);
                    c_list_box.find(".cl_item_companyaddr").eq(i).html("(" + field.company.zip + ") " + field.company.address.replace("|", " "));

                    if(i == 0) {
                        c_list_box.find(".cl_item_status").eq(c_now_limit + i).find("input").attr("checked", true);
                    }
                }

                $('body').tooltip({
                    selector: '[data-bs-toggle="tooltip"]'
                });

                if ((c_now_page == 1 && c_now_length < data.result.total) || (c_now_page < data.result.max_page)) {
                    c_add_box.removeClass("d-none");
                }
                console.log(c_fulllist);
            } else {
                if (c_now_page == 1) {
                    c_empty_box.removeClass("d-none");
                }
            }
        } else {
            showModal(data.message);
        }

        c_loading_box.addClass("d-none");
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
        c_loading_box.addClass("d-none");
    });
}

function c_select() {
    for(var i = 0; i < c_fulllist.length; i++) {
        var field = c_fulllist[i];
        if(c_list_box.find(".cl_item_status").eq(i).find("input").is(":checked")) {
            c_selectlist = c_fulllist[i];
            $("#work_name").val(field.name + " :: " + field.mobile);
            $("#work_company").val(field.company.comname + " :: " + field.company.tel);
            $("#fmc_searchclient").modal("hide");
            break;
        }
    }

    $("#fmc_searchclient").modal("hide");
}


$(document).ready(function ($) {
    var tagify = $('[name=hashtag]').tagify();

    $("#work_clientsearch").click(function (e) {
        c_now_page = 1;
        c_now_limit = 0;
        c_loadData();
        showSearchClient();
    });

    //influencer
    $("#work_infsearch").click(function (e) {
        i_now_page = 1;
        i_now_limit = 0;
        i_loadData();
        showSearchInf();
    });

    $("#inf_search_button").click(function (e) {
        i_now_page = 1;
        i_now_limit = 0;
        i_loadData();
    });

    $("#inf_item_add").click(function (e) {
        i_now_page++;
        i_now_limit = (i_now_page - 1) * i_now_length;
        i_loadData();
    });

    $("#inf_item_selectgo").click(function () {
        i_select();
    });

    //Client
    $("#cl_search_button").click(function (e) {
        c_now_page = 1;
        c_now_limit = 0;
        c_loadData();
    });

    $("#cl_item_add").click(function (e) {
        c_now_page++;
        c_now_limit = (c_now_page - 1) * c_now_length;
        c_loadData();
    });

    $("#cl_item_selectgo").click(function () {
        c_select();
    });

});