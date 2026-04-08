class Room < ApplicationRecord
  before_save :capitalize_name_and_info

  belongs_to :topic
  belongs_to :user
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, length: { maximum: 50 }
  validates :info, presence: true, length: { minimum: 10, maximum: 100 }

  private

  def capitalize_name_and_info
    self.name = name.capitalize
    self.info = info.capitalize
  end
end
