class AddBattleToMatchSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :match_sessions, :battle_string, :string
  end
end
