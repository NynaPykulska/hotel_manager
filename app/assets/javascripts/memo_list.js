$(document).on('turbolinks:load',function() {

  $(function(){
    $('#sort_room_memo').click(function() {
      $("table thead").find("th:eq(3)").trigger("sort");
    });
  });

  $(function(){
    $('#sort_time_memo').click(function() {
      $("table thead").find("th:eq(5)").trigger("sort");
    });
  });

  $('.memo-ready-button').click(function(e){
		if($(this).closest('tr').hasClass("tr-not_done"))
		{
	    $(this).closest('tr').find('.strike-out').addClass('td-done');
	    $(this).closest('tr').removeClass('tr-not_done');
	    $(this).closest('tr').addClass('tr-done');
	    
	    // Change number of ready memos
	    var old_number = parseInt(document.getElementById('ready-number').innerHTML);
	    old_number++;
	    $('#ready-number').text(old_number);
	    
	    // // Change number of open memos
	    old_number = parseInt(document.getElementById('open-number').innerHTML);
	    old_number--;

	    $('#open-number').text(old_number);
	    $(this).closest('tr').find('.is-complete-icon-ok').show();
	    $(this).closest('tr').find('.is-complete-icon-circle').hide();
	    $(this).closest('tr').find('.issue-ok-icon').show();
	    $(this).closest('tr').find('.issue-nok-icon').hide();
	    $(this).closest('tr').find('.edit-button').hide();
	    
	    // TODO: Find a better way to do it
	    $(this).closest('tr').find('.memo-ready-button.enabled').hide();
	    $(this).closest('tr').find('.memo-ready-button.disabled').show();
	    if(localStorage.getItem("current_tab") === "open")
	    
	    {
	        $(this).closest('tr').hide();
	    }
		}
  });

	$('.memo-reopen-button').click(function(e){
    if($(this).closest('tr').hasClass("tr-done"))
    {
      $(this).closest('tr').find('.strike-out').removeClass('td-done');
      $(this).closest('tr').addClass('tr-not_done');
      $(this).closest('tr').removeClass('tr-done');
      // Change number of ready memos
      var old_number = parseInt(document.getElementById('ready-number').innerHTML);
      old_number--;
      $('#ready-number').text(old_number);
      // Change number of open memos
      old_number = parseInt(document.getElementById('open-number').innerHTML);
      old_number++;
      $('#open-number').text(old_number);
      $(this).closest('tr').find('.is-complete-icon-ok').hide();
      $(this).closest('tr').find('.is-complete-icon-circle').show();
      $(this).closest('tr').find('.issue-nok-icon').show();
      $(this).closest('tr').find('.issue-ok-icon').hide();
      $(this).closest('tr').find('.edit-button').show();

      // TODO: Find a better way to do it
      $(this).closest('tr').find('.memo-ready-button.enabled').show();
      $(this).closest('tr').find('.memo-ready-button.disabled').hide();

      if(localStorage.getItem("current_tab") ==="ready")
      {
          $(this).closest('tr').hide();
      }
    }
	});

});
