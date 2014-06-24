class SubmitForm
  constructor: ->
    # Hide submit button
    @submit_button = ($ 'form input[type=submit]').hide()

    # Check form on changes and submit
    @form = ($ 'form.remote')
    @form.on 'change', (e) =>
      @form.submit()

$ ->
  submit = new SubmitForm if ($ '.remote').length > 0
