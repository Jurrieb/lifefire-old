class FriendsController < ApplicationController
  def index
    if token = current_user.oauth_token
      @graph = Koala::Facebook::GraphAPI.new(token)
      @friends = @graph.get_connections('me', 'friends')
    end
  end

  def write_on_wall
    if token = current_user.oauth_token
      @graph = Koala::Facebook::GraphAPI.new(token)
      @graph.put_object('me', 'feed', :message => "I am writing on my wall!")
    end
  end
end
