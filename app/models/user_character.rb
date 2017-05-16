class UserCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :character
  belongs_to :breed
  has_and_belongs_to_many :alternatives

  validates :name, :history, :character_id, presence: true


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
end
