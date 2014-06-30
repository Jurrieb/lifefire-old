class SubmitForm
  constructor: ->
    # Hide submit button
    submit_button = ($ 'form input[type=submit]').hide()
    input = ($ 'form input')
    # Check form on changes and submit
    form = ($ 'form.remote')
    # On form change (listener)
    form.on 'change', (e) =>
      # Get correct form to submit
      submit_form = ($ e.target).closest('form')
      # Check if form requires date param
      if submit_form.hasClass('smokes') || submit_form.hasClass('sports')
        # Parse and create date
        year = (new Date).getFullYear()
        date = ($ e.target).closest('.component').find('.date-select .active').text()
        date_parsed = new Date(date + year).strftime('%Y-%m-%d')
        # Set date hidden input field
        date_input = ($ '.hidden_date input[type=hidden]').val(date_parsed)

      # TODO:validation Validates if fields are not empty, than submit
      # if ($ 'input:empty').length == 0

      # Submit this form only
      submit_form.submit()

      # Refresh graph
      refresh_graph = new refreshGraph if ($ '.graph').length > 0

$ ->
  submit = new SubmitForm if ($ '.remote').length > 0
