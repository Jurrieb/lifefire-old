class Smoke < ActiveRecord::Base
  # Relations
  belongs_to :user

  # Validations
  validates :user_id, :count, :date, presence: true

  # Scopes
  scope :by_user, -> (user_id) { where(user_id: user_id) }
  scope :by_date, -> (date) { where(date: date) }

  # Adds count to counter
  def add_to_smoking_counter(count)
    self.increment!(:count, count - self.count)
  end
end
