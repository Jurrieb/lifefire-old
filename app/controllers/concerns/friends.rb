module Friends
  extend ActiveSupport::Concern

  included do
    before_action :find_friends
  end

  def find_friends 
    @friends = current_user.friends.select(:id, :name, :karma)
  end
end