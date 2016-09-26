class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :exception


  #include helpers
  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    # Pundit
    def user_not_authorized
      flash[:alert] = "You are not authorized to view this page."
      redirect_to(request.referrer || root_path)
    end

end
