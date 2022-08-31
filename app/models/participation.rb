class Participation < ApplicationRecord
  validates :creator, presence: true, uniqueness: true
  belongs_to :user
  belongs_to :activity
end
