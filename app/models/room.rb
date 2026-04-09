class Room < ApplicationRecord
  before_save :format_name_and_info
  belongs_to :topic
  belongs_to :user # host
  has_and_belongs_to_many :participants, class_name: "User", dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, length: { maximum: 50 }
  validates :info, presence: true, length: { minimum: 10, maximum: 100 }

  def host
    user
  end

  private

  def format_name_and_info
    self.name = name.titleize
    self.info = info.capitalize
  end
end
