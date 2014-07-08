module Sporting
  extend ActiveSupport::Concern

  # Calories burned in latest workout, or 0
  def last_workout_calories
    set_sport_by_user.last.try(:burned_calories) || 0
  end

  # Calories burned in total, or 0
  def total_workout_calories
    set_sport_by_user.sum(:burned_calories)  || 0
  end

  # Avarage calories burned, or 0
  def avarage_calories_burned
    total_workout_calories / set_sport_by_user.count  || 0
  end

  # Show latest workout with KM, or 0
  def last_workout_with_km_calories
    set_sport_by_user.last.distance  || 0
  end

  # Avarage workout with distance, or 0
  def avarage_workout_with_km_calories
    set_sport_by_user.sum(:distance) / set_sport_by_user.count  || 0
  end

  # Show total amount of KM's
  def total_workout_with_km_calories
    set_sport_by_user.sum(:distance)
  end

  # User is following sports program
  def sports?
    userPreference.sports?
  end

  private

  def set_sport_by_user
    Sport.by_user(self.id)
  end
end
