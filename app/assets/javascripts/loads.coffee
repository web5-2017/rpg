$(document).on 'turbolinks:load', ->
  APP.image_preview()
  APP.render_map()
  APP.factory_map()
  APP.generate_filds()
  $('.minicolors').minicolors theme: 'bootstrap'
