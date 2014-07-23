class SetupToggle
  constructor: ->
    # Set switch elements
    @smoke_switch  = ($ '.smoke_switch input')
    @sport_switch  = ($ '.sport_switch input')
    # Check for changes
    @bindListeners()

  bindListeners: =>
    @smoke_switch.on 'change', (e) =>
      @toggleElement('smoke')
    @sport_switch.on 'change', (e) =>
      @toggleElement('sport')

  toggleElement: (element_name) =>
    ($ ".hidden_input_fields .#{element_name}").slideToggle('200')

$ ->
  toggle = new SetupToggle if ($ '.setup').length > 0
