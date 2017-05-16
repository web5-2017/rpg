class AddExpToAlternatives < ActiveRecord::Migration[5.0]
  def change
    add_column :alternatives, :exp, :integer
  end
end
