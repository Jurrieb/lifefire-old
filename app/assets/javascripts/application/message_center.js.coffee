$ ->
  messageCount = 0
  console.log "FAYE CLIENT"
  client = new Faye.Client('/faye')
  console.log client

  # Get userhash from cookie
  user_hash = $.cookie('user_hash')
  console.log user_hash

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
