module Smoking
  extend ActiveSupport::Concern

  # Calculation
  require 'unitwise'

  # Price of one sigaret
  def cigaret_price
    0.30
  end

  # Proven tar within one sigaret (10 mg, 0.00001 mg/kg)
  def cigaret_tar
    Unitwise(0.00001, 'kilogram')
  end

  # User has paid for all cigarrets
  def all_costs
    smoked_all_time * cigaret_price
  end

  # Calculate tar in smoked cigarrets
  def calculate_tar
    (Smoke.by_user(self.id).sum(:counted) * cigaret_tar).convert_to('milligram')
                                                        .to_i
                                                        .round(2)
  end

  # Calculate avarage smokes a day
  def avarage_smokes
    smokes = Smoke.by_user(self.id)
    if smokes.any?
      # Count between date ranges
      date_range_count = (smokes.first.date..smokes.last.date).count
      # Return smoked avarage
      return Smoke.by_user(self.id).sum(:counted) / date_range_count unless date_range_count == 0
    else
      0
    end
  end

  # Calculate smokes reduced from avarage
  def reduced_cigarettes
    smokes = Smoke.by_user(self.id)
    if smokes.any?
      # Avarage smoke and date range (count days)
      avarage_smokes = self.userSmokeAddiction.avarage_smokes_day
      date_range_count = (smokes.first.date..smokes.last.date).count
      # Totaal smoked without our program
      smoked_total_without_program = avarage_smokes * date_range_count
      # Smoked with program
      smoked_smokes = smokes.sum(:counted)
      # Return avarage reduced smokes
      return smoked_total_without_program - smoked_smokes
    else
      0
    end
  end

  # User Smoked today
  def smoked_today
    Smoke.by_user(self.id).by_date(Date.today).sum(:counted)
  rescue
    0
  end

  # User Smoked this week
  def smoked_this_week
    Smoke.by_user(self.id).this_week(Date.today).sum(:counted)
  rescue
    0
  end

  # User Smoked this month
  def smoked_this_month
    Smoke.by_user(self.id).this_month(Date.today).sum(:counted)
  rescue
    0
  end

  # User Smoked in all time
  def smoked_all_time
    Smoke.by_user(self.id).sum(:counted)
  rescue
    0
  end
end
