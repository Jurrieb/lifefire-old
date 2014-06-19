# app/controllers/concerns/running.rb
module Sports
  extend ActiveSupport::Concern

  included do
    before_action :all_populair_sports
    before_action :set_sport
  end

  def add_to_sports_counter(sports_input)
    @sport = Sport.find_or_create_by(user_id: current_user.id,
                                     date: Date.today,
                                     populair_sport_id: sports_input[:populair_sport_id])

    if @sport.update!(sport_params)
      flash[:success] = t('flash.sports_added')
    else
      flash[:error] = t('flash.sports_not_added')
    end
  end

  private

  def calculate_calories(sports_id, duration)
    # Find sports
    sport = PopulairSport.find(sports_id)

    # User's weigth in grams
    user_weight = current_user.userDetails.weight
  end

  def sport_params
    params.require(:sport).permit(:distance, :duration, :populair_sport_id)
  end

  def set_sport
    @sport = Sport.new
  end

  def all_populair_sports
    @populair_sports = PopulairSport.all
  end

  def get_total_duration_today
    @sport_duration_today = Sport.where(user_id: current_user.id,
                                        date: Date.today).sum(:duration)
  end

  def get_total_duration
    @sport_duration = Sport.where(user_id: current_user.id).sum(:duration)
  end
end
