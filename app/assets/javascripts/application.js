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

        $(document).ready(function() {

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

            $('#showall').click(function(e){        
                 $('.done').show();
                 $('.not_done').show();
                 e.stopPropagation();

            });

            $('#showopen').click(function(e){        
                 $('.done').hide();
                 $('.not_done').show();
                 e.stopPropagation();
            });

            $('#showready').click(function(e){        
                 $('.done').show();
                 $('.not_done').hide();
                 e.stopPropagation();
            });

            $('#mark_ready').click(function(e){
						    $(this).closest("tr").css("color","#FF0000");
						});

        });