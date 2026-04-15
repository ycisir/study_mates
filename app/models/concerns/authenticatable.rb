module Authenticatable
	extend ActiveSupport::Concern

	included do
		has_secure_password
		attr_accessor :remember_token
	end

	class_methods do
		# Returns the hash digest of the given string.
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		# Returns a random token.
		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = self.class.new_token
		update!(remember_digest: self.class.digest(remember_token))
		remember_digest
	end

	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.blank? || token.blank?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forgets a user.
	def forget
		update!(remember_digest: nil)
	end
end