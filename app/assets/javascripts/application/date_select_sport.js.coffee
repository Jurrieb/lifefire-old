class DateSelectSport
  constructor: ->
    # Date form
    @dateSelect = ($ '#dateselect')
    # Initialize date select JqueryUI
    @dateSelect.datepicker({ dateFormat: 'dd-mm-yy', maxDate: "+0w"  })
    # Input and date elements
    @sportsList = ($ '.messages.sports ul')
    @datetitle = ($ 'span.date_sported')
    # Event listeners
    @bindListeners()

  bindListeners: =>
    @dateSelect.on 'change', (e) =>
      e.preventDefault()
      # Get selected date (and parsed)
      date_selected = moment(($ e.target).val(), "MM-DD-YYYY")._i
      # Get values via AJAX request
      $.ajax '/find-sport?date=' + date_selected,
          type: 'GET'
          dataType: 'json'
          success: (data, textStatus, jqXHR) =>
            console.log data
            # Create array of objects
            sports = []
            for sport in data
              # Create LI and add to array
              sport = "<li>" + sport['populair_sport']['name'] + " - " + sport['duration'] + " - " + " reacties(0)</li>"
              sports.push sport
            # Set message if there is now sport practised
            sports.push "<li>Geen sport beoefend</li>" if sports.length == 0
            # Empty UL
            @sportsList.empty()
            # Set new data in UL
            @sportsList.html(sports)
            # Set title
            @datetitle.text(date_selected)

$ ->
  date_select = new DateSelectSport if ($ '#dateselect.sport').length > 0
