class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.string :name
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_join_table :games, :histories
    add_index :games_histories, [:game_id, :history_id], unique: true
  end
end
