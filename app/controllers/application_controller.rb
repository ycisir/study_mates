class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:danger] = "Record not found!"
    redirect_to root_url
  end
end
