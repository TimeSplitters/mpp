$(document).ready(function () {
	$('#block_top_menu ul li').hover(function () {
		if(!$(this).hasClass('sfHover')) {
			$(this).addClass('sfHover');
		}
    },
	function () {
        if(!$(this).hasClass('sfHoverForce')) {
            $(this).removeClass('sfHover');
        }
    });
});