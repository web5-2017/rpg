class Character < ApplicationRecord
  belongs_to :history
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :breeds

  validates :name, :description, presence: true
end
