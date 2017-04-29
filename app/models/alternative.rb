class Alternative < ApplicationRecord
  belongs_to :challenge

  validates :content, presence: true
end
