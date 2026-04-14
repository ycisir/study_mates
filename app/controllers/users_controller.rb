class UsersController < ApplicationController
	before_action :signed_in_user, only: %i[ index edit update destroy following followers ]
	before_action :set_user, only: %i[ show edit update destroy following followers ]
	before_action :check_activation, only: %i[ show edit update destroy following followers ]
	before_action :correct_user, only: %i[ edit update ]
	before_action :admin_user, only: %i[ destroy ]

	def index
		@users = User.where(activated: true).paginate(page: params[:page])
	end

	def show
		@rooms = Room.by_user(@user).paginate(page: params[:page], per_page: 10)
	end

	def new
		redirect_to(root_url, status: :see_other) if signed_in?
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:info] = "Please check your email to activate your account."
			redirect_to root_url
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy
		flash[:success] = "User deleted"
		redirect_to users_url, status: :see_other
	end

	def following
	    @title = "Following"
	    @users = @user.following.paginate(page: params[:page])
	    render 'show_follow'
	  end

	  def followers
	    @title = "Followers"
	    @users = @user.followers.paginate(page: params[:page])
	    render 'show_follow'
	  end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
	end

	def correct_user
		redirect_to(root_url, status: :see_other) unless current_user?(@user)
	end

	def set_user
	  @user = User.friendly.find(params[:slug])
	end

	def check_activation
		redirect_to root_url and return unless @user.activated
	end

	def admin_user
		redirect_to root_url unless current_user&.admin?
	end
end
