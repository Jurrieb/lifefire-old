# app/controllers/concerns/stop_smoking.rb
module StopSmoking
  extend ActiveSupport::Concern

  included do
    before_action :new_smoke_for_today, only: :index
  end

  def add_to_smoking_counter
    # Find or create smoke (if date is other than today)
    @smoke = Smoke.find_or_create_by(user_id: current_user.id, date: Date.parse(params[:smoke][:date]))
    # Add counted cigarettes
    if @smoke.add_to_smoking_counter(params[:smoke][:counted].to_i)
      flash[:success] = t('flash.smokes_added', count: params[:smoke][:counted].to_i)
    else
      flash[:error] = t('flash.smokes_not_added')
    end
  end

  def find_smoke_for_date
    render json: Smoke.find_or_create_by(user_id: current_user.id, date: Date.parse(params[:date]))
  end

  private

  def params_component
    params.require(:component).permit(:value, :user_id)
  end

  def new_smoke_for_today
    @smoke = Smoke.find_or_create_by(user_id: current_user.id, date: Date.today)
  end
end
