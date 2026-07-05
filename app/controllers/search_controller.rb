class SearchController < ApplicationController
  def index
    @topics = Topic.with_rooms
    @messages = Message.activity_feed
    if params[:q].present?
      @rooms = Room.search(params[:q])
      @users = User.search(params[:q]).activated
    else
      @users = []
      @rooms = []
    end
  end
end
