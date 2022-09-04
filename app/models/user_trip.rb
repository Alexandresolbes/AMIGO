class UserTrip < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  def wallet
    return Wallet.find_by_user_trip_id(self.id)
  end
end
