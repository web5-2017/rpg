class Breed < ApplicationRecord
  belongs_to :game
  has_and_belongs_to_many :particulars

  validates :name, :description, presence: true
end
