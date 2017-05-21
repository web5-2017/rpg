# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

APP.console_interator = ->
  $('#console-input').focus ->
    $('#console-input').keydown (e)->
      if e.keyCode == 8 or e.keyCode == 46
        user_name = $('#console-input').data('user')
        if $('#console-input').val() == "#{user_name}# - "
          e.preventDefault();

      if e.keyCode == 13
        pattern = /.*# - (.*)/
        code = pattern.exec($('#console-input').val())[1].trim()
        location.href = $('#console-input').data('url') + "?code=#{code}";

APP.scroll_console = ->
  height = document.getElementById("console-output").scrollHeight
  $('#console-output').scrollTop( height )
