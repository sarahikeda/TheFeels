$(document).ready(function(){
  $('.add-partner').click(function(){
    $('.new-partner').show();
    $('.add-partner').hide();
  });

  $(".sentiment-spacing").rangeslider({
    polyfill: false
  });
});
