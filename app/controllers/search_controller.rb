class SearchController < ApplicationController
  def index
    @topics = Topic.with_rooms
    @messages = Message.activity_feed
    if params[:q].present?
      @rooms = Room.search(params[:q]).paginate(page: params[:page], per_page: 30)
      @rooms_count = @rooms.count
    else
      @rooms = []
      @rooms_count = 0
    end
  end
end