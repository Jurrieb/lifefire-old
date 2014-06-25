class DateSelect
  constructor: ->
    # Date form
    @select = ($ '.date-select')
    @dates = ($ '.date-select a')

    @dates.on 'click', (e) =>
      console.log e.target
      # Nothing happens
      e.preventDefault()
      # Remove active state
      ($ e.target).parent().parent().find('.active').removeClass('active')
      # Add active state to selected
      ($ e.target).parent().parent().addClass('active')


    console.log @select
    console.log @dates.parent()



$ ->
  date_select = new DateSelect if ($ '.date-select').length > 0
