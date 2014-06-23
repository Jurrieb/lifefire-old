class NotificationRemover
  constructor: ->
    @notifications = ($ '.notification .notice')
    @delay_time = 6000

    for notice in @notifications
      @removeNotice(notice)
      @delay(@delay_time)

  removeNotice: (notice) =>
    ($ notice).delay(@delay_time).animate({ height: 0, opacity: 0 }, '200')

$ ->
  remover = new NotificationRemover if ($ '.notification .notice').length > 0
