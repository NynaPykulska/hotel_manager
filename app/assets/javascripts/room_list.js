$(document).on('turbolinks:load',function() {

	$(function(){
		$('#sort_room_rooms').click(function() {
		$("table thead").find("th:eq(1)").trigger("sort");
		});
  });

});
