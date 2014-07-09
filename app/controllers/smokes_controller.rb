class SmokesController < ApplicationController

  def new
    @smoke = Smoke.find_or_create_by(user_id: current_user.id, date: Date.today)
  end

  def create
    # Find or create smoke (if date is other than today)
    @smoke = Smoke.find_or_create_by(user_id: current_user.id, date: Date.parse(params[:smoke][:date]))
    # Add counted cigarettes
    if @smoke.add_to_smoking_counter(params[:smoke][:counted].to_i)
      flash[:success] = t('flash.smokes_added', count: params[:smoke][:counted].to_i)
    else
      flash[:error] = t('flash.smokes_not_added')
    end
  end

  # Find or create Smoke and render json
  def find_smoke_for_date
    render json: Smoke.find_or_create_by( user_id: current_user.id,
                                          date: Date.parse(params[:date]) )
  end

  private

  # Permit access for columns:
  def smoke_params
    params.require(:smoke).permit(:date, :counted)
  end
end
