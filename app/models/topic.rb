class Topic < ApplicationRecord
	before_save :titleize_name
	validates :name, presence: true, length: { maximum: 30 }
	extend FriendlyId
	friendly_id :name, use: :slugged

	private

	def titleize_name
		self.name = name.titleize
	end
end
