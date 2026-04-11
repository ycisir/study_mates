class Topic < ApplicationRecord
	has_many :rooms, dependent: :destroy
	validates :name, presence: true, length: { maximum: 30 }
	extend FriendlyId
	friendly_id :name, use: :slugged
end
