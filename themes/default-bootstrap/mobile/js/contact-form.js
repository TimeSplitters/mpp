$(document).ready(function(){
	$(document).on('change', 'select[name=id_contact]', function(){
		if($(this).val() > 0)
			$(this).addClass('colored');
		else $(this).removeClass('colored');
	});
	$('select[name=id_contact]').trigger('change');
});