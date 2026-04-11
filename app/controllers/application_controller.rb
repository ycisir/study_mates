class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # Confirms a signed-in user.
  def signed_in_user
    unless signed_in?
      store_location
      flash[:danger] = "Please sign in"
      redirect_to signin_url, status: :see_other
    end
  end

  def record_not_found
    flash[:danger] = "Record not found!"
    redirect_to root_url
  end
end
