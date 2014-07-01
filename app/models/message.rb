class Message < ActiveRecord::Base
  # Relation
  belongs_to :user

  # Validations
  validates :name,
            :karma,
            :seen,
            :user_id,
            presence: true

  # Validate if karma and user_id are greater than 0
  validates_numericality_of :karma


end
