module Friends
  extend ActiveSupport::Concern

  included do
    before_action :find_friends
  end

  # Find healthiest friends
  def find_friends
    @friends = current_user.friends
                           .limit(5)
                           .order('karma DESC')
                           .select(:id, :name, :karma)
  end
end
