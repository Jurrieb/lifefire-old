class SubmitForm
  constructor: ->
    # Hide submit button
    submit_button = ($ 'form input[type=submit]').hide()
    input = ($ 'form input')

    # Check form on changes and submit
    form = ($ 'form.remote')

    # On form change (listener)
    form.on 'change', (e) =>

      # Check if form requires date
      if form.hasClass('smokes') || form.hasClass('sports')
        year = (new Date).getFullYear()
        date = ($ e.target).closest('.component').find('.date-select .active').text()
        date_parsed = new Date(date + year)
        # Set date hidden input field
        date_input = ($ '.hidden_date input[type=hidden]').val(date_parsed)


      # Validates if fields are not empty, than submit
      # if ($ 'input:empty').length == 0
      form.submit()

$ ->
  submit = new SubmitForm if ($ '.remote').length > 0
