
$(document).ready(function ($) {

    $("#gridRadios1").click(function (event) {
        $(".corpinfo").removeClass("d-none");
    });
    $("#gridRadios2").click(function (event) {
        $(".corpinfo").addClass("d-none");
    });

    $("#form_editinfo").submit(function (event) {
        event.preventDefault();

        var email = $("#useremail").val();



    });
});