class StaticPagesController < ApplicationController
  def home
    @topics = Topic.with_rooms
    @messages = Message.activity_feed
    @rooms = Room.feed

    if params[:topic].present?
      topic = Topic.friendly.find(params[:topic])
      @rooms = @rooms.by_topic(topic.id)
    end

    @rooms = @rooms.paginate(page: params[:page], per_page: 10)
  end

  def help
  end

  def about
  end

  def contact
  end
end
