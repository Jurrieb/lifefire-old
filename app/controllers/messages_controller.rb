# class MessagesController < ApplicationController

#   # Update all messages to been seen by user
#   def update_seen
#     Message.update_all(seen: true, user_id: current_user.id)
#     render nothing: true
#   end
# end


class MessagesController < ApplicationController
  # observe User, :after_save do |message|
  #   MessagesController.publish("/message/#{current_user.user_hash}", message.attributes)
  # end

  def index  
  	@activities = PublicActivity::Activity.where(owner_id: current_user.id).limit(10).order('id desc')
  end
end
