class SliderValue
  constructor: ->
    # Range form
    @output = ($ '.range output')
    @range = ($ '.range input[type=range]')
    @form = ($ 'form .ranged_field')
    # Get Value from range
    @getAndSetValue()
    # On change get value
    @range.on 'input', (e) =>
      @getAndSetValue()

  getAndSetValue: ->
    # Counted
    rangeValue = @range.val()
    # Percentage
    rangeValuePercentage = @range.val() * 2
    # Corrected width for slider
    rangeWidth = ((@range.width() - 30) / 100) * rangeValuePercentage
    # Set text and add left css px's
    @output.text(rangeValue).css('left', rangeWidth + 'px')

$ ->
  slider_value = new SliderValue if ($ '.range input[type=range]').length > 0