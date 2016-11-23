$(document).ready(function () {
    if (!$('#id_address_billing').is(":visible")) {
        $('#id_address_billing_sentence').hide();
        $("#add_billing_address").hide();
    }

    if ($('.delivery_option_radio').filter(':checked').length == $('#select_product_shipping .cart_product_shipping').length) {
        $('#continue_shipping_button').prop('disabled', false);
    } else {
        $('#continue_shipping_button').prop('disabled', true);
    }

    $(document).on('click', '#got_account', function () {
        $('#got_account').hide();
        $('#no_account').show();
        $('#create-account_form').hide();
        $('#login_form').show();
        //$('#opc_account .order_continue_button').hide();
    });

    $(document).on('click', '#no_account', function () {
        $('#got_account').show();
        $('#no_account').hide();
        $('#create-account_form').show();
        $('#login_form').hide();
        //$('#opc_account .order_continue_button').show();
    });

    $(document).on('click', 'input[name=same]', function () {
        if ($(this).filter(':checked').val() == 1) {
            $('#id_address_billing').stop(true).fadeOut(800);
            $('#id_address_billing_sentence').stop(true).fadeOut(800);
            $('#update_billing_address').stop(true).fadeOut(800);
            $('#add_billing_address').stop(true).fadeOut(800);
            //$('#delivery_address_fieldset > fieldset').prop('disabled', false);

            //$('#billing_address_displayed').slideDown('slow');
            $('#add_billing_address_form').slideUp('slow');
            /*$('#add_billing_address_form').slideUp('slow').promise().done(function () {
             $('#billing_address_displayed').slideDown('slow');
             });*/

            $('#add_billing_address_form .error_message').hide();

            if (typeof addressesWorld != 'undefined' && addressesWorld != null) {
                var address_id = $('#id_address_delivery').val();
                $.each(addressesWorld, function (i, addr) {
                    if (addr.id_address == address_id) {
                        $('#billing_address_displayed .displayed_address_lastname').html(addr.lastname);
                        $('#billing_address_displayed .displayed_address_firstname').html(addr.firstname);
                        $('#billing_address_displayed .displayed_address_address1').html(addr.address1);
                        $('#billing_address_displayed .displayed_address_address2').html(addr.address2);
                        $('#billing_address_displayed .displayed_address_postcode').html(addr.postcode);
                        $('#billing_address_displayed .displayed_address_city').html(addr.city);
                        $('#billing_address_displayed .displayed_address_country').html(addr.country);
                        $('#billing_address_displayed .displayed_address_phone').empty().html(addr.phone);
                        $('#id_address_billing').val(address_id);
                    }
                });
            }
        } else {
            $('#id_address_billing').val($('#id_address_delivery').val());
            $('#update_billing_address').stop(true).fadeIn(800);
            if (addressesWorld != null && addressesWorld.length > 0) {
                $('#id_address_billing_sentence').stop(true).fadeIn(800);
                $('#id_address_billing').stop(true).fadeIn(800);
                $('#add_billing_address').stop(true).fadeIn(800);
            } else {
                $('#add_billing_address_form').stop(true).slideDown('slow');
                $('#id_address_billing_sentence').stop(true).fadeOut(800);
                $('#id_address_billing').stop(true).fadeOut(800);
            }

            if (!userIsLoggedIn()) {
                $('#add_billing_address').hide();
            }

            //$('#billing_address_displayed').stop(true).slideUp('slow').promise().done(function () {
            //$('#delivery_address_fieldset > fieldset').prop('disabled', true);
            //});
        }
    });

    $(document).on('change', '#id_address_delivery', function () {
        var address_id = $(this).val();

        $.each(addresses, function (i, addr) {
            if (addr.id_address == address_id) {

                $('#delivery_address_displayed .displayed_address_lastname').html(addr.lastname);
                $('#delivery_address_displayed .displayed_address_firstname').html(addr.firstname);
                $('#delivery_address_displayed .displayed_address_address1').html(addr.address1);
                $('#delivery_address_displayed .displayed_address_address2').html(addr.address2);
                $('#delivery_address_displayed .displayed_address_postcode').html(addr.postcode);
                $('#delivery_address_displayed .displayed_address_city').html(addr.city);
                $('#delivery_address_displayed .displayed_address_country').html(addr.country);

                $('#update_delivery_address').attr('data-address-id', addr.id_address);
                if (addr.phone == "") {
                    $('#delivery_address_displayed .displayed_address_phone').empty().html('<span class="alert-warning">N° Tel. manquant</span>');
                    $('#add_delivery_address_form #phone').addClass('alert-warning');
                    $('#update_delivery_address').trigger('click');
                    return;
                } else {
                    $('#delivery_address_displayed .displayed_address_phone').html(addr.phone);
                    $('#p_edit_delivery_address').hide();
                    $('#add_delivery_address_form').stop(true).slideUp('slow');

                }
                if ($('input[name=same]').filter(':checked').val() == "1") {
                    $('#id_address_billing').val(address_id);
                    $('#id_address_billing').trigger("change");
                }

            }
            /*            if($('#add_delivery_address_form').is(":hidden")){
             $('#add_delivery_address_form').slideDown();
             $.each(addr,function($key,$val){
             $key=($key=="postcode")?"postal_code":$key;
             $key=($key=="city")?"locality":$key;
             $('#add_delivery_address_form input[name="'+$key+'"]').val($val).filter(function(){return this.value!="";}).focusin().focusout();
             });

             }*/
        });
    });

    $(document).on('change', '#id_address_billing', function () {
        var address_id = $(this).val();

        $.each(addressesWorld, function (i, addr) {
            if (addr.id_address == address_id) {

                $('#billing_address_displayed .displayed_address_lastname').html(addr.lastname);
                $('#add_billing_address_form input[name="lastname"]').val(addr.lastname);
                $('#billing_address_displayed .displayed_address_firstname').html(addr.firstname);
                $('#add_billing_address_form input[name="firstname"]').val(addr.firstname);
                $('#billing_address_displayed .displayed_address_address1').html(addr.address1);
                $('#add_billing_address_form input[name="address1"]').val(addr.address1);
                $('#billing_address_displayed .displayed_address_address2').html(addr.address2);
                $('#add_billing_address_form input[name="address2"]').val(addr.address2);
                $('#billing_address_displayed .displayed_address_postcode').html(addr.postcode);
                $('#add_billing_address_form input[name="postal_code"]').val(addr.postcode);
                $('#billing_address_displayed .displayed_address_city').html(addr.city);
                $('#add_billing_address_form input[name="locality"]').val(addr.city);
                $('#billing_address_displayed .displayed_address_country').html(addr.country);
                $('#add_billing_address_form input[name="country"]').val(addr.country);
                $('#add_billing_address_form input').focusin().focusout();

                $('#update_billing_address').attr('data-address-id', addr.id_address);
            }
        });

        $('#add_billing_address_form').slideUp(800);

        /* if(address_id != $('#id_address_delivery').val()) {
         $('#addressesAreNotEquals').trigger('click');
         $('input[name=same][value="0"]').trigger('click');
         } else {
         $('#addressesAreEquals').trigger('click');
         $('input[name=same][value="1"]').trigger('click');
         }*/
    });

    $(document).on('click', '#update_delivery_address', function () {
        var address_id = $(this).attr('data-address-id');
        $('#add_delivery_address_form input[name="id_address"]').val(address_id);
        no_phone = false;
        $.each(addresses, function (i, addr) {
            if (addr.id_address == address_id) {
                $('#add_delivery_address_form input[name="lastname"]').val(addr.lastname);
                $('#add_delivery_address_form input[name="firstname"]').val(addr.firstname);
                $('#add_delivery_address_form input[name="address1"]').val(addr.address1);
                $('#add_delivery_address_form input[name="address2"]').val(addr.address2);
                $('#add_delivery_address_form input[name="postal_code"]').val(addr.postcode);
                $('#add_delivery_address_form input[name="locality"]').val(addr.city);
                $('#add_delivery_address_form input[name="country"]').val(addr.country);
                $('#add_delivery_address_form input[name="phone"]').val(addr.phone);
                if (addr.phone == "") {
                    no_phone = true;
                }
            }
        });

        $('#add_delivery_address_form input').each(function () {
            if ($(this).val() != '') {
                $(this).focusin().focusout();
            }
        });

        //$('#billing_address_fieldset > fieldset').prop('disabled', true);
        if (!no_phone) {
            $('#delivery_address_displayed').slideUp('slow').promise().done(function () {
                $('#p_edit_delivery_address').show();
                $('#add_delivery_address_form').slideDown('slow');
            });
        } else {
            $('#p_edit_delivery_address').show();
            $('#add_delivery_address_form').slideDown('slow');
        }
    });

    $(document).on('click', '#update_billing_address', function () {
        var address_id = $(this).attr('data-address-id');
        $('#add_delivery_address_form input[name="id_address"]').val(0);

        $.each(addressesWorld, function (i, addr) {
            if (addr.id_address == address_id) {
                $('#add_billing_address_form input[name="lastname"]').val(addr.lastname);
                $('#add_billing_address_form input[name="firstname"]').val(addr.firstname);
                $('#add_billing_address_form input[name="address1"]').val(addr.address1);
                $('#add_billing_address_form input[name="address2"]').val(addr.address2);
                $('#add_billing_address_form input[name="postal_code"]').val(addr.postcode);
                $('#add_billing_address_form input[name="locality"]').val(addr.city);
                //$('#add_billing_address_form input[name="country"]').val(addr.country);
                $('#add_billing_address_form input[name="phone"]').val(addr.phone);
            }
        });

        $('#add_billing_address_form input').each(function () {
            if ($(this).val() != '') {
                $(this).focusin().focusout();
            }
        });

        //$('#billing_address_displayed').stop(true).slideUp('slow').promise().done(function () {
        //$('#delivery_address_fieldset > fieldset').prop('disabled', true);
        //});
        $('#add_billing_address_form').stop(true).slideDown('slow');
    });

    $(document).on('click', '#add_delivery_address', function () {
        $('#add_delivery_address_form input[name="id_address"]').val(0);
        $('#add_delivery_address_form input').each(function () {
            if ($.inArray($(this).attr('name'), ['country', 'address_alias', 'phone_required', 'back', 'id_address']) == -1) {
                $(this).val('');
            }
            $(this).focusin().focusout();
        });

        $('#delivery_address_displayed').stop(true).slideUp('slow').promise().done(function () {
            $('#p_new_delivery_address').stop(true).show();
            $('#add_delivery_address_cancel').stop(true).show();
            $('#add_delivery_address_form').stop(true).slideDown('slow');
        });
    });

    $(document).on('click', '#add_billing_address', function () {
        //$('#addressesAreNotEquals').prop('checked', true);
        //$('#addressesAreEquals').prop('checked', false);
        $('#add_billing_address_form input').each(function () {
            if ($.inArray($(this).attr('name'), ['country', 'address_alias', 'phone_required', 'back', 'id_address']) == -1) {
                $(this).val('');
            }
            $(this).focusin().focusout();
        });

        /*if ($('#add_billing_address_form input[name="country"]').is(':visible')) {
         $('#add_billing_address_form').stop(true).slideUp();
         } else {
         }*/
        $('#add_billing_address_form').stop(true).slideDown();
    });

    var addedAddr;
    $(document).on('submit', '#add_delivery_address_form, #add_billing_address_form', function (e) {
        e.preventDefault();
        var activeForm = $(this);
        var same = id_address_billing = "";
        same = "&same=true";
        if ($('input[name="same"]:checked').val() == 0) {
            id_address_billing = "&id_address_invoice=" + $('#id_address_billing').val();
            //cf : same=Tools::isSubmit('same')
        }
        $.ajax({
            type: 'GET',
            headers: {"cache-control": "no-cache"},
            url: baseUri + '?rand=' + new Date().getTime() + '&controller=order&ajax=true&action=addDeliveryAddress' + id_address_billing + '&token=' + static_token,
            async: false,
            cache: false,
            dataType: "json",
            data: activeForm.serialize(),
            success: function (jsonData) {
                activeForm.find('.error_message').hide();
                console.log(jsonData.errors);

                if (jsonData.hasError) {
                    $.each(jsonData.errors, function (index, value) {
                        activeForm.find("." + index).show();
                        activeForm.find("." + index).html(value);
                    });
                }
                else {
                    activeForm.hide();
                    activeForm.parent().find('.displayed_address').removeClass('unvisible').show();
                    activeForm.find('input').removeClass('alert-warning');
                    addedAddr = JSON.parse(jsonData.addedAddress);
                    console.log(' ok2');

                    addressesWorld = JSON.parse(jsonData.addresses);

                    var options = '';
                    $.each(addressesWorld, function (i, addr) {
                        options += '<option value="' + addr.id_address + '">'
                            //+ addr.alias + ' – '
                            + addr.lastname + ' '
                            + addr.firstname + ', '
                            + addr.address1 + ' '
                            + addr.address2 + ' '
                            + addr.postcode + ' '
                            + addr.city + '</option>';
                    });

                    if ($('input[name="same"]:checked').val() != 1) {
                        $oldval = $('#id_address_billing').val();
                        $('#id_address_billing').html(options).val($oldval);
                    } else {
                        $('#id_address_billing').html(options).val(addedAddr.id);
                    }
                    if (activeForm.is('#add_billing_address_form')) {
                        $oldval = $('#id_address_delivery').val();
                        $('#id_address_delivery').html(options).val($oldval);
                    }

                    if (addedAddr.country == 'France') {
                        addresses = JSON.parse(jsonData.addresses);

                        var options = '';
                        $.each(addresses, function (i, addr) {
                            options += '<option value="' + addr.id_address + '">'
                                //+ addr.alias + ' – '
                                + addr.lastname + ' '
                                + addr.firstname + ', '
                                + addr.address1 + ' '
                                + addr.address2 + ' '
                                + addr.postcode + ' '
                                + addr.city + '</option>';
                        });


                        if (activeForm.is('#add_delivery_address_form')) {
                            $('#id_address_delivery').html(options);
                        }

                    }

                    if ($('input[name=same]').filter(':checked').val() == 1) {
                        $('.addresses_lists').each(function () {
                            $('#' + $(this).prop('id')).val(addedAddr.id);
                            $('#' + $(this).prop('id')).trigger('change');
                        });
                    } else {
                        activeForm.parent().find('.addresses_lists').each(function () {
                            $('#' + $(this).prop('id')).val(addedAddr.id);
                            $('#' + $(this).prop('id')).trigger('change');
                        });
                    }

                    $('#add_billing_address_submit').show();
                    $('#add_delivery_address_submit').show();
                    $('#add_delivery_address_cancel').show();

                    activeForm.find('input[name="id_address"]').val(addedAddr.id);
                    $('#p_new_delivery_address').hide();
                    $('#p_edit_delivery_address').hide();
                    console.log(' ok3');

                    $('html, body').animate({
                        scrollTop: activeForm.closest(':has(h3)').find('h3').offset().top
                    }, 800);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                if (textStatus !== 'abort') {
                    error = "TECHNICAL ERROR: unable to save adresses \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
                    if (!!$.prototype.fancybox)
                        $.fancybox.open([
                            {
                                type: 'inline',
                                autoScale: true,
                                minHeight: 30,
                                content: '<p class="fancybox-error">' + error + '</p>'
                            }
                        ], {
                            padding: 0
                        });
                    else
                        alert(error);
                }
            }
        });
    });

    $(document).on('click', '#processAddress', function (e) {
        e.preventDefault();

        var countErrors = 0;

        if (!userIsLoggedIn()) {
            $('#create-account_form').trigger('submit');
            $('#login_form').trigger('submit');

            countErrors = $('.error_message:visible').length;

            if (countErrors > 0) {
                $('html, body').animate({
                    scrollTop: $('h3[data-step-id="1"]').offset().top
                }, 800);
            }
        }

        if (countErrors == 0) {
            if ($('#addresses_table').is(':visible')) {
                $('#login_create_table').stop(true).slideUp().promise().done(function () {
                    $('#add_delivery_address_form').trigger('submit');

                    if ($('input[name=same]').filter(':checked').val() == 0 && $('#add_billing_address_form').is(':visible')) {
                        $('#add_billing_address_form').trigger('submit');
                    }

                    countErrors = $('.error_message:visible').length;

                    if (countErrors > 0) {
                        $('html, body').animate({
                            scrollTop: $('h3[data-step-id="1"]').offset().top
                        }, 800);
                    }
                    else {
                        $.ajax({
                            type: 'GET',
                            headers: {"cache-control": "no-cache"},
                            url: baseUri + '?rand=' + new Date().getTime() + '&controller=order&ajax=true&action=nextStep&step=1&token=' + static_token,
                            async: false,
                            cache: false,
                            dataType: "json",
                            data: {
                                'ajax': true,
                                'id_address_delivery': $('#id_address_delivery').val(),
                                'id_address_invoice': $('#id_address_billing').val()
                            },
                            success: function (jsonData) {
                                if (jsonData.hasError === true) {
                                    $.each(JSON.parse(jsonData.errors), function (index, value) {
                                        $("." + index + ", #" + index).show();
                                        $("." + index + ", #" + index).html(value);
                                    });
                                }
                                else {
                                    $('html, body').animate({
                                        scrollTop: $('h3[data-step-id="1"]').offset().top
                                    }, 1000).promise().done(function () {
                                        $('#opc_account').slideUp().promise().done(function () {

                                            //$('#addressStepResume').css('display', 'block');
                                            $('#addressStepResume').hide();

                                            if ($('#email_create').length) {
                                                $('#addressResumeLogin #created_mail').val(
                                                    $('#email_create').val()
                                                );

                                                $('#addressResumeLogin #created_passwd').val(
                                                    $('#passwd1').val()
                                                );
                                            }


                                            $('#addressStepResume #addressResumeDelivery > div:last-child').html(
                                                $('#delivery_address_displayed blockquote > div').html()
                                            );
                                            $('#add_delivery_address_form').hide();
                                            $('#addressStepEditButton').show();
                                            $('#shippingStepEditButton').hide();
                                            $('#carrier_area').slideDown(800);
                                            $('#add_delivery_address').removeClass('hidden');
                                            $('#login_create_table').hide();
                                            $('#delivery_address_displayed').fadeIn(800);
                                            $('#add_billing_address').fadeIn(800);
                                            $('.user_address_blockquote').fadeIn(800);
                                            $('#add_billing_address_submit').fadeIn(800);

                                            $('h3[data-step-id="1"]>span:first-child').removeClass('step-active');
                                            $('h3[data-step-id="2"]>span:first-child').addClass('step-active');
                                            $('h3[data-step-id="1"]>span:last-child').addClass('icon-valid');
                                            $('.form_global_fieldset').removeClass('disabled');
                                        });
                                    });
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                if (textStatus !== 'abort') {
                                    error = "TECHNICAL ERROR: unable to save adresses \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
                                    if (!!$.prototype.fancybox)
                                        $.fancybox.open([
                                            {
                                                type: 'inline',
                                                autoScale: true,
                                                minHeight: 30,
                                                content: '<p class="fancybox-error">' + error + '</p>'
                                            }
                                        ], {
                                            padding: 0
                                        });
                                    else
                                        alert(error);
                                }
                            }
                        });
                    }
                });
            } else {
                $('#addresses_table').removeClass('hidden');
                $('#login_create_table').addClass('hidden');
            }
        }
    });

    $(document).on('click', '#add_delivery_address_cancel', function (e) {
        e.preventDefault();

        $('#add_delivery_address_form').slideUp('slow').promise().done(function () {
            $('#delivery_address_displayed').slideDown('slow');
            //$('#billing_address_fieldset > fieldset').prop('disabled', false);
            $('#p_new_delivery_address').hide();
            $('#p_edit_delivery_address').hide();
            $('#add_delivery_address_form .error_message').hide();
        });

        var address_id = $("#id_address_delivery").val();
        no_phone = false;
        $.each(addresses, function (i, addr) {
            if (addr.id_address == address_id && addr.phone == "") {
                no_phone = true;
            }
        });
        if (no_phone) {
            $.each(addresses, function (i, addr) {
                if (addr.phonae != "") {
                    $('#id_address_delivery').val(addr.id_address).trigger('change');
                }
            });
        }

        $('html, body').animate({
            scrollTop: $('h3[data-step-id="1"]').offset().top
        }, 800);
    });

    $(document).on('click', '#add_billing_address_cancel', function (e) {
        e.preventDefault();

        $('#add_billing_address_form').slideUp('slow').promise().done(function () {
            $('#p_new_billing_address').hide();
            $('#p_edit_billing_address').hide();
            $('#add_billing_address_form .error_message').hide();
        });
    });
});

//update the display of the addresses
function updateAddressesDisplay(first_view) {
    // update content of delivery address
    updateAddressDisplay('delivery');
    var txtInvoiceTitle = "";
    try {
        var adrs_titles = getAddressesTitles();
        txtInvoiceTitle = adrs_titles.invoice;
    }
    catch (e) {
    }
    // update content of invoice address
    //if addresses have to be equals...
    if ($('#addressesAreEquals:checked').length === 1 && ($('#multishipping_mode_checkbox:checked').length === 0)) {
        if ($('#multishipping_mode_checkbox:checked').length === 0) {
            $('#address_invoice_form:visible').hide('fast');
        }
        $('ul#address_invoice').html($('ul#address_delivery').html());
        $('ul#address_invoice li.address_title').html(txtInvoiceTitle);
    }
    else {
        $('#address_invoice_form:hidden').show('fast');
        if ($('#id_address_billing').val())
            updateAddressDisplay('invoice');
        else {
            $('ul#address_invoice').html($('ul#address_delivery').html());
            $('ul#address_invoice li.address_title').html(txtInvoiceTitle);
        }
    }
    if (!first_view) {
        if (orderProcess === 'order')
            updateAddresses();
    }
    return true;
}

function updateAddressDisplay(addressType) {
    if (typeof formatedAddressFieldsValuesList == 'undefined' || (formatedAddressFieldsValuesList != null && formatedAddressFieldsValuesList.length <= 0))
        return;

    var idAddress = parseInt($('#id_address_' + addressType + '').val());
    buildAddressBlock(idAddress, addressType, $('#address_' + addressType));

    // change update link
    var link = $('ul#address_' + addressType + ' li.address_update a').attr('href');
    var expression = /id_address=\d+/;
    if (link) {
        link = link.replace(expression, 'id_address=' + idAddress);
        $('ul#address_' + addressType + ' li.address_update a').attr('href', link);
    }
}

function updateAddresses() {
    var idAddress_delivery = parseInt($('#id_address_delivery').val());
    var idAddress_invoice = ($('input[name=same]').filter(':checked').val() == 1) ? idAddress_delivery : parseInt($('#id_address_billing').val());

    if (isNaN(idAddress_delivery) == false && isNaN(idAddress_invoice) == false) {
        //$('.addresses .waitimage').show();
        //$('[name="processAddress"]').prop('disabled', 'disabled');
        $.ajax({
            type: 'POST',
            headers: {"cache-control": "no-cache"},
            url: baseUri + '?rand=' + new Date().getTime(),
            async: true,
            cache: false,
            dataType: "json",
            data: {
                processAddress: true,
                step: 2,
                ajax: 'true',
                controller: 'order',
                'multi-shipping': $('#id_address_delivery:hidden').length,
                id_address_delivery: idAddress_delivery,
                id_address_invoice: idAddress_invoice,
                token: static_token
            },
            success: function (jsonData) {
                if (jsonData.hasError) {
                    var errors = '';
                    for (var error in jsonData.errors)
                        //IE6 bug fix
                        if (error !== 'indexOf')
                            errors += $('<div />').html(jsonData.errors[error]).text() + "\n";
                    if (!!$.prototype.fancybox)
                        $.fancybox.open([
                            {
                                type: 'inline',
                                autoScale: true,
                                minHeight: 30,
                                content: '<p class="fancybox-error">' + errors + '</p>'
                            }
                        ], {
                            padding: 0
                        });
                    else
                        alert(errors);
                }
                $('.addresses .waitimage').hide();
                $('[name="processAddress"]').prop('disabled', '');
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $('.addresses .waitimage').hide();
                $('[name="processAddress"]').prop('disabled', '');
                if (textStatus !== 'abort') {
                    error = "TECHNICAL ERROR: unable to save adresses \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
                    if (!!$.prototype.fancybox)
                        $.fancybox.open([
                            {
                                type: 'inline',
                                autoScale: true,
                                minHeight: 30,
                                content: '<p class="fancybox-error">' + error + '</p>'
                            }
                        ], {
                            padding: 0
                        });
                    else
                        alert(error);
                }
            }
        });
    }
}

function getAddressesTitles() {
    if (typeof titleInvoice !== 'undefined' && typeof titleDelivery !== 'undefined')
        return {
            'invoice': titleInvoice,
            'delivery': titleDelivery
        };
    else
        return {
            'invoice': '',
            'delivery': ''
        };
}

function buildAddressBlock(id_address, address_type, dest_comp) {
    if (isNaN(id_address))
        return;
    var adr_titles_vals = getAddressesTitles();
    var li_content = formatedAddressFieldsValuesList[id_address]['formated_fields_values'];
    var ordered_fields_name = ['title'];
    var reg = new RegExp("[ ]+", "g");
    ordered_fields_name = ordered_fields_name.concat(formatedAddressFieldsValuesList[id_address]['ordered_fields']);
    ordered_fields_name = ordered_fields_name.concat(['update']);
    dest_comp.html('');
    li_content['title'] = adr_titles_vals[address_type];
    if (typeof liUpdate !== 'undefined') {
        var items = liUpdate.split(reg);
        var regUrl = new RegExp('(https?://[^"]*)', 'gi');
        liUpdate = liUpdate.replace(regUrl, addressUrlAdd + parseInt(id_address));
        li_content['update'] = liUpdate;
    }
    appendAddressList(dest_comp, li_content, ordered_fields_name);
}

function appendAddressList(dest_comp, values, fields_name) {
    for (var item in fields_name) {
        var name = fields_name[item].replace(/,/g, "");
        var value = getFieldValue(name, values);
        if (value != "") {
            var new_li = document.createElement('li');
            var reg = new RegExp("[ ]+", "g");
            var classes = name.split(reg);
            new_li.className = '';
            for (clas in classes)
                new_li.className += 'address_' + classes[clas].toLowerCase().replace(":", "_") + ' ';
            new_li.className = $.trim(new_li.className);
            new_li.innerHTML = value;
            dest_comp.append(new_li);
        }
    }
}

function getFieldValue(field_name, values) {
    var reg = new RegExp("[ ]+", "g");
    var items = field_name.split(reg);
    var vals = new Array();
    for (var field_item in items) {
        items[field_item] = items[field_item].replace(/,/g, "");
        vals.push(values[items[field_item]]);
    }
    return vals.join(" ");
}

(function ($) {
    $.each(['show', 'hide'], function (i, ev) {
        var el = $.fn[ev];
        $.fn[ev] = function () {
            this.trigger(ev);
            return el.apply(this, arguments);
        };
    });
})(jQuery);