# app/controllers/concerns/running.rb
module Sports
  extend ActiveSupport::Concern

  included do
    before_action :all_populair_sports, only: :index
    before_action :set_sport
  end

  def add_to_sports_counter
    @sport = Sport.new(sport_params)
    @sport.user_id = current_user.id

    if @sport.save!
      flash[:success] = t('flash.sports_added')
    else
      flash[:error] = t('flash.sports_not_added')
    end
  end

  def find_sport_for_date
    render json: Sport.find_or_create_by(user_id: current_user.id, date: Date.parse(params[:date]))
  end

  private

  def sport_params
    params.require(:sport).permit(:distance, :date, :duration, :populair_sport_id)
  end

  # Add new sports entry
  def set_sport
    @sport = Sport.new
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
