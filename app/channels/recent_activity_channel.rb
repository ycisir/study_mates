class RecentActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "recent_activity_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
