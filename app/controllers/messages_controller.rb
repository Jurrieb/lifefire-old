class MessagesController < ApplicationController
  def index
    @messages = Message.where(user_id: current_user.id).order(:created_at).limit(5)
    respond_to do |format|
      format.html
      format.json { render :json => @messages}
  	end
  end

  def count

  end
end
