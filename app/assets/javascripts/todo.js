jQuery.fn.todoStatus = function() {

	this.has(".status_material:contains('Complete!')").addClass('status-MComplete');
	this.has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	this.has(".status_material:contains('To Do')").addClass('status-MTodo');

}

jQuery.fn.todoAdvanced = function() {

	this.find('.advanced').hide();

	this.click(function() {
		$(this).find('.advanced').slideToggle();
	});

}

jQuery.fn.sortTodosByStatus = function() {
	
	this.has(".status_material:contains('Complete!')").insertAfter('#complete');
	this.has(".status_material:contains('In Progress')").insertAfter('#todosToBeDone');
	this.has(".status_material:contains('To Do')").insertAfter('#todosToBeDone');
}

$(document).ready(function() {

	$('.todo_material').todoStatus();
	$('.todo_card').sortTodosByStatus();
	$('.todo_material').todoAdvanced();

});