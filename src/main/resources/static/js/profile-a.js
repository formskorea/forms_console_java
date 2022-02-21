$(document).ready(function ($) {

    var isProcessing = false;

    $("#form_editinfo").submit(function (event) {
        event.preventDefault();

        var submitButton = $(this).find("button[type=submit]");

        if (!isProcessing) {
            isProcessing = true;

            var name = $("#Name").val();
            var email = $("#Email").val();

            if (name == "") {
                showModal("성명을 입력해주세요.");
            } else if (email == "") {
                showModal("이메일을 입력해주세요.");
            } else {
                var tojson = {'mtype': MEMTYPE, 'email': email, 'name': name, 'nik': name};

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

                    $("#view_name").html(name);
                    $("#view_email").html(email);

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