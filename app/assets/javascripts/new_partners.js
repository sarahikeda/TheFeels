$(document).ready(function(){
  $('.add-partner').click(function(){
    $(".add-partner").prop("disabled", true);
    $('.new-partner').show();
    $('.add-partner').hide();
  });

  $(".sentiment-spacing").rangeslider({
    polyfill: false
  });

  $(".partners-list").change(function(){
    var partnerId = this.value
    $.ajax({
      url: '/emails',
      data: {"partner": partnerId}
    })
  })
});
