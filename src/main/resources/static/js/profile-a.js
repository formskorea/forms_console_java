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
        }

    });
});