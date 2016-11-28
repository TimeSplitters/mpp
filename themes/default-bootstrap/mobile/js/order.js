$(document).ready(function () {
    $('.order_payment_button_card button').prop('disabled', true);

    $('#form_button_payment').html(
        $('.order_payment_button_card').html()
    );

    $(document).on('click', 'div.button-login', function () {
        $.fancybox.open([
            {
                type: 'iframe',
                href: '?controller=authentication&content_only=1',
                width: 965
            }
        ], {
            'beforeClose': function () {
                window.parent.location.reload(false);
            }
        });
    });

    $(document).on('click', '#discount_delete_value span', function () {
        $('#discount_name').val("");
    });

    $(document).on('click', '#discount_name_link', function (e) {
        e.preventDefault();
        if ($('.discount_table').is(':visible') && $('.discount_table').val().length == 0) {
            $('.discount_table').addClass("unvisible");
        }
        else {
            $('.discount_table').removeClass('unvisible');
        }
    });


    $(document).on('click', '#order_payment_tabs > div > div.tabInactive > div', function (e) {
        e.preventDefault();
        $('#order_payment_tabs > div:first-child > div').removeClass('tabActive').addClass('tabInactive');
        $(this).parent().addClass('tabActive').removeClass('tabInactive');

        $('#order_payment_tabs .payment_content').hide();
        $("#"+$(this).attr('data-payment')).show();

        $(this).removeClass('btn-default').addClass('btn-primary');
        $('.tabInactive > div').removeClass('btn-primary').addClass('btn-default');

        $('.order_payment_button_form').hide();
        var form_button_paiement = $('#form_button_payment');
        if ($(this).attr('data-payment') == 'payment_paypal') {
            $('.order_payment_button_paypal').show();
            form_button_paiement.html("");
            form_button_paiement.html(
                $('.order_payment_button_paypal').clone()
            );
        } else {
            var opbc = $('.order_payment_button_card');
            opbc.show();
            form_button_paiement.html(
                opbc.html()
            );
        }

        $(this).blur();
    });

    $('#order_payment_tabs .payment_content:first').show();
    $('.order_payment_button_form:first').show();


    $(document).on('submit', 'form[name="carrier_area"]', function (e) {
        e.preventDefault();

    });

    $(document).on('submit', '#order_payment_form', function (e) {
        e.preventDefault();

    });

    $('.cart_product_shipping input').on('change', function (e) {
        var shipping_fees = 0.00;

        $(this).closest('.cart_product_shipping').find('.table-row').removeClass('select_delivery_option');
        $(this).closest('.table-row').addClass('select_delivery_option');

        var p_qty = 0;
        for (i in product_qty) {
            p_qty++;
        }

        var checked_qty = 0;
        $('.cart_product_shipping input:checked').each(function () {
            shipping_fees += parseFloat(delivery_vals[$(this).val()].replace(',', '.').replace(' ', '')) * product_qty[$(this).attr('data-product-id')];

            checked_qty++;
        });

        var total_product = parseFloat($("#total_product").html().replace(',', '.').replace(' ', ''));
        var discount = parseFloat($("#total_discount").html().replace(',', '.').replace(' ', ''));

        $("#total_shipping").html(formatCurrency(shipping_fees, currencyFormat, currencySign, currencyBlank));
        $("#total_price").html(formatCurrency((total_product + shipping_fees + discount), currencyFormat, currencySign, currencyBlank));

        $("#payment_paypal input[name=amount]").val((total_product + shipping_fees + discount).toFixed(2).replace(',', '.'));

        if (p_qty == checked_qty) {
            $('#continue_shipping_button').prop('disabled', false);
            $('#payment_paypal button[name="submit"]').prop('disabled', false);
        }
        else {
            $('#continue_shipping_button').prop('disabled', true);
            $('#payment_paypal button[name="submit"]').prop('disabled', true);
        }
    });


    $('#continue_shipping_button').on('click', function () {
        $.ajax({
            type: 'GET',
            headers: {"cache-control": "no-cache"},
            url: baseUri + '?rand=' + new Date().getTime() + '&controller=order&ajax=true&action=nextStep&step=2&token=' + static_token + '&' + $('form[name="carrier_area"]').serialize(),
            async: true,
            cache: false,
            dataType: "json",
            success: function (jsonData) {
                $("form[name='carrier_area'] .error_message").hide();
                if (jsonData.hasError) {
                    $.each(JSON.parse(jsonData.errors), function (index, value) {
                        $("form[name='carrier_area'] ." + index).show();
                        $("form[name='carrier_area'] ." + index).html(value);
                    });
                }
                else {
                    $('html, body').animate({
                        scrollTop: $('h3[data-step-id="2"]').offset().top
                    }, 1000).promise().done(function () {
                        $('#carrier_area').slideUp('slow').promise().done(function () {
                            $('h3[data-step-id="2"]>span:first-child').removeClass('step-active');
                            $('h3[data-step-id="3"]>span:first-child').addClass('step-active');
                            $('h3[data-step-id="2"]>span:last-child').addClass('icon-valid');
                            $('#shippingStepEditButton').show();
                            $('#order-payment-block').slideDown(800);
                        });
                    });
                }
            }
        });
    });

    $(document).on('click', '#addressStepEditButton, #shippingStepEditButton', function () {
        $(this).hide();
        var stepId = $(this).parent().attr('data-step-id');
        $('.opc-main-block').slideUp().promise().done(function () {
            $('html, body').animate({
                scrollTop: $('h3[data-step-id="' + stepId + '"]').offset().top
            }, 1000).promise().done(function () {
                $('h3.order-step > span:first-child').removeClass('step-active');
                $('h3.order-step[data-step-id="' + stepId + '"]>span:last-child').removeClass('icon-valid');
                if (stepId == 1) {
                    $('#addressStepResume').hide();
                    $('#addressStepEditButton').hide();
                    $('#opc_account').show();
                    $('#add_billing_address_cancel').show();
                    $('#add_billing_address_submit').show();
                    $('#opc_account .addresses').slideDown(800);
                    $('#opc_account .error_message').hide();
                    $('h3[data-step-id="1"]>span:first-child').addClass('step-active');
                    $('h3[data-step-id="2"]>span:first-child').removeClass('step-active');
                    $('h3[data-step-id="1"]>span:last-child').removeClass('icon-valid');
                    $('h3[data-step-id="2"]>button').hide();
                } else if (stepId == 2) {
                    $('#carrier_area').show();

                    $('h3[data-step-id="2"]>span:first-child').addClass('step-active');
                    $('h3[data-step-id="3"]>span:first-child').removeClass('step-active');
                    $('h3[data-step-id="2"]>span:last-child').removeClass('icon-valid');
                }
                if ($('input[name=same]').filter(':checked').val() == "1") {
                    $('#add_billing_address').hide();
                }
            });
        });
    });

    $('input[name="mercanet_card"]').on('click', function () {
        $('#payment_credit_card iframe').slideDown(800);
    });
});

function errorPayment(msg, method) {
    $('.errorPayment').remove();
    $error = $("<div />").addClass('alert alert-info errorPayment').html(msg[0])
        .append($("<a />").attr('href', "/nous-contacter?id_contact=7").html("Signalez-nous un problème"));
    $('#order-payment-block').prepend($error).hide().fadeIn(1000);
    if (method == "mercanet") {
        $("#mercanet-form input:checked").trigger('click');
    }


}