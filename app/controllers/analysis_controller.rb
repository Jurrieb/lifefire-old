class AnalysisController < ApplicationController

  # Include modules TODO: Based upon settings user
  # include Sports

  include StopSmoking
  include Sports

  def index
    @all_time = smoked_all_time
    @all_costs = calculate_price(@all_time)

    @sports_duration_today = get_total_duration_today
    @sport_duration = get_total_duration
  end

  def create
    # Check for spots or smoking params
    add_to_smoking_counter(params[:smoke][:count].to_i) if params[:smoke]
    add_to_sports_counter(params[:sport]) if params[:sport]

    redirect_to :back
  end

  def current_user_smokes?
    current_user.smokes?
  end
end
