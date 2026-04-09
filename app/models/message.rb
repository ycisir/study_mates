class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  after_create :add_user_to_room_participants_list

  private

  def add_user_to_room_participants_list
  # Skip if the sender is the room host
    return if user_id == room.user_id

    unless room.participants.exists?(user_id)
      room.participants << user
    end
  end
end
