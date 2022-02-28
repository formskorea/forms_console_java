var item_i_list, item_i_loading, item_i_empty, item_i_body;
var item_y_list, item_y_loading, item_y_empty, item_y_body;
var item_b_list, item_b_loading, item_b_empty, item_b_body;

var graph_i, graph_y, graph_b;

function loadData(mtype) {
    var daytype = 1;
    var iseq = 0;
    var sdate = "";
    var edate = "";
    var loading, body, list, empty;

    switch (mtype) {
        case 2 :
            daytype = $("#work_y_select option:selected").val();
            iseq = $("#work_y_userselect option:selected").val();
            sdate = $("#work_y_start").val();
            edate = $("#work_y_end").val();
            loading = item_y_loading;
            body = item_y_body;
            list = item_y_list;
            empty = item_y_empty;
            break;
        case 3 :
            daytype = $("#work_b_select option:selected").val();
            iseq = $("#work_b_userselect option:selected").val();
            sdate = $("#work_b_start").val();
            edate = $("#work_b_end").val();
            loading = item_b_loading;
            body = item_b_body;
            list = item_b_list;
            empty = item_b_empty;
            break;
        default :
            daytype = $("#work_i_select option:selected").val();
            iseq = $("#work_i_userselect option:selected").val();
            sdate = $("#work_i_start").val();
            edate = $("#work_i_end").val();
            loading = item_i_loading;
            body = item_i_body;
            list = item_i_list;
            empty = item_i_empty;
            break;
    }

    loading = "<tr>" + loading + "</tr>";
    list = "<tr>" + list + "</tr>";
    empty = "<tr>" + empty + "</tr>";

    iseq = iseq == "" ? -1 : iseq *= 1;

    body.html(loading);

    $.ajax({
        url: '/api/count/worklog',
        type: 'POST',
        data: JSON.stringify({
            'mtype': mtype,
            'odby': daytype,
            'iseq': iseq,
            'start': sdate,
            'end': edate,
            'wseq': workno
        }),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        console.log(data);
        if (data.status == 200) {
            var series = new Array();
            var labels = new Array();

            switch (mtype) {
                case 2 :
                    series.push({name: "재생수", data: new Array()});
                    series.push({name: "댓글", data: new Array()});
                    break;
                case 3 :
                    series.push({name: "공감", data: new Array()});
                    series.push({name: "댓글", data: new Array()});
                    break;
                default :
                    series.push({name: "좋아요", data: new Array()});
                    series.push({name: "댓글", data: new Array()});
                    break;
            }

            if (data.result.length <= 0) {
                body.html(empty);
            } else {
                body.html('');
                for (var i = 0; i < data.result.length; i++) {
                    var field = data.result[i];
                    body.append(list);
                    body.find("tr").eq(i).find("th").html(field.day);
                    labels.push(field.day);

                    switch (mtype) {
                        case 2 :
                            body.find("tr").eq(i).find("td").eq(0).html(comma(field.count5));
                            body.find("tr").eq(i).find("td").eq(1).html(comma(field.count8));
                            body.find("tr").eq(i).find("td").eq(2).html(comma(field.count6));
                            body.find("tr").eq(i).find("td").eq(3).html(comma(field.count2));
                            body.find("tr").eq(i).find("td").eq(4).html(comma(field.count3));

                            series[0].data.push(field.count5);
                            series[1].data.push(field.count8);
                            break;
                        case 3 :
                            body.find("tr").eq(i).find("td").eq(0).html(comma(field.count4));
                            body.find("tr").eq(i).find("td").eq(1).html(comma(field.count5));
                            body.find("tr").eq(i).find("td").eq(2).html(comma(field.count2));
                            body.find("tr").eq(i).find("td").eq(3).html(comma(field.count1));
                            body.find("tr").eq(i).find("td").eq(4).html(comma(field.count3));

                            series[0].data.push(field.count4);
                            series[1].data.push(field.count5);
                            break;
                        default :
                            body.find("tr").eq(i).find("td").eq(0).html(comma(field.count4));
                            body.find("tr").eq(i).find("td").eq(1).html(comma(field.count5));
                            body.find("tr").eq(i).find("td").eq(2).html(comma(field.count3));
                            body.find("tr").eq(i).find("td").eq(3).html(comma(field.count1));
                            body.find("tr").eq(i).find("td").eq(4).html(comma(field.count2));

                            series[0].data.push(field.count4);
                            series[1].data.push(field.count5);
                            break;
                    }
                }
            }

            switch (mtype) {
                case 2 :
                    if (graph_y) {
                        graph_y.updateOptions({
                            series: series,
                            xaxis: {
                                type: 'date',
                                categories: labels
                            }
                        });
                    } else {
                        graph_y = makeLineChart("#youtube_chart", series, labels, "yy-MM-dd");
                    }
                    break;
                case 3 :
                    if (graph_b) {
                        graph_b.updateOptions({
                            series: series,
                            xaxis: {
                                type: 'date',
                                categories: labels
                            }
                        });
                    } else {
                        graph_b = makeLineChart("#blog_chart", series, labels, "yy-MM-dd");
                    }
                    break;
                default :
                    if (graph_i) {
                        graph_i.updateOptions({
                            series: series,
                            xaxis: {
                                type: 'date',
                                categories: labels
                            }
                        });
                    } else {
                        graph_i = makeLineChart("#instagram_chart", series, labels, "yy-MM-dd");
                    }
                    break;
            }
        } else {
            showModal(data.message);
            body.html(empty);
        }
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
        body.html(empty);
    });
}

$(document).ready(function ($) {

    $("#work_editgo").click(function (e) {
        location.href = "/work/edit/" + workno + "?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });
    $("#work_listgo").click(function (e) {
        location.href = "/work/list?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });

    if ($("#instagram").length) {
        item_i_list = $("#work_i_list tr.work_i_body").html();
        item_i_loading = $("#work_i_list tr.work_i_loading").html();
        item_i_empty = $("#work_i_list tr.work_i_list_empty").html();
        item_i_body = $("#work_i_list tbody");
        item_i_body.html('');

        loadData(1);
    }
    if ($("#youtube").length) {
        item_y_list = $("#work_y_list tr.work_y_body").html();
        item_y_loading = $("#work_y_list tr.work_y_loading").html();
        item_y_empty = $("#work_y_list tr.work_y_list_empty").html();
        item_y_body = $("#work_y_list tbody");
        item_y_body.html('');

        loadData(2);
    }

    if ($("#blog").length) {
        item_b_list = $("#work_b_list tr.work_b_body").html();
        item_b_loading = $("#work_b_list tr.work_b_loading").html();
        item_b_empty = $("#work_b_list tr.work_b_list_empty").html();
        item_b_body = $("#work_b_list tbody");
        item_b_body.html('');

        loadData(3);
    }

    $("#work_i_search").click(function(e) {
        loadData(1);
    });

    $("#work_y_search").click(function(e) {
        loadData(2);
    });

    $("#work_b_search").click(function(e) {
        loadData(3);
    });
});