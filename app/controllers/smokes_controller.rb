class SmokesController < ApplicationController

  # Create new smoke for date and user
  def new
    @smoke = Smoke.find_or_create_by(user_id: current_user.id,
                                     date: Date.today)
  end

  # Create new smoke for date and user
  def create
    # Find or create smoke (if date is other than today)
    @smoke = Smoke.find_or_create_by(user_id: current_user.id,
                                     date: Date.parse(params[:smoke][:date]))
    # Add counted cigarettes
    @smoke.add_to_smoking_counter(params[:smoke][:counted].to_i)
    # Karma calculation background job
    karma_for_smoking
    # Redirect to back
    redirect_to :back
  end

  # Find or create Smoke and render json
  def find_smoke_for_date
    render json: Smoke.find_or_create_by(user_id: current_user.id,
                                         date: Date.parse(params[:date]))
  end

  private

  # Permit access for columns:
  def smoke_params
    params.require(:smoke).permit(:date, :counted, :date)
  end
end
