class RemoveRelationshipBetweenCharactersHistories < ActiveRecord::Migration[5.0]
  def change
    remove_index :characters, :history_id
    remove_column :characters, :history_id
  end
end
