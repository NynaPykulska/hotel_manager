$(document).on('turbolinks:load',function() {

  $(".current-user-resolver").hide();

  $('.issue-ready-button').click(function(e){
    if($(this).closest('tr').hasClass("tr-not_done"))
		{
	    $(this).closest('tr').find('.strike-out').addClass('td-done');
	    $(this).closest('tr').removeClass('tr-not_done');
	    $(this).closest('tr').addClass('tr-done');

      $(this).closest('tr').find('.current-user-resolver').show();
	    
	    // Change number of ready memos
	    var old_number = parseInt(document.getElementById('ready-number').innerHTML);
	    old_number++;
	    $('#ready-number').text(old_number);
	    
	    // // Change number of open memos
	    old_number = parseInt(document.getElementById('open-number').innerHTML);
	    old_number--;

	    $('#open-number').text(old_number);
      $(this).closest('tr').find('.issue-ok-icon').removeClass("g-issue-icon-red");
	    $(this).closest('tr').find('.issue-ok-icon').addClass("g-issue-icon-green");
	    $(this).closest('tr').find('.edit-button').hide();
	    
	    // TODO: Find a better way to do it
	    $(this).closest('tr').find('.issue-ready-button.enabled').hide();
	    $(this).closest('tr').find('.issue-ready-button.disabled').show();
	    if(localStorage.getItem("current_tab") === "open")
	    
	    {
	        $(this).closest('tr').hide();
	    }
		}
  });

	$('.issue-reopen-button').click(function(e){
    if($(this).closest('tr').hasClass("tr-done"))
    {
      $(this).closest('tr').find('.strike-out').removeClass('td-done');
      $(this).closest('tr').addClass('tr-not_done');
      $(this).closest('tr').removeClass('tr-done');

      $(this).closest('tr').find('.current-user-resolver').hide();
      $(this).closest('tr').find('.c-resolver').hide();
      // Change number of ready memos
      var old_number = parseInt(document.getElementById('ready-number').innerHTML);
      old_number--;
      $('#ready-number').text(old_number);
      // Change number of open memos
      old_number = parseInt(document.getElementById('open-number').innerHTML);
      old_number++;
      $('#open-number').text(old_number);
      $(this).closest('tr').find('.issue-ok-icon').removeClass("g-issue-icon-green");
      $(this).closest('tr').find('.issue-ok-icon').addClass("g-issue-icon-red");
      $(this).closest('tr').find('.edit-button').show();

      // TODO: Find a better way to do it
      $(this).closest('tr').find('.issue-ready-button.enabled').show();
      $(this).closest('tr').find('.issue-ready-button.disabled').hide();

      if(localStorage.getItem("current_tab") ==="ready")
      {
          $(this).closest('tr').hide();
      }
    }
	});

  $(function(){
      $('#sort_room_issue').click(function() {
          console.log("WTF");
          $("table thead").find("th:eq(2)").trigger("sort");
      });
  });

  $(function(){
      $('#sort_time_issue').click(function() {
          $("table thead").find("th:eq(3)").trigger("sort");
      });
  });

  $(function(){
      $('#sort_comment_issue').click(function() {
          $("table thead").find("th:eq(5)").trigger("sort");
      });
  });

  $(function(){
      $('#sort_priority_issue').click(function() {
          $("table thead").find("th:eq(4)").trigger("sort");
      });
  });
});
