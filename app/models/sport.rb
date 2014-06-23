class Sport < ActiveRecord::Base
  # Before save
  before_save :calculate_burned_calories

  # Relations
  belongs_to :populairSport

  # Scopes
  scope :by_user, -> (user_id) { where(user_id: user_id) }
  scope :by_date, -> (date) { where(date: date) }

  # Validations
  validates :date,
            :populair_sport_id,
            :burned_calories,
            presence: true

  validates_numericality_of :duration,
                            :distance,
                            greater_than: 0

  def calculate_burned_calories
    # Find practised sport
    practised_sport = PopulairSport.find(self.populair_sport_id)
    # Integer to hour
    duration = self.duration / 60
    # User weigth
    weight = User.find(self.user_id).userDetail.weight
    # define burned Kcalories
    puts self.burned_calories = (practised_sport.kcal * duration) * weight
  end
end
