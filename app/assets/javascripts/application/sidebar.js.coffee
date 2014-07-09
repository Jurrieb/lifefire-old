$ ->
   $(".sidebar .bars").click (e)-> 
      $(".sidebar span").hide()
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
            $(".sidebar span").show()

