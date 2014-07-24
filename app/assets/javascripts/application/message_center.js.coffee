class MessageCenter
  constructor: ->
    alert('hi!')
    # Pusher settings & user hash
    user_hash       = $.cookie('user_hash')
    pusher          = new Pusher('6f2ca9f149c05426c0d4')
    @channel        = pusher.subscribe(user_hash)
    # Message count
    @messageCount   = 0
    @messageCenter  = ($ '.message_center')
    @messageButton  = ($ '#message')
    @messageCounter = ($ '#message .count')

    @bindListeners()

  bindListeners: =>
    @channel.bind 'event', (data) =>
      # Retrieve message
      message = data['message']
      @messageCount++
      # Append message to ul
      @messageCenter.append('<li>' + message + '</li>')
      # Add to counter
      @messageCounter.text(@messageCount).fadeIn()

    @messageButton.click (e) =>
      e.preventDefault()
      # Remove counted value
      @messageCount = 0
      @messageCounter.fadeOut()
      # Open list
      @messageCenter.slideToggle("fast")

$ ->
  message_center = new MessageCenter if ($ '.message_center').length > 0
