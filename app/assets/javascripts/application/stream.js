$(function() {
  var source = new EventSource('/messages');
  var count = 0;
  source.addEventListener('messages', function(e) {
    data = JSON.parse(e.data);
    if(data.length > 0){
      $.each(data, function(key, value) {
        if(value.seen == false) {
          count++;
        }
        $('.message_center').prepend('<li data-id="' + value.id + ' "><span class="coloured">' + value.karma + ' karma</span>' + value.message + '</li>');
      });
      while ($('.message_center li').length >= 10) {
        $('.message_center li').last().remove();
      }
    }
    $("#message .count").text(count);
    if(count > 0) {
      $("#message .count").fadeIn('fast');
    }
  });
  $('#message').on( "click", function(e) {
    if($('.message_center').not(':visible')) {
      count = 0
      $("#message .count").fadeOut('fast');
      $.ajax({
        url: "/messages/seen",
        context: document.body
      });
    } 
  $('.message_center').slideToggle("fast");
 	e.preventDefault();
  });
});