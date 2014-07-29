class Sport < ActiveRecord::Base

  include PublicActivity::Common

  # Before save
  before_save :calculate_burned_calories

  # Relations
  belongs_to :populair_sport
  belongs_to :user, touch: true

  # Custom scopes
  scope :by_user, -> (user_id) { where(user_id: user_id) }
  scope :by_date, -> (date) { where(date: date) }

  # Validations on presence and if duration and distance are greater than 0
  validates :date,
            :populair_sport_id,
            :burned_calories,
            presence: true
  validates_numericality_of :duration,
                            :distance,
                            greater_than: 0
  validates :duration, :distance, inclusion: 0..300

  # Calculate burned calories from the to save sport activity
  def calculate_burned_calories
    # Find practised sport
    practised_sport = PopulairSport.find(populair_sport_id)

    if practised_sport
      require 'unitwise'
      # Integer to hour (kcal are based upon hours)
      duration = BigDecimal.new(self.duration) / 60
      # User weigth
      weight = Unitwise(User.find(self.user_id).userDetail.weight, 'kilogram')
      # Set burned Kcalories
      self.burned_calories = (practised_sport.kcal * duration) * weight
    else
      # Return with 0 calories burned
      self.burned_calories = 0
    end
  end
end
