class DateSelectSport
  constructor: ->
    # # Date form
    @dateSelect = ($ '#dateselect')
    # Initialize date select JqueryUI
    @dateSelect.datepicker({ dateFormat: 'dd-mm-yy', maxDate: "+0w"  })
    # Slider input and output
    @smoked_value = ($ '.range output')
    @counted_value = ($ '#smoke_counted')
    # Event listeners
    @bindListeners()


  bindListeners: =>
    @dateSelect.on 'change', (e) =>
      e.preventDefault()
      # Get selected date (and parsed)
      date_selected = moment(($ e.target).val(), "MM-DD-YYYY")._i
      # Get values via AJAX request
      $.ajax '/find-smokes?date=' + date_selected,
          type: 'GET'
          dataType: 'json'
          success: (data, textStatus, jqXHR) =>
            # Set new data
            @smoked_value.text(data['counted'])
            @counted_value.val(data['counted'])
            # Edit css for slider thumb
            @range = ($ '.range input[type=range]')
            rangeValue = @range.val()
            # Percentage of slider
            rangeValuePercentage = @range.val() * 2
            # Corrected width for slider
            rangeWidth = ((@range.width() - 30) / 100) * rangeValuePercentage
            # Set text and add left css px's
            @smoked_value.css('left', rangeWidth + 'px')

$ ->
  date_select = new DateSelectSport if ($ '#dateselect.sport').length > 0
