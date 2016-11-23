
$(document).ready(function() {
	    $('input[name=phone]').formatter({
      'pattern': '{{9999999999}}',
      'persistent': false
    });
	if (typeof addressesConfirm !== 'undefined' && addressesConfirm)
	{
		$('a[data-id="addresses_confirm"]').click(function(){
			return confirm(addressesConfirm);
		});
	}

	$('.address_update a, #add_address').fancybox({
		'beforeClose': function () {
			window.parent.location.reload(false);
		},
		helpers: {
			title: null
		},
		width: 965
	});
});
