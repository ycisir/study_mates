class User < ApplicationRecord
	before_save do
		email.downcase!
		username.downcase!
	end
	VALID_USERNAME_REGEX = /\A[a-z0-9_]{4,16}\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :username, presence: true, length: { maximum: 255 }, format: { with: VALID_USERNAME_REGEX }, uniqueness: true
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
