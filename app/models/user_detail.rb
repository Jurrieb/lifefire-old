class UserDetail < ActiveRecord::Base
  # Relations
  belongs_to :user, touch: true
end
