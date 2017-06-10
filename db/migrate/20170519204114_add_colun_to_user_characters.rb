class AddColunToUserCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :user_characters, :character_type, :string
  end
end
