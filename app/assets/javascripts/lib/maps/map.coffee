class APP.Map

  constructor: (json) ->
    @rows = json.rows
    @columns = json.columns
    @map = json.map
    @mat = json.mat
    @tambleId = json.tambleId
    @tableTemplate = new APP.Table(@mat, @rows, @columns, @tambleId)

  render: (id) ->
    $("##{id}").html(@tableTemplate.render())

    for cell in @map
      $("##{@tambleId}-#{cell.id}").css("background-color", cell.color);
