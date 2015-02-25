jQuery.fn.todoStatus = function() {

	this.has(".status_material:contains('Complete!')").addClass('status-MComplete');
	this.has(".status_material:contains('In Progress')").addClass('status-MInProgress');
	this.has(".status_material:contains('To Do')").addClass('status-MTodo');

}

jQuery.fn.todoAdvanced = function() {

	this.find('.advanced').hide();

	var todo = this;
	var expand_button = this.find("button");

	expand_button.click(function() {
		
		$(this).parent().parent().parent().find('.advanced').slideToggle();
		$(this).find("span").toggleClass("glyphicon-chevron-right glyphicon-chevron-down");
	
	});

}

jQuery.fn.sortTodosByStatus = function() {
	
	this.has(".status_material:contains('Complete!')").insertAfter('#complete');
	// this.has(".status_material:contains('In Progress')").insertAfter('#todosToBeDone');
	// this.has(".status_material:contains('To Do')").insertAfter('#todosToBeDone');
}

$(document).ready(function() {

	$('.todo_material').todoStatus();
	$('.todo_card').sortTodosByStatus();
	$('.todo_material').todoAdvanced();

});