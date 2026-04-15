class User < ApplicationRecord
	include Authenticatable
	include Activatable
	include Recoverable
	include Followable
	include Feedable

	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :downcase_email

	has_one_attached :avatar do |attachable|
	    attachable.variant :thumb, resize_to_limit: [30, 30]
	    attachable.variant :profile, resize_to_limit: [100, 100]
	    attachable.variant :activity_thumb, resize_to_limit: [20, 20]
	end

	has_many :rooms, dependent: :destroy
	has_and_belongs_to_many :joined_rooms, class_name: "Room", dependent: :destroy
	has_many :messages, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

	extend FriendlyId
	friendly_id :name, use: :slugged

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	scope :search, ->(q) { where("name ILIKE ?", "%#{q}%") }
	scope :activated, -> { where(activated: true) }

	# Returns a session token to prevent session hijacking.
	# We reuse the remember digest for convenience.
	def session_token
		remember_digest || remember
	end

	private

	# Converts email to all lowercase.
	def downcase_email
		self.email = email.downcase
	end
end
