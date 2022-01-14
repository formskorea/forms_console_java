
var isEmailCheck = false;
var saveEmail = "";
var isCompany = true;

$(document).ready(function(){
    $("#inf_email_check").click(function(){
        var email = $("#inf_email").val();

        if(email == "") {
            showModal("이메일 정보가 없습니다.");
        } else if(!checkEmail(email)) {
            showModal("이메일 형식이 올바르지 않습니다.");
        } else {
            $.ajax({
                url: '/api/emailcheck',
                type: 'POST',
                data: JSON.stringify({'mtype': 'influencer', 'email': email}),
                headers: {'Content-Type': 'application/json'},
            }).then((data, textStatus, jqXHR) => {
                if (data.status == 200) {
                    if(data.result) {
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
        if(isEmailCheck) {
            if(saveEmail != $(this).val()) {
                $("#inf_email_check").addClass("btn-primary");
                $("#inf_email_check").removeClass("btn-success");
                $("#inf_email_check").html("<i class='bi bi-check'></i> 중복확인");

                saveEmail = "";
                isEmailCheck = false;
            }
        }
    });

    $("#inf_company_type1").click(function(event){
        event.preventDefault();

        $(".inf_comapy_checked").removeClass("d-none");
        $("#inf_company_searchgo").removeClass("d-none");
        isCompany = true;
    });

    $("#inf_company_type2").click(function(event){
        event.preventDefault();

        $(".inf_comapy_checked").addClass("d-none");
        $("#inf_company_searchgo").addClass("d-none");
        isCompany = false;
    });

    $("#inf_company_addressgo").click(function (event) {
        event.preventDefault();
        
        new daum.Postcode({
            oncomplete: function(data) {
                $("#inf_company_zipcode").val(data.zonecode);
                $("#inf_company_address1").val(data.roadAddress ? data.roadAddress : data.jibunAddress);
            }
        }).open();
    });

});