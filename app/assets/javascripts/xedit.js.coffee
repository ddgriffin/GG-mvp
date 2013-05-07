# request the state of the event from the server
# update the appropriate checkmarks
$.updateCheckmarks = ->
  $.ajax
    url: $('#checkmarks-url').data('url')
    type: 'get'
    dataType: 'json'
    data: "id=" + $('#checkmarks-url').data('id')
    success: (checkmarks)->
      if checkmarks.design
        $('#number-design').addClass('hidden')
        $('#checkmark-design').removeClass('hidden')
      else
        $('#number-design').removeClass('hidden')
        $('#checkmark-design').addClass('hidden')
      if checkmarks.private
        $('#number-private').addClass('hidden')
        $('#checkmark-private').removeClass('hidden')
      else
        $('#number-private').removeClass('hidden')
        $('#checkmark-private').addClass('hidden')
      if checkmarks.payment
        $('#number-payment').addClass('hidden')
        $('#checkmark-payment').removeClass('hidden')
      else
        $('#number-payment').removeClass('hidden')
        $('#checkmark-payment').addClass('hidden')

jQuery ->
  # editable initialization
  $('.editable').editable
    mode: 'inline'
    onblur: 'submit'
    ajaxOptions:
      type: 'put'
      dataType: 'json'
    success: (response)->
      if response.errors
        return response.errors
      $(this).parent('.field').css "opacity", "0"
      $(this).parent('.field').animate(opacity: "1", 1500)
      $.updateCheckmarks

    # editable tag fields
    $('.tags').children(".editable").editable
      mode: 'inline'
      onblur: 'submit'
      ajaxOptions:
        type: 'put'
        dataType: 'json'
      params: (params)->
        data = {}
        data['id'] = params.pk
        data['name'] = params.name
        data['value'] = ->
          if params.value
            return params.value
          else
            return []
        return data
      success: (response)->
        if response.errors
          return response.errors
        $(this).parent('.field').css "opacity", "0"
        $(this).parent('.field').animate(opacity: "1", 1500)
        $.updateCheckmarks

    # TBA customizations
    $('#tba').children(".editable").editable
      mode: 'inline'
      onblur: 'submit'
      ajaxOptions:
        type: 'put'
        dataType: 'json'
      success: (response)->
        if (response.datetime_tba == true)
          $('#dates, #from').addClass('hidden')
        else
          $('#dates, #from').removeClass('hidden')
        $(this).parent('.field').css "opacity", "0"
        $(this).parent('.field').animate(opacity: "1", 1500)

    # private address customization
    $('#private-address').children(".editable").editable
      mode: 'inline'
      onblur: 'submit'
      ajaxOptions:
        type: 'put'
        dataType: 'json'
      success: (response)->
        if (response.location_private == true)
          $('#nbrhood-toggle').removeClass('hidden')
        else
          $('#nbrhood-toggle').addClass('hidden')
        $(this).parent('.field').css "opacity", "0"
        $(this).parent('.field').animate(opacity: "1", 1500)

  # preview window
  childWindow = undefined
  $(".preview-btn").click ->
    if childWindow
      childWindow.close()
    childWindow = window.open $(this).data('url')















