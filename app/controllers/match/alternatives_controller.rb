class Match::AlternativesController < Match::AppMatchController

  def destroy
    game = current_user.games.find params[:game_id]
    history = game.histories.find params[:history_id]
    challenge = game.challenges.find params[:challenge_id]
    alternative = challenge.alternatives.find params[:id]

    alternative.destroy

    redirect_to edit_match_game_history_challenge_path(game, history, challenge)
  end
end
