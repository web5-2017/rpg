class CreateFriendList < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_list do |t|
      t.references :first_friend, references: :user, foreign_key: true
      t.references :second_friend, references: :user, foreign_key: true
    end
  end
end
