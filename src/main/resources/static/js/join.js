$(document).ready(function () {
   //address search
   $("#addr_search").click(function (event) {
      event.preventDefault();
      new daum.Postcode({
         oncomplete: function(data) {
            $("#zipcode").val(data.zonecode);
            $("#address1").val(data.roadAddress ? data.roadAddress : data.jibunAddress);
         }
      }).open();
   });

   $("#gridRadios1").click(function (event) {
      $(".form_client").removeClass("d-none");
      $(".form_influencer").addClass("d-none");
   });

   $("#gridRadios2").click(function (event) {
      $(".form_client").addClass("d-none");
      $(".form_influencer").removeClass("d-none");
   });

   $("#join_form").submit(function (event) {
      event.preventDefault();

      var email = $("#useremail").val();
      var password = $("#yourPassword").val();
      var password2 = $("#yourPassword2").val();
      var mtype = $("#gridRadios1").is(":checked") ? $("#gridRadios1").val() : $("#gridRadios2").val();

      if(!checkEmail(email)) {
         var message = $("#useremail").parent().find(".invalid-feedback").text();
         showModal(message);
      } else if(password != "" && password != "" && password != password2) {
         showModal("비밀번호가 일치하지 않습니다.");
      } else if(email != "" && password != "") {

         var tojson = {'mtype': mtype, 'email': email, 'pass': password, 'pass2': password2, 'name' : $("#name").val(), 'nik': $("#nikname").val(), 'mobile' : $("#mobile").val() };

         if ($("#gridRadios1").is(":checked")) {
            if($("#corpname").val() != "") {
               tojson.company = { 'comname': $("#corpname").val(), 'tel': $("#corptel").val(), 'zip': $("#zipcode").val(), 'address': $("#address1").val(), 'address2': $("#address2").val() };
            }
         } else {
            if($("#in_corpname").val() != "") {
               tojson.company = { 'comname': $("#in_corpname").val(), 'tel': $("#in_corptel").val(), 'zip': $("#zipcode").val(), 'address': $("#address1").val(), 'address2': $("#address2").val() };
            }
            tojson.media = [{'usertype': mtype, 'type': 1, 'url': $("#media_1").val()}, {'usertype': mtype, 'type': 2, 'url': $("#media_2").val()}, {'usertype': mtype, 'type': 3, 'url': $("#media_3").val()}, {'usertype': mtype, 'type': 4, 'url': $("#media_4").val()}];
         }

         console.log(tojson);

         $.ajax({
            url: '/api/join',
            type: 'POST',
            data: JSON.stringify(tojson),
            headers: {'Content-Type': 'application/json'},
         }).then((data, textStatus, jqXHR) => {
            console.log(data);
            if(data.status == 200) {
               location.href = "/joinok";
            } else {
               showModal(data.message);
            }
         }, (jqXHR, textStatus, errorThrown) => {
            /*pass*/
         });
      }
   });
});