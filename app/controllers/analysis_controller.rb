class AnalysisController < ApplicationController

  # Include all programs
  include StopSmoking
  include Sports

  def index
  end

  def create
    # Check for spots or smoking params
    add_to_smoking_counter if params[:smoke]
    add_to_sports_counter if params[:sport]
    # Redirect
    redirect_to :back
  end

  def current_user_smokes?
    current_user.smokes?
  end

  def current_user_sports_graphic
    # Fetch one week and burned calories
    render json: current_user.sports.where(date: (1.weeks.ago.midnight..Time.now)).sum(:burned_calories)
  end

  def current_user_smokes_graphic
    # Fetch smoke data, limit 7 => 7 days
    render json: current_user.smokes.last(7).sum(:counted)
  end
end
