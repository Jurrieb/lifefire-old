class Sport < ActiveRecord::Base
  # Relations
  belongs_to :populairSport

  # Scopes
  scope :by_user, -> (user_id) { where(user_id: user_id) }
  scope :by_date, -> (date) { where(date: date) }

  # Validations
  validates :date,
            :populair_sport_id,
            :duration,
            :distance,
            presence: true

  # validates_numericality_of :duration,
  #                           :distance,
  #                           :populair_sport_id,
  #                           greater_than: 0




end
