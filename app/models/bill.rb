class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  validates :user_id, presence: { message: "must be given please" }
  
  def amigo
    return self.user
  end

  def amigo_wallet
    return Wallet.find_by_user_trip_id(UserTrip.find_by_user_id(self.user.id))
  end
end
