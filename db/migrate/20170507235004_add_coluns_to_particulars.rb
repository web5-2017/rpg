class AddColunsToParticulars < ActiveRecord::Migration[5.0]
  def change
    add_column :particulars, :additional, :string
  end
end
