class Room < ApplicationRecord
	attr_accessor :topic_name

	belongs_to :user
	belongs_to :topic
	validates :name, presence: { message: "is required" }
	validates :topic_name, presence: { message: "is required" }
	validates :description,
            presence: { message: "is required" },
            length: { minimum: 10, message: "must be at least 10 characters long" }
	before_validation :clean_data

	private

	def clean_data
	    self.name = name.to_s.titleize
	    self.topic_name = topic_name.to_s.titleize
	end
end
