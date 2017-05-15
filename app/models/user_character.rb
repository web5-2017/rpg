class UserCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :character
  belongs_to :breed

  validates :name, :history, :character_id, presence: true
end
