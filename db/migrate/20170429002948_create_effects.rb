class CreateEffects < ActiveRecord::Migration[5.0]
  def change
    create_table :effects do |t|
      t.string :name
      t.text :description
      t.float :value
      t.integer :duration

      t.timestamps
    end
  end
end
