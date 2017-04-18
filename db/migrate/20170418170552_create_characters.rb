class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :description
      t.references :history, foreign_key: true

      t.timestamps
    end
  end
end
