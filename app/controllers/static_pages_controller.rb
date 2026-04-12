class StaticPagesController < ApplicationController
  def home
    @topics = Topic.with_rooms
    @rooms = Room.feed.paginate(page: params[:page], per_page: 10)

    if params[:topic].present?
      topic = Topic.friendly.find(params[:topic])
      @rooms = @rooms.by_topic(topic.id)
    else
      @rooms
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
