$(document).on 'turbolinks:load', ->
  APP.create_character()
  APP.cast_dice()
  APP.breeds_selected()
  APP.save_attrs()
