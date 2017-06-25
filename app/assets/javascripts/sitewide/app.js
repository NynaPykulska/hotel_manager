$(document).on('turbolinks:load',function() {

	$("table").tablesorter(); 

	localStorage.setItem("current_tab" , "all");

	$('#my-link').click(function (event) {
		$('div.g-aside-menu-position-active').removeClass('g-aside-menu-position-active');
	});

	$('.showall').click(function(e){        
		$('.tr-done').show();
		$('.tr-not_done').show();
		$('.showopen').removeClass('active');
		$('.showready').removeClass('active');
		$('.showall').addClass('active');
		localStorage.setItem("current_tab" , "all");
	});

	$('.showopen').click(function(e){        
		$('.tr-done').hide();
		$('.tr-not_done').show();
		$('.showready').removeClass('active');
		$('.showall').removeClass('active');
		$('.showopen').addClass('active');
		localStorage.setItem("current_tab" , "open");
	});

	$('.showready').click(function(e){
		$('.tr-done').show();
		$('.tr-not_done').hide();
		$('.showopen').removeClass('active');
		$('.showall').removeClass('active');
		$('.showready').addClass('active');
		localStorage.setItem("current_tab" , "ready");
	});

});
