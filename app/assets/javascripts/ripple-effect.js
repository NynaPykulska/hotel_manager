// Ripple Effect
$(function(){
    var ink, d, x, y;
    $(".g-ripple-effect").click(function(e){
        if($(this).find(".g-ink-effect").length === 0) {
            $(this).prepend("<span class='g-ink-effect'></span>");
        }
             
        ink = $(this).find(".g-ink-effect");
        ink.removeClass("g-ink-effect-animate");
         
        if(!ink.height() && !ink.width()){
            d = Math.max($(this).outerWidth(), $(this).outerHeight());
            ink.css({height: d, width: d});
        }
         
        x = e.pageX - $(this).offset().left - ink.width()/2;
        y = e.pageY - $(this).offset().top - ink.height()/2;
         
        ink.css({top: y+'px', left: x+'px'}).addClass("g-ink-effect-animate");
    });
});