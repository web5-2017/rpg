class Game < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :players, class_name: 'user'

  validates :name, presence: true
end
