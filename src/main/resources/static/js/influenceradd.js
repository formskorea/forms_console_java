var c_list_box = $("#com_item_box");
var c_list_item = c_list_box.html();
var c_loading_box = $("#com_loading_box");
var c_empty_box = $("#com_empty_box");
var c_add_box = $("#com_additem_box");
var c_now_limit = 0;
var c_now_length = 10;
var c_now_page = 1;
var c_fulllist = new Array();
var isProcessing = false;

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
        'keyword': $("#com_search_text").val()
    };

    $.ajax({
        url: '/api/company',
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
                    c_list_box.find(".com_item_companyname").eq(i).html(field.comname);
                    c_list_box.find(".com_item_companytel").eq(i).html(field.tel);
                    c_list_box.find(".com_item_companyaddr").eq(i).html("(" + field.zip + ") " + field.address.replace("|", " "));
                    c_list_box.find(".com_item_status").eq(c_now_limit + i).find("input").attr("id", "com_item_select" + field.seq);
                    c_list_box.find(".com_item_status").eq(c_now_limit + i).find("label").attr("for", "com_item_select" + field.seq);

                    if (i == 0) {
                        c_list_box.find(".com_item_status").eq(c_now_limit + i).find("input").attr("checked", true);
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
    for (var i = 0; i < c_fulllist.length; i++) {
        var field = c_fulllist[i];
        if (c_list_box.find(".com_item_status").eq(i).find("input").is(":checked")) {
            c_selectlist = c_fulllist[i];
            $("#inf_company_name").val(field.comname);
            $("#inf_company_tel").val(field.tel);
            $("#inf_company_zipcode").val(field.zip);
            var address = field.address.split("|");
            $("#inf_company_address1").val((address[0] == undefined || address[0] == "") ? "" : address[0]);
            $("#inf_company_address2").val((address[1] == undefined || address[1] == "") ? "" : address[1]);
            $("#inf_company_number").val((field.corpnum == undefined || field.corpnum == "") ? "" : field.corpnum);
            $("#fmc_searchcompany").modal("hide");
            break;
        }
    }

    $("#fmc_searchcompany").modal("hide");
}

$(document).ready(function () {
    var tagify = $('[name=hashtag]').tagify();

    $("#inf_email_check").click(function () {
        var email = $("#inf_email").val();

        if (email == "") {
            showModal("????????? ????????? ????????????.");
        } else if (!checkEmail(email)) {
            showModal("????????? ????????? ???????????? ????????????.");
        } else {
            $.ajax({
                url: '/api/emailcheck',
                type: 'POST',
                data: JSON.stringify({'mtype': 'influencer', 'email': email}),
                headers: {'Content-Type': 'application/json'},
            }).then((data, textStatus, jqXHR) => {
                if (data.status == 200) {
                    if (data.result) {
                        $("#inf_email_check").removeClass("btn-primary");
                        $("#inf_email_check").addClass("btn-success");
                        $("#inf_email_check").html("????????? ??????");
                        saveEmail = email;
                        isEmailCheck = true;
                    } else {
                        showModal("?????? ????????? ???????????? ????????????.");
                    }
                } else {
                    showModal(data.message);
                }
            }, (jqXHR, textStatus, errorThrown) => {
                /*pass*/

            });
        }
    });

    $("#inf_email").bind('keyup keydown', function (event) {
        if (isEmailCheck) {
            if (saveEmail != $(this).val()) {
                $("#inf_email_check").addClass("btn-primary");
                $("#inf_email_check").removeClass("btn-success");
                $("#inf_email_check").html("<i class='bi bi-check'></i> ????????????");

                saveEmail = "";
                isEmailCheck = false;
            }
        }
    });

    $("#inf_company_type1").click(function (event) {
        $(".inf_comapy_checked").removeClass("d-none");
        $("#inf_company_searchgo").removeClass("d-none");
        isCompany = true;
    });

    $("#inf_company_type2").click(function (event) {
        $(".inf_comapy_checked").addClass("d-none");
        $("#inf_company_searchgo").addClass("d-none");
        isCompany = false;
    });

    $("#inf_company_addressgo").click(function (event) {
        event.preventDefault();

        new daum.Postcode({
            oncomplete: function (data) {
                $("#inf_company_zipcode").val(data.zonecode);
                $("#inf_company_address1").val(data.roadAddress ? data.roadAddress : data.jibunAddress);
            }
        }).open();
    });

    $("input[name='inf_status']").click(function(event) {
        infStatus = $(this).val();
    });

    $("#com_item_add").click(function (e) {
        c_now_page++;
        c_now_limit = (c_now_page - 1) * c_now_length;
        c_loadData();
    });

    $("#com_item_selectgo").click(function () {
        c_select();
    });

    $("#inf_company_searchgo").click(function(event){
        c_now_page = 1;
        c_now_limit = 0;
        $("#com_search_text").val('');
        c_loadData();
        $("#fmc_searchcompany").modal("show");
    });

    $("#com_search_button").click(function(event){
        c_now_page = 1;
        c_now_limit = 0;
        c_loadData();
    });

    $("#inf_readgo").click(function(event){
        location.href  = "/influencer/read/" + infno + "?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });

    $("#inf_listgo").click(function(event){
        location.href = "/influencer/list?keyword=" + keyword + "&page=" + page + "&status=" + status;
    });

    $("#form_influencer").submit(function(event){
        event.preventDefault();

        if(!isProcessing) {
            isProcessing = true;
            var submitButton = $(this).find("button[type=submit]");

            $("#inf_btn_process").removeClass("d-none");
            $("#inf_btn_icon").addClass("d-none");
            submitButton.removeClass("btn-primary");
            submitButton.addClass("btn-secondary");

            var isError = false;
            var name = $("#inf_name").val();
            var nik = $("#inf_nik").val();
            var email = $("#inf_email").val();
            var mobile = $("#inf_mobile").val();
            var password1 = $("#inf_pass").val();
            var password2 = $("#inf_pass2").val();
            var media1 = $("#inf_media1").val();
            var media2 = $("#inf_media2").val();
            var media3 = $("#inf_media3").val();
            var media4 = $("#inf_media4").val();

            var corpname = $("#inf_company_name").val();
            var corptel = $("#inf_company_tel").val();
            var corpzipcode = $("#inf_company_zipcode").val();
            var corpaddr1 = $("#inf_company_address1").val();
            var corpaddr2 = $("#inf_company_address2").val();
            var corpnum = $("#inf_company_number").val();

            var nowtags = "";
            var company = {};

            if (name == "") {
                showModal("????????? ??????????????????.");
                isError = true;
            } else if (nik == "") {
                showModal("???????????? ??????????????????.");
                isError = true;
            } else if (email == "") {
                showModal("???????????? ??????????????????.");
                isError = true;
            } else if (!isEmailCheck) {
                showModal("????????? ????????? ??????????????????.");
                isError = true;
            } else if ((password1 == "" || password2 == "") && !isEdit) {
                showModal("??????????????? ??????????????????.");
                isError = true;
            } else if (password1 != password2) {
                showModal("??????????????? ???????????? ????????????.");
                isError = true;
            } else {
                var pwcheck = checkPass(password1);

                if (isEdit && password1 == "" && password2 == "") {
                    pwcheck.error = false;
                    pwcheck.message = "";
                }

                if (pwcheck.error) {
                    showModal(pwcheck.message);
                    isError = true;
                } else if (media1 == "" && media2 == "" && media3 == "" && media4 == "") {
                    showModal("????????? ????????? ?????????.");
                    isError = true;
                } else {
                    if (isCompany) {
                        if (corpname == "") {
                            showModal("??????????????? ??????????????????.");
                            isError = true;
                        } else if (corptel == "") {
                            showModal("????????? ???????????? ??????????????????.");
                            isError = true;
                        } else {
                            company = {
                                'comname': corpname,
                                'tel': corptel,
                                'zip': corpzipcode,
                                'address': corpaddr1,
                                'address2': corpaddr2,
                                'corpnum': corpnum
                            };
                            if (c_selectlist.seq != undefined && c_selectlist.seq != null) {
                                company.seq = c_selectlist.seq;
                            }
                        }
                    }
                }
            }

            if (!isError) {
                var tojson = {
                    'mtype': 'influencer',
                    'email': email,
                    'pass': password1,
                    'pass2': password2,
                    'name': name,
                    'nik': nik,
                    'mobile': mobile,
                    'status': infStatus
                };

                tojson.company = company;
                tojson.media = [{'type': 1, 'url': media1}, {'type': 2, 'url': media2}, {
                    'type': 3,
                    'url': media3
                }, {'type': 4, 'url': media4}];

                var url = '/api/influencer/add';

                if (isEdit) {
                    url = '/api/influencer/edit';
                    tojson.seq = infno;
                    if (c_selectlist.seq != undefined && c_selectlist.seq != null) {
                        tojson.comseq = c_selectlist.seq;
                    }
                }

                if (tagify.val()) {
                    var tdata = eval(tagify.val());
                    var tags = new Array();
                    for (key in tdata) {
                        tags.push({'tag': tdata[key].value});
                        nowtags += (nowtags != "" ? ", " : "") + "#" + tdata[key].value;
                    }
                    tojson.tags = tags;
                }

                $.ajax({
                    url: url,
                    type: 'POST',
                    data: JSON.stringify(tojson),
                    headers: {'Content-Type': 'application/json'},
                }).then((data, textStatus, jqXHR) => {
                    console.log(data);
                    if (data.status == 200) {
                        isProcessing = false;
                        $("#inf_btn_process").addClass("d-none");
                        $("#inf_btn_icon").removeClass("d-none");
                        submitButton.removeClass("btn-secondary");
                        submitButton.addClass("btn-primary");

                        if (isEdit) {
                            location.href = "/influencer/read/" + infno + "?status=" + infStatus + "&page=1&keyword=";
                        } else {
                            location.href = "/influencer/list?status=" + infStatus;
                        }
                    } else {
                        showModal(data.message);
                        isProcessing = false;
                        $("#inf_btn_process").addClass("d-none");
                        $("#inf_btn_icon").removeClass("d-none");
                        submitButton.removeClass("btn-secondary");
                        submitButton.addClass("btn-primary");
                    }
                }, (jqXHR, textStatus, errorThrown) => {
                    /*pass*/
                    showModal("DB ????????? ????????? ?????????????????????.");
                    isProcessing = false;
                    $("#inf_btn_process").addClass("d-none");
                    $("#inf_btn_icon").removeClass("d-none");
                    submitButton.removeClass("btn-secondary");
                    submitButton.addClass("btn-primary");
                });
            } else {
                isProcessing = false;
                $("#inf_btn_process").addClass("d-none");
                $("#inf_btn_icon").removeClass("d-none");
                submitButton.removeClass("btn-secondary");
                submitButton.addClass("btn-primary");
            }
        } else {
            showModal("??????????????????.");
        }

    });

});