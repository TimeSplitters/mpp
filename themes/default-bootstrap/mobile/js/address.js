$(document).ready(function() {
    $('#submitAddress').on('click', function(e) {
        $('#success').hide();
        $('.error_message').hide();
        $('.success_message').hide();
        e.preventDefault();
        $.ajax({
            type: 'POST',
            url: baseUri + '?rand=' + new Date().getTime(),
            async: false,
            cache: false,
            dataType: "json",
            headers: {"cache-control": "no-cache"},
            data: {
                controller: 'address',
                ajax: true,
                firstname: $('#firstname').val(),
                lastname: $('#lastname').val(),
                address1: $('#address1').val(),
                address2: $('#address2').val(),
                postcode: $('#postal_code').val(),
                city: $('#locality').val(),
                country: $('#country').val(),
                phone: $('#phone').val(),
                phone_required: $('#phone_required').val(),
                alias: $('#alias').val(),
                id_address: $('input[name="id_address"]').val(),
                submitAddress: true,
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
                    var toTag;
                    // Creation
                    if(jsonData.successMsg == 1) {
                        toTag = $('#success_add');
                    } else {
                        toTag = $('#success_update');
                    }

                    $('.form-group, #submitAddress').hide(400).promise().done(function(){
                        toTag.show();
                        parent.$.fancybox.update();
                        $(document).delay(3000).queue(function() {
                            window.parent.$.fancybox.close();
                        });
                    });

                    $('html,body').animate({
                        scrollTop: $('header').offset().top
                    }, 400);
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