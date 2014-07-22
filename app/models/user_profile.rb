class UserProfile < ActiveRecord::Base
  # Relation
  belongs_to :user, touch: true
end
