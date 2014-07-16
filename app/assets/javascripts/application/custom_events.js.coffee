$ ->
  $(".messages").click (e)-> 
    ga('send', 'event', 'message', 'click', 'Click a messages')
  $(".profile .add_friend").click (e)-> 
    ga('send', 'event', 'friend', 'add', 'Add a friend')
  $(".profile .remove_friend").click (e)-> 
    ga('send', 'event', 'friend', 'remove', 'Remove a friend')
  $(".profile .signout").click (e)-> 
    ga('send', 'event', 'interface', 'signout', 'Loggout')
  $(".search_form").submit (e)-> 
    ga('send', 'event', 'friend', 'search', 'Search a friend')
  $(".bars").click (e)-> 
    ga('send', 'event', 'interface', 'sidebar', 'Toggles sidebar')
  $(".friend").click (e)-> 
    ga('send', 'event', 'friend', 'click', 'Click on friend')
  $(".smokes").submit (e)-> 
    ga('send', 'event', 'smoke', 'create', 'Filled in smoking')
  $(".sports").submit (e)-> 
    ga('send', 'event', 'sport', 'create', 'Filled in sports')
  $(".logo").click (e)-> 
    ga('send', 'event', 'interface', 'logo', 'Click on logo')
