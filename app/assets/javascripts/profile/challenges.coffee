# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

div_input = (id) ->
  return "
<div class=\"row\">
  <div class=\"col-xs-10\">
    <div class=\"form-group string required challenge_alternatives_content\">
        <label class=\"control-label string required\" for=\"challenge_alternatives_attributes_#{id}_content\">Content</label>
        <input class=\"form-control string required\" name=\"challenge[alternatives_attributes][#{id}][content]\"
               id=\"challenge_alternatives_attributes_#{id}_content\" type=\"text\">
    </div>
  </div>
  <div class=\"col-xs-2\">
    <button id=\"remove-js\"type=\"button\" class=\"btn btn-default\">x</button>
  </div>
</div>
"

APP.generate_filds =  ->
  $('#add-alternative').click ->
    id = $('#alternatives .challenge_alternatives_content').length
    unless id >= 10
      $('#alternatives').append(div_input(id))

  $('#alternatives').on 'click', '#remove-js', ->
    $(@).parent().parent().remove()
