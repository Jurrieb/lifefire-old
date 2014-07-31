$ ->
  # if $.cookie("sidebar") == 'open'
  #   if $(".sidebar").width() == 44
  #     $(".content").animate {
  #       paddingLeft: '44px'
  #     }, 200, ->
  #       $(".sidebar").animate {
  #         width: '200px'
  #       }, 200, ->
  #         $(".sidebar span").show()
  # if $.cookie("sidebar") == 'closed'
  #   if $(".sidebar").width() > 44
  #     $(".sidebar span").hide()
  #     $(".sidebar").animate {
  #       width: '44px'
  #     }, 200, ->
  #       $(".content").animate {
  #       paddingLeft: '44px'
  #       }, 200, ->

  $(".sidebar .bars").click (e)->
    if $(".sidebar").width() > 44
      $(".sidebar span").hide()
      $(".sidebar").animate {
        width: '44px'
      }, 200, ->
        $(".content").animate {
          paddingLeft: '44px'
        }, 200, ->
        $.cookie("sidebar",  "closed")
    else
      $(".content").animate {
        paddingLeft: '200px'
      }, 200, ->
        $(".sidebar").animate {
          width: '200px'
        }, 200, ->
          $(".sidebar span").show()
          $.cookie("sidebar", "open")