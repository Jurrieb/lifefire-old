class DateSelect
  constructor: ->
    # # Date form
    @dateSelect = ($ '#dateselect')
    # Initialize date select JqueryUI
    @dateSelect.datepicker({ dateFormat: 'dd-mm-yy' })



    # @dates = ($ '.date-select.smoke a')
    # @date_in_text = ($ 'span.date_in_text_smoke')
    # @smoked_value = ($ '.range output')
    # @counted_value = ($ '#smoke_counted')

    # # Add Localed dates
    # Date.ext.locales['nl'] = {
    #     #a: ['dim', 'lun', 'mar', 'mer', 'jeu', 'ven', 'sam'],
    #     #A: ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],
    #     #b: ['jan', 'fév', 'mar', 'avr', 'mai', 'jun', 'jui', 'aoû', 'sep', 'oct', 'nov', 'déc'],
    #     B: ['januari', 'februari', 'maart', 'april', 'mei', 'juni', 'juli', 'augustus', 'september', 'oktober', 'november', 'december'],
    #     #c: '%a %d %b %Y %T %Z',
    #     #p: ['', ''],
    #     #P: ['', ''],
    #     x: '%d.%m.%Y',
    #     #X: '%T'
    # }

    # # When clicking on a date link
    # @dates.on 'click', (e) =>
    #   # Nothing happens
    #   e.preventDefault()
    #   # Get selected date (and parsed)
    #   year = (new Date).getFullYear()
    #   date_selected = new Date(($ e.target).text() + year).strftime('%Y-%m-%d')
    #   # Remove active state
    #   ($ e.target).parent().find('.active').removeClass('active')
    #   # Add active state to selected
    #   ($ e.target).addClass('active')
    #   # Get values via AJAX request
    #   $.ajax '/find-smokes?date=' + date_selected,
    #       type: 'GET'
    #       dataType: 'json'
    #       success: (data, textStatus, jqXHR) =>
    #         # Replace text and numbers
    #         date_in_view = new Date(data['date'])
    #         # Set date localisation
    #         date_in_view.locale = "nl"
    #         # Set in view
    #         @date_in_text.text(date_in_view.strftime('%d %B'))
    #         @smoked_value.text(data['counted'])
    #         @counted_value.val(data['counted'])
    #         # Edit css for slider thumb
    #         @range = ($ '.range input[type=range]')
    #         rangeValue = @range.val()
    #         # Percentage of slider
    #         rangeValuePercentage = @range.val() * 2
    #         # Corrected width for slider
    #         rangeWidth = ((@range.width() - 30) / 100) * rangeValuePercentage
    #         # Set text and add left css px's
    #         @smoked_value.css('left', rangeWidth + 'px')

$ ->
  date_select = new DateSelect if ($ '#dateselect').length > 0
