
APP.breeds_selected = ->
  $('#user_character_breed_id').change ->
    $.ajax(
      url: "/match/game/#{$('#user_character_breed_id').data('game')}/breeds/#{@.value}"
      success: (classes)->
        select = "<select class=\"form-control\" name=\"user_character[character_id]\">
                    <option>Escolha uma classe</option>"

        $.each classes, (index, character) ->
          select += "<option value=\"#{character.id}\">#{character.name}</option>"

        select += "</select>"

        $('#characters').html(select)
    )
