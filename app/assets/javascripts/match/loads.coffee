$(document).on 'turbolinks:load', ->
  APP.create_character()
  APP.cast_dice()
  APP.breeds_selected()
  APP.save_attrs()
  APP.console_interator()
  APP.scroll_console()
  APP.render_map()
