module Sporting
  extend ActiveSupport::Concern

  # Calories burned in latest workout
  def last_workout_calories
    Sport.by_user(self.id).last.burned_calories
  end

  # Calories burned in total
  def total_workout_calories
    Sport.by_user(self.id).sum(:burned_calories)
  end

  # Avarage calories burned
  def avarage_calories_burned
    total_workout_calories / Sport.by_user(self.id).count
  end

  #
  def last_workout_with_km_calories
    Sport.by_user(self.id).last.distance
  end

  def total_workout_with_km_calories
    Sport.by_user(self.id).sum(:distance)
  end
end
