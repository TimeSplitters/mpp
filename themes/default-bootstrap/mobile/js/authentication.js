$(document).ready(function () {

   $(document).on('submit', '#create-account_form', function (e) {
      e.preventDefault();
      createAccount();
      $('#email_create').trigger('blur');
   });

   $(document).on('submit', '#complete-account_form', function (e) {
      e.preventDefault();
      completeAccount();
   });

   $(document).on('change', '#email, #email_create', function (e) {
         $('#mail_already_exists').hide();
   });

   $(document).on('submit', '#login_form', function (e) {
      e.preventDefault();
      if (!userIsLoggedIn()) {
         verifLogin();
      }
   });

   $('.is_customer_param').hide();

   // Prevent bug when click on Submit AND lost of input focus at the same time
   $("#SubmitCreate").on("mousedown", function (e) {
      $("#SubmitCreate").data("mouseDown", true);
   });

   $("#SubmitCreate").on("mouseup", function (e) {
      $("#SubmitCreate").data("mouseDown", false);
   });

   $("#SubmitComplete").on("mousedown", function (e) {
      $("#SubmitComplete").data("mouseDown", true);
   });

   $("#SubmitComplete").on("mouseup", function (e) {
      $("#SubmitComplete").data("mouseDown", false);
   });

   $(document).on('click', '#mystery', function () {
      window.parent.$.fancybox.close();
      window.parent.location.href = $(this).attr('data-href');
   });

   $(document).on('click', '#enjoy-button, #my-account-button', function () {
      window.parent.$.fancybox.close();
      window.parent.location = $(this).attr('data-href');
   });

   $(document).on('click', '#addToWishlistCreatedToAccount', function () {
      window.parent.$.fancybox.close();
      window.parent.location.replace('?controller=my-account');
   });

   $(document).on('click', '#addToWishlistCreatedContinue', function () {
      window.parent.$.fancybox.close();
   });

   /*
   $(document).on('click', '.lost_password a', function (e) {
      e.preventDefault();
      window.parent.$.fancybox.close();
      window.parent.location = $(this).attr('href');
   });*/
});

var parsed_pid;
var parsed_paid;

function verifLogin() {
   $.ajax({
      type: 'POST',
      url: baseUri + '?rand=' + new Date().getTime(),
      async: false,
      cache: false,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      data: {
         controller: 'authentication',
         ajax: true,
         SubmitLogin: 1,
         email: $('#email').val(),
         passwd: $('#passwd').val(),
         back: $('input[name=back]').val(),
         pid: $('input[name=pid]').val(),
         token: static_token
      },
      success: function (jsonData) {
         $('#login_form .error_message').hide();

         if (jsonData.hasError) {
            //var errors = '';
            $.each(jsonData.errors, function (index, value) {
               $("#" + index).show();
               $("#" + index).html(value);
            });
         } else {
            //userSetLoggedIn(true);
            static_token = jsonData.token;
            parsed_pid = parseInt(jsonData.pid);
            parsed_paid = parseInt(jsonData.paid);
            if (parsed_pid > 0) {
               // Cas particulier: un visiteur souhaite ajouter un produit à sa liste d'envies,
               // mais si le produit a déjà été ajouté auparavant,
               // on ne souhaite pas le supprimer "involontairement"
               if (jsonData.pidInWishlist === false) {
                  WishlistCart('wishlist_block_list', 'add', parsed_pid, parsed_paid, 1);
               }
               window.parent.$.fancybox.close();
               window.parent.location.reload(false);
            }
            else {
               if(jsonData.back != "")
                  window.parent.location.replace("?controller="+jsonData.back);
               else window.parent.location.reload(false);
            }
         }
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
         error = "TECHNICAL ERROR: unable to load #login.\n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
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
      },
      always: function () {
         window.parent.location.reload(false); //parent.location.pathname + '#' + jsonData.pid);
      }
   });
}

function createAccount() {
   $('#create_account_error').html('').hide();
   $.ajax({
      beforeSend: function () {
         $('#create-account_form h3 .icon-spinner').css('display', 'inline-block');
      },
      complete: function () {
         $('#create-account_form h3 .icon-spinner').hide();
      },
      type: 'POST',
      url: baseUri + '?rand=' + new Date().getTime(),
      async: false,
      cache: false,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      data: {
         controller: 'authentication',
         SubmitCreate: 1,
         ajax: false,
         email_create: $('#email_create').val(),
         passwd1: $('#passwd1').val(),
         passwd2: $('#passwd2').val(),
         newsletter: $('input[name=ckb_newsletter]:checked').val(),
         back: $('input[name=back]').val(),
         pid: $('input[name=pid]').val(),
         token: token
      },
      success: function (jsonData) {
         $('#create-account_form .error_message').hide();

         if (jsonData.hasError) {
            //var errors = '';
            $.each(jsonData.errors, function (index, value) {
               $("#" + index).show();
               $("#" + index).html(value);
            });
         }
         else {
            $('#SubmitCreate').hide();
            $('#create_success').show();

            parsed_pid = parseInt(jsonData.pid);
            parsed_paid = parseInt(jsonData.paid);

            if (parsed_pid > 0) {
               WishlistCart('wishlist_block_list', 'add', parsed_pid, parsed_paid, 1);
            }

            if($('#complete-account_form').length) {
               $('.auth-boxes > form').show();
               $('#complete-account_form').fadeIn(3000);
               $('html, body').animate({
                  scrollTop: $('#complete-account_form').offset().top
               }, 2500);
            }
         }
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
         error = "TECHNICAL ERROR: unable to load form #createAccount.\n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
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

function completeAccount() {
   $('#complete_account_error').html('').hide();

   $.ajax({
      type: 'POST',
      url: baseUri + '?rand=' + new Date().getTime(),
      async: false,
      cache: false,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      data: {
         controller: 'authentication',
         SubmitComplete: 1,
         ajax: false,
         lastname_complete: $('#lastname_complete').val(),
         firstname_complete: $('#firstname_complete').val(),
         gender_complete: $('input[name=id_gender]:checked').val(),
         address_complete: $('input[name=address_complete]').val(),
         postal_code: $('input[name=postal_code]').val(),
         locality: $('input[name=locality]').val(),
         country: $('input[name=country]').val(),
         alias: $('input[name=address_alias]').val(),
         back: $('input[name=back]').val(),
         token: token
      },
      success: function (jsonData) {
         $('#complete-account_form .error_message').hide();

         if (jsonData.hasError) {
            //var errors = '';
            $.each(jsonData.errors, function (index, value) {
               $("#" + index).show();
               $("#" + index).html(value);
            });
         } else {
            if (parsed_pid > 0) {
               window.location.replace('?controller=authentication&content_only=1&message=addToWishlistCreateAccountOK');
            }
            else if (!!$.prototype.fancybox) {
               $.fancybox([
                  {
                     type: 'iframe',
                     href: '?controller=authentication&content_only=1&message=completeAccountOK',
                     width: 965
                  }
               ], {
                  'beforeClose': function () {
                     window.parent.location.replace('./');
                  }
               });
            }
            else
               alert(error);
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
