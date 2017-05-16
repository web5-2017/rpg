class History < ApplicationRecord
  include Bootsy::Container

  has_and_belongs_to_many :games
  has_many :maps
  belongs_to :user

  def destroy
    if self.games.empty?
      super
      return true
    end

    false
  end
end
