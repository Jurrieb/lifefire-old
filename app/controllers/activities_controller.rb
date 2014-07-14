class ActivitiesController < ApplicationController

  before_action :user_activities, only: :index

  def show
    @activity = Activity.find(params[:id])
    @comment  = @activity.comments.new
  end

  private

  def user_activities
    @user = User.find(params[:friend_id])
  end
end
