class StaticPagesController < ApplicationController
  def home
    @rooms = Room.feed.paginate(page: params[:page], per_page: 10)
  end

  def help
  end

  def about
  end

  def contact
  end
end
