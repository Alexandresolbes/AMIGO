class Message < ApplicationRecord
  validates :content, presence: true, allow_blank: false
  belongs_to :room
  belongs_to :user
  has_many :user_messages
end
