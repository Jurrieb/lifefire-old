class Message < ActiveRecord::Base
  # Relation
  belongs_to :user
  has_many :comments, as: :commentable

  # Validations
  validates :message,
            :user_id,
            presence: true

  # Validate if karma is nummeric
  validates_numericality_of :user_id

end