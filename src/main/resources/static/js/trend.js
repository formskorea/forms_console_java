function loadTrend(itype, stype, sex, date = null) {
    $.ajax({
        url: '/api/trend/data',
        type: 'POST',
        data: JSON.stringify({'date': date, 'itype': itype, 'stype': stype, 'sex': sex, 'limit': 10}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        if (data.status == 200) {
            for(var i = 0; i < data.result.length; i++) {
                if(itype == 2) {
                    if(i == 0 && $("#trand2_date").val() == "") {
                        $("#trand2_date").val(data.result[i].date);
                    }
                    $("#admin_dh_n2trend_list li").eq(i).html(data.result[i].trend);
                } else {
                    if(i == 0 && $("#trand1_date").val() == "") {
                        $("#trand1_date").val(data.result[i].date);
                    }
                    $("#admin_dh_ntrend_list li").eq(i).html(data.result[i].trend);
                }
            }
        } else {
            showModal(data.message);
        }
    }, (jqXHR, textStatus, errorThrown) => {
        /*pass*/
    });
}

function loadGTrend(date = null) {
    $.ajax({
        url: '/api/trend/data',
        type: 'POST',
        data: JSON.stringify({'date': date, 'itype': 3, 'limit': 10}),
        headers: {'Content-Type': 'application/json'},
    }).then((data, textStatus, jqXHR) => {
        if (data.status == 200) {
            for(var i = 0; i < data.result.length; i++) {
                if(i == 0 && $("#trand3_date").val() == "") {
                    $("#trand3_date").val(data.result[i].date);
                }
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

    $("#trand1_search").click(function(e){
        e.preventDefault();
        loadTrend(1, $("#trand1_category option:selected").val(), null, $("#trand1_date").val());
    });
    $("#trand2_search").click(function(e){
        e.preventDefault();
        loadTrend(2, $("#trand2_category option:selected").val(), $("#trand2_sex option:selected").val(), $("#trand2_date").val());
    });
    $("#trand3_search").click(function(e){
        e.preventDefault();
        loadGTrend($("#trand3_date").val());
    });

    loadTrend(1, '비즈니스·경제', null);
    loadTrend(2, '25-29세', 9);
    loadGTrend();

});