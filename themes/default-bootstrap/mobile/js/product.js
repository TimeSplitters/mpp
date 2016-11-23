var consoleX = 0;
var time = (new Date()).getTime();
var hashCombId;
var serialScrollNbImagesDisplayed;
var selectedCombination = [];
var globalQuantity = 0;
var colors = [];
var original_url = window.location + '';
var first_url_check = true;
var firstTime = true;
var preventAutoChange = false;

var swipeEnabled = true;
var isSwipping = true;
$(document).ready(function () {
    var found_combination_index = the_combination_id;
    if (typeof combinationImages !== 'undefined' && combinationImages) {
        combinationImagesJS = [];
        combinationImagesJS[0] = [];
        var k = 0;
        for (var i in combinationImages) {
            combinationImagesJS[i] = [];
            for (var j in combinationImages[i]) {
                var id_image = parseInt(combinationImages[i][j]['id_image']);
                if (id_image !== null) {
                    combinationImagesJS[0][k++] = id_image;
                    combinationImagesJS[i][j] = [];
                    combinationImagesJS[i][j] = id_image;
                }
            }
        }
        if (typeof combinationImagesJS[0] !== 'undefined' && combinationImagesJS[0]) {
            var array_values = [];
            for (var key in arrayUnique(combinationImagesJS[0]))
                array_values.push(combinationImagesJS[0][key]);
            combinationImagesJS[0] = array_values;
        }
        combinationImages = combinationImagesJS;
    }

    if (typeof combinations !== 'undefined' && combinations) {
        combinationsJS = [];
        var k = 0;
        for (var i in combinations) {
            k = i;
            globalQuantity += combinations[i]['quantity'];
            combinationsJS[k] = [];
            combinationsJS[k]['idCombination'] = parseInt(i);
            combinationsJS[k]['idsAttributes'] = combinations[i]['attributes'];
            combinationsJS[k]['attributesByGroup'] = combinations[i]['attributesByGroup'];
            combinationsJS[k]['quantity'] = combinations[i]['quantity'];
            combinationsJS[k]['price'] = combinations[i]['price'];
            combinationsJS[k]['shipping_fees'] = combinations[i]['shipping_fees'];
            combinationsJS[k]['ecotax'] = combinations[i]['ecotax'];
            combinationsJS[k]['image'] = parseInt(combinations[i]['id_image']);
            combinationsJS[k]['images_list'] = combinations[i]['images_list'];
            combinationsJS[k]['reference'] = combinations[i]['reference'];
            combinationsJS[k]['complement_description'] = combinations[i]['complement_description'];
            combinationsJS[k]['complement_resume'] = combinations[i]['complement_resume'];
            combinationsJS[k]['unit_price'] = combinations[i]['unit_impact'];
            combinationsJS[k]['list'] = combinations[i]['list'];
            combinationsJS[k]['minimal_quantity'] = parseInt(combinations[i]['minimal_quantity']);
            combinationsJS[k]['main_attributes'] = combinations[i]['main_attributes'];
            combinationsJS[k]['default_on'] = combinations[i]['default_on'];
            combinationsJS[k]['available_date'] = [];
            combinationsJS[k]['available_date']['date'] = combinations[i]['available_date'];
            combinationsJS[k]['available_date']['date_formatted'] = combinations[i]['date_formatted'];

            combinationsJS[k]['specific_price'] = [];
            combinationsJS[k]['specific_price']['reduction_percent'] = (combinations[i]['specific_price'] && combinations[i]['specific_price']['reduction'] && combinations[i]['specific_price']['reduction_type'] == 'percentage') ? combinations[i]['specific_price']['reduction'] * 100 : 0;
            combinationsJS[k]['specific_price']['reduction_price'] = (combinations[i]['specific_price'] && combinations[i]['specific_price']['reduction'] && combinations[i]['specific_price']['reduction_type'] == 'amount') ? combinations[i]['specific_price']['reduction'] : 0;
            combinationsJS[k]['price'] = (combinations[i]['specific_price'] && combinations[i]['specific_price']['price'] && parseInt(combinations[i]['specific_price']['price']) != -1) ? combinations[i]['specific_price']['price'] : combinations[i]['price'];

            combinationsJS[k]['reduction_type'] = (combinations[i]['specific_price'] && combinations[i]['specific_price']['reduction_type']) ? combinations[i]['specific_price']['reduction_type'] : '';
            combinationsJS[k]['id_product_attribute'] = (combinations[i]['specific_price'] && combinations[i]['specific_price']['id_product_attribute']) ? combinations[i]['specific_price']['id_product_attribute'] : 0;
            combinationsJS[k]['attributes_values'] = combinations[i]['attributes_values'];
            combinationsJS[k]['weight'] = combinations[i]['weight'];
            //k++;
        }
        combinations = combinationsJS;
    }

    Timer();

    $('#product_combinations_vignettes a').on('click', function (e) {
        e.preventDefault();
        $('#product_combinations_vignettes a').tooltip('hide');
        $(this).tooltip('show');
        window.location.hash = $(this).attr('href').replace(/([0-9a-z-_\.\/:]+)\?ipa=(\d+)/, '#/$2');
    });

    var quantity = $('#quantity_wanted').val();
    if (isNaN(quantity))
        $('#quantity_wanted').val(1);

    $('#closeZoom').on('click', function () {
        $('#zoomImg img').parent().hide().find('img').remove();
    });

    var hash = window.location.hash.match(/#\/(\d+)/);
    if(hash != null) {
        $(document).trigger('hashchange');
    }
});

$(window).bind('hashchange', function () {
    checkUrl();
});

//hover 'other views' images management
$(document).on('click', '#views_block li a', function (e) {
    e.preventDefault();
    displayImage($(this));
});

function arrayUnique(a) {
    return a.reduce(function (p, c) {
        if (p.indexOf(c) < 0)
            p.push(c);
        return p;
    }, []);
}

//check if a function exists
function function_exists(function_name) {
    if (typeof function_name === 'string')
        function_name = this.window[function_name];
    return typeof function_name === 'function';
}

//add a combination of attributes in the global JS sytem
function addCombination(idCombination, arrayOfIdAttributes, quantity, price, ecotax, id_image, reference, unit_price, minimal_quantity, available_date, combination_specific_price, complement_description, complement_resume) {
    globalQuantity += quantity;

    var combination = [];
    combination['idCombination'] = idCombination;
    combination['quantity'] = quantity;
    combination['idsAttributes'] = arrayOfIdAttributes;
    combination['price'] = price;
    combination['ecotax'] = ecotax;
    combination['image'] = id_image;
    combination['reference'] = reference;
    combination['complement_description'] = complement_description;
    combination['complement_resume'] = complement_resume;
    combination['unit_price'] = unit_price;
    combination['minimal_quantity'] = minimal_quantity;
    combination['available_date'] = [];
    combination['available_date'] = available_date;
    combination['specific_price'] = [];
    combination['specific_price'] = combination_specific_price;
    combinations.push(combination);
}
// search the combinations' case of attributes and update displaying of availability, prices, ecotax, and image
function findCombination() {
    if (typeof combinations == 'undefined' || !combinations)
        combinations = [];

    var default_combination_id = 0;
    var couleurMatiereComb = [];
    var found = false;
    for (var combination in combinations) {
        if (combinations[combination]['default_on'] == 1) {
            default_combination_id = combinations[combination]['idCombination'];
        }

        if (combinations[combination]['idCombination'] == hashCombId) {
            found_combination_index = combinations[combination]['idCombination'];
            found = true;
        }
    }
    if (!found) {
        found_combination_index = default_combination_id;
    }

    var attr_list = [];
    attr_list.push(
        [38, 'weight'],
        [24, 'typical_price'],
        [25, 'foot'],
        [12, 'finishing'],
        [26, 'maintenance'],
        [27, 'special_caracteristics'],
        [29, 'tray'],
        [23, 'tray_thickness'],
        [28, 'fabric'],
        [30, 'bulb_type'],
        [31, 'bulb_count'],
        [32, 'max_power'],
        [33, 'light_switch'],
        [34, 'cable_type'],
        [35, 'cable_length'],
        [36, 'fixation'],
        [37, 'light_color'],
        [39, 'composition_tissu']
    );

    $.each(attr_list, function (i, k) {
        if (combinations[found_combination_index]['attributes_values'][k[0]]) {
            $('.data_sheet_element.product_' + k[1]).removeClass('hidden');
            if (k[1] == 'typical_price') {
                $('#product_' + k[1]).html(formatCurrency(parseInt(combinations[found_combination_index]['attributes_values'][k[0]]), currencyFormat, currencySign, currencyBlank));
            } else {
                $('#product_' + k[1]).html(combinations[found_combination_index]['attributes_values'][k[0]]);
            }
        }
        else $('.data_sheet_element.product_' + k[1]).addClass('hidden');
    });

    $('#product_weight').html(parseFloat(initial_weight) + combinations[found_combination_index].weight + ' Kg');

    var product_materials = [];
    if (combinations[found_combination_index]['attributes_values'][11])
        product_materials.push(combinations[found_combination_index]['attributes_values'][11]);
    if (combinations[found_combination_index]['attributes_values'][14])
        product_materials.push(combinations[found_combination_index]['attributes_values'][14]);
    if (combinations[found_combination_index]['attributes_values'][15])
        product_materials.push(combinations[found_combination_index]['attributes_values'][15]);

    if (product_materials.length > 0) {
        $('.data_sheet_element.product_materials').removeClass('hidden');
        $('#product_materials').html(product_materials.join(', '));
    }
    else $('.data_sheet_element.product_materials').addClass('hidden');

    $('.delay_min').html(combinations[found_combination_index]['attributes_values'][9]);
    $('.delay_max').html(combinations[found_combination_index]['attributes_values'][10]);

    $('.shipping_fees').html(combinations[found_combination_index]['shipping_fees']);

    $('#complement_description').html(nl2br(combinations[found_combination_index]['complement_description']));
    $('#complement_resume').html(nl2br(combinations[found_combination_index]['complement_resume']));

    var d = new Date();
    var y = d.getFullYear();
    var m = d.getMonth() + 1;
    var da = d.getDate() + 1;
    var paDate = d;
    if(combinations[found_combination_index]['available_date'].date != "") {
        paDate = new Date(combinations[found_combination_index]['available_date'].date);
    }

    var force_express = combinations[found_combination_index]['attributes_values'][44];

    if ((combinations[found_combination_index]['quantity'] >= 1 || force_express == 'Oui') && paDate <= d) {
        $('.delay_express_delivery').removeClass('hidden');
        $('#no_express_delivery, #timer').addClass('hidden');
        stock_available_qty = combinations[found_combination_index]['quantity'];
        $('#available_stock_qty').html(stock_available_qty);
        if (force_express == 'Oui' || combinations[found_combination_index]['quantity'] > 5) {
            $('#available_stock').addClass('hidden');
        } else {
            $('#available_stock').removeClass('hidden');
        }
    } else {
        $('#no_express_delivery, #timer').removeClass('hidden');
        $('.delay_express_delivery, #available_stock').addClass('hidden');
    }

    if (paDate > d) {
        $('#add_to_cart button').prop('disabled', true);
        $('#add_to_cart button, #quantity_wanted-button, #timer, #available_stock').addClass('hidden');
        $('#add_to_cart span.epuise').removeClass('hidden');
    } else {
        $('#add_to_cart button, #quantity_wanted-button').prop('disabled', false);
        $('#add_to_cart button, #quantity_wanted-button').removeClass('hidden');
        $('#add_to_cart span.epuise').addClass('hidden');
    }

    preventAutoChange = false;
    /*
     var main_attr = [];

     $.each(combinations[found_combination_index]['main_attributes'], function (key, is_main) {
     if (is_main == 1)
     main_attr.push(combinations[found_combination_index]['attributes_values'][key]);
     });*/
    $('#product_main_caracteristics').html(combinations[found_combination_index]['attributes_values'][22]);
    $('#breadcrumb_product_main_caracteristics').html(', ' + combinations[found_combination_index]['attributes_values'][22]);

    if (typeof combinations[found_combination_index]['attributes_values'][8] != 'undefined') {
        $('.sale-box.macaron').removeClass('hidden');
        $('.sale-box.macaron .sale-label').html('<img src="' + baseUri + 'img/co/' + combinations[found_combination_index]["attributes_values"][8] + '.jpg" />');
    }
    else {
        $('.sale-box.macaron').addClass('hidden');
    }

    //combination of the user has been found in our specifications of combinations (created in back office)
    selectedCombination['unavailable'] = false;
    selectedCombination['reference'] = combinations[found_combination_index]['reference'];
    $('#idCombination').val(combinations[found_combination_index]['idCombination']);
    $('#wishlist_heart_product').attr('id', 'wishlist_heart_product' + combinations[found_combination_index]['idCombination']);

    var wish_heart = $('#wishlist_heart_product' + combinations[found_combination_index]['idCombination']);
    wish_heart.attr('rel', combinations[found_combination_index]['idCombination']);
    wish_heart.attr('onclick', "WishlistCart('wishlist_block_list', 'add', '" + id_product + "', '" + combinations[found_combination_index]['idCombination'] + "', 1); return false;");

    /*if(!isProductInWishlist(combinations[found_combination_index]['idCombination'])) {
     $(".wishlist_heart_product[rel='" + combinations[found_combination_index]['idCombination'] + "']").removeClass('product_no_wishlist').addClass('product_in_wishlist');
     } else {
     $(".wishlist_heart_product[rel='" + combinations[found_combination_index]['idCombination'] +"']").removeClass('product_in_wishlist').addClass('product_no_wishlist');
     }*/

    //get the data of product with these attributes
    quantityAvailable = combinations[found_combination_index]['quantity'];
    selectedCombination['price'] = combinations[found_combination_index]['price'];
    selectedCombination['unit_price'] = combinations[found_combination_index]['unit_price'];
    selectedCombination['specific_price'] = combinations[found_combination_index]['specific_price'];
    if (combinations[found_combination_index]['ecotax'])
        selectedCombination['ecotax'] = combinations[found_combination_index]['ecotax'];
    else
        selectedCombination['ecotax'] = default_eco_tax;

    refreshProductImages(found_combination_index);
    //show the large image in relation to the selected combination
    if (combinations[found_combination_index]['image'] && combinations[found_combination_index]['image'] != -1)
        displayImage($('#thumbs_list_frame li:visible').first().find('a'));

    //show discounts values according to the selected combination
    if (combinations[found_combination_index]['idCombination'] && combinations[found_combination_index]['idCombination'] > 0)
        displayDiscounts(combinations[found_combination_index]['idCombination']);

    //get available_date for combination product
    selectedCombination['available_date'] = combinations[found_combination_index]['available_date'];

    //this combination doesn't exist (not created in back office)
    selectedCombination['unavailable'] = true;
    if (typeof(selectedCombination['available_date']) != 'undefined')
        delete selectedCombination['available_date'];

    var DetailsDimensionsMinHeight = $('#product_section1_tabs > ul').outerHeight(true) + Math.max($('#product_section1_tab2').outerHeight(true), $('#product_section1_tab1').outerHeight(true));
    $('#product_section1_tabs').css('min-height', DetailsDimensionsMinHeight + 'px');

    updateDisplay();
    $('#image-block').carousel(0);
}

//update display of the availability of the product AND the prices of the product
function updateDisplay() {
    var productPriceDisplay = productPrice;
    var productPriceWithoutReductionDisplay = productPriceWithoutReduction;

    //if (!selectedCombination['unavailable'] && quantityAvailable > 0 && productAvailableForOrder == 1) {
    if (!selectedCombination['unavailable'] && productAvailableForOrder == 1) {
        //show the choice of quantities
        //$('#quantity_wanted_p:hidden').show('slow');
        //show the "add to cart" button ONLY if it was hidden
        //$('#add_to_cart:hidden').fadeIn(600);

        //hide the hook out of stock
        //$('#oosHook').hide();

        $('#availability_date').fadeOut();

        //availability value management
        /*
         if (stock_management && availableNowValue != '') {
         $('#availability_value').removeClass('label-warning').addClass('label-success').text(availableNowValue).show();
         $('#availability_statut:hidden').show('slow');
         }
         else
         $('#availability_statut:visible').hide('slow');

         //'last quantities' message management
         if (!allowBuyWhenOutOfStock) {
         if (quantityAvailable <= maxQuantityToAllowDisplayOfLastQuantityMessage)
         $('#last_quantities').show('slow');
         else
         $('#last_quantities').hide('slow');
         }

         if (quantitiesDisplayAllowed) {
         $('#pQuantityAvailable:hidden').show('slow');
         $('#quantityAvailable').text(quantityAvailable);

         if (quantityAvailable < 2) // we have 1 or less product in stock and need to show "item" instead of "items"
         {
         $('#quantityAvailableTxt').show();
         $('#quantityAvailableTxtMultiple').hide();
         }
         else {
         $('#quantityAvailableTxt').hide();
         $('#quantityAvailableTxtMultiple').show();
         }
         }*/
    }
    else {
        //show the hook out of stock
        /*
         if (productAvailableForOrder == 1) {
         $('#oosHook').show();
         if ($('#oosHook').length > 0 && function_exists('oosHookJsCode'))
         oosHookJsCode();
         }

         //hide 'last quantities' message if it was previously visible
         $('#last_quantities:visible').hide('slow');

         //hide the quantity of pieces if it was previously visible
         $('#pQuantityAvailable:visible').hide('slow');

         //hide the choice of quantities
         if (!allowBuyWhenOutOfStock)
         $('#quantity_wanted_p:visible').hide('slow');

         //display that the product is unavailable with theses attributes
         if (!selectedCombination['unavailable']) {
         $('#availability_value').text(doesntExistNoMore + (globalQuantity > 0 ? ' ' + doesntExistNoMoreBut : ''));
         if (!allowBuyWhenOutOfStock)
         $('#availability_value').removeClass('label-success').addClass('label-warning');
         }
         else {
         $('#availability_value').text(doesntExist).removeClass('label-success').addClass('label-warning');
         $('#oosHook').hide();
         }

         if ((stock_management == 1 && !allowBuyWhenOutOfStock) || (!stock_management && selectedCombination['unavailable']))
         $('#availability_statut:hidden').show();


         if (typeof(selectedCombination['available_date']) != 'undefined' && typeof(selectedCombination['available_date']['date_formatted']) != 'undefined' && selectedCombination['available_date']['date'].length != 0) {
         var available_date = selectedCombination['available_date']['date'];
         var tab_date = available_date.split('-');
         var time_available = new Date(tab_date[0], tab_date[1], tab_date[2]);
         time_available.setMonth(time_available.getMonth() - 1);
         var now = new Date();
         if (now.getTime() < time_available.getTime() && $('#availability_date_value').text() != selectedCombination['available_date']['date_formatted']) {
         $('#availability_date').fadeOut('normal', function () {
         $('#availability_date_value').text(selectedCombination['available_date']['date_formatted']);
         $(this).fadeIn();
         });
         }
         else if (now.getTime() < time_available.getTime())
         $('#availability_date').fadeIn();
         }
         else
         $('#availability_date').fadeOut();
         */

        //show the 'add to cart' button ONLY IF it's possible to buy when out of stock AND if it was previously invisible
        /*
         if (allowBuyWhenOutOfStock && !selectedCombination['unavailable'] && productAvailableForOrder) {
         //$('#add_to_cart:hidden').fadeIn(600);

         if (stock_management && availableLaterValue != '') {
         $('#availability_value').addClass('label-warning').text(availableLaterValue).show('slow');
         $('#availability_statut:hidden').show('slow');
         }
         else
         $('#availability_statut:visible').hide('slow');
         } else {
         //$('#add_to_cart:visible').fadeOut(600);
         if (stock_management == 1 && productAvailableForOrder)
         $('#availability_statut:hidden').show('slow');
         }

         if (productAvailableForOrder == 0)
         $('#availability_statut:visible').hide();
         */
    }

    /*
     if (selectedCombination['reference'] || productReference) {
     if (selectedCombination['reference'])
     $('#product_reference span').text(selectedCombination['reference']);
     else if (productReference)
     $('#product_reference span').text(productReference);
     $('#product_reference:hidden').show('slow');
     }
     else
     $('#product_reference:visible').hide('slow');

     */
     // If we have combinations, update price section: amounts, currency, discount amounts,...
     if (productHasAttributes)
     updatePrice();
}

function updatePrice() {
    // Get combination prices
    var combID = $('#idCombination').val();
    var combination = combinationsFromController[combID];
    if (typeof combination == 'undefined')
        return;

    // Set product (not the combination) base price
    var basePriceWithoutTax = +productPriceTaxExcluded;
    var basePriceWithTax = +productPriceTaxIncluded;
    var priceWithGroupReductionWithoutTax = 0;

    priceWithGroupReductionWithoutTax = basePriceWithoutTax * (1 - groupReduction);

    // Apply combination price impact (only if there is no specific price)
    // 0 by default, +x if price is inscreased, -x if price is decreased
    basePriceWithoutTax = basePriceWithoutTax + +combination.price;
    basePriceWithTax = basePriceWithTax + +combination.price * (taxRate / 100 + 1);

    // If a specific price redefine the combination base price
    if (combination.specific_price && combination.specific_price.price > 0) {
        basePriceWithoutTax = +combination.specific_price.price;
        basePriceWithTax = +combination.specific_price.price * (taxRate / 100 + 1);
    }


    var priceWithDiscountsWithoutTax = basePriceWithoutTax;
    var priceWithDiscountsWithTax = basePriceWithTax;
    console.log(priceWithDiscountsWithTax);

    if (default_eco_tax) {
        // combination.ecotax doesn't modify the price but only the display
        priceWithDiscountsWithoutTax = priceWithDiscountsWithoutTax + default_eco_tax * (1 + ecotaxTax_rate / 100);
        priceWithDiscountsWithTax = priceWithDiscountsWithTax + default_eco_tax * (1 + ecotaxTax_rate / 100);
        basePriceWithTax = basePriceWithTax + default_eco_tax * (1 + ecotaxTax_rate / 100);
        basePriceWithoutTax = basePriceWithoutTax + default_eco_tax * (1 + ecotaxTax_rate / 100);
    }

    // Apply specific price (discount)
    // We only apply percentage discount and discount amount given before tax
    // Specific price give after tax will be handled after taxes are added
    if (combination.specific_price && combination.specific_price.reduction > 0) {
        if (combination.specific_price.reduction_type == 'amount') {
            if (typeof combination.specific_price.reduction_tax !== 'undefined' && combination.specific_price.reduction_tax === "0") {
                var reduction = combination.specific_price.reduction;
                if (combination.specific_price.id_currency == 0)
                    reduction = reduction * currencyRate * (1 - groupReduction);
                priceWithDiscountsWithoutTax -= reduction;
                priceWithDiscountsWithTax -= reduction * (taxRate / 100 + 1);
            }
        }
        else if (combination.specific_price.reduction_type == 'percentage') {
            priceWithDiscountsWithoutTax = priceWithDiscountsWithoutTax * (1 - +combination.specific_price.reduction);
            priceWithDiscountsWithTax = priceWithDiscountsWithTax * (1 - +combination.specific_price.reduction);
        }
    }


    // Apply Tax if necessary
    if (noTaxForThisProduct || customerGroupWithoutTax) {
        basePriceDisplay = basePriceWithoutTax;
        priceWithDiscountsDisplay = priceWithDiscountsWithoutTax;
    }
    else {
        basePriceDisplay = basePriceWithTax;
        priceWithDiscountsDisplay = priceWithDiscountsWithTax;
    }

    // If the specific price was given after tax, we apply it now
    if (combination.specific_price && combination.specific_price.reduction > 0) {
        if (combination.specific_price.reduction_type == 'amount') {
            if (typeof combination.specific_price.reduction_tax === 'undefined'
                || (typeof combination.specific_price.reduction_tax !== 'undefined' && combination.specific_price.reduction_tax === '1')) {
                var reduction = combination.specific_price.reduction;

                if (typeof specific_currency !== 'undefined' && specific_currency && parseInt(combination.specific_price.id_currency) && combination.specific_price.id_currency != currency.id)
                    reduction = reduction / currencyRate;
                else if (!specific_currency)
                    reduction = reduction * currencyRate;

                if (typeof groupReduction !== 'undefined' && groupReduction > 0)
                    reduction *= 1 - parseFloat(groupReduction);

                priceWithDiscountsDisplay -= reduction;
                // We recalculate the price without tax in order to keep the data consistency
                priceWithDiscountsWithoutTax = priceWithDiscountsDisplay - reduction * ( 1 / (1 + taxRate / 100) );
            }
        }
    }

    // Compute discount value and percentage
    // Done just before display update so we have final prices
    if (basePriceDisplay != priceWithDiscountsDisplay) {
        var discountValue = basePriceDisplay - priceWithDiscountsDisplay;
        var discountPercentage = (1 - (priceWithDiscountsDisplay / basePriceDisplay)) * 100;
    }

    var unit_impact = +combination.unit_impact;
    if (productUnitPriceRatio > 0 || unit_impact) {
        if (unit_impact) {
            baseUnitPrice = productBasePriceTaxExcl / productUnitPriceRatio;
            unit_price = baseUnitPrice + unit_impact;

            if (!noTaxForThisProduct || !customerGroupWithoutTax)
                unit_price = unit_price * (taxRate / 100 + 1);
        }
        else
            unit_price = priceWithDiscountsDisplay / productUnitPriceRatio;
    }

    /*  Update the page content, no price calculation happens after */

    // Hide everything then show what needs to be shown
    $('#reduction_percent').hide();
    $('#reduction_amount').hide();
    //$('#old_price, #old_price_display, #old_price_display_taxes').hide();
    $('.price-ecotax').hide();
    $('.unit-price').hide();

    $('#our_price_display').text(formatCurrency(priceWithDiscountsDisplay, currencyFormat, currencySign, currencyBlank)).trigger('change');

    // If the calculated price (after all discounts) is different than the base price
    // we show the old price striked through

    if (priceWithDiscountsDisplay.toFixed(2) != basePriceDisplay.toFixed(2)) {
        $('#old_price_display span.price').text(formatCurrency(basePriceDisplay, currencyFormat, currencySign, currencyBlank));
        $('#old_price, #old_price_display, #old_price_display_taxes').removeClass('hidden');

        // Then if it's not only a group reduction we display the discount in red box
        if (priceWithDiscountsWithoutTax != priceWithGroupReductionWithoutTax) {
            if (combination.specific_price.reduction_type == 'amount') {
                $('#reduction_amount_display').html('-' + formatCurrency(discountValue, currencyFormat, currencySign, currencyBlank));
                $('#reduction_amount').show();
            }
            else {
                var toFix = 2;
                if ((parseFloat(discountPercentage).toFixed(2) - parseFloat(discountPercentage).toFixed(0)) == 0)
                    toFix = 0;
                $('#reduction_percent_display').html('-' + parseFloat(discountPercentage).toFixed(toFix) + '%');
                $('#reduction_percent').show();
            }
        }
    }

    // Green Tax (Eco tax)
    // Update display of Green Tax
    if (default_eco_tax) {
        ecotax = default_eco_tax;

        // If the default product ecotax is overridden by the combination
        if (combination.ecotax)
            ecotax = +combination.ecotax;

        if (!noTaxForThisProduct)
            ecotax = ecotax * (1 + ecotaxTax_rate / 100)

        $('#ecotax_price_display').text(formatCurrency(ecotax * currencyRate, currencyFormat, currencySign, currencyBlank));
        $('.price-ecotax').show();
    }

    // Unit price are the price per piece, per Kg, per m²
    // It doesn't modify the price, it's only for display
    if (productUnitPriceRatio > 0) {
        $('#unit_price_display').text(formatCurrency(unit_price * currencyRate, currencyFormat, currencySign, currencyBlank));
        $('.unit-price').show();
    }

    if (noTaxForThisProduct || customerGroupWithoutTax)
        updateDiscountTable(priceWithDiscountsWithoutTax);
    else
        updateDiscountTable(priceWithDiscountsWithTax);
}

//update display of the large image
function displayImage(domAAroundImgThumb, no_animation) {
    if (typeof(no_animation) == 'undefined')
        no_animation = false;
    if (domAAroundImgThumb.attr('href')) {
        var new_src = domAAroundImgThumb.attr('href');
        var new_title = domAAroundImgThumb.attr('title');
        var new_href = domAAroundImgThumb.attr('href');

        if ($('#bigpic').attr('src') != new_src) {
            $('#bigpic').attr({
                'src': new_src,
                'alt': new_title,
                'title': new_title
            }).load(function () {
                if (typeof(jqZoomEnabled) != 'undefined' && jqZoomEnabled)
                    $(this).attr('rel', new_href);
            });
            $('meta[property="og:image"]').attr('content', new_src);
        }
        $('#views_block li a').removeClass('shown');
        $(domAAroundImgThumb).addClass('shown');

        if (domAAroundImgThumb.parent().attr('id') != $('#thumbs_list_frame li:visible').first().attr('id'))
            $('#product_infos_firstgroup').fadeOut(1100);
        else $('#product_infos_firstgroup').fadeIn(1100);
    }
}

/**
 * Update display of the discounts table.
 * @param combination Combination ID.
 */
function displayDiscounts(combination) {
    // Tables & rows selection
    var quantityDiscountTable = $('#quantityDiscount').parent();
    var combinationsSpecificQuantityDiscount = $('.quantityDiscount_' + combination, quantityDiscountTable);
    var allQuantityDiscount = $('.quantityDiscount_0', quantityDiscountTable);

    // If there is some combinations specific quantity discount, show them, else, if there are some
    // products quantity discount: show them. In case of result, show the category.
    if (combinationsSpecificQuantityDiscount.length != 0) {
        $('tbody tr', quantityDiscountTable).not('.quantityDiscount_' + combination).hide();
        combinationsSpecificQuantityDiscount.show();
        allQuantityDiscount.show();
        quantityDiscountTable.show();
    } else if (allQuantityDiscount.length != 0) {
        $('tbody tr', quantityDiscountTable).not('.quantityDiscount_0').hide();
        allQuantityDiscount.show();
        quantityDiscountTable.show();
    } else {
        quantityDiscountTable.hide();
    }
}

function updateDiscountTable(newPrice) {
    $('#quantityDiscount tbody tr').each(function () {
        var type = $(this).data("discount-type");
        var discount = $(this).data("discount");
        var quantity = $(this).data("discount-quantity");

        if (type == 'percentage') {
            var discountedPrice = newPrice * (1 - discount / 100);
            var discountUpTo = newPrice * (discount / 100) * quantity;
        }
        else if (type == 'amount') {
            var discountedPrice = newPrice - discount;
            var discountUpTo = discount * quantity;
        }

        if (displayDiscountPrice != 0)
            $(this).children('td').eq(1).text(formatCurrency(discountedPrice * currencyRate, currencyFormat, currencySign, currencyBlank));
        $(this).children('td').eq(2).text(upToTxt + ' ' + formatCurrency(discountUpTo * currencyRate, currencyFormat, currencySign, currencyBlank));
    });
}


// Change the current product images regarding the combination selected
function refreshProductImages(id_product_attribute) {
    id_product_attribute = parseInt(id_product_attribute);

    if (typeof combinations == 'undefined' || !combinations)
        combinations = [];

    var imgList = [];

    if (combinations[id_product_attribute]['images_list'] !== null) {
        $.each(combinations[id_product_attribute]['images_list'], function (i, img) {
            imgList.push(parseInt(img.id_image));
        });
    }

    var thumb_id;
    var liPointer = 0;
    $('#image-block .img-item').each(function () {
        thumb_id = parseInt($(this).attr('id').replace('thumbnail_', ''));
        if ($.inArray(thumb_id, imgList) != -1) {
            $(this).addClass('carousel-item').removeClass('unvisible');
            liPointer++;
        } else {
            $(this).removeClass('carousel-item').addClass('unvisible');
        }
    });

    $('#image-block .carousel-inner > div').removeClass('active');
    $('#image-block .carousel-indicators li').each(function () {
        if ($(this).attr('data-slide-to') > liPointer - 1) {
            $(this).addClass('unvisible');
        } else {
            $(this).removeClass('unvisible');
        }
    });
    $('#image-block .carousel-indicators li').removeClass('active');
    $('#image-block .carousel-indicators li:visible:first').addClass('active');
    $('#image-block .carousel-item:first').addClass('active');
    $('#image-block').carousel(0);
}

function saveCustomization() {
    $('#quantityBackup').val($('#quantity_wanted').val());
    $('#customizationForm').submit();
}

function submitPublishProduct(url, redirect, token) {
    var id_product = $('#admin-action-product-id').val();

    $.ajaxSetup({async: false});
    $.post(url + '/index.php', {
            action: 'publishProduct',
            id_product: id_product,
            status: 1,
            redirect: redirect,
            ajax: 1,
            tab: 'AdminProducts',
            token: token
        },
        function (data) {
            if (data.indexOf('error') === -1)
                document.location.href = data;
        }
    );
    return true;
}

function checkMinimalQuantity(minimal_quantity) {
    if ($('#quantity_wanted').val() < minimal_quantity) {
        //$('#quantity_wanted').css('border', '1px solid red');
        $('#minimal_quantity_wanted_p').css('color', 'red');
    }
    else {
        //$('#quantity_wanted').css('border', '1px solid #BDC2C9');
        $('#minimal_quantity_wanted_p').css('color', '#374853');
    }
}

function colorPickerClick(elt) {
    id_attribute = $(elt).attr('id').replace('color_', '');
    $(elt).parent().parent().children().removeClass('selected');
    $(elt).fadeTo('fast', 1, function () {
        $(this).fadeTo('fast', 0, function () {
            $(this).fadeTo('fast', 1, function () {
                $(this).parent().addClass('selected');
            });
        });
    });
    $(elt).parent().parent().parent().children('.color_pick_hidden').val(id_attribute);
}


var requestGroups = [];
function getProductAttribute() {
    // get every attributes values
    var request = '';

    var tab_attributes = [];
    $('#group_3, #group_4').each(function () {
        tab_attributes.push($(this).val());
    });

    // build new request
    for (var i in attributesCombinations) {
        for (var a in tab_attributes) {
            if (attributesCombinations[i]['id_attribute'] === tab_attributes[a]) {
                if (attributesCombinations[i]['id_attribute_group'] > 0) {
                    requestGroups[attributesCombinations[i]['id_attribute_group']] = [];

                    requestGroups[attributesCombinations[i]['id_attribute_group']].push(
                        attributesCombinations[i]['id_attribute']
                    );
                    requestGroups[attributesCombinations[i]['id_attribute_group']].push(
                        attributesCombinations[i]['group']
                    );
                    requestGroups[attributesCombinations[i]['id_attribute_group']].push(
                        attributesCombinations[i]['attribute']
                    );
                }
            }
        }
    }

    ksort(requestGroups);
    $.each(requestGroups, function (i, elems) {
        if (elems && typeof elems[1] != 'undefined') {
            request += '/' + elems[0] + '-' + elems[1] + attribute_anchor_separator + elems[2];
        }
    });

    request = request.replace(request.substring(0, 1), '#/');
    var url = window.location + '';

    // redirection
    if (url.indexOf('#') != -1)
        url = url.substring(0, url.indexOf('#'));

    if ($('#customizationForm').length) {
        // set ipa to the customization form
        customAction = $('#customizationForm').attr('action');
        if (customAction.indexOf('#') != -1)
            customAction = customAction.substring(0, customAction.indexOf('#'));
        $('#customizationForm').attr('action', customAction + request);
    }

    window.location.replace(url + request);
}

function checkUrl() {
    var url = window.location + '';
    if (url.indexOf('#/') != -1) {

        var params = url.substring(url.indexOf('#') + 1, url.length);
        var tabParams = params.split('/');
        var tabValues = [];
        if (tabParams[0] == '')
            tabParams.shift();

        var len = tabParams.length;
        for (var i = 0; i < len; i++) {
            tabParams[i] = tabParams[i].replace(attribute_anchor_separator, '-');
            tabValues.push(tabParams[i].split('-'));
        }

        hashCombId = parseInt(tabValues[0][0]);
    } else {
        hashCombId = 0;
    }

    findCombination();
    return false;
}

function Timer(time) {
    var nbJours, nbHeures, nbMinutes, nbSecondes;

    var timeTo;
    if (time > 0) {
        timeTo = time;
    } else {
        timeTo = $('#timer_timestamp').val();
    }

    var timeToRemaining = timeTo;

    nbJours = Math.floor(timeTo / 86400);
    timeTo -= 86400 * nbJours;

    nbHeures = Math.floor(timeTo / 3600);
    timeTo -= nbHeures * 3600;
    if (nbHeures < 10)
        nbHeures = '0' + nbHeures;

    nbMinutes = Math.floor(timeTo / 60);
    timeTo -= nbMinutes * 60;
    if (nbMinutes < 10)
        nbMinutes = '0' + nbMinutes;

    nbSecondes = Math.floor(timeTo);
    if (nbSecondes < 10)
        nbSecondes = '0' + nbSecondes;

    $("#timer #days").html(nbJours);
    $("#timer #hours").html(nbHeures);
    $("#timer #minutes").html(nbMinutes);
    $("#timer #seconds").html(nbSecondes);

    var t = setTimeout(function () {
        Timer(timeToRemaining - 1);
    }, 1000);
}

function ksort(inputArr, sort_flags) {
    var tmp_arr = {},
        keys = [],
        sorter, i, k, that = this,
        strictForIn = false,
        populateArr = {};

    switch (sort_flags) {
        case 'SORT_STRING':
            // compare items as strings
            sorter = function (a, b) {
                return that.strnatcmp(a, b);
            };
            break;
        case 'SORT_LOCALE_STRING':
            // compare items as strings, original by the current locale (set with  i18n_loc_set_default() as of PHP6)
            var loc = this.i18n_loc_get_default();
            sorter = this.php_js.i18nLocales[loc].sorting;
            break;
        case 'SORT_NUMERIC':
            // compare items numerically
            sorter = function (a, b) {
                return ((a + 0) - (b + 0));
            };
            break;
        // case 'SORT_REGULAR': // compare items normally (don't change types)
        default:
            sorter = function (a, b) {
                var aFloat = parseFloat(a),
                    bFloat = parseFloat(b),
                    aNumeric = aFloat + '' === a,
                    bNumeric = bFloat + '' === b;
                if (aNumeric && bNumeric) {
                    return aFloat > bFloat ? 1 : aFloat < bFloat ? -1 : 0;
                } else if (aNumeric && !bNumeric) {
                    return 1;
                } else if (!aNumeric && bNumeric) {
                    return -1;
                }
                return a > b ? 1 : a < b ? -1 : 0;
            };
            break;
    }

    // Make a list of key names
    for (k in inputArr) {
        if (inputArr.hasOwnProperty(k)) {
            keys.push(k);
        }
    }
    keys.sort(sorter);

    // BEGIN REDUNDANT
    this.php_js = this.php_js || {};
    this.php_js.ini = this.php_js.ini || {};
    // END REDUNDANT
    strictForIn = this.php_js.ini['phpjs.strictForIn'] && this.php_js.ini['phpjs.strictForIn'].local_value && this.php_js
            .ini['phpjs.strictForIn'].local_value !== 'off';
    populateArr = strictForIn ? inputArr : populateArr;

    // Rebuild array with sorted key names
    for (i = 0; i < keys.length; i++) {
        k = keys[i];
        tmp_arr[k] = inputArr[k];
        if (strictForIn) {
            delete inputArr[k];
        }
    }
    for (i in tmp_arr) {
        if (tmp_arr.hasOwnProperty(i)) {
            populateArr[i] = tmp_arr[i];
        }
    }

    return strictForIn || populateArr;
}
