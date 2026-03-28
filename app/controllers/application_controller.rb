class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  include Pundit

  # When user is not authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Devise signout redirect
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    # if resource.admin?
    #   admin_root_path
    # else
    #   profile_path
    # end
    profile_path(resource)
  end

  private

  def user_not_authorized
    redirect_to(request.referer || rooms_path, alert: "You are not authorized to perform this action.")
  end
end
