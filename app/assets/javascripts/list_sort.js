$(document).ready(function() {

	$('.todo_material_form').hide();
	$('.list_form').hide();

	$('.new_form').click(function() {
		$(this).toggleClass('active');
		if ( $(this).text() == "New Todo" ) {
			$('.todo_material_form').toggle("slide");
		}
		if ( $(this).text() == "New List" ) {
			$('.list_form').toggle("slide");
		}
	})

	$('.list_sort').click(function() {
		$('.list_sort').removeClass('active');
		$(this).addClass('active');
		// $('.todo_material').fadeOut(200).delay(200);
		// $('.todo_material').slideUp( "fast", "swing" ).delay(400);

		var list_name = $(this).text();
		if( list_name != "All" ){
			$('.todo_material').not(":has(.listName_material:contains('" + list_name + "'))").slideUp("fast", "swing");

			$('.todo_material').has(".listName_material:contains('" + list_name + "')").slideDown("fast", "swing");
		}
		else{
			$('.todo_material').slideDown("fast", "swing");
		}
	})

});