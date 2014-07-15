# The ProgressController shows in an interactive way the progress of the
# programs from the current user.
class ProgressController < ApplicationController
  before_action :user, only: :index

  def index
    # Set data for graphs
    @smokes = @user.smokes if @user.smokes?
    @sports = @user.sports if @user.sports?
  end

  private

  # Set the current user in variable
  def user
    @user = User.find(current_user.id)
  end
end
