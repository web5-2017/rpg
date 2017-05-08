class AddColunsToSkill < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :modifier, :integer
  end
end
