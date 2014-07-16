$ ->
  $(".friend").click (e)-> 
  	document.location.href = $(this).find('a').attr('href')