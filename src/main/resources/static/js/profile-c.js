
$(document).ready(function ($) {
    $('[name=hashtag]').tagify();

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

        var email = $("#useremail").val();



    });
});