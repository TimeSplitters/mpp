$(document).ready(function() {
    $('#my-account-identity-tabs').idTabs();
    $(document).trigger('hashchange');

    $('button[name="submitIdentity"]').on('click', function(e) {
        e.preventDefault();
        $('#success').hide();
        $('.error_message').hide();
        $('.success_message').hide();
        $.ajax({
            type: 'POST',
            url: baseUri + '?rand=' + new Date().getTime(),
            async: false,
            cache: false,
            dataType: "json",
            headers: {"cache-control": "no-cache"},
            data: {
                controller: 'identity',
                ajax: true,
                gender: $('input[name="id_gender"]:checked').val(),
                firstname: $('input[name="firstname"]').val(),
                lastname: $('input[name="lastname"]').val(),
                days: $('input[name="days"]').val(),
                months: $('input[name="months"]').val(),
                years: $('input[name="years"]').val(),
                email: $('input[name="email"]').val(),
                old_passwd: $('input[name="old_passwd"]').val(),
                passwd: $('input[name="passwd"]').val(),
                passwd2: $('input[name="passwd2"]').val(),
                newsletter: $('input[name="newsletter"]:checked').val(),
                submitIdentity: true,
                token: static_token
            },
            success: function (jsonData) {
                if (jsonData.hasError) {
                    //var errors = '';
                    $.each(jsonData.errors, function (index, value) {
                        $("#" + index+"_error").show();
                        $("#" + index+"_error").html(value);
                    });
                } else {
                    $('.success_message').show();
                    $('input[type=password]').val('').focusout();
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
    });
});

$(window).bind('hashchange', function () {
    var hash = window.location.hash;
    hash = hash.replace( /^#/, '' );

    if(hash == 'tab-identity' || hash == 'tab-addresses' || hash == 'tab-newsletters') {
        $('#my-account-identity-tabs > ul > li > a[href="#'+hash+'"]').trigger('click');
    }
});