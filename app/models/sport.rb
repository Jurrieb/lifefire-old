class Sport < ActiveRecord::Base
  # Relations
  belongs_to :populairSport

  # Scopes
  scope :by_user, -> (user_id) { where(user_id: user_id) }
  scope :by_date, -> (date) { where(date: date) }

end
