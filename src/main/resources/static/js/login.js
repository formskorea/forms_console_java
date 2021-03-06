$(document).ready(function () {
    $("#login_form").submit(function (event) {
        event.preventDefault();

        var email = $("#useremail").val();
        var password = $("#yourPassword").val();
        var mtype = $("#gridRadios1").is(":checked") ? $("#gridRadios1").val() : ($("#gridRadios2").is(":checked") ? $("#gridRadios2").val() : $("#gridRadios3").val());
        var save = $('#rememberMe').is(":checked");

        if(!checkEmail(email)) {
            var message = $("#useremail").parent().find(".invalid-feedback").text();
            showModal(message);
        } else if(email != "" && password != "") {
            $.ajax({
                url: '/api/login',
                type: 'POST',
                data: JSON.stringify({'mtype': mtype, 'email': email, 'pass': password, 'save' : save}),
                headers: {'Content-Type': 'application/json'},
            }).then((data, textStatus, jqXHR) => {
                console.log(data);
                if(data.status == 200) {
                    location.href = "/";
                } else {
                    showModal(data.message);
                }
            }, (jqXHR, textStatus, errorThrown) => {
                /*pass*/
            });
        }
    });
});