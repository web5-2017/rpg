class Game < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :players, class_name: 'User'
  has_and_belongs_to_many :histories
  has_many :challenges
  has_many :items

  validates :name, presence: true
end
