class UserTrip < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :wallets
  has_many :bills, through: :wallets
  
  def wallet
    return Wallet.find_by_user_trip_id(self.id)
  end
end
