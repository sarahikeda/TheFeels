$(document).ready(function(){
  $('.add-partner').click(function(){
    $(".add-partner").prop("disabled", true);
    $('.new-partner').show();
    $('.add-partner').hide();
  });
});
