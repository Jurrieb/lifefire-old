class MessagesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(owner_id: current_user.id)
                                          .limit(10)
                                          .order('id desc')
  end
end
