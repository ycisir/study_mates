class RoomsController < ApplicationController
	before_action :signed_in_user, only: %i[new create destroy]
	before_action :set_room, only: %i[show destroy]
	before_action :correct_user, only: %i[destroy]
	
	def new
		@room = current_user.rooms.new()
	end

	def create
		@room = current_user.rooms.new(room_params)
		
		if params[:room][:topic_name].present?
			topic_name = params[:room][:topic_name].strip.downcase.titleize
			topic = Topic.find_or_create_by!(name: topic_name)
			@room.topic = topic
		end

		if @room.save
			flash[:success] = "Room created!"
			redirect_to root_url
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
	end

	def destroy
		@room.destroy
		flash[:success] = "Room deleted"
		redirect_to root_url, status: :see_other
	end

	private

	def room_params
		params.require(:room).permit(:name, :topic_name, :info)
	end

	def set_room
		@room = Room.friendly.find(params[:slug])
	end

	def correct_user
		unless (@room.user == current_user || current_user.admin?)
			redirect_to root_url, status: :see_other
		end
	end
end
