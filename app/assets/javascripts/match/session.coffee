# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

APP.console_interator = ->
  $('#console-input').focus ->
    $('#console-input').keydown (e)->
      if e.keyCode == 13
        code = $('#console-input').val().trim()
        game_id = $('#console-input').data('game')
        session_id = $('#console-input').data('session')
        App.matchSessions.console(code, game_id, session_id)

APP.scroll_console = ->
  if typeof $('#console-output')[0] != 'undefined'
    height = document.getElementById("console-output").scrollHeight
    if height > 150
      $('#console-output').scrollTop( height )
