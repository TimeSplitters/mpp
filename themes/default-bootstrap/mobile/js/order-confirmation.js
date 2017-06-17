$(document).ready(function () {
    $('#googleFormClose').on('click', function (e) {
        e.preventDefault();
        $('#googleForm').slideUp(400);
    });

    $('input[name=sondageReponse]:radio').on('change', function () {
        $.ajax({
            type: 'POST',
            headers: { "cache-control": "no-cache" },
            url: baseUri + '?rand=' + new Date().getTime(),
            async: true,
            cache: false,
            dataType: 'text',
            data: 'controller=order-confirmation&action=googleForm&ajax=true'
            + '&sondageReponse='+$(this).val()
            + '&token='+static_token,
            success: function(jsonData)
            {
                $('#googleForm').slideUp(400);
            }
        });
    });
});