class Activity < ApplicationRecord
  validates :title, :address, presence: true, uniqueness: true
  validates :categories, :description, presence: true
  validates :min_amigos, presence: true, numericality: { only_integer: true }, allow_blank: false

  belongs_to :trip
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
