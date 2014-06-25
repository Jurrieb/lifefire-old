class SubmitForm
  constructor: ->
    # Hide submit button
    submit_button = ($ 'form input[type=submit]').hide()
    input = ($ 'form input')

    # Check form on changes and submit
    form = ($ 'form.remote')

    # On form change (listener)
    form.on 'change', (e) =>

      # Validates if fields are not empty, than submit
      # if ($ 'input:empty').length == 0
      form.submit()

$ ->
  submit = new SubmitForm if ($ '.remote').length > 0
