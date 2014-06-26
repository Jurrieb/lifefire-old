class PopulairSport < ActiveRecord::Base
  # Relations
  has_many :sports

  # Validations on presence
  validates :name, :kcal, presence: true
end
