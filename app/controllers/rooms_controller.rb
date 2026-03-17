class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy]
  before_action :authenticate_user!, only: %i[ new create edit update destroy]
  before_action :authorize_user, only: %i[ edit update destroy]

  def index
    @topics = Topic.last(10)
    @rooms = Room.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: 3)
  end

  def show
  end

  def new
    @room = current_user.rooms.new
    load_topics
  end

  def create
    @room = current_user.rooms.new(room_params)

    if @room.topic_name.present?
      topic = Topic.find_or_create_by(name: @room.topic_name.titleize)
      @room.topic = topic
    end

    if @room.save
      redirect_to @room, notice: 'Room created'
    else
      load_topics
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_topics
  end

  def update
    if params[:room][:topic_name].present?
      topic = Topic.find_or_create_by(name: params[:room][:topic_name].titleize)
      @room.topic = topic
    end

    if @room.update(room_params)
      redirect_to @room, notice: 'Room updated'
    else
      load_topics
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, status: :see_other, notice: "Room deleted"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_user
    redirect_to rooms_path, alert: "You are not authorized" unless current_user == @room.user
  end

  def room_params
    params.expect(room: [ :name, :description, :topic_name ])
  end

  def load_topics
    @topics = Topic.pluck(:name)
  end
end
