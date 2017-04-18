class CreateCharactersBreeds < ActiveRecord::Migration[5.0]
  def change
    create_join_table :characters, :breeds
    add_index :breeds_characters, [:character_id, :breed_id], unique: true
  end
end
