class CreateUserCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :user_characters do |t|
      t.string :name
      t.text :history
      t.integer :str, default: 0
      t.integer :dex, default: 0
      t.integer :con, default: 0
      t.integer :int, default: 0
      t.integer :wis, default: 0
      t.integer :cha, default: 0
      t.integer :atk, default: 10
      t.integer :magic_atk, default: 20
      t.integer :hp, default: 20
      t.integer :mp, default: 10
      t.integer :def, default: 5
      t.integer :magic_def, default: 10
      t.boolean :confirmed_attributes, default: false
      t.boolean :new_character, default: true
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.references :character, foreign_key: true
      t.references :breed, foreign_key: true

      t.timestamps
    end
  end
end
