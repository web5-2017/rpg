class CreateTableGamesUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :games, :users
    add_index :games_users, [:game_id, :user_id], unique: true
  end
end
