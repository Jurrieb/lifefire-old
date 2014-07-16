module Friends
  extend ActiveSupport::Concern

  included do
    before_action :find_friends
  end

  # Find healthiest friends
  def find_friends
    friend_ids = current_user.friends.where(accepted: true).map(&:friend_id)
    @friends = User.where(id: friend_ids).order('karma DESC').limit(5)
  end
end
