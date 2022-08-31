class Message < ApplicationRecord
  validates :content, presence: true, allow_blank: false
  belongs_to :room
  belongs_to :user
end
