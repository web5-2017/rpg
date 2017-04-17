# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
APP.render_map = ->
  $('.map-box').each ->
    json_map = $($(@).data('map'))

    unless json_map.val().length == 0
      json = JSON.parse(json_map.val())
      map = new APP.Map(json)
      map.render(@)

APP.factory_map = ->
  json_map = $('#map_json_map')

  unless json_map.val().length == 0
    json = JSON.parse(json_map.val())
  else
    json =
      tableId: 'new-map'
      rows: 15
      columns: 18
      map: []
    $('#map_rows').val(15)
    $('#map_columns').val(18)
    json_map.val(JSON.stringify(json))

  factory_rows_collumns(json, json_map)
  factory_add_components(json, json_map)
  factory_component(json, json_map)
  factory_cells_component(json, json_map)

  APP.render_map()

factory_add_components = (json, json_map) ->
  $('#new-components button').click ->
    name = $('#component_name').val()
    color = $('#component_color').val()

    json.map.push(
      {
        name: name
        color: color
        cells: []
      }
    )
    json_map.val(JSON.stringify(json))

    $('#components').append("<p class='component' style='background-color: #{color};'>#{name}</p>")

factory_component = (json) ->
  $('.form-map-box').on 'click', '.component', ->
    name = $(@).text()
    index = 0
    for component in json.map
      if component.name == name
        break
      else
        index++

    $('.component').css 'border', '1px solid black'
    $(@).css 'border', '5px solid black'

    $('#active-component').html(index)

factory_cells_component = (json, json_map) ->
  map = new APP.Map(json)

  $('.map-box').on 'click', '.map-field', ->
    index = parseInt($('#active-component').html())
    cells = json.map[index].cells

    if cells.indexOf($(@).text()) == -1
      cells.push($(@).text())
    else
      if ( cells.indexOf($(@).text()) == 0 )
        cells = cells.slice(1, cells.length)
      else if ( cells.indexOf($(@).text()) == cells.length - 1 )
        cells.pop()
      else
        array1 = cells.slice(0, cells.indexOf($(@).text()))
        array2 = cells.slice(cells.indexOf($(@).text()) + 1, cells.length)
        cells = array1.concat(array2)

    json.map[index].cells = cells
    json_map.val(JSON.stringify(json))
    map.process_cells()

factory_rows_collumns = (json, json_map)->
    $('#map_rows').focusout ->
      json.rows = parseInt($(@).val())
      json_map.val(JSON.stringify(json))
      APP.render_map()

    $('#map_columns').focusout ->
      json.columns = parseInt($(@).val())
      json_map.val(JSON.stringify(json))
      APP.render_map()
