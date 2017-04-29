class Item < ApplicationRecord
  belongs_to :effect
  belongs_to :game

  validates :name, :description, presence: true
end
