class Activity < ApplicationRecord
  belongs_to :trip
  has_many :users, through: :particaptions

  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if :will_save_change_to_address?
end
