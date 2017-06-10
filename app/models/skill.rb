class Skill < ApplicationRecord

  def skill_modifier
    result = []
    skill_modifier = self.modifier.split(',')
    result << Integer(skill_modifier[0].split(':')[1])
    result << Integer(skill_modifier[1].split(':')[1])

    result
  end

end
