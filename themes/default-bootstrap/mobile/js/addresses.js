
$(document).ready(function() {
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
