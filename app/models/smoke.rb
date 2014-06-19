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

  # Price of one sigaret
  def cigaret_price
    0.30
  end

  # Proven tar within one sigaret (10 mg)
  def cigaret_tar
    0.00001
  end

  # Calculate price and convert to localed price
  def calculate_price
    include ActionView::Helpers::NumberHelper
    approx_price = self.sum(:count) * cigaret_price
    number_to_currency(approx_price, locale: :nl)
  end

  # Calculate tar in smoked cigarrets
  def calculate_tar
    (self.sum(:count) * cigaret_tar).round(2)
  end

  def avarage_smokes_a_day
    self.sum(:count) / self.date.count
  end

  def reduced_cigarettes
    #
    # current_user.smokes.
    # group_by(:date).sum(:count) * current_user.userSmokeAddiction.avarage_smokes_day

  end

  # User Smoked today
  def smoked_today
    self.by_date(Date.today).sum(:count)
  end

  # User Smoked in all time
  def smoked_all_time
    self.sum(:count)
  end
end
