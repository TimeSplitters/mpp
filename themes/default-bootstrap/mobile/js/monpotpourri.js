$(function () {
    if (typeof cookieLawAccept != 'undefined' && cookieLawAccept) {
        $('#cookieLaw').show();
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
