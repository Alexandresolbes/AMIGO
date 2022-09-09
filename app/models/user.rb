class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true, allow_blank: false

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

  def amigos
    User.all.reject { |u| u.id == self.id }
  end

  def wallet
    Wallet.find_by_user_trip_id(UserTrip.find_by_user_id(self.id).id)
  end

  def balances
    balances = 0
    self.amigos.each do |a|
      balances += 1 if self.wallet.account(a) > 0
      balances -= 1 if self.wallet.account(a) > 0
    end
    balances
  end
end
