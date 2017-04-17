class APP.Table

  constructor:(mat, rows, columns, id) ->
    @mat = mat
    @rows = rows
    @columns = columns
    @id = id
    @template = "<table id=\"#{@id}\"class=\"map\">"

  contact: (template)->
    @template += template

  head: ->
    header = '<thead><tr>'

    for j in [0..@columns - 1]
      header += "<th id=\"#{@id}-#{@mat[0][j]}\">#{@mat[0][j]}</th>"

    header += '</tr></thead>'
    @contact header

  body: ->
    body = '<tbody>'
    @head()

    for i in [1..@rows - 1]
      row = '<tr>'
      for j in [0..@columns - 1]
        if j == 0
          row += "<td id=\"#{@id}-#{@mat[i][j]}\">#{@mat[i][j]}</td>"
        else
          row += "<td id=\"#{@id}-#{@mat[i][j]}\" class=\"map-field\">#{@mat[i][j]}</td>" 
      row += '</tr>'
      @contact row

  end: ->
    @template += '</table>'

  render: ->
    @body()
    @end()
    @template
