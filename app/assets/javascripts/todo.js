$(document).ready(function() {

	$('.todo').has(".status:contains('Complete!')").addClass('status-Complete');
	$('.todo').has(".status:contains('In Progress')").addClass('status-InProgress');
	$('.todo').has(".status:contains('To Do')").addClass('status-Todo');

	$('.todo_material').has(".status_material:contains('Complete!')").addClass('status-MComplete');
	$('.todo_material').has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	$('.todo_material').has(".status_material:contains('To Do')").addClass('status-MTodo');

	$('.advanced').hide();

});