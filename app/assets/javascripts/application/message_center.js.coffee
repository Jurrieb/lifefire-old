$(document).ready ->
  $("#message").click (e)->
    e.preventDefault()
    if ($(".messageCenter").length == 0)
      $("<ul>").addClass('messageCenter').insertAfter(".menu").hide()
      messageCenter = $(".messageCenter")
      $.ajax '/messages.json',
        type: 'GET'
        dataType: 'html'
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->
          results = JSON.parse data
          for key, value of results
            if value.karma
              messageCenter.prepend('<li data-id="' + value.id + ' "><span class="coloured">' + value.karma + ' karma</span>' + value.name + '</li>')
            else
              messageCenter.prepend('<li data-id="' + value.id + ' ">' + value.name + '</li>')
          if results.length == 0
            messageCenter.prepend('<li>Er zijn geen nieuwe berrichten</li>')
      messageCenter.slideDown("fast")
    else
      messageCenter = $(".messageCenter")
      if(messageCenter.is(':visible'))
        messageCenter.slideUp("fast")
      else
        $.ajax '/messages.json',
        type: 'GET'
        dataType: 'html'
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->
          messageCenter.html("");
          results = JSON.parse data
          for key, value of results
            if value.karma
              messageCenter.prepend('<li data-id="' + value.id + ' "><span class="coloured">' + value.karma + ' karma</span>' + value.name + '</li>')
            else
              messageCenter.prepend('<li data-id="' + value.id + ' ">' + value.name + '</li>')

          if results.length == 0
            messageCenter.prepend('<li>Er zijn geen nieuwe berrichten</li>')
        messageCenter.slideDown("fast")

  callback = ->
    $.ajax '/messages/count.json',
      type: 'GET'
      dataType: 'html'
      success: (data, textStatus, jqXHR) ->
        alert(data)
    setTimeout callback, 10000

  callback()