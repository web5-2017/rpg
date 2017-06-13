# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

APP.console_interator = ->
  $('#console-form').submit (e)->
    code = $('#console-input').val().trim()
    $('#console-input').val('')
    game_id = $('#console-input').data('game')
    session_id = $('#console-input').data('session')
    App.matchSessions.console(code, game_id, session_id)
    return false

APP.scroll_console = ->
  if $('#console-output').length
    $('#console-output').animate
          scrollTop: $('#console-output')[0].scrollHeight
    , 1000
