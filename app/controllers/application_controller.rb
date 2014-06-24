class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  # For all actions, authenticate user
  before_action :authenticate_user!
  before_action :check_settings

  # Set flash message and redirect
  def set_flash_and_redirect(status, message, redirect_url)
    flash[status] = message
    redirect_to redirect_url
  end

  def check_settings
    if current_user 
      unless current_user.userPreference.smokes || current_user.userPreference.sports
        redirect_to setup_path unless controller_name == 'users'
      end
    end
  end
end
