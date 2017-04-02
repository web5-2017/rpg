APP.imagePreview = ->
  readURL = (input)->
    if input.files && input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $('.file_preview').attr 'src', e.target.result
        $('.file_preview').addClass('active')

      reader.readAsDataURL input.files[0]

  $("#user_avatar").change ->
      readURL @
      $('#box-image-preview .text-input').css('display' : 'none')
      $('#box-image-preview .btn').css('display' : 'block')
