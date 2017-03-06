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
//= require_tree .

var room_order = 0;
        var date_order = 0;

        $(document).on('turbolinks:load',function() {

            $('#my-link').click(function (event) {
                $('div.g-aside-menu-position-active').removeClass('g-aside-menu-position-active');
            });

            $("table").tablesorter({
                dateFormat : "uk",
                headers: {
                    // set "sorter: false" (no quotes) to disable the column
                    0: { sorter: "false" },
                    1: { sorter: "text" },
                    3: { sorter: "text" }
                }
            }); 

            $(function(){
                $('#sort_room').click(function() {
                    $("table").trigger("sorton", [[[2, room_order]]]);
                    room_order = ((room_order + 1) % 2 );
                });
            });

            $(function(){
                $('#sort_date').click(function() {
                    $("table").trigger("sorton", [[[3, date_order]]]);
                    date_order = ((date_order + 1) % 2 );
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
                $(this).closest('tr').find('.strike-out').addClass('td-done');
                $(this).closest('tr').removeClass('tr-not_done');
                $(this).closest('tr').addClass('tr-done');
                // Change number of ready memos
                var old_number = parseInt(document.getElementById('ready-number').innerHTML);
                old_number++;
                $('#ready-number').text(old_number);
                // Change number of open memos
                old_number = parseInt(document.getElementById('open-number').innerHTML);
                old_number--;
                $('#open-number').text(old_number);
                $(this).closest('tr').find('.is-complete-icon-ok').show();
                $(this).closest('tr').find('.is-complete-icon-circle').hide();
                $(this).closest('tr').find('.edit-issue-button').hide();
                $(this).closest('tr').find('.ready-button').attr('disabled', true);
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
                    // $(this).closest('tr').find('.ready-button').show();
                    // $(this).closest('div').find('.dropdown-menu').hide();
                    $(this).closest('tr').find('.edit-issue-button').show();
                    $(this).closest('tr').find('.ready-button').removeAttr('disabled');
                }
            });

            $("#recurring_check_box").change(function() {
                if(this.checked)
                {
                    $("#new_memo_date_field").hide()
                    $("#new_memo_recurring_options").show()
                }
                else
                {
                    $("#new_memo_date_field").show()
                    $("#new_memo_recurring_options").hide()
                }
            });

            $("#memo_recurrence").change(function() {
                if($(this).val() == 4){
                    $("#new_memo_recurring_additional").show()
                } else {
                    $("#new_memo_recurring_additional").hide()
                }
            });
});