$(document).ready(function() {
	// var fontSize = $(".todoTable tbody tr:first").css('background-color', '#dddddd');

	$('#no-script').remove();

	// $('#togDisclaimer').click(function() {
	// 	$('.disclaimer').slideToggle('slow');

	// 	if ( $('.disclaimer').is(':visible') ) {
	// 		$(this).val('Hide');
	// 	}
	// 	else {
	// 		$(this).val('Show');
	// 	}
	// });

	$('#togDisclaimer').click(function() {
		$('.disclaimer').slideUp('slow', function() {
			$('#togDisclaimer').fadeOut();
		});
	});

	// $('.todoTable tr').mouseover(function() {
	// 	$(this).addClass('zebraHover');
	// });

	// $('.todoTable tr').mouseout(function() {
	// 	$(this).removeClass('zebraHover');
	// });

	
});