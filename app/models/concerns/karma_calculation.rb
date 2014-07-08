module KarmaCalculation
  extend ActiveSupport::Concern

  # - Multipliers calculations ------------------------------------------------#
  # Calculate profile score based upon filled in fields
  def profile_karma
    score_for_profile = []
    # Check for variables
    score_for_profile.push(filled_in_profile)
    score_for_profile.push(filled_in_user_details)
    score_for_profile.push(public_profile)
    score_for_profile.push(private_profile)
    # Return count of all values in score_for_profile
    score_for_profile.sum * karma_points
  end

  # Calculate smoking karma score based upon predefined settings
  def smoking_karma
    score_for_smoking = []
    # Check


    # Return count of all values in score_for_profile
    (score_for_smoking.sum * karma_points) * multiplier('smoke')
  end

  # Calculate sporting karma score based upon predefined settings
  def sporting_karma
    score_for_sporting = []
    multiplier = days_active('sport') # gives multiplier

    puts multiplier

    # Return count of all values in score_for_profile
    (score_for_sporting.sum * karma_points) * multiplier('sport')
  end

  # Standard karmapoints for inviting a friend
  def invited_friend
    50
  end

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
    case
    # After a day
    when number <= 7                    then return 1
    # After a week
    when number > 7 && number <= 30     then return 2
    # After a month
    when number > 30 && number <= 178   then return 3
    # After a half year
    when number > 178 && number <= 365  then return 4
    # After a year
    when number > 365                   then return 5
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

  # Multiplier if user has smoked less then normal
  def less_smoked?
    avarage_smokes = UserSmokeAddiction.find(id).avarage_smokes_day
    # Return 2 or 1 if
    smokes_counted.by_date(Date.today) < avarage_smokes ? 1 : 0
  end

  # Multiplier for days user has stopt smoking, all time
  def days_stopped?
    Smoke.by_user(id).where(counted: 0).count > 120 ? 2 : 0
  end

  # Multiplier if user has quitted smoking? (after approx. 4 months)
  def quit_smoking?
    Smoke.by_user(id).where(counted: 0).count > 120 ? 10 : 0
  end

  # Multiplier for tar inhaled
  def tar_smoked
    # Calculate tar (in mg)
    tar_smoked = smokes_counted * cigaret_price

    case
    when counted_smokes_price <= 10                 then return 3
    when counted_smokes_price > 10 && number <= 50  then return 2
    else
      # Return always 1, now it can be multiplied
      return 1
    end
  end

  # Multiplier for money being spend on smoking
  def money_spend_by_smoking
    # Money spend
    counted_smokes_price = smokes_counted * cigaret_price

    case
    when counted_smokes_price <= 10                 then return 3
    when counted_smokes_price > 10 && number <= 50  then return 2
    else
      # Return always 1, now it can be multiplied
      return 1
    end
  end

  # Total of smokes counted
  def smokes_counted
    Smoke.by_user(id).sum(:counted)
  end

  # Sum of multipliers
  def multiplier(name)
    if name = 'smoke'
      # Return multiplier
      return days_active('smoke') + less_smoked?
                                  + quit_smoking?
                                  + money_spend_by_smoking
                                  + tar_smoked
    else
      # Return multiplier
      return days_active('sports')
    end
  end

  # - Sporting karma points # -------------------------------------------------#

  # Multipliers for kcal
  # Multipliers with score for sported
  # Multipliers distance
  # Multipliers duration
end
