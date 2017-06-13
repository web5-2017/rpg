App.matchSessions = App.cable.subscriptions.create "MatchSessionsChannel",
  connected: ->
    console.log('connected')

  disconnected: ->
    console.log("disconnected")

  received: (data) ->
    console.log(data)

  console: (code, game_id, session_id) ->
    @perform 'console', code: code, game_id: game_id, session_id: session_id
