class Room < ApplicationRecord
  attr_accessor :topic_name
  before_save :format_name_and_info
  belongs_to :topic
  belongs_to :user # host
  has_and_belongs_to_many :participants, class_name: "User", dependent: :destroy
  has_many :messages, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, length: { maximum: 50 }
  validates :info, presence: true, length: { minimum: 10, maximum: 50 }

  def host
    user
  end

  scope :feed, -> {
    includes(:user, :topic).order(created_at: :desc)
  }

  private

  def format_name_and_info
    self.name = name.to_s.titleize
    self.info = info.to_s.capitalize
  end
end
