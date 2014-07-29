class SliderValue
  constructor: ->
    # Range form
    @output = ($ '.range output')
    @range  = ($ '.range input[type=range]')
    @form   = ($ 'form .ranged_field')

    @initialPosition()
    @bindListeners()

  # Change position of slider thumb on start
  initialPosition: =>
    @changePosition()

  # Change position of slider thumb
  changePosition: =>
    offset = ((@range.width() - 30) / 100) * @range.val()
    @output.text(@range.val()).css(left: "#{offset * 2}px")

  # Listen on input
  bindListeners: =>
    @range.on "input", =>
      @changePosition()

$ ->
  slider_value = new SliderValue if ($ '.range input[type=range]').length > 0
