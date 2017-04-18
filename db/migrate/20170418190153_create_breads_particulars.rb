class CreateBreadsParticulars < ActiveRecord::Migration[5.0]
  def change
    create_table :particulars do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_join_table :breeds, :particulars
    add_index :breeds_particulars, [:breed_id, :particular_id], unique: true
  end
end
