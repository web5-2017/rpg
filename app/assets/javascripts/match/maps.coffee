# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
APP.render_map = ->
  json = {
    tambleId: 'm1',
    rows: 6,
    columns: 6,
    mat: [
     ['', 'A', 'B','C','D','E'],
     ['1', 'A1', 'B1','C1','D1','E1'],
     ['2', 'A2', 'B2','C2','D2','E2'],
     ['3', 'A3', 'B3','C3','D3','E3'],
     ['4', 'A4', 'B4','C4','D4','E4'],
     ['5', 'A5', 'B5','C5','D5','E5']
    ],
    map: [
      {id: 'A1', color: '#4e342e'},
      {id: 'A2', color: '#4e342e'},
      {id: 'A3', color: '#4e342e'},
      {id: 'A4', color: '#eeeeee'},
      {id: 'A5', color: '#eeeeee'},
      {id: 'B1', color: '#4e342e'},
      {id: 'B2', color: '#4e342e'},
      {id: 'B3', color: '#4e342e'},
      {id: 'B4', color: '#eeeeee'},
      {id: 'B5', color: '#eeeeee'},
      {id: 'C1', color: '#4e342e'},
      {id: 'C2', color: '#4e342e'},
      {id: 'C3', color: '#4e342e'},
      {id: 'C4', color: '#eeeeee'},
      {id: 'C5', color: '#eeeeee'},
      {id: 'D1', color: '#eeeeee'},
      {id: 'D2', color: '#eeeeee'},
      {id: 'D3', color: '#eeeeee'},
      {id: 'D4', color: '#eeeeee'},
      {id: 'D5', color: '#eeeeee'},
      {id: 'E1', color: '#eeeeee'},
      {id: 'E2', color: '#eeeeee'},
      {id: 'E3', color: '#eeeeee'},
      {id: 'E4', color: '#eeeeee'},
      {id: 'E5', color: '#eeeeee'}
    ]
  }

  map = new APP.Map(json)
  id = $('.map-box').attr('id')
  map.render(id)
