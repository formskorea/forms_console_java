$(document).ready(function ($) {
    var tagify = $('[name=hashtag]').tagify();
    var isProcessing = false;
    $("#addr_search").click(function (event) {
        event.preventDefault();
        new daum.Postcode({
            oncomplete: function (data) {
                $("#zipcode").val(data.zonecode);
                $("#address1").val(data.roadAddress ? data.roadAddress : data.jibunAddress);
            }
        }).open();
    });

    $("#gridRadios1").click(function (event) {
        $(".corpinfo").removeClass("d-none");
    });
    $("#gridRadios2").click(function (event) {
        $(".corpinfo").addClass("d-none");
    });

    $("#form_editinfo").submit(function (event) {
        event.preventDefault();

        if (!isProcessing) {
            var name = $("#Name").val();
            var email = $("#Email").val();
            var nikname = $("#Nikname").val();
            var mobile = $("#Mobile").val();
            var media1 = $("#media_1").val();
            var media2 = $("#media_2").val();
            var media3 = $("#media_3").val();
            var media4 = $("#media_4").val();
            var banktype = $("#banktype").val();
            var banknum = $("#bankinfo").val();

            var nowtags = "";
            var submitButton = $(this).find("button[type=submit]");

            if (name == "") {
                showModal("성명을 입력해주세요.");
            } else if (email == "") {
                showModal("이메일을 입력해주세요.");
            } else if (!checkEmail(email)) {
                showModal("이메일 형식이 맞지 않습니다.");
            } else if (nikname == "") {
                showModal("활동명을 입력해주세요.");
            } else if (mobile == "") {
                showModal("연락처를 입력해주세요.");
            } else if (media1 == "" && media2 == "" && media3 == "" && media4 == "") {
                showModal("미디어 매체정보가 비었습니다. Instagram, Youtube, Blog, Shopping mall 정보를 입력해주세요.");
            } else {
                isProcessing = true;

                var tojson = {'mtype': MEMTYPE, 'email': email, 'name': name, 'nik': nikname, 'mobile': mobile};

                if ($("#gridRadios1").is(":checked")) {
                    tojson.company = {
                        'comname': $("#corpname").val(),
                        'tel': $("#corptel").val(),
                        'zip': $("#zipcode").val(),
                        'address': $("#address1").val(),
                        'address2': $("#address2").val()
                    };
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

                var medias = new Array();
                if (media1 != "") {
                    medias.push({'type': 1, 'url': media1});
                }
                if (media2 != "") {
                    medias.push({'type': 2, 'url': media2});
                }
                if (media3 != "") {
                    medias.push({'type': 3, 'url': media3});
                }
                if (media4 != "") {
                    medias.push({'type': 4, 'url': media4});
                }
                tojson.media = medias;

                var cashs = new Array();
                cashs.push({'cashtype': 1, 'banktype': banktype, 'banknum': banknum})
                tojson.cashs = cashs;

                console.log(JSON.stringify(tojson));

                $("#form_edit_process").removeClass("d-none");
                submitButton.removeClass("btn-primary");
                submitButton.addClass("btn-secondary");

                $.ajax({
                    url: '/api/useredit',
                    type: 'POST',
                    data: JSON.stringify(tojson),
                    headers: {'Content-Type': 'application/json'},
                }).then((data, textStatus, jqXHR) => {
                    $("#form_edit_process").addClass("d-none");
                    isProcessing = false;
                    submitButton.addClass("btn-primary");
                    submitButton.removeClass("btn-secondary");

                    console.log(data);
                    if (data.status == 200) {
                        //media change
                        var tags_media = "";
                        if (media1 != null && media1 != "") {
                            tags_media += "<a href=\"" + media1 + "\" target=\"_blank\" id=\"goto_instagram\" class=\"instagram\"><i class=\"bi bi-instagram\"></i></a>";
                        }
                        if (media2 != null && media2 != "") {
                            tags_media += "<a href=\"" + media2 + "\" target=\"_blank\" id=\"goto_youtube\" class=\"youtube\"><i class=\"bi bi-youtube\"></i></a>";
                        }
                        if (media3 != null && media3 != "") {
                            tags_media += "<a href=\"" + media3 + "\" target=\"_blank\" id=\"goto_blog\" class=\"blog\"><i class=\"bi bi-bootstrap\"></i></a>";
                        }
                        if (media4 != null && media4 != "") {
                            tags_media += "<a href=\"" + media4 + "\" target=\"_blank\" id=\"goto_shoppingmall\" class=\"shoppingmall\"><i class=\"bi bi-cart3\"></i></a>";
                        }
                        $("#media_box").html(tags_media);

                        //tag change
                        $("#view_tags").html(nowtags);
                        $("#view_name").html(name);
                        $("#view_nikname").html(nikname);
                        $("#view_email").html(email);
                        $("#view_mobile").html(mobile);

                        if ($("#gridRadios1").is(":checked")) {
                            $("#view_corpname").html($("#corpname").val());
                            $("#view_corptel").html($("#corptel").val());
                            $("#view_address").html("(" + $("#zipcode").val() + ") " + $("#address1").val() + " " + $("#address2").val());
                        } else {
                            $("#view_corpname").html("없음");
                            $("#view_corptel").html("없음");
                            $("#view_address").html("없음");
                        }

                        if (banktype != "" && banknum != "" && banktype != null && banknum != null) {
                            $("#view_cash").html(banktype + " " + banknum);
                        } else {
                            $("#view_cash").html("없음");
                        }

                    }

                    showModal(data.message);

                }, (jqXHR, textStatus, errorThrown) => {
                    /*pass*/
                    $("#form_edit_process").addClass("d-none");
                    isProcessing = false;
                    submitButton.addClass("btn-primary");
                    submitButton.removeClass("btn-secondary");
                });
            }
        } else {
            showModal("처리중입니다.");
        }
    });

    $("#form_password").submit(function (event) {
        event.preventDefault();

        if (!isProcessing) {
            var current = $("#currentPassword").val();
            var password = $("#newPassword").val();
            var repassword = $("#renewPassword").val();
            var submitButton = $(this).find("button[type=submit]");

            if (current == "" || password == "" || repassword == "") {
                showModal("비밀번호 항목을 전부 입력해 주세요.");
            } else if (current == password) {
                showModal("이전 비밀번호와 동일합니다.");
            } else if (password != repassword) {
                showModal("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
            } else {
                isProcessing = true;

                $("#form_password_process").removeClass("d-none");
                submitButton.removeClass("btn-primary");
                submitButton.addClass("btn-secondary");

                var tojson = {'mtype': MEMTYPE, 'pass' : current, 'pass2' : password};

                $.ajax({
                    url: '/api/repass',
                    type: 'POST',
                    data: JSON.stringify(tojson),
                    headers: {'Content-Type': 'application/json'},
                }).then((data, textStatus, jqXHR) => {
                    showModal(data.message);

                    $("#form_password_process").addClass("d-none");
                    isProcessing = false;
                    submitButton.addClass("btn-primary");
                    submitButton.removeClass("btn-secondary");

                    $("#currentPassword").val('');
                    $("#newPassword").val('');
                    $("#renewPassword").val('');
                }, (jqXHR, textStatus, errorThrown) => {
                    /*pass*/
                    $("#form_password_process").addClass("d-none");
                    isProcessing = false;
                    submitButton.addClass("btn-primary");
                    submitButton.removeClass("btn-secondary");

                    $("#currentPassword").val('');
                    $("#newPassword").val('');
                    $("#renewPassword").val('');
                });
            }
        } else {
            showModal("처리중입니다.");
        }
    });
});