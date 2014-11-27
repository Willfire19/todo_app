$(document).ready(function() {

	$('.list_sort').click(function() {
		$('.list_sort').removeClass('active');
		$(this).addClass('active');
		$('.todo_material').fadeOut();
		var list_name = $(this).text();
		if( list_name != "All" ){
			$('.todo_material').has(".listName_material:contains('" + list_name + "')").fadeIn();
		}
		else{
			$('.todo_material').fadeIn();
		}
	})

});