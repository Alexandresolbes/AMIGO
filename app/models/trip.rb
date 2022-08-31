class Trip < ApplicationRecord
  validates :destination, presence: true

  has_many :activities, dependent: :destroy
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips
end
