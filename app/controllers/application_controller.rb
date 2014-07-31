# Application Controller holds all shared methods that can be accessed from the
# entire Lifefire project.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # For all actions, authenticate user
  before_action :authenticate_user!
  before_action :user_hash_to_cookie
  before_action :current_user_last_messages

  # Set flash message and redirect
  def set_flash_and_redirect(status, message, redirect_url)
    flash[status] = message
    redirect_to redirect_url
  end

  # - User ID hash ------------------------------------------------------------#
  def user_hash_to_cookie
    if current_user
      cookies[:user_hash] = current_user.user_hash unless cookies[:user_hash]
    end
  end

  # - Redirect paths ----------------------------------------------------------#

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

  # - Array mapping -----------------------------------------------------------#

  # Return array with self + friends ID
  def self_and_friends
    current_user.friendships.accepted.map(&:id) << current_user.id
  end

  #  - Karma background jobs --------------------------------------------------#

  # Calculation for karma as background job adding a friend
  def karma_for_adding_friend
    KarmaWorker.perform_async('add_friend', current_user.id)
  end

  # Calculation for karma as background job for smoking
  def karma_for_smoking
    KarmaWorker.perform_async('smoke', current_user.id)
  end

  # Calculation for karma as background job for sporting
  def karma_for_sporting
    KarmaWorker.perform_async('sport', current_user.id)
  end

  # Calculation for karma as background job for updating profile
  def karma_for_profile
    KarmaWorker.perform_async('profile', current_user.id)
  end

  # Calculation for karma as background job for all of the above
  def karma_for_all_progress
    KarmaWorker.perform_async('all', current_user.id)
  end

  # - Messages ----------------------------------------------------------------#

  # Retrieve the last 5 messages if current user is set
  def current_user_last_messages
    @last_messages = current_user.messages.unseen.limit(5) if current_user
  end
end
