class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many_attached :files do |attachable|
      attachable.variant :thumb, resize_to_limit: [150, 150]
  end
  after_create :add_user_to_room_participants_list

  private

  def add_user_to_room_participants_list
  # Skip if the sender is the room host
    return if user_id == room.user_id

    unless room.participants.include?(user)
      room.participants << user
    end
  end
end
