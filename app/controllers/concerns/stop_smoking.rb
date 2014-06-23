# app/controllers/concerns/stop_smoking.rb
module StopSmoking
  extend ActiveSupport::Concern

  included do
    before_action :new_smoke_for_today
  end

  def add_to_smoking_counter(count)
    if @smoke.add_to_smoking_counter(count)
      flash[:success] = t('flash.smokes_added', count: count)
    else
      flash[:error] = t('flash.smokes_not_added')
    end
  end

  private

  def params_component
    params.require(:component).permit(:value, :user_id)
  end

  def new_smoke_for_today
    @smoke = Smoke.find_or_create_by(user_id: current_user.id, date: Date.today)
  end
end
