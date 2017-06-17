$(document).ready(function () {
   $(document).on('submit', '#form_forgotpassword', function (e) {
      e.preventDefault();
      forgotPassword();
   });

   $(document).on('submit', '#change-password_form', function (e) {
      e.preventDefault();
      changePassword();
   });

   $.each($('input'), function () {
      if ($(this).val() !== '') {
         $('#label_' + $(this).prop('id')).parent().parent().addClass('label-active');
      }
   });

   $(document).on('focus', '.form-control', function () {
      $('#label_' + $(this).prop('id')).parent().parent().addClass('label-active');
   });

   $(document).on('blur', '.form-control', function () {
      if ($("#SubmitCreate").data("mouseDown") != true) {
         if ($(this).val() == "") {
            $('#label_' + $(this).prop('id')).parent().parent().removeClass('label-active');
            $('#label_' + $(this).prop('id')).parent().parent().removeClass('form-ok form-error');
         }

         $("#" + $(this).prop('id') + "_error").hide();
      }
   });
});

function forgotPassword() {
   $('#forgot_password_error').html('').hide();
   $.ajax({
      beforeSend: function () {
         $('#form_forgotpassword h3 .icon-spinner').css('display', 'inline-block');
      },
      complete: function () {
         $('#form_forgotpassword h3 .icon-spinner').hide();
      },
      type: 'POST',
      url: baseUri + '?rand=' + new Date().getTime(),
      async: true,
      cache: false,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      data: {
         controller: 'password',
         email: $('#email').val(),
         message: $('#message').val(),
         ajax: true,
         token: $('#hidden_token').val()
      },
      success: function (jsonData) {
         $('.error_message').each(function () {
            $(this).hide();
         });

         if (jsonData.hasError) {
            //var errors = '';
            $.each(jsonData.errors, function (index, value) {
               $("#" + index).show();
               $("#" + index).html(value);
            });
         } else {
            $('#SubmitForgotPassword').hide();
            $('#forgot_password_success').show();
         }
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
         error = "TECHNICAL ERROR: unable to load form.\n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
         if (!!$.prototype.fancybox) {
            $.fancybox.open([
                  {
                     type: 'inline',
                     autoScale: true,
                     minHeight: 30,
                     content: "<p class='fancybox-error'>" + error + '</p>'
                  }],
               {
                  padding: 0
               });
         }
         else
            alert(error);
      }
   });
}

function changePassword() {
   $.ajax({
      type: 'POST',
      url: baseUri + '?rand=' + new Date().getTime(),
      async: false,
      cache: false,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      data: {
         controller: 'password',
         passwd1: $('#passwd1').val(),
         passwd2: $('#passwd2').val(),
         email_token: $('input[name=hidden_token]').val(),
         id_customer: $('input[name=hidden_id_customer]').val(),
         ajax: true
      },
      success: function (jsonData) {
         $('.error_message').each(function () {
            $(this).hide();
         });

         if (jsonData.hasError) {
            //var errors = '';
            $.each(jsonData.errors, function (index, value) {
               $("#" + index).show();
               $("#" + index).html(value);
            });
         }
         else {
            $('#SubmitChangePassword').hide();
            $('#change_password_success').show();
            window.location = $('input[name="url_redirect"]').val();
         }
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
         error = "TECHNICAL ERROR: unable to load form.\n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
         if (!!$.prototype.fancybox) {
            $.fancybox.open([
                  {
                     type: 'inline',
                     autoScale: true,
                     minHeight: 30,
                     content: "<p class='fancybox-error'>" + error + '</p>'
                  }],
               {
                  padding: 0
               });
         }
         else
            alert(error);
      }
   });
}