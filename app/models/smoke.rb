class Smoke < ActiveRecord::Base
  # Relations
  belongs_to :user

  # Validations
  validates :user_id, :counted, :date, presence: true

  # Scopes
  scope :by_user,     -> (user_id) { where(user_id: user_id) }
  scope :by_date,     -> (date)    { where(date: date) }
  scope :this_week,   -> (date)    { where('date >= ?', date.beginning_of_week) }
  scope :this_month,  -> (date)    { where('date >= ?', date.beginning_of_month) }

  # Adds count to counter
  def add_to_smoking_counter(count)
    self.increment!(:counted, count - self.counted)
  end
end
