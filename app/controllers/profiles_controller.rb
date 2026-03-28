class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
  end
end
