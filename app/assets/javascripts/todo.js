$(document).ready(function() {

	$('.todo').has(".status:contains('Complete!')").addClass('status-Complete');
	$('.todo').has(".status:contains('In Progress')").addClass('status-InProgress');
	$('.todo').has(".status:contains('To Do')").addClass('status-Todo');

});