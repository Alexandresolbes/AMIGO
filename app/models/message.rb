class Message < ApplicationRecord
  validates :content presence: true, allow_blank: false
  validates :created_at presence: true
  validates :updated_at presence: true

  belongs_to :room
  belongs_to :user
end
