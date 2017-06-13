App.matchSessions = App.cable.subscriptions.create "MatchSessionsChannel",
  connected: ->
    console.log('connected')

  disconnected: ->
    console.log("disconnected")

  received: (data) ->
    console.log(data)

    $('#console-output').append(data.log)

    $('#console-output').animate
          scrollTop: $('#console-output')[0].scrollHeight
    , 1000

    if data.battle == null
      $('#battle').html("")
    else
      render_table(data.battle)

  console: (code, game_id, session_id) ->
    @perform 'console', code: code, game_id: game_id, session_id: session_id


render_table = (chars) ->
  init_table = table()
  end_table = "</tbody></table></div></div>"

  for char in chars
    init_table += row_table(char)

  init_table += end_table

  $('#battle').html(init_table)



row_table = (char) ->
  return "<tr>
    <td>#{char.id}</td>
    <td>#{char.name}</td>
    <td>#{char.status}</td>
  </tr>"

table = ->
  return "<div class=\"panel panel-default\">
    <div class=\"panel-heading\">Batalha</div>
    <div class=\"panel-body\">
      <table class=\"table\">
        <thead>
          <tr>
            <th>id</th>
            <th>Nome</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>"
