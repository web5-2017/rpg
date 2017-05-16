class RemoveRelationshipBetweenBreedsHistories < ActiveRecord::Migration[5.0]
  def change
    remove_index :breeds, :history_id
    remove_column :breeds, :history_id
  end
end
