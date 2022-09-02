class Activity < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :address, :categories, :description, presence: true
  validates :min_amigos, presence: true, numericality: { only_integer: true }, allow_blank: false

  belongs_to :trip
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def creator
    @users = User.all
    @creator = @users.select do |user|
      self.participations.find_by_user_id(user.id) && self.participations.find_by_user_id(user.id).creator == true
    end
    return @creator.first
  end

  def creator?(user)
    return true if self.participations.find_by_user_id(user.id) && self.participations.find_by_user_id(user.id).creator == true
  end

  def participates?(user)
    return true if self.participations.find_by_user_id(user.id)
  end
end
