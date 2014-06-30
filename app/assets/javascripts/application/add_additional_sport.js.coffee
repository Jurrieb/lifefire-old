class AddAdditinalSport
  constructor: ->
    # Range form
    @content  = ($ 'content.sport')
    @extra_sport_form = ($ '#new_extra_sport')
    @add_button = ($ '.add_extra_sport')
    @close_button = ($ '.close_extra_sport')

    # Hide second form
    @extra_sport_form.hide()
    @close_button.hide()

    # Add listeners
    @add_button.on 'click', (e) => @toggler(e)
    @close_button.on 'click', (e) => @toggler(e)

  toggler: (e) =>
    # Prevent execution
    e.preventDefault()
    # Show or hide extra input
    if @extra_sport_form.is(":visible")
      @extra_sport_form.slideUp(200).hide()
    else
      @extra_sport_form.slideDown(200).show()
    # Show/hide buttons
    @close_button.toggle()
    @add_button.toggle()

$ ->
  add_sport = new AddAdditinalSport if ($ '.range input[type=range]').length > 0
