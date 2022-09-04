class Trip < ApplicationRecord
  validates :destination, presence: true

  has_many :activities, dependent: :destroy
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips
  has_many :notifications, dependent: :destroy
  has_many :rooms, dependent: :destroy

  def creator
    @users = User.all
    @creator = @users.select do |user|
      self.user_trips.find_by_user_id(user.id) && self.user_trips.find_by_user_id(user.id).creator == true
    end
    return @creator.first
  end

  def creator?(user)
    return true if self.user_trips.find_by_user_id(user.id) && self.user_trips.find_by_user_id(user.id).creator == true
  end

  def participates?(user)
    return true if self.user_trips.find_by_user_id(user.id)
  end
end
