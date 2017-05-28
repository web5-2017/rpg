# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

APP.modal_picture_events = ->
  $('#show-new-picture').click ->
    $('#pictures-modal').modal 'hide'
    $('#new-picture-modal').modal 'show'

  $('#cancel-picture').click ->
    $('#new-picture-modal').modal 'hide'
    $('#pictures-modal').modal 'show'
