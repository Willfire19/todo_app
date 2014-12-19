$(document).ready(function() {

	$('.todo_material').has(".status_material:contains('Complete!')").addClass('status-MComplete');
	$('.todo_material').has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	$('.todo_material').has(".status_material:contains('To Do')").addClass('status-MTodo');

	$('.advanced').hide();

	$('.todo_material').click(function() {
		$(this).find('.advanced').slideToggle();
	});

});