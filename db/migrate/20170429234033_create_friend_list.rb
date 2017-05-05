class CreateFriendList < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_list do |t|
      t.references :first_friend, index: true
      t.references :second_friend, index: true
    end

    add_foreign_key :friend_list, :users, column: :first_friend_id
    add_foreign_key :friend_list, :users, column: :second_friend_id
  end
end
