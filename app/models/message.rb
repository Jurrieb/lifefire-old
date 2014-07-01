class Message < ActiveRecord::Base
  # Relation
  belongs_to :user

  # Validations
  validates :message,
            :karma,
            :user_id,
            presence: true

  # Validate if karma is nummeric
  validates_numericality_of :karma, :user_id
end
