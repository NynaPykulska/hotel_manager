$(document).on('turbolinks:load',function() {

  $("table").tablesorter(); 

  $('.showall').click(function(e){        
    $('.tr-admin').show();
    $('.tr-receptionist').show();
    $('.tr-maid').show();
    $('.tr-maitenance').show();
    $('.showadmin').removeClass('active');
    $('.showreceptionist').removeClass('active');
    $('.showmaid').removeClass('active');
    $('.showmaitenance').removeClass('active');
    $('.showall').addClass('active');
  });

  $('.showadmin').click(function(e){        
    $('.tr-admin').show();
    $('.tr-receptionist').hide();
    $('.tr-maid').hide();
    $('.tr-maitenance').hide();
    $('.showadmin').addClass('active');
    $('.showreceptionist').removeClass('active');
    $('.showmaid').removeClass('active');
    $('.showmaitenance').removeClass('active');
    $('.showall').removeClass('active');  });

  $('.showreceptionist').click(function(e){
    $('.tr-admin').hide();
    $('.tr-receptionist').show();
    $('.tr-maid').hide();
    $('.tr-maitenance').hide();
    $('.showadmin').removeClass('active');
    $('.showreceptionist').addClass('active');
    $('.showmaid').removeClass('active');
    $('.showmaitenance').removeClass('active');
    $('.showall').removeClass('active');   
  });

  $('.showmaid').click(function(e){
    $('.tr-admin').hide();
    $('.tr-receptionist').hide();
    $('.tr-maid').show();
    $('.tr-maitenance').hide();
    $('.showadmin').removeClass('active');
    $('.showreceptionist').removeClass('active');
    $('.showmaid').addClass('active');
    $('.showmaitenance').removeClass('active');
    $('.showall').removeClass('active');   
  });

  $('.showmaitenance').click(function(e){
    $('.tr-admin').hide();
    $('.tr-receptionist').hide();
    $('.tr-maid').hide();
    $('.tr-maitenance').show();
    $('.showadmin').removeClass('active');
    $('.showreceptionist').removeClass('active');
    $('.showmaid').removeClass('active');
    $('.showmaitenance').addClass('active');
    $('.showall').removeClass('active');
  });

});