module KarmaCalculation
  extend ActiveSupport::Concern

  # - Multipliers calculations ------------------------------------------------#
  def profile_karma
    score_for_profile ||= []
    score_for_profile.push(filled_in_profile)
    score_for_profile.push(filled_in_user_details)
    score_for_profile.push(public_profile)
    score_for_profile.push(private_profile)
    # Return count of all values in score_for_profile
    score_for_profile.sum * karma_points
  end

  def smoking_karma
    score_for_smoking ||= []
    multiplier = days_active('smoke') # gives multiplier
    # Return count of all values in score_for_profile
    (score_for_smoking.sum * karma_points) * multiplier
  end

  def sporting_karma
    score_for_sporting ||= []

    # Days active
    days_active('sport')

    # Return count of all values in score_for_profile
    score_for_sporting.sum * karma_points
  end

  # TODO:
  # Invited friends?

  private

  # - Shared partials for calculation of karma --------------------------------#
  # Standard Karmapoints
  def karma_points
    1
  end

  # Active days for user for a program
  def days_active(model)
    active_days = model.camelize
                       .constantize
                       .by_user(self.id)
                       .uniq(:created_at)
    # return value for active_days
    multiplier_for_days(active_days.length)
  end

  # Random number to increase karma
  def gamble
    rand(1..100)
  end

  # Multipliers for day/week/month/half year/year to three years
  def multiplier_for_days(number)
    case number
    # After a day
    when 1..7       then return 1
    # After a week
    when 7..30      then return 2
    # After a month
    when 30..178    then return 3
    # After a half year
    when 178..365   then return 4
    # After a year (till 3 years)
    when 366..1095  then return 5
    else
      # Return always 1, now it can be multiplied
      return 1
    end
  end

  # - Profile karma points # --------------------------------------------------#
  # Returns value if user filled in profile
  def filled_in_profile
    userProfile.created_at < userProfile.updated_at ? 6 : 0
  end

  def filled_in_user_details
    # Get user details values in array
    columns = UserDetail.where(user_id: self.id)
                        .pluck('height', 'weight', 'target_weight')
                        .flatten
    # Create new array
    total = []
    # Loop through values
    columns.each do |value|
      total.push(5) unless value == 0
    end
    # Return total multiplier points
    total.sum
  end

  # Return value for public profile
  def public_profile
    userPreference.public_profile ? 4 : 0
  end

  # Return value for private profile
  def private_profile
    userPreference.private_profile ? 2 : 0
  end

  # - Quit Smoking karma points # ---------------------------------------------#

  # Multipliers for days stopped smoking
  # Multipliers for MG tar reduced
  # Multiplier for saved euros

  # - Sporting karma points # -------------------------------------------------#
  # Multipliers for kcal
  # Multipliers with score for sported
  # Multipliers distance
  # Multipliers duration
end
