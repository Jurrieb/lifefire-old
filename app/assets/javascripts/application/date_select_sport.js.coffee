class DateSelectSport
  constructor: ->
    # Date form
    @select = ($ '.date-select.sport')
    @dates = ($ '.date-select.sport a')
    @date_in_text = ($ 'span.date_in_text_sport')

    # Add Localed dates
    Date.ext.locales['nl'] = {
        #a: ['dim', 'lun', 'mar', 'mer', 'jeu', 'ven', 'sam'],
        #A: ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],
        #b: ['jan', 'fév', 'mar', 'avr', 'mai', 'jun', 'jui', 'aoû', 'sep', 'oct', 'nov', 'déc'],
        B: ['januari', 'februari', 'maart', 'april', 'mei', 'juni', 'juli', 'augustus', 'september', 'oktober', 'november', 'december'],
        #c: '%a %d %b %Y %T %Z',
        #p: ['', ''],
        #P: ['', ''],
        x: '%d.%m.%Y',
        #X: '%T'
    }

    # When clicking on a date link
    @dates.on 'click', (e) =>
      # Nothing happens
      e.preventDefault()
      # Get selected date (and parsed)
      year = (new Date).getFullYear()
      date_selected = new Date(($ e.target).text() + year).strftime('%Y-%m-%d')
      # Remove active state
      ($ e.target).parent().find('.active').removeClass('active')
      # Add active state to selected
      ($ e.target).addClass('active')
      # Get values via AJAX request
      $.ajax '/find-sport?date=' + date_selected,
          type: 'GET'
          dataType: 'json'
          success: (data, textStatus, jqXHR) =>
            console.log data
            # Replace text and numbers
            date_in_view = new Date(data['date'])
            # Set date localisation
            date_in_view.locale = "nl"
            # Set in view
            @date_in_text.text(date_in_view.strftime('%d %B'))

$ ->
  date_select2 = new DateSelectSport if ($ '.date-select').length > 0
