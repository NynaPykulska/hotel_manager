// This is a manifest file that'll be compiled into application.js, which will include all the files

// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require turbolinks
//= require sorttable
//= require multi-select
//= require_tree .

        $(document).on('turbolinks:load',function() {

            $('#my-link').click(function (event) {
                $('div.g-aside-menu-position-active').removeClass('g-aside-menu-position-active');
            });

            $("table").tablesorter(); 

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

            $(function(){
                $('#sort_room_issue').click(function() {
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
                    console.log("xaxax");
                });
            });

            $('.showall').click(function(e){        
                 $('.tr-done').show();
                 $('.tr-not_done').show();
                 $('.showopen').removeClass('active');
                 $('.showready').removeClass('active');
                 $('.showall').addClass('active');

            });

            $('.showopen').click(function(e){        
                 $('.tr-done').hide();
                 $('.tr-not_done').show();
                 $('.showready').removeClass('active');
                 $('.showall').removeClass('active');
                 $('.showopen').addClass('active');
            });

            $('.showready').click(function(e){        
                 console.log("eeeee")
                 $('.tr-done').show();
                 $('.tr-not_done').hide();
                 $('.showopen').removeClass('active');
                 $('.showall').removeClass('active');
                 $('.showready').addClass('active');
            });

            $('.ready-button').click(function(e){
            if($(this).closest('tr').hasClass("tr-not_done"))
            {
                console.log("ready");
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
                // $(this).closest('tr').find('.ready-button').prop('disabled', true);
                $(this).closest('tr').find('.ready-button.enabled').hide();
                $(this).closest('tr').find('.ready-button.disabled').show();
        
            }
            });

            $('.reopen').click(function(e){
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
                    
                    // $(this).closest('tr').find('.ready-button').show();
                    // $(this).closest('div').find('.dropdown-menu').hide();
                    $(this).closest('tr').find('.edit-button').show();
                    // $(this).closest('tr').find('.ready-button').prop('disabled', false);
                    $(this).closest('tr').find('.ready-button.enabled').show();
                    $(this).closest('tr').find('.ready-button.disabled').hide();
                }
            });

            $('#new_issue_date_field .input-group.date').datepicker({
                        format: 'yyyy-mm-dd',
                        language: "pl",
                        autoclose: true,
                        todayHighlight: true,
                        todayBtn: "linked"
                    }).on('changeDate', function (a) {
                        
                    });
});