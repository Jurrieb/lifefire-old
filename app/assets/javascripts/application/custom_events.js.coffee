$ ->
  $(".messages").click (e)-> 
    ga('send', 'event', 'message', 'click', 'Click a messages')

  $(".profile .add_friend").click (e)-> 
    ga('send', 'event', 'friend', 'add', 'Add a friend')
  $(".friend").click (e)-> 
    ga('send', 'event', 'friend', 'click', 'Click on friend')
  $(".profile .remove_friend").click (e)-> 
    ga('send', 'event', 'friend', 'remove', 'Remove a friend')
  $(".search_form").submit (e)-> 
    ga('send', 'event', 'friend', 'search', 'Search a friend')

  $(".profile .signout").click (e)-> 
    ga('send', 'event', 'interface', 'signout', 'Loggout')
  $(".logo").click (e)-> 
    ga('send', 'event', 'interface', 'logo', 'Click on logo')
  $(".bars").click (e)-> 
    ga('send', 'event', 'interface', 'sidebar', 'Toggles sidebar')

  $(".smokes").submit (e)-> 
    ga('send', 'event', 'smoke', 'create', 'Filled in smoking')
  $(".sports").submit (e)-> 
    ga('send', 'event', 'sport', 'create', 'Filled in sports')
  $(".new_comment").submit (e)-> 
    ga('send', 'event', 'comment', 'create', 'Filled in comment')
