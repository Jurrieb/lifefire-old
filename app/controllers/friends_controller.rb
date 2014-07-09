class FriendsController < ApplicationController
  def index
    # if token = current_user.oauth_token
    #   @graph = Koala::Facebook::GraphAPI.new(token)
    #   @friends = @graph.get_connections('me', 'friends')
    # end
    @friends = current_user.friends
  end

  def search
    @query =  params[:q]
    @results = User.where(User.arel_table[:name].matches("%#{@query}%"))
  end

  def create
    # add friend to user and redirec
    if params[:id] == current_user.id
      flash['error'] = 'Je kan jezelf niet als vriend toevoegen.'
    else
      user = User.find(params[:id])
      unless user.blank?
        if current_user.friends << user
          StreamController.publish("/message/#{user.user_hash}", '#{user.name} heeft jouw toegevoegt')
          current_user.create_activity action: :add_friend, owner: current_user, recipient: user
        end
      end
    end
    redirect_to :back
  end

  def destroy
    friend = User.find(params[:id])
    unless friend.blank?
      current_user.friends.delete(friend)
      set_flash_and_redirect('success', t('flash.friend.removed'), :back)
    end
  end

  def write_on_wall
    if token = current_user.oauth_token
      @graph = Koala::Facebook::GraphAPI.new(token)
      @graph.put_object('me', 'feed', :message => "I am writing on my wall!")
    end
  end
end
