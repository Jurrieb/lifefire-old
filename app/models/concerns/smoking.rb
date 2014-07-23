module Smoking
  extend ActiveSupport::Concern

  # Calculation
  require 'unitwise'


  def smoking_progress
    Smoke.by_user(self.id).where(:counted => 0, created_at: 3.days.ago..Time.now).count
  end

  # Price of one sigaret
  def cigaret_price
    0.30
  end

  # Proven tar within one sigaret (10 mg, 0.00001 mg)
  def cigaret_tar
    Unitwise(0.00001, 'kilogram')
  end

  # Proven Nicotin within one sigaret (1 mg, 0.000001 mg)
  def cigaret_nicotin
    Unitwise(0.000001, 'kilogram')
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

  # Calculate tar in smoked cigarrets
  def calculate_nicotin
    (Smoke.by_user(self.id).sum(:counted) * cigaret_nicotin).convert_to('milligram')
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

  # User Smoked today, or return 0
  def smoked_today
    Smoke.by_user(id).by_date(Date.today).sum(:counted) || 0
  end

  # User Smoked this week, or return 0
  def smoked_this_week
    Smoke.by_user(id).this_week(Date.today).sum(:counted) || 0
  end

  # User Smoked this month, or return 0
  def smoked_this_month
    Smoke.by_user(id).this_month(Date.today).sum(:counted) || 0
  end

  # User Smoked in all time, or return 0
  def smoked_all_time
    Smoke.by_user(id).sum(:counted) || 0
  end

  # User is following quit-smoking program?
  def smokes?
    userPreference.smokes?
  end

  #############################
  # #   Benchmark purpose   # #
  #############################

  # def test_methods
  #   require "benchmark"

  #   test1 = Benchmark.measure do
  #     begin
  #       Smoke.by_user(id).this_month(Date.today).sum(:counted)
  #     rescue
  #       0
  #     end
  #   end
  #   puts "Rescue with user: #{test1}"

  #   test2 = Benchmark.measure do
  #     begin
  #       Smoke.by_user(999).this_month(Date.today).sum(:counted)
  #     rescue
  #       0
  #     end
  #   end
  #   puts "Rescue without user: #{test2}"

  #   test3 = Benchmark.measure do
  #     Smoke.by_user(id).this_month(Date.today).sum(:counted) || 0
  #   end
  #   puts "Without rescue with user: #{test3}"

  #   test4 = Benchmark.measure do
  #     Smoke.by_user(999).this_month(Date.today).sum(:counted) || 0
  #   end
  #   puts "Without rescue without user: #{test4}"
  # end
end
