class AddFildsToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_reference :challenges, :game, index: true, foreign_key: true
    add_reference :challenges, :history, index: true, foreign_key: true
  end
end
