$(document).ready(function () {
//toggle details 
    $('a.delivery_infos').click(function (e) {
        e.preventDefault();
        var spanHidden = $(this).find('span.hidden');
        var spanVisible = $(this).find('span:not(.hidden)');
        spanHidden.removeClass('hidden');
        spanVisible.addClass('hidden');
        $(this).closest('.order-detail').find('.collapse').fadeToggle('slow');
    });
});