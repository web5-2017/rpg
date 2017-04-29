module Match::HistoriesHelper

  def correct_table_column(game, history)
    if controller.is_a? Match::HistoriesController
      if controller.action_name == 'index'
        link_to 'Adicionar', match_game_history_add_history_path(game, history),
                     class: 'btn btn-primary add-history'
      else
        link_to('Editar', edit_match_history_path(history),
                     class: 'btn btn-primary add-history') + " " +
        link_to('Remover', match_history_path(history),
                    class: 'btn btn-danger', method: :delete)
      end
    else
        link_to('Remover', match_game_history_remove_history_path(game, history),
                    class: 'btn btn-danger', method: :delete) + " " +
        link_to('Desafios', match_game_history_challenges_path(game, history),
                    class: 'btn btn-default')
    end
  end

end
