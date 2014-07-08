# $(document).ready ->
#   $("#message").click (e)->
#     e.preventDefault()
#     if ($(".messageCenter").length == 0)
#       $("<ul>").addClass('messageCenter').insertAfter(".menu").hide()
#       messageCenter = $(".messageCenter")
#       $.ajax '/messages.json',
#         type: 'GET'
#         dataType: 'html'
#         error: (jqXHR, textStatus, errorThrown) ->
#         success: (data, textStatus, jqXHR) ->
#           results = JSON.parse data
#           for key, value of results
#             if value.karma
#               messageCenter.prepend('<li data-id="' + value.id + ' "><span class="coloured">' + value.karma + ' karma</span>' + value.message + '</li>')
#             else
#               messageCenter.prepend('<li data-id="' + value.id + ' ">' + value.message + '</li>')
#           if results.length == 0
#             messageCenter.prepend('<li>Er zijn geen nieuwe berichten</li>')
#       messageCenter.slideDown("fast")
#     else
#       messageCenter = $(".messageCenter")
#       if(messageCenter.is(':visible'))
#         messageCenter.slideUp("fast")
#       else
#         $.ajax '/messages.json',
#         type: 'GET'
#         dataType: 'html'
#         error: (jqXHR, textStatus, errorThrown) ->
#         success: (data, textStatus, jqXHR) ->
#           messageCenter.html("");
#           results = JSON.parse data
#           for key, value of results
#             if value.karma
#               messageCenter.prepend('<li data-id="' + value.id + ' "><span class="coloured">' + value.karma + ' karma</span>' + value.name + '</li>')
#             else
#               messageCenter.prepend('<li data-id="' + value.id + ' ">' + value.name + '</li>')

#           if results.length == 0
#             messageCenter.prepend('<li>Er zijn geen nieuwe berichten</li>')
#         messageCenter.slideDown("fast")


$ ->
  console.log "Laden van Faye"
  client = new Faye.Client('/faye')

  user_hash = ($ '.userhash').text()

  console.log user_hash

  client.subscribe '/message/' + user_hash, (payload)->
    console.log "PING!"
    # You probably want to think seriously about XSS here:
    console.log payload
