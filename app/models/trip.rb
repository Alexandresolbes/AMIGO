class Trip < ApplicationRecord
  has_many :activiies
  has_many :users, through: :user_trips
end
