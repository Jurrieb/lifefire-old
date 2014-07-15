# Application Controller holds all shared methods that can be accessed from the
# entire Lifefire project.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # For all actions, authenticate user
  before_action :authenticate_user!

  # Set flash message and redirect
  def set_flash_and_redirect(status, message, redirect_url)
    flash[status] = message
    redirect_to redirect_url
  end

  # URL to redirect to after sign in (Devise)
  def after_sign_in_path_for(resource)
    analysis_index_path
  end

  # URL to redirect to after sign out (Devise)
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # Redirects first time user to setup path
  def redirect_to_setup_path
    redirect_to setup_path unless controller_name == 'users'
  end

  # Return array with self + friends ID
  def self_and_friends
    current_user.friends.map(&:id) << current_user.id
  end
end
