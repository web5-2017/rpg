class AddCurrentSkillToUserCharacters < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_characters, :skill, foreign_key: true
  end
end
