var isEmailCheck = false;
var saveEmail = "";
var isCompany = true;

$(document).ready(function () {
    $("#inf_email_check").click(function () {
        var email = $("#inf_email").val();

        if (email == "") {
            showModal("이메일 정보가 없습니다.");
        } else if (!checkEmail(email)) {
            showModal("이메일 형식이 올바르지 않습니다.");
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
                        $("#inf_email_check").html("이메일 확인");
                        saveEmail = email;
                        isEmailCheck = true;
                    } else {
                        showModal("이미 가입된 이메일이 있습니다.");
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
                $("#inf_email_check").html("<i class='bi bi-check'></i> 중복확인");

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

    $("#form_influencer").submit(function(event){
        event.preventDefault();
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
        var corptel = $("#inf_compnay_tel").val();
        var corpzipcode = $("#inf_company_zipcode").val();
        var corpaddr1 = $("#inf_company_address1").val();
        var corpaddr2 = $("#inf_company_address2").val();
        var corpnum = $("#inf_company_number").val();

        if(name == "") {
            showModal("성명을 입력해주세요.");
        } else if(nik == "") {
            showModal("활동명을 입력해주세요.");
        } else if(email == "") {
            showModal("이메일을 입력해주세요.");
        } else if(!isEmailCheck) {
            showModal("이메일 중복을 확인해주세요.");
        } else if(password1 == "" || password2 == "") {
            showModal("비밀번호를 입력해주세요.");
        } else if(password1 != password2) {
            showModal("비밀번호가 일치하지 않습니다.");
        } else {
            var pwcheck = checkPass(password1);
            if(pwcheck.error) {
                showModal(pwcheck.message);
            } else if(media1 == "" && media2 == "" && media3 == "" && media4 == "") {
                showModal("매체를 등록해 주세요.");
            } else {
                var tojson = {'mtype': 'influencer', 'email': email, 'pass': password1, 'pass2': password2, 'name' : name, 'nik': nik, 'mobile' : mobile };

                if(isCompany) {
                    if(corpname == "") {
                        showModal("소속사명을 입력해주세요.");
                    } else if(corptel == "") {
                        showModal("소속사 연락처를 입력해주세요.");
                    } else {
                        tojson.company = { 'comname': corpname, 'tel': corptel, 'zip': corpzipcode, 'address': corpaddr1, 'address2': corpaddr2, 'corpnum': corpnum };
                    }
                }

                tojson.media = [{'type': 1, 'url': media1}, {'type': 2, 'url': media2}, {'type': 3, 'url': media3}, {'type': 4, 'url': media4}];

                $.ajax({
                    url: '/api/join',
                    type: 'POST',
                    data: JSON.stringify(tojson),
                    headers: {'Content-Type': 'application/json'},
                }).then((data, textStatus, jqXHR) => {
                    console.log(data);
                    if(data.status == 200) {
                        location.href = "/influencer";
                    } else {
                        showModal(data.message);
                    }
                }, (jqXHR, textStatus, errorThrown) => {
                    /*pass*/
                });
            }
        }

    });

});