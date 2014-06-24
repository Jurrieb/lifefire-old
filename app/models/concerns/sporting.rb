module Sporting
  extend ActiveSupport::Concern

  # Calories burned in latest workout
  def last_workout_calories
    set_sport_by_user.last.try(:burned_calories)
  end

  # Calories burned in total
  def total_workout_calories
    calories = set_sport_by_user
    return calories.sum(:burned_calories) if calories.any?
  end

  # Avarage calories burned
  def avarage_calories_burned
    total_workout_calories / set_sport_by_user.count
  rescue
    0
  end

  # Show latest workout with KM
  def last_workout_with_km_calories
    set_sport_by_user.last.distance
  rescue
    0
  end

  # Show total amount of KM's
  def total_workout_with_km_calories
    set_sport_by_user.sum(:distance)
  end

  private

  def set_sport_by_user
    Sport.by_user(self.id)
  end
end