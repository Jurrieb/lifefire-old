$ ->
  messageCount = 0
  client = new Faye.Client('/faye')
  # Get userhash from template
  user_hash = ($ '.userhash').text()

  # Subscribe to private user channel
  client.subscribe '/message/' + user_hash, (payload)->
    console.log payload
    messageCenter = $(".message_center")
    messageCount++
    messageCenter.append('<li>' + payload + '</li>')
    $("#message .count").text(messageCount)
    $("#message .count").fadeIn()

  $("#message").click (e)->
    messageCenter = $(".message_center")
    messageCount = 0  
    $("#message .count").fadeOut()
    messageCenter.slideToggle("fast")
    e.preventDefault()
