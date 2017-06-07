class UserCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :character
  belongs_to :breed

  validates :name, :history, presence: true
  validates :level,
            :str,
            :dex,
            :con,
            :int,
            :wis,
            :cha,
            :atk,
            :magic_atk,
            :def,
            :magic_def,
            :hp,
            :mp,
            presence: true,
            if: :type_is_npc_or_mob?


  def self.new_for_type(type, attributes)
    attributes[:character_type] = type

    char = self.new attributes
    char.confirmed_attributes = true
    char.new_character = false
    char.exp = char.level * 20

    char
  end

  def add_exp(exp)
    self.exp += exp

    if (self.exp < (self.level - 1) * 20)
      self.exp = (self.level - 1) * 20
    end

    if (self.exp >= self.level * 20)
      self.level += 1
      self.confirmed_attributes = false
    end

    save
  end

  def attack(options = {})
    damage = exec_skill(options)

    if damage > 0
      options[:target].hp -= damage
      options[:target].save
    end

    save
  end

  def set_skill(id)
    if character.skill_ids.include?(Integer(id))
      skill = character.skills.find(id)

      if skill.skill_modifier[1] <= self.mp
        self.skill_id = id
        save
        return true
      end
    end

    false
  end

  def live
    self.hp <= 0 ? "Morto" : "Vivo"
  end

  private
  def type_is_npc_or_mob?
    character_type == 'npc'
  end

  def damage_calc(damage, options)
    dice = Dice.new options[:dice]

    if options[:magic_atk]
      modifier = dice.cast
      damage += self.magic_atk + modifier - options[:target].magic_def
    else
      modifier = dice.cast
      damage += self.atk + modifier - options[:target].def
    end

    damage
  end

  def exec_skill(options)
    damage = 0
    unless self.skill_id.nil?
      skill = Skill.find self.skill_id

      damage += skill.skill_modifier[0]
      self.mp -= skill.skill_modifier[1]
    end

    damage_calc(damage, options)
  end
end
