function loadWorkCount(start, end, htmltype) {
    $.ajax({
        url: '/api/count/work',
        type: 'POST',
        data: JSON.stringify({'start': start, 'end': end}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        if (data.status == 200) {
            if (htmltype == 1) {
                var series = new Array();
                var labels = new Array();

                series.push({name: "협업", data: new Array()});
                series.push({name: "인스타그램", data: new Array()});
                series.push({name: "유튜브", data: new Array()});
                series.push({name: "블로그", data: new Array()});

                for (var i = 0; i < data.result.length; i++) {
                    var field = data.result[i];
                    labels.push(field.date);
                    series[0].data.push(field.work);
                    series[1].data.push(field.instagram);
                    series[2].data.push(field.youtube);
                    series[3].data.push(field.blog);
                }

                $("#reportsChart").html("");
                makeLineChart("#reportsChart", series, labels, "yy-MM-dd");
            } else {
                console.log(data.result);

                var wicon = "-";
                var wcount = data.result[1].work - data.result[0].work;
                var iicon = "-";
                var icount = data.result[1].instagram - data.result[0].instagram;
                var yicon = "-";
                var ycount = data.result[1].youtube - data.result[0].youtube;
                var bicon = "-";
                var bcount = data.result[1].blog - data.result[0].blog;

                console.log( data.result[1].work + " - " + data.result[0].work + " = " + wcount);

                $("#admin_dh_works_percent").removeClass("text-primary");
                $("#admin_dh_works_percent").removeClass("text-danger");
                $("#admin_dh_works_percent").removeClass("text-dark");

                if(wcount == 0) {
                    wicon = "<i class=\"bx bx-minus\"></i>&nbsp;" + wcount + "건";
                    $("#admin_dh_works_percent").addClass("text-dark");
                } else if(wcount > 0) {
                    wicon = "<i class=\"bx bx-arrow-from-bottom\"></i>&nbsp;" + wcount + "건";
                    $("#admin_dh_works_percent").addClass("text-primary");
                } else {
                    wicon = "<i class=\"bx bx-arrow-from-top\"></i>&nbsp;" + (wcount * -1) + "건";
                    $("#admin_dh_works_percent").addClass("text-danger");
                }

                $("#admin_dh_works_count").html(data.result[1].work + "건");
                $("#admin_dh_works_percent").html(wicon);


                $("#admin_dh_instagram_percent").removeClass("text-primary");
                $("#admin_dh_instagram_percent").removeClass("text-danger");
                $("#admin_dh_instagram_percent").removeClass("text-dark");

                if(icount == 0) {
                    iicon = "<i class=\"bx bx-minus\"></i>&nbsp;" + icount + "건";
                    $("#admin_dh_instagram_percent").addClass("text-dark");
                } else if(icount > 0) {
                    iicon = "<i class=\"bx bx-arrow-from-bottom\"></i>&nbsp;" + icount + "건";
                    $("#admin_dh_instagram_percent").addClass("text-primary");
                } else {
                    iicon = "<i class=\"bx bx-arrow-from-top\"></i>&nbsp;" + (icount * -1) + "건";
                    $("#admin_dh_instagram_percent").addClass("text-danger");
                }

                $("#admin_dh_instagram_count").html(data.result[1].instagram + "건");
                $("#admin_dh_instagram_percent").html(iicon);


                $("#admin_dh_youtube_percent").removeClass("text-primary");
                $("#admin_dh_youtube_percent").removeClass("text-danger");
                $("#admin_dh_youtube_percent").removeClass("text-dark");

                if(ycount == 0) {
                    yicon = "<i class=\"bx bx-minus\"></i>&nbsp;" + ycount + "건";
                    $("#admin_dh_youtube_percent").addClass("text-dark");
                } else if(ycount > 0) {
                    yicon = "<i class=\"bx bx-arrow-from-bottom\"></i>&nbsp;" + ycount + "건";
                    $("#admin_dh_youtube_percent").addClass("text-primary");
                } else {
                    yicon = "<i class=\"bx bx-arrow-from-top\"></i>&nbsp;" + (ycount * -1) + "건";
                    $("#admin_dh_youtube_percent").addClass("text-danger");
                }

                $("#admin_dh_youtube_count").html(data.result[1].youtube + "건");
                $("#admin_dh_youtube_percent").html(yicon);

                $("#admin_dh_blog_percent").removeClass("text-primary");
                $("#admin_dh_blog_percent").removeClass("text-danger");
                $("#admin_dh_blog_percent").removeClass("text-dark");

                if(bcount == 0) {
                    bicon = "<i class=\"bx bx-minus\"></i>&nbsp;" + bcount + "건";
                    $("#admin_dh_blog_percent").addClass("text-dark");
                } else if(bcount > 0) {
                    bicon = "<i class=\"bx bx-arrow-from-bottom\"></i>&nbsp;" + bcount + "건";
                    $("#admin_dh_blog_percent").addClass("text-primary");
                } else {
                    bicon = "<i class=\"bx bx-arrow-from-top\"></i>&nbsp;" + (bcount * -1) + "건";
                    $("#admin_dh_blog_percent").addClass("text-danger");
                }

                $("#admin_dh_blog_count").html(data.result[1].blog + "건");
                $("#admin_dh_blog_percent").html(bicon);

            }
        } else {
            showModal(data.message);
        }
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/

    });
}

function loadUserCount(start, end, htmltype) {
    $.ajax({
        url: '/api/count/user',
        type: 'POST',
        data: JSON.stringify({'start': start, 'end': end}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        if (data.status == 200) {
            if (htmltype == 1) {
                var series = new Array();
                var labels = new Array();

                series.push({name: "인플루언서", data: new Array()});
                series.push({name: "협력사", data: new Array()});

                for (var i = 0; i < data.result.length; i++) {
                    var field = data.result[i];
                    labels.push(field.date);
                    series[0].data.push(field.influencer);
                    series[1].data.push(field.client);
                }

                $("#reportsChart2").html("");
                makeLineChart("#reportsChart2", series, labels, "yy-MM-dd");
            } else {
                var inficon = "-";
                var infcount = data.result[1].influencer - data.result[0].influencer;
                var clicon = "-";
                var clcount = data.result[1].client - data.result[0].client;

                $("#admin_dh_influencer_percent").removeClass("text-primary");
                $("#admin_dh_influencer_percent").removeClass("text-danger");
                $("#admin_dh_influencer_percent").removeClass("text-dark");

                if(infcount == 0) {
                    inficon = "<i class=\"bx bx-minus\"></i>&nbsp;" + infcount + "명";
                    $("#admin_dh_influencer_percent").addClass("text-dark");
                } else if(infcount > 0) {
                    inficon = "<i class=\"bx bx-arrow-from-bottom\"></i>&nbsp;" + infcount + "명";
                    $("#admin_dh_influencer_percent").addClass("text-primary");
                } else {
                    inficon = "<i class=\"bx bx-arrow-from-top\"></i>&nbsp;" + (infcount * -1) + "명";
                    $("#admin_dh_influencer_percent").addClass("text-danger");
                }

                $("#admin_dh_influencer_count").html(data.result[1].influencer + "명");
                $("#admin_dh_influencer_percent").html(inficon);


                $("#admin_dh_client_percent").removeClass("text-primary");
                $("#admin_dh_client_percent").removeClass("text-danger");
                $("#admin_dh_client_percent").removeClass("text-dark");

                if(clcount == 0) {
                    clicon = "<i class=\"bx bx-minus\"></i>&nbsp;" + clcount + "명";
                    $("#admin_dh_client_percent").addClass("text-dark");
                } else if(clcount > 0) {
                    clicon = "<i class=\"bx bx-arrow-from-bottom\"></i>&nbsp;" + clcount + "명";
                    $("#admin_dh_client_percent").addClass("text-primary");
                } else {
                    clicon = "<i class=\"bx bx-arrow-from-top\"></i>&nbsp;" + (clcount * -1) + "명";
                    $("#admin_dh_client_percent").addClass("text-danger");
                }

                $("#admin_dh_client_count").html(data.result[1].client + "명");
                $("#admin_dh_client_percent").html(clicon);

            }
        } else {
            showModal(data.message);
        }
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/

    });
}

function loadTrendCategory(itype) {

}

function loadTrend(itype, stype) {
    $.ajax({
        url: '/api/trend/data',
        type: 'POST',
        data: JSON.stringify({'itype': itype, 'stype': stype, 'sex': 9, 'limit': 10}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        if (data.status == 200) {
            for(var i = 0; i < data.result.length; i++) {
                $("#admin_dh_ntrend_list li").eq(i).html(data.result[i].trend);
            }
        } else {
            showModal(data.message);
        }
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
    });
}

function loadGTrend() {
    $.ajax({
        url: '/api/trend/data',
        type: 'POST',
        data: JSON.stringify({'itype': 3, 'limit': 10}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        if (data.status == 200) {
            for(var i = 0; i < data.result.length; i++) {
                $("#admin_dh_gtrend_list li").eq(i).html(data.result[i].trend);
            }
        } else {
            showModal(data.message);
        }
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
    });
}


$(document).ready(function () {

    var enddate = changeDateToString();
    var startdate = addDateString(-6, 'day', enddate);
    var start2date = addDateString(-1, 'day', enddate);

    console.log(startdate + " -> " + enddate + " / " + start2date);

    loadWorkCount(startdate, enddate, 1);
    loadUserCount(startdate, enddate, 1);
    loadWorkCount(start2date, enddate, 2);
    loadUserCount(start2date, enddate, 2);

    loadTrend(2, '25-29세');
    loadGTrend();
});