class Friendship < ActiveRecord::Base
  # Self-Referential Relation for Users
  belongs_to :user,   class_name: 'User', foreign_key: 'user_id'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  # scopes
  scope :accepted,    -> { where(accepted: true) }
  scope :unaccepted,  -> { where(accepted: false) }

  # # Create bi-directional relation
  # def befriend friend
  #   self.friends << friend
  #   friend.users << self
  # end
end
