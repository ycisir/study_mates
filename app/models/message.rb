class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many_attached :files do |attachable|
      attachable.variant :thumb, resize_to_limit: [150, 150]
  end
  after_create :add_user_to_room_participants_list
  after_create_commit :broadcast_recent_activity

  scope :recent, -> { order(created_at: :desc).first(9) }
  scope :activity_feed, -> { includes(:user, :room).recent  }

  private

  def add_user_to_room_participants_list
  # Skip if the sender is the room host
    return if user_id == room.user_id

    unless room.participants.include?(user)
      room.participants << user
    end
  end

  def broadcast_recent_activity
    html = ApplicationController.render(
      partial: "static_pages/recent_activity",
      locals: { message: self }
    )

    ActionCable.server.broadcast("recent_activity_channel", {
      html: html
    })
  end
end
