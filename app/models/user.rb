class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  has_many :games
  has_and_belongs_to_many :games_playing, class_name: 'Game'
  has_many :histories

  def self.where_name_like(query, current_user)
    return where("name LIKE '%#{query}%' AND id != #{current_user.id}")
  end
end
