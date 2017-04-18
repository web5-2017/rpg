class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.string :name
      t.text :json_map
      t.integer :rows
      t.integer :columns
      t.references :history, foreign_key: true

      t.timestamps
    end
  end
end
