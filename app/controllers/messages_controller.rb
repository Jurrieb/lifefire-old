class MessagesController < ApplicationController
  def index
    @messages = Message.where(user_id: current_user.id).order('id DESC').limit(5)
    respond_to do |format|
      format.html
      format.json { render :json => @messages}
  	end
  end

  def count
    # Render JSON of messages where last is first
    render json: Message.where(user_id: current_user.id).order('id DESC')
  end
end
