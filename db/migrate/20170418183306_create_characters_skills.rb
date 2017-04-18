class CreateCharactersSkills < ActiveRecord::Migration[5.0]
  def change
    create_join_table :characters, :skills
    add_index :characters_skills, [:character_id, :skill_id], unique: true
  end
end
