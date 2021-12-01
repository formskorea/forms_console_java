$(document).ready(function () {
    $("#find_form").submit(function (event) {
        event.preventDefault();

        var email = $("#useremail").val();
        var mtype = $("#gridRadios1").is(":checked") ? $("#gridRadios1").val() : ($("#gridRadios2").is(":checked") ? $("#gridRadios2").val() : $("#gridRadios3").val());

        if(!checkEmail(email)) {
            var message = $("#useremail").parent().find(".invalid-feedback").text();
            showModal(message);
        } else if(email != "") {
            $.ajax({
                url: '/api/find',
                type: 'POST',
                data: JSON.stringify({'mtype': mtype, 'email': email}),
                headers: {'Content-Type': 'application/json'},
            }).then((data, textStatus, jqXHR) => {
                console.log(data);
                if(data.status == 200) {
                    if($('#rememberMe').is(":checked")) {
                        setCookie(fmctk, data.result, 15);
                    } else {
                        setCookie(fmctk, data.result);
                    }
                    location.href = "/findok?email=" + email;
                } else {
                    showModal(data.message);
                }
            }, (jqXHR, textStatus, errorThrown) => {
                /*pass*/
            });
        }
    });
});