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

  unless json_map.length == 0
    unless (json_map.val() == '')
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
    remove_component(json, json_map)

    APP.render_map()

factory_add_components = (json, json_map) ->
  for component in json.map
    $('#components').append(
            "<p class='component clearfix' data-name=\"#{component.name}\" style='background-color: #{component.color};'>
                #{component.name}
                <span class='btn btn-default pull-right'>X</span>
            </p>")

  $('#new-components button').click ->
    name = $('#component_name').val()
    color = $('#component_color').val()
    index = get_index_component(json, name, color)

    unless index != null
      json.map.push(
        {
          name: name
          color: color
          cells: []
        }
      )
      json_map.val(JSON.stringify(json))

      $('#components').append(
                      "<p class='component clearfix' data-name=\"#{name}\" style='background-color: #{color};'>
                          #{name}
                          <span class='btn btn-default pull-right'>X</span>
                      </p>")

get_index_component = (json, name, color = null)->
  index = 0
  for component in json.map
    if component.name.toLowerCase() == name.toLowerCase()
      return index

    if index and component.color == color
      return index

    index++

  index = null

factory_component = (json) ->
  $('.form-map-box').on 'click', '.component', ->
    name = $(@).data('name')
    index = get_index_component(json, name)

    $('.component').css 'border', '1px solid black'
    $(@).css 'border', '5px solid black'

    $('#active-component').html(index)

factory_cells_component = (json, json_map) ->
  map = new APP.Map(json)

  $('.map-box').on 'click', '.map-field', ->
    index = parseInt($('#active-component').html())
    unless isNaN(index)
      cells = json.map[index].cells

      if map.cell_component_empty($(@).text(), index)
        if cells.indexOf($(@).text()) == -1
          cells.push($(@).text())
          map.add_cell_component($(@).text(), json.map[index])
        else
          map.remove_cell_component($(@).text())
          cells = remove_array(cells, cells.indexOf($(@).text()))

        json.map[index].cells = cells
        json_map.val(JSON.stringify(json))

factory_rows_collumns = (json, json_map)->
    $('#map_rows').focusout ->
      json.rows = parseInt($(@).val())
      json_map.val(JSON.stringify(json))
      APP.render_map()

    $('#map_columns').focusout ->
      json.columns = parseInt($(@).val())
      json_map.val(JSON.stringify(json))
      APP.render_map()

remove_component = (json, json_map) ->
  $('.form-map-box').on 'click', '.component .btn', ->
    index = get_index_component(json, $(@).parent().data('name'))
    json.map = remove_array(json.map, index)
    $(@).parent().css('display', 'none')
    json_map.val(JSON.stringify(json))
    APP.render_map()


remove_array = (array, index) ->
  if ( index == 0 )
    return array.slice(1, array.length)
  if ( index == array.length - 1 )
    array.pop()
    return array

  array1 = array.slice(0, index)
  array2 = array.slice(index + 1, array.length)
  return array1.concat(array2)
