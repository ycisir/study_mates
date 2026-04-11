# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

start_time = Time.now

puts "Seeding started..."

# Create Admin User
admin = User.create!(
  name: "Jack Sparrow",
  email: "jack@example.com",
  password: "jack123",
  password_confirmation: "jack123",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

puts "Admin created"

# Generate Users
users = [admin]

50.times do |n|
  users << User.create!(
    name: Faker::Name.name,
    email: "test-#{n + 1}@example.co",
    password: "test123",
    password_confirmation: "test123",
    activated: true,
    activated_at: Time.zone.now
  )
end

puts "#{users.count} users created"

# Generate Topics
topics = []

10.times do
  name = Faker::Hobby.activity.strip.downcase.titleize
  topic = Topic.find_or_create_by!(name: name)
  topics << topic
end

topics.uniq!

puts "#{topics.count} topics created"

# Generate Rooms
rooms = []

20.times do
  creator = users.sample
  topic   = topics.sample

  room = Room.create!(
    name: Faker::Lorem.words(number: 3).join(" "),
    info: Faker::Lorem.sentence,
    topic: topic,
    user: creator
  )

  # Ensure creator is always a participant
  participants = users.sample(rand(5..10))
  participants << creator

  participants.uniq.each do |user|
    room.participants << user unless room.participants.include?(user)
  end

  rooms << room
end

puts "Rooms created: #{rooms.count}"

# Time taken
end_time = Time.now
time_taken = (end_time - start_time).round(2)

puts "Seeding completed in #{time_taken} seconds."