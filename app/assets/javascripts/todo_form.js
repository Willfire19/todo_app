$(document).ready(function() {

	$('.advanced').hide();
	
	$('#advanced_options').click(function() {
		$('.advanced').slideToggle('slow');
	});

});