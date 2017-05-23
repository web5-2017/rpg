class AddMapToMatchSessions < ActiveRecord::Migration[5.0]
  def change
    add_reference :match_sessions, :map, foreign_key: true
  end
end
