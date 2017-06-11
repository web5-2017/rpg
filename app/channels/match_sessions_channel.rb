class MatchSessionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_sessions"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def console(data)
    @data = data
    @game = user.games.find_by id: @data['game_id']

    if @game.nil?
      player_exec
    else
      master_exec
    end

    ActionCable.server.broadcast 'match_sessions', @match_session.last_log
    @match_session.save
  end

  private
    def master_exec
      @match_session = @game.sessions.find @data['session_id']
      @match_session.master_exec @data['code'], 'Mestre'
    end

    def player_exec
      @game = user.games_playing.find @data['game_id']
      @match_session = @game.sessions.find @data['session_id']

      char = user.characters.find_by game_id: @game.id
      @match_session.player_exec @data['code'], char.name, char
    end
end
