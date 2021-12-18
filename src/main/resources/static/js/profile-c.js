
$(document).ready(function ($) {
    var tagify = $('[name=hashtag]').tagify();
    var isProcessing = false;

    $("#addr_search").click(function (event) {
        event.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                $("#zipcode").val(data.zonecode);
                $("#address1").val(data.roadAddress ? data.roadAddress : data.jibunAddress);
            }
        }).open();
    });

    $("#form_editinfo").submit(function (event) {
        event.preventDefault();

        if (!isProcessing) {
            var name = $("#Name").val();
            var email = $("#Email").val();
            var mobile = $("#Mobile").val();
            var banktype = $("#banktype").val();
            var banknum = $("#bankinfo").val();
            var corpname = $("#corpname").val();
            var corptel = $("#corptel").val();
            var address1 = $("#address1").val();

            var nowtags = "";
            var submitButton = $(this).find("button[type=submit]");

            if (name == "") {
                showModal("성명을 입력해주세요.");
            } else if (email == "") {
                showModal("이메일을 입력해주세요.");
            } else if (!checkEmail(email)) {
                showModal("이메일 형식이 맞지 않습니다.");
            } else if (mobile == "") {
                showModal("연락처를 입력해주세요.");
            } else if (corpname == "") {
                showModal("회사명을 입력해주세요.");
            } else if (corptel == "") {
                showModal("회사 연락처를 입력해주세요.");
            } else if (address1 == "") {
                showModal("회사 주소를 선택해주세요.");
            } else {
                isProcessing = true;
                var tojson = {'mtype': MEMTYPE, 'email': email, 'name': name, 'nik': name, 'mobile': mobile};

                tojson.company = {
                    'comname': $("#corpname").val(),
                    'tel': $("#corptel").val(),
                    'zip': $("#zipcode").val(),
                    'address': $("#address1").val(),
                    'address2': $("#address2").val()
                };

                if (tagify.val()) {
                    var tdata = eval(tagify.val());
                    var tags = new Array();
                    for (key in tdata) {
                        tags.push({'tag': tdata[key].value});
                        nowtags += (nowtags != "" ? ", " : "") + "#" + tdata[key].value;
                    }
                    tojson.tags = tags;
                }

                // var cashs = new Array();
                // cashs.push({'cashtype': 1, 'banktype': banktype, 'banknum': banknum})
                // tojson.cashs = cashs;

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

                        //tag change
                        $("#view_tags").html(nowtags);
                        $("#view_name").html(name);
                        $("#view_email").html(email);
                        $("#view_mobile").html(mobile);

                        $("#view_corpname").html($("#corpname").val());
                        $("#view_corptel").html($("#corptel").val());
                        $("#view_address").html("(" + $("#zipcode").val() + ") " + $("#address1").val() + " " + $("#address2").val());

                        $("#view_cash").html(banktype + " " + banknum);

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