class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, :first_name, :last_name, presence: true, uniqueness: true
  validates :encrypted_password, presence: true, uniqueness: true, allow_blank: false

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_trips, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :activities, through: :participations
  has_many :trips, through: :user_trips
  has_many :activities, through: :participations
  has_many :notifications, dependent: :destroy
  has_many :wallets, through: :user_trips
  has_many :bills, dependent: :destroy
  has_many :user_notifications, dependent: :destroy
  has_one_attached :photo

end
