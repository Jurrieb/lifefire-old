jQuery(document).ready ->
  # Set timeout for check
  setTimeout (->
    source = new EventSource("/stream/messages")
    source.addEventListener "message-published", (e) ->
      # Log event
      console.log e
  ), 1
