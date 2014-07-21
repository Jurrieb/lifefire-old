$ ->
  messageCount = 0
  # Get userhash from cookie
  user_hash = $.cookie('user_hash')

  pusher = new Pusher('6f2ca9f149c05426c0d4')
  channel = pusher.subscribe(user_hash)
  channel.bind 'event', (data) ->
    message = data['message']
    messageCenter = $(".message_center").empty()
    messageCount++
    messageCenter.append('<li>' + message + '</li>')
    $("#message .count").text(messageCount)
    $("#message .count").fadeIn()

  $("#message").click (e)->
    messageCenter = $(".message_center")
    messageCount = 0
    $("#message .count").fadeOut()
    messageCenter.slideToggle("fast")
    e.preventDefault()
