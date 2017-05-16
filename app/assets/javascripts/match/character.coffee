# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

APP.cast_dice = ->
  $('#action').on 'click', '#dice', ->
      $.ajax(
        url: '/cast_dice'
        data:
          type: 6
          amount: 6
        success: (result) ->
          add_dice_atribures result
          ajax_save_attrs(true)
          $('#action').html(' ')
      )

APP.save_attrs = ->
  $('#action').on 'click', '#save', ->
    ajax_save_attrs()

APP.create_character = ->
  $('.decrease').click ->
    value = decrement_value(get_value(@), $(@).data('attr'))
    set_value(@, value)

  $('.add').click ->
    value = increment_value(get_value(@))
    set_value(@, value)

  $('#str').change ->
    calc_str_attr()

  $('#int').change ->
    calc_int_attr()

  $('#total-points').change ->
    if get_int_value('#total-points') == 0
      $('#action').html('<button id="save" type="button" class="btn btn-primary">Salvar</button>')
    else
      $('#action').html('')


###################################################################################################
############################ Helpers methods #####################################################
#################################################################################################

ajax_save_attrs = (dice)->
  game_id = $('#action').data('game')
  data =
    character_attrs:
      str: get_int_value('#str')
      dex: get_int_value('#dex')
      con: get_int_value('#con')
      int: get_int_value('#int')
      wis: get_int_value('#wis')
      cha: get_int_value('#cha')
      hp: get_int_value('#hp')
      atk: get_int_value('#atk')
      def: get_int_value('#def')
      mp: get_int_value('#mp')
      magic_atk: get_int_value('#magic_atk')
      magic_def: get_int_value('#magic_def')
      confirmed_attributes: true

  if dice
    data.character_attrs.new_character = false

  $.post({
    url:"/match/game/#{game_id}/save_attrs"
    data: data
  });

add_dice_atribures = (result) ->
  $('#str').text(get_int_value('#str') + result[0])
  $('#dex').text(get_int_value('#dex') + result[1])
  $('#con').text(get_int_value('#con') + result[2])
  $('#int').text(get_int_value('#int') + result[3])
  $('#wis').text(get_int_value('#wis') + result[4])
  $('#cha').text(get_int_value('#cha') + result[5])
  calc_str_attr()
  calc_int_attr()

calc_int_attr = ->
  value = get_int_value('#int')
  mp = 10 + value * 3
  magic_atk = 20 + value * 2
  magic_def = 10 + value * 2
  $('#mp').text(mp)
  $('#magic_atk').text(magic_atk)
  $('#magic_def').text(magic_def)

calc_str_attr = ->
  value = get_int_value('#str')
  hp = 20 + value * 5
  atk = 10 + value
  def = 5 + value
  $('#hp').text(hp)
  $('#atk').text(atk)
  $('#def').text(def)

get_value = (obj)->
  id = $(obj).data('attr')
  return get_int_value(id)

set_value = (obj, value)->
  id = $(obj).data('attr')
  $(id).text(value)
  $(id).change()

increment_value = (value) ->
  total = get_int_value('#total-points')

  if (total >= 1)
    value++
    total--
    $('#total-points').text(total)
    $('#total-points').change()

  return value

decrement_value = (value, id) ->
  total = get_int_value('#total-points')

  if value > parseInt($(id).data('value'))
    value--
    total++
    $('#total-points').text(total)
    $('#total-points').change()

  return value

get_int_value = (selector)->
  return parseInt($(selector).text())
