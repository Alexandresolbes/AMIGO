class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_trips, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :trips, through: :user_trips
  has_many :activities, through: :participations

  has_one_attached :photo
end
