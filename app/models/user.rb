class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  has_many :games
  has_many :characters, class_name: 'UserCharacter'
  has_and_belongs_to_many :games_playing, class_name: 'Game'
  has_many :histories
  has_and_belongs_to_many  :friend_list,
                           class_name: 'User',
                           join_table: "friend_list",
                           foreign_key: "first_friend_id",
                           association_foreign_key: "second_friend_id"

  def self.where_name_like(query, current_user)
    return where("name LIKE '%#{query}%' AND id != #{current_user.id} AND confirmed_at > '0000-00-00 00:00:00'::timestamp")
  end
end
