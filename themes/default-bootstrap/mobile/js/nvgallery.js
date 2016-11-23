(function ($) {

    $.event.special.doubletap = {
        bindType: 'touchend',
        delegateType: 'touchend',

        handle: function (event) {
            var handleObj = event.handleObj,
                targetData = jQuery.data(event.target),
                now = new Date().getTime(),
                delta = targetData.lastTouch ? now - targetData.lastTouch : 0,
                delay = delay == null ? 300 : delay;

            if (delta < delay && delta > 30) {
                targetData.lastTouch = null;
                event.type = handleObj.origType;
                ['clientX', 'clientY', 'pageX', 'pageY'].forEach(function (property) {
                    event[property] = event.originalEvent.changedTouches[0][property];
                })

                // let jQuery handle the triggering of "doubletap" event handlers
                handleObj.handler.apply(this, arguments);
            } else {
                targetData.lastTouch = now;
            }
        }
    };

})(jQuery);

$(function () {
    /*$(".carousel").swipe({

        swipeLeft: function () {
            $(this).carousel('next');
        },
        swipeRight: function () {
            $(this).carousel('prev');
        },
        allowPageScroll: "vertical"
    });

    $('#offcanvas-overlay').on('scrollstart tap', function () {
        $('.navbar-toggle.is-open').click();
        $(document).focusout();
    });

    $('#home_pics .carousel-item').bind('tap', function () {
        window.location = $(this).attr('data-href');
    });

    $('#image-block .img-item').bind('tap', function () {
        var imgActive = $(this).find('img');
        $('#zoomImg').append('<img src="' + imgActive.attr('src') + '" alt="Zoom" />').show();

        var isZoomed = false;
        $('#zoomImg img').css({
            'height': $(window).height() - 20,
            'top': 10
        }).panzoom({
            $zoomIn: $("#zoomImg .zoom-in"),
            $zoomOut: $("#zoomImg .zoom-out"),
            minScale: 1,
            maxScale: 2
        }).on('doubletap dblclick', function () {
            if(!isZoomed) {
                $(this).panzoom("zoom", 2);
                isZoomed = true;
            } else {
                $(this).panzoom("zoom", 1);
                isZoomed = false;
            }
        });

        $('#image-block').carousel('pause');
    });
    $('nav.navbar [data-toggle="tooltip"]').on('click', function () {
        $('.tooltip').css('left', '-1rem');
    });

    */

    $('[data-toggle="tooltip"]').tooltip();

    $('[data-toggle="tooltip"]').on('click', function () {
        var that = $(this);
        that.tooltip('show');
        setTimeout(function () {
            that.tooltip('hide');
        }, 2000);
    });

    if (typeof cookieLawAccept != 'undefined' && cookieLawAccept) {
        $('#cookieLaw').show();
    }

    if (typeof cookieRestrictedCountry != 'undefined' && cookieRestrictedCountry) {
        $('#restricted-country').show();
    }

    $('a[href="#"]').on('click', function (e) {
        e.preventDefault();
    });

    $('#cookieLaw button').on('click', function () {
        $.ajax({
            type: 'get',
            url: baseUri,
            async: true,
            cache: false,
            dataType: "json",
            headers: {"cache-control": "no-cache"},
            data: {
                ajax: true,
                controller: 'authentication',
                action: 'cookieLawAccept',
                token: token
            },
            success: function () {

            }
        });
        $('#cookieLaw').hide();
    });

    $('#restricted-country button').on('click', function () {
        $.ajax({
            type: 'get',
            url: baseUri,
            async: true,
            cache: false,
            dataType: "json",
            headers: {"cache-control": "no-cache"},
            data: {
                ajax: true,
                controller: 'authentication',
                action: 'cookieRestrictedCountry',
                token: token
            },
            success: function () {

            }
        });
        $('#restricted-country').hide();
    });

    $('input.form-control, textarea.form-control').each(function () {
        if ($(this).prop("placeholder") != "") {
            $(this).wrap('<div class="input-placeholder"></div>')
                .parent()
                .prepend('<span class="text-uppercase">' + $(this).attr("placeholder") + '</span>');
            inputPlaceholder($(this));
        }
    });

    $('input.form-control, textarea.form-control').on('focusin', function () {
        if ($(this).prop("placeholder") != "") {
            inputPlaceholder($(this), true);
        }
    }).on('focusout', function () {
        inputPlaceholder($(this));
    });

    if (!!$.prototype.bxSlider)
        $('#instafeed .bxslider').bxSlider({
            useCSS: false,
            minSlides: 3,
            maxSlides: 3,
            slideMargin: 7,
            slideWidth: 120,
            infiniteLoop: false,
            hideControlOnEnd: true,
            pager: false,
            autoHover: true,
            auto: false,
            speed: 500,
            pause: 3000,
            controls: true
        });

    $('button[name=submit_search]').on('click', function (e) {
        e.preventDefault();
        $('#searchClose, #searchBack').removeClass('hidden');
        $('header .navbar-brand, header .navbar-toggle').addClass('hidden');
        $(this).parent().find('#search_query_top').removeClass('hidden').focus();
    });

    $('#searchClose').on('click', function (e) {
        e.preventDefault();
        if($('#search_query_top').val() != "") {
            $('#search_query_top').val('').focus();
        } else {
            $(this).addClass('hidden');
            $('#searchClose, #searchBack').addClass('hidden');
            $('header .navbar-brand, header .navbar-toggle').removeClass('hidden');
            $(this).parent().find('#search_query_top').addClass('hidden');
        }
    });

    $('#searchBack').on('click', function (e) {
        e.preventDefault();
        $(this).addClass('hidden');
        $('#searchClose, #searchBack').addClass('hidden');
        $('header .navbar-brand, header .navbar-toggle').removeClass('hidden');
        $(this).parent().find('#search_query_top').addClass('hidden');
    });
});

$.prototype.idTabs = function () {
};

function inputPlaceholder(that, force) {
    if (that.val() != '' || force == true) {
        that.parent().find('span').slideDown(400);
    } else {
        that.parent().find('span').slideUp(400);
    }
}

function userIsLoggedIn() {
    var isLogged = false;
    $.ajax({
        type: 'get',
        url: baseUri,
        async: false,
        cache: false,
        dataType: "json",
        headers: {"cache-control": "no-cache"},
        data: {
            ajax: true,
            controller: 'authentication',
            action: 'userIsLoggedIn',
            token: token
        },
        success: function (res) {
            isLogged = res;
        }
    });

    return isLogged;
}


function nl2br(str, is_xhtml) {
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}
