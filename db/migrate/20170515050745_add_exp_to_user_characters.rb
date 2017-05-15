class AddExpToUserCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :user_characters, :exp, :integer, default: 1
    add_column :user_characters, :level, :integer, default: 1
  end
end
