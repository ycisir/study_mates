# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :set_user, only: [:edit, :update]

  include Pundit


  def update
    authorize @user

    if update_resource(@user, account_update_params)
      redirect_to profile_path(@user), notice: "Profile updated successfully"
    else
      render :edit
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end

  private

  def set_user
    @user = current_user
  end
end
