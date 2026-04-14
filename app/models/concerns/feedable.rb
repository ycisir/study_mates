module Feedable
    extend ActiveSupport::Concern

    def feed
        part_of_feed = "
            relationships.follower_id = :id
            or rooms.user_id = :id
            or rooms_users.user_id = :id
            or messages.user_id = :id
            or EXISTS (
                  SELECT 1 FROM messages
                  WHERE messages.room_id = rooms.id
                  AND messages.user_id = :id
                )
            "
        Room
            .left_outer_joins(user: :followers)
            .left_joins(:participants)
            .left_joins(:messages)
            .where(part_of_feed, { id: id })
            .distinct
            .includes(:user, :topic, messages: { files_attachments: :blob } )
            .order(updated_at: :desc)
    end
end