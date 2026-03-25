class Room < ApplicationRecord
	attr_accessor :topic_name

	belongs_to :user
	belongs_to :topic
	validates :name, presence: { message: "is required" }
	validates :topic_name, presence: { message: "is required" }
	validates :description, length: { minimum: 5}
	before_validation :clean_data

	def topic_name
		topic&.name
	end

	def topic_name=(name)
		self.topic = Topic.find_or_create_by(name: name)
	end

	private

	def clean_data
	    self.name = name.to_s.titleize
	    self.topic_name = topic_name.to_s.titleize
	    self.description = description.to_s.capitalize
	end
end
