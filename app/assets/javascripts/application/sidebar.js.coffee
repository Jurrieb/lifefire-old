$ ->
   $(".sidebar .bars").click (e)-> 
      if $(".sidebar").width() > 44
        $(".sidebar").animate {
          width: '44px'
        }, 100, ->
          $(".content").animate {
            width: $('.content').width() + 156
          }, 100, ->
      else
        $(".content").animate {
          width: $('.content').width() - 156
        }, 100, ->
          $(".sidebar").animate {
            width: '200px'
          }, 100, ->

