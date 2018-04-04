$(document).on('turbolinks:load',function() {

  $('#memo-calendar .input-group.date').datepicker({
      format: 'yyyy-mm-dd',
      language: "pl",
      autoclose: true,
      todayHighlight: true,
      todayBtn: "linked"
  }).on('changeDate', function (a) {
      var date = a.date.getFullYear() + "-" + (a.date.getMonth() + 1) + "-" + a.date.getDate();
      var link = window.location.href.split('?')[0] + "?date=" + date;
      window.location.href = link;
  });

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

$( document). on('click', ".unpinned-memo-icon" ,function() {
  console.log('chuj');
  var row = $(this).closest('tr');
  $(this).removeClass('unpinned-memo-icon');
  $(this).addClass('pinned-memo-icon');
  row.remove();
  row.prependTo('#memo_table');
});

$( document). on('click',".pinned-memo-icon" ,function() {
  var row = $(this).closest('tr');
  $(this).removeClass('pinned-memo-icon');
  $(this).addClass('unpinned-memo-icon');
  row.remove();
  var last_pinned_row = $('.pinned-memo-icon').last().closest('tr');
  var memo_date = new Date(row.children('.memo-date').first().find('h4').text());
  var dateparts = $('#memo_current_day').text().trim().split('/');
  var current_date = new Date(dateparts[2] + "-" + dateparts[1] + "-" + dateparts[0]);
  if(memo_date.setHours(0,0,0,0) != current_date.setHours(0,0,0,0))
  {
    return;
  }
  if(last_pinned_row.length != 0)
  {
    last_pinned_row.after(row)
  }
  else
  {
    row.prependTo('#memo_table');
  }
});