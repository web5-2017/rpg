# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

APP.console_interator = ->
  $('#console-input').focus ->
    $('#console-input').keydown (e)->
      if e.keyCode == 13
        code = $('#console-input').val().trim()
        location.href = $('#console-input').data('url') + "?code=#{code}";

APP.scroll_console = ->
  if typeof $('#console-output')[0] != 'undefined'
    height = document.getElementById("console-output").scrollHeight
    if height > 150
      $('#console-output').scrollTop( height )
