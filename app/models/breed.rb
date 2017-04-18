class Breed < ApplicationRecord
  belongs_to :history
  has_and_belongs_to_many :particulars

  validates :name, :description, presence: true
end
