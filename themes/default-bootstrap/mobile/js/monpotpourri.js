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

    $('.form-control').on('focus', function () {
        $(this).parent().addClass('form-focused').find('.btn-default').removeClass('btn-default').addClass('btn-primary');
    }).on('blur', function () {
        $(this).parent().removeClass('form-focused').find('.btn-primary').addClass('btn-default').removeClass('btn-primary');
    });
});

$.prototype.idTabs = function () {

};

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
