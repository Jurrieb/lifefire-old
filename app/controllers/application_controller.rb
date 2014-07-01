class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  # For all actions, authenticate user
  before_action :authenticate_user!
  before_action :check_settings, only: :facebook

  # Set flash message and redirect
  def set_flash_and_redirect(status, message, redirect_url)
    flash[status] = message
    redirect_to redirect_url
  end

  # Check settings and redirect to user setup
  def check_settings
    if current_user
      unless current_user.userPreference.smokes || current_user.userPreference.sports
        redirect_to setup_path unless controller_name == 'users'
      end
    end
  end

  # Redirect to analysis#index
  def after_sign_in_path_for(resource)
    analysis_index_path
  end

  # Redirect to sign in page
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
