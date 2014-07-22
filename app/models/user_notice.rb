class UserNotice < ActiveRecord::Base
  # Relations
  belongs_to :user, touch: true
end
