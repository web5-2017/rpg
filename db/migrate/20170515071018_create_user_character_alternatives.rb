class CreateUserCharacterAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_join_table :alternatives, :user_characters
  end
end
