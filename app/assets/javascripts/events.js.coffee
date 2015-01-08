jQuery ->
  $(".featured-btn").click ->
    $(this).removeClass("fa")
    $(this).addClass("fa")
    $(this).toggleClass("fa-star-o")
    $(this).toggleClass("fa-star")
    $.post $(this).data("url")

jQuery ->
  $(".filter_austin").click ->
    $("#austin_events").show()
    $("#houston_events").hide()
  $(".filter_houston").click ->
    $("#houston_events").show()
    $("#austin_events").hide()