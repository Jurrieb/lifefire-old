class MessagesController < ApplicationController
  def index
    @messages = Message.last(5)
    respond_to do |format|
      format.html
      format.json { render :json => @messages}
  	end
  end

  def new_message_count

  end
end
