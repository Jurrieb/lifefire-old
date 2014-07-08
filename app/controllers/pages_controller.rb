class PagesController < ApplicationController
  # Do NOT authenticate user
  skip_before_action :authenticate_user!
  # Set user
  before_action :find_user_with_friendly_id, only: :users
  # Render different layout
  layout 'backdrop'

  def index
  end

  # Show privacy policy page
  def privacy_policy
  end

  private

  # Find user with name (Friendly ID)
  def find_user_with_friendly_id
    @found_user = User.friendly.find(params[:id])
  end
end
