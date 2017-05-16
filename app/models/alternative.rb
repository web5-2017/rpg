class Alternative < ApplicationRecord
  belongs_to :challenge
  has_and_belongs_to_many :user_characters

  validates :content, presence: true

  def chosen(char)
    self.user_characters << char
    char.add_exp self.exp
  end
end
