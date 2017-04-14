class History < ApplicationRecord
  include Bootsy::Container

  has_and_belongs_to_many :games
  belongs_to :user
end
