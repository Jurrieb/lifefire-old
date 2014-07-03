class MessagesController < ApplicationController

  def update_seen
    Message.update_all(:seen => true, :user_id => current_user.id)
    render layout: false
  end

end
