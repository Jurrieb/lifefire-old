# Fetches all messages from a user and friend
class MessagesController < ApplicationController
  # Get messages till a week ago
  def index
    @activities = PublicActivity::Activity.where(owner_id: self_and_friends)
                                          .includes(:owner, :recipient)
                                          .limit(10)
                                          .order('id desc')
  end
end
