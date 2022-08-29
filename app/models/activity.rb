class Activity < ApplicationRecord
  belongs_to :trip
  has_many :users, through: :particaptions

  has_one_attached :photo
end
