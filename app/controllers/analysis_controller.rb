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

  # Check if current user smokes
  def current_user_smokes?
    current_user.smokes?
  end

  # Fetch one week and sum the burned calories, render JSON
  def current_user_sports_graphic
    render json: current_user.sports.group_by_day(:date, range: 1.weeks.ago.midnight..Time.now).sum(:burned_calories)

  end

  # Fetch smoked cigarettes and sum counted, render JSON
  def current_user_smokes_graphic
    render json: current_user.smokes
                             .group_by_day(:date, range: (1.weeks.ago.midnight..Time.now))
                             .sum(:counted)
  end
end
