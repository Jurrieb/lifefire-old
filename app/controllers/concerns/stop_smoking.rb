# app/controllers/concerns/stop_smoking.rb
module StopSmoking
  extend ActiveSupport::Concern

  included do
    before_action :new_smoke_for_today
    before_action :smoked_today

    include ActionView::Helpers::NumberHelper

  end

  def add_to_smoking_counter(count)
    if @smoke.add_to_smoking_counter(count)
      flash[:success] = t('flash.smokes_added', count: count)
    else
      flash[:error] = t('flash.smokes_not_added')
    end
  end

  private

  def sigaret_price
    # Price of one sigaret, TODO: Should be en localized prices
    0.30
  end

  def calculate_price(count)
    # Calculate price
    approx_price = count * sigaret_price

    # Convert to localed price
    number_to_currency(approx_price, locale: :nl)
  end

  def params_component
    params.require(:component).permit(:value, :user_id)
  end

  def new_smoke_for_today
    @smoke = Smoke.find_or_create_by(user_id: current_user.id,
                                     date: Date.today)
  end

  # Smoked today
  def smoked_today
    @smoked_today = Smoke.by_user(current_user.id)
                         .by_date(Date.today)
                         .sum(:count)
  end

  # Smoked in all time
  def smoked_all_time
    Smoke.by_user(current_user.id).sum(:count)
  end
end
