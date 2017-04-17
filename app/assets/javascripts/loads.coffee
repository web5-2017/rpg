$(document).on 'turbolinks:load', ->
  APP.image_preview()
  APP.render_map()
  APP.factory_map()
  $('.minicolors').minicolors theme: 'bootstrap'
