# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(name: "Jack Sparrow", email: "jack@example.com", password: "jack123", password_confirmation: "jack123", admin: true)

# Generate a bunch of additional users.
99.times do |n|
	name = Faker::Name.name
	email = "test-#{n+1}@example.co"
	password = "test123"
	User.create!(name: name, email: email, password: password, password_confirmation: password)
end