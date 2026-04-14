module Feedable
    extend ActiveSupport::Concern

    def feed
        part_of_feed = "relationships.follower_id = :id or rooms.user_id = :id or rooms_users.user_id = :id"
        Room.left_outer_joins(user: :followers).left_joins(:participants).where(part_of_feed, { id: id })
        .distinct.includes(:user, :topic, messages: { files_attachments: :blob } )
    end
end