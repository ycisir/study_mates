class SearchController < ApplicationController
	def index
		if params[:q].present?
	      @rooms = Room.search(params[:q])
		  @users = User.search(params[:q]).activated
	    else
	      @users = []
	      @rooms = []
	    end
	end
end
