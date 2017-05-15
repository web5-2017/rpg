class Breed < ApplicationRecord
  belongs_to :game
  has_and_belongs_to_many :particulars
  has_and_belongs_to_many :characters

  validates :name, :description, presence: true
end
