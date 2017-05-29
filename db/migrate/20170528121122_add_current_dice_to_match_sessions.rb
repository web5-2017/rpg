class AddCurrentDiceToMatchSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :match_sessions, :current_dice, :integer, default: 6
  end
end
