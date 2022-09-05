class Bill < ApplicationRecord
  belongs_to :wallet
  belongs_to :user

  def amigo
    return self.user
  end

  def amigo_wallet
    return Wallet.find_by_user_trip_id(UserTrip.find_by_user_id(self.user.id))
  end
end
