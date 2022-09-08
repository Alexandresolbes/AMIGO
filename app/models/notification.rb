class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :user_notifications, dependent: :destroy
end
