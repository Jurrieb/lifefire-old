module Friends
  extend ActiveSupport::Concern

  included do
    before_action :find_friends
  end

  # Find healthiest friends
  def find_friends
    @friends = User.where(id: self_and_friends).order('karma DESC').limit(5)
  end
end
