class MessagesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(owner_id: user_ids)
                                          .where('created_at > ?', 1.week.ago)
                                          .order('id desc')
  end

  private

  # Creates array of (user)IDs that is used for selecting messages
  def user_ids
    # Create new array
    ids = []
    # Set current user ID in array
    ids << current_user.id
    # For all friends, add to array
    current_user.friends.each { |friend| ids << friend.id }
    # Return array
    ids
  end
end
