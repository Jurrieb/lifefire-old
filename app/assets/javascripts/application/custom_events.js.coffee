$ ->
  $(".messages").click (e)-> 
    ga('send', 'event', 'message', 'click', 'Click a messages')
  $(".profile .add_friend").click (e)-> 
    ga('send', 'event', 'friend', 'add', 'Add a friend')
  $(".profile .add_friend").click (e)-> 
    ga('send', 'event', 'friend', 'remove', 'Remove a friend')
  $(".profile .signout").click (e)-> 
    ga('send', 'event', 'user', 'signout', 'Logs out')
  $(".search_form").submit (e)-> 
    ga('send', 'event', 'friend', 'search', 'Search a friend')
  $(".bars").click (e)-> 
    ga('send', 'event', 'sidebar', 'toggle', 'Toggles sidebar')
  $(".friend").click (e)-> 
    ga('send', 'event', 'friend', 'click', 'Click on friend')
