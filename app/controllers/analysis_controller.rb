class AnalysisController < ApplicationController
  # Before actions
  before_action :first_time_user, only: :index

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
    sports = current_user.sports
                         .group_by_day(:date, range: (1.weeks.ago..Date.today))
                         .sum(:burned_calories)
    # Return JSON from array
    render_json(add_and_return_array(sports))
  end

  # Fetch smoked cigarettes and sum counted, render JSON
  def current_user_smokes_graphic
    smokes = current_user.smokes
                         .group_by_day(:date, range: (1.weeks.ago..Date.today))
                         .sum(:counted)
    # Return JSON from array
    render_json(add_and_return_array(smokes))
  end

  # Return array with parsed date and results
  def add_and_return_array(data)
    # Create new array
    days = []
    # Loop through dates
    (1.week.ago.to_date..Date.today).each do |date|
      # Set datetime to beginning of day
      date = date.midnight
      # Push to hash into array
      days << { m: date, a: data[date] }
    end
    # return days as array
    return days
  end

  # Render JSON with an object
  def render_json(object)
    render json: object
  end

  # When user is first time user, redirect to setup path
  def first_time_user
    redirect_to_setup_path if current_user.first_time_user?
  end
end
