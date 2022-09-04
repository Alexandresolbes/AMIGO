class Bill < ApplicationRecord
  belongs_to :wallet
  belongs_to :user

  def amigo
    return self.user
  end
end
