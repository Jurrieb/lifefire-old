$(function() {
  var source = new EventSource('/messages');
  source.addEventListener('counter', function(e) {
    console.log(e.data)
  });
});