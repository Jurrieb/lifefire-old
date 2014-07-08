# class MessagesController < ApplicationController

#   # Update all messages to been seen by user
#   def update_seen
#     Message.update_all(seen: true, user_id: current_user.id)
#     render nothing: true
#   end
# end


class MessagesController < FayeRails::Controller
  observe User, :after_save do |message|
    MessagesController.publish('/message', new_widget.attributes)
  end
end
