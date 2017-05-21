
APP.breeds_selected = ->
  $('#user_character_breed_id').change ->
    $.ajax(
      url: "/game/#{$('#user_character_breed_id').data('game')}/breeds/#{@.value}"
      success: (classes)->
        label = "<label class=\"control-label select required\" for=\"user_character_character_id\">
                    Classes</label>"

        select = "<select id=\"user_character_character_id\" class=\"form-control\" name=\"user_character[character_id]\">
                    <option>Escolha uma classe</option>"

        $.each classes, (index, character) ->
          select += "<option value=\"#{character.id}\">#{character.name}</option>"

        select += "</select>"

        $('#characters').html(label + select)
    )
