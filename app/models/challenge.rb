class Challenge < ApplicationRecord
  attr_reader :alternatives_count

  has_many :alternatives, dependent: :destroy, inverse_of: :challenge
  belongs_to :history
  belongs_to :game

  accepts_nested_attributes_for :alternatives

  validates :name, :description, presence: true
end
