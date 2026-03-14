class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy]
  before_action :authenticate_user!, only: %i[ new create edit update destroy]

  def index
    @rooms = Room.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to @room, notice: 'Room created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Room updated'
    else
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

  def room_params
    params.expect(room: [ :name, :description ])
  end
end
