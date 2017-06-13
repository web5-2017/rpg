class CreateMatchSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :match_sessions do |t|
      t.references :game, foreign_key: true
      t.boolean :opened, default: false
      t.text :log

      t.timestamps
    end
  end
end
