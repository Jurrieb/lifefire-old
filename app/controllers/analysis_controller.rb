class AnalysisController < ApplicationController

  include StopSmoking
  include Sports

  def index
  end

  def create
    # Check for spots or smoking params
    add_to_smoking_counter(params[:smoke][:count].to_i) if params[:smoke]
    add_to_sports_counter(params[:sport]) if params[:sport]
    # Redirect
    redirect_to :back
  end

  def current_user_smokes?
    current_user.smokes?
  end
end
