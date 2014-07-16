class SportsController < ApplicationController

  before_action :all_populair_sports, only: :new
  before_action :set_sport, only: :new

  def new
    @sports = Sport.by_user(current_user.id).by_date(Date.today).includes(:populair_sport)
  end

  # Create a new sport record for user
  def create
    @sport = Sport.new(sport_params)
    @sport.user_id = current_user.id

    if @sport.save!
      flash[:success] = t('flash.sports_added')
    else
      flash[:error] = t('flash.sports_not_added')
    end
    # Karma background job
    karma_for_sporting
    # Redirect
    redirect_to :back
  end

  # Find or create Sport and render it as JSON
  def find_sport_for_date
    render json: Sport.find_or_create_by(user_id: current_user.id,
                                         date: Date.parse(params[:date]))
  end

  private

  # Permit access to columns
  def sport_params
    params.require(:sport).permit(:distance,
                                  :date,
                                  :duration,
                                  :populair_sport_id)
  end

  # Add new sports entry
  def set_sport
    @sport = Sport.new
    @extra_sport = Sport.new
  end

  # List of populair spots in the Netherlands
  def all_populair_sports
    @populair_sports = PopulairSport.all
  end

  # Total time sported today
  def get_total_duration_today
    @sport_duration_today = Sport.where(user_id: current_user.id,
                                        date: Date.today).sum(:duration)
  end

  # All Total time sported
  def get_total_duration
    @sport_duration = Sport.where(user_id: current_user.id).sum(:duration)
  end
end
