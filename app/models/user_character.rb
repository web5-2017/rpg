class UserCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :character
  belongs_to :breed
  has_and_belongs_to_many :alternatives

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
    dice = Dice.new options[:dice]

    if options[:magic_atk]
      modifier = dice.cast
      damage = self.magic_atk + modifier - options[:target].magic_def

      if damage > 0
        options[:target].hp -= damage
      end
    elsif options[:skill]

    else
      modifier = dice.cast
      damage = self.atk + modifier - options[:target].def

      if damage > 0
        options[:target].hp -= damage
      end
    end

    options[:target].save
    save
  end

  def set_skill(id)
    if character.skills.include? id
      self.current_skill_id = id
      return save
    end

    return false
  end

  def live
    self.hp <= 0 ? "Morto" : "Vivo"
  end

  private
  def type_is_npc_or_mob?
    character_type == 'npc'
  end
end
