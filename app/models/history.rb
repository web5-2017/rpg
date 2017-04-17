class History < ApplicationRecord
  include Bootsy::Container

  has_and_belongs_to_many :games
  has_many :maps
  has_many :breeds
  belongs_to :user

  def destroy
    puts self.games.empty?
    if self.games.empty?
      super
      return true
    end

    false
  end
end
