class UsersController < ApplicationController
	before_action :signed_in_user, only: %i[ index edit update destroy ]
	before_action :correct_user, only: %i[ edit update ]
	before_action :admin_user, only: %i[ destroy ]

	def index
		@users = User.paginate(page: params[:page])
		if params[:q].present?
			@users = @users.where('name ILIKE :q', q: "%#{params[:q]}%")
		end
	end

	def show
		@user = User.friendly.find(params[:slug])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			reset_session
			sign_in @user
			flash[:success] = "Welcome to StudyMates"
			redirect_to @user
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
		@user = User.friendly.find(params[:slug])
		flash[:success] = "User deleted"
		redirect_to users_url, status: :see_other
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
	end

	def signed_in_user
		unless signed_in?
			store_location
			flash[:danger] = "Please sign in"
			redirect_to signin_url, status: :see_other
		end
	end

	def correct_user
		@user = User.friendly.find(params[:slug])
		redirect_to(root_url, status: :see_other) unless current_user?(@user)
	end

	def admin_user
		redirect_to(root_url, status: :see_other) unless current_user.admin?
	end
end
