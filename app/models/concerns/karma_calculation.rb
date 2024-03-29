module KarmaCalculation
  extend ActiveSupport::Concern

  def calculated_karma program
    # Set user
    @user = User.find(self.id)

    # Define program to give karma to
    score = case program
            when 'all'
              profile_karma + smoking_karma + sporting_karma
            when 'smoke'
              smoking_karma
            when 'sport'
              sporting_karma
            when 'profile'
              profile_karma
            when 'add_friend'
              invited_friend
            else
              smoking_karma + sporting_karma
            end
    # Update karma user with total score
    @user.increment!(:karma, score) unless score == 0
  end

  # - Multipliers calculations ------------------------------------------------#

  # Calculate profile score based upon filled in fields
  def profile_karma
    score_for_profile = []
    # Check for variables
    score_for_profile.push(filled_in_profile)
    score_for_profile.push(filled_in_user_details)
    score_for_profile.push(access_to_profile)
    # Return count of all values in score_for_profile
    score_for_profile.sum * karma_points
  end

  # Calculate smoking karma score based upon predefined settings
  def smoking_karma
    if User.find(self.id).userPreference.smokes
      score_for_smoking = []
      # Check for variables
      score_for_smoking.push(less_smoked?)
      score_for_smoking.push(quit_smoking?)
      score_for_smoking.push(money_spend_by_smoking)
      score_for_smoking.push(tar_smoked)
      # Return count of all values in score_for_smoking
      return score_for_smoking.sum * karma_points if multiplier('smoke') == 0
      return (score_for_smoking.sum * karma_points) * multiplier('smoke')
    else
      0
    end
  end

  # Calculate sporting karma score based upon predefined settings
  def sporting_karma
    if User.find(self.id).userPreference.sports
      score_for_sporting = []
      # Check for variables
      score_for_sporting.push(latest_distance)
      score_for_sporting.push(latest_duration)
      score_for_sporting.push(burned_kcal)
      # Return count of all values in score_for_sporting
      return score_for_sporting.sum * karma_points if multiplier('sport') == 0
      return (score_for_sporting.sum * karma_points) * multiplier('sport')
    end
    0
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
    user = UserProfile.where(user_id: self.id).first
    user.created_at < user.updated_at ? 6 : 0
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
  def access_to_profile
    user = UserPreference.where(user_id: self.id).first

    case
    when user.public_profile &&
         user.private_profile then return 5
    when user.public_profile  then return 2
    when user.private_profile then return 1
    else
      0
    end
  end

  # - Quit Smoking karma points # ---------------------------------------------#

  # Multiplier if user has smoked less then normal
  def less_smoked?
    avarage_smokes = UserSmokeAddiction.find(id).avarage_smokes_day
    # Return 1 or 0 if smoked is below avarage
    smokes_counted_today < avarage_smokes ? 1 : 0
  end

  # Multiplier for days user has stopt smoking, all time
  def days_stopped?
    Smoke.by_user(id).where(counted: 0).count > 120 ? 2 : 0
  end

  # Multiplier if user has quitted smoking? (after approx. 4 months)
  def quit_smoking?
    Smoke.by_user(id).where(counted: 0).count > 120 ? 10 : 0
  end

  # Multiplier for tar inhaled today
  def tar_smoked
    # Calculate tar (in mg)
    tar_smoked = smokes_counted_today * cigaret_tar

    case
    when tar_smoked == Unitwise(0, 'kilogram') then return 2
    when tar_smoked <= Unitwise(0.0001, 'kilogram') then return 1
    else
      return 0
    end
  end

  # Multiplier for money being spend on smoking
  def money_spend_by_smoking
    # Money spend
    counted_smokes_price = smokes_counted_today * cigaret_price

    return 1 if counted_smokes_price <= 1
    0
  end

  # Total of smokes counted today
  def smokes_counted_today
    Smoke.by_user(self.id).by_date(Date.today).sum(:counted)
  end

  # Return sum of multipliers for days
  def multiplier(name)
    return days_active('smoke') if name == 'smoke'
    return days_active('sport') if name == 'sport'
  end

  # - Sporting karma points # -------------------------------------------------#

  # Multiplier for distance for latest activity
  def latest_distance
    latest_sport_distance = Sport.by_user(self.id).where.not(distance: 0).last

    return 0 if latest_sport_distance.blank?

    case
    when latest_sport_distance < 5 then return 1
    when latest_sport_distance > 10 then return 2
    when latest_sport_distance > 20 then return 3
    else
      0
    end
  end

  # Multiplier for duration for latest add sport activity
  def latest_duration
    latest_sport_duration = last_sport_added.duration if last_sport_added
    return 0 if latest_sport_duration.blank?

    case
    when latest_sport_duration < 30 then return 1
    when latest_sport_duration > 29 &&
         latest_sport_duration < 60 then return 2
    when latest_sport_duration > 59 then return 3
    else
      0
    end
  end

  # Multiplier for burned calories with latest activity
  def burned_kcal
    calories = last_sport_added.kcal if last_sport_added
    return 0 if calories.blank?

    case
    when calories < 150 then return 1
    when calories > 149 &&
         calories < 300 then return 2
    when calories > 299 &&
         calories < 600 then return 3
    when calories > 599  then return 4
    else
      0
    end
  end

  # Latest sport added
  def last_sport_added
    Sport.by_user(self.id).last
  end
end
