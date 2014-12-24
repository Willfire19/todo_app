jQuery.fn.todoStatus = function() {
	// $('.todo_material').has(".status_material:contains('Complete!')").addClass('status-MComplete');
	// $('.todo_material').has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	// $('.todo_material').has(".status_material:contains('To Do')").addClass('status-MTodo');

	this.has(".status_material:contains('Complete!')").addClass('status-MComplete');
	this.has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	this.has(".status_material:contains('To Do')").addClass('status-MTodo');
}

jQuery.fn.todoAdvanced = function() {
	// $('.advanced').hide();

	// $('.todo_material').click(function() {
	// 	$(this).find('.advanced').slideToggle();
	// });

	this.find('.advanced').hide();

	this.click(function() {
		$(this).find('.advanced').slideToggle();
	});
}

$(document).ready(function() {

	// $('.todo_material').has(".status_material:contains('Complete!')").addClass('status-MComplete');
	// $('.todo_material').has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	// $('.todo_material').has(".status_material:contains('To Do')").addClass('status-MTodo');

	// $('.advanced').hide();

	// $('.todo_material').click(function() {
	// 	$(this).find('.advanced').slideToggle();
	// });

	$('.todo_material').todoStatus();
	$('.todo_material').todoAdvanced();

});