class Topic < ApplicationRecord
  has_many :rooms, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :with_rooms, -> { joins(:rooms).select("topics.*, COUNT(rooms.id) AS rooms_count").group("topics.id").order(id: :desc).limit(20) }
end
