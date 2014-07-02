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
    rangeValuePercentage = rangeValue / ((@range.attr('max') * 1.03) * 0.01)
    # Set text and add left css px's
    @output.text(rangeValue).css('left', rangeValuePercentage + '%')

$ ->
  slider_value = new SliderValue if ($ '.range input[type=range]').length > 0
