class APP.Map

  constructor: (json) ->
    @rows = json.rows
    @columns = json.columns
    @map = json.map
    @tableId = json.tableId
    console.log(json)

  render: (map_box) ->
    @buildMat()
    @tableTemplate = new APP.Table(@mat, @rows, @columns, @tableId)
    $(map_box).html(@tableTemplate.render())
    @process_cells()

  process_cells: ->
    for component in @map
      for cell in component.cells
        console.log(cell)
        $("##{@tableId}-#{cell}").css("background-color", component.color)

  buildMat: ->
    @rows += 1
    @columns += 1
    @mat = new Array(@rows)
    @mat[i] = new Array(@columns) for i in [0..@rows]

    @head()
    @body()

  head: ->
    @mat[0][0] = ''

    for j in [1..@columns]
      char = 64 + j
      if char <= 90
        @mat[0][j] = String.fromCharCode(char)
      else
        @mat[0][j] = String.fromCharCode(((char - 65)/25) + 64) +
                     String.fromCharCode(char - (26 * Math.floor((char - 65)/25)))

    for i in [1..@rows]
      @mat[i][0] = i

  body: ->
    for i in [1..@rows]
      for j in [1..@columns]
        @mat[i][j] = "#{@mat[0][j]}#{i}"
