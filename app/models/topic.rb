class Topic < ApplicationRecord
	has_many :rooms, dependent: :destroy
	before_validation :capitalize_name

	private

	def capitalize_name
		self.name = name.to_s.titleize
	end
end
