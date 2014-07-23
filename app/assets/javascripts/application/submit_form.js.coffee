# class SubmitForm
#   constructor: ->
#     # Hide submit button
#     submit_button = ($ 'form input[type=submit]').hide()
#     input = ($ 'form input')
#     # Check form on changes and submit
#     form = ($ 'form.remote')
#     # On form change (listener)
#     form.on 'change', (e) =>
#       # Submit this form only
#       form.submit() unless input == 0
#       message = "Opgeslagen"
#       # Find notification container
#       notice = ($ '.notification .notice.success')
#       notice.html(message)

# $ ->
#   submit = new SubmitForm if ($ '.remote').length > 0
