module Profile::HistoriesHelper

  def correct_table_column(game, history)
    if controller.is_a? Profile::HistoriesController
      if controller.action_name == 'index'
        unless game.histories.exists? history.id
          link_to 'Adicionar', profile_game_history_add_history_path(game, history),
                      class: 'btn btn-primary add-history'
        end
      else
        link_to('Editar', edit_profile_history_path(history),
                     class: 'btn btn-primary add-history') + " " +
        link_to('Remover', profile_history_path(history),
                    class: 'btn btn-danger', method: :delete)
      end
    else
        link_to('Remover', profile_game_history_remove_history_path(game, history),
                    class: 'btn btn-danger', method: :delete)
    end
  end

end
