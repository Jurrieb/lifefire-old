# Fetches all messages from a user and friend
class MessagesController < ApplicationController
  # Get messages till a week ago
  def index
    @messages = current_user.messages.limit(100).order('id desc')
  end

  def show
    @message = Message.find(params[:id])
    @comment  = @message.comments.new
  end

end
