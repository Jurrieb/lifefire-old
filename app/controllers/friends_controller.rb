class FriendsController < ApplicationController
  def index
    all_friends = current_user.friends.includes(:friend)
    @friends = all_friends.where(accepted: true)
    @unaccepted_friends = all_friends.where(accepted: false)
  end

  # Search for an User
  def search
    @results = User.where(User.arel_table[:name].matches("%#{params[:q]}%"))
  end

  # Accept an invitation
  def accept
    # Find friend request, select first
    friend_request = Friend.where(user_id: current_user.id,
                                  friend_id: params[:friend_id],
                                  accepted: false).first
    # Toggle accepted status
    friend_request.update(accepted: true)
    # Karma background job
    karma_for_adding_friend
    # Publish a message
    current_user.publish(t('flash.friend_added'))
    # Redirect
    redirect_to :back
  end

  def create
    # add friend to user and redirect
    if params[:id] == current_user.id
      flash['error'] = 'Je kan jezelf niet als vriend toevoegen.'
    else
      user = User.find(params[:id])
      unless user.blank?
        if current_user.users << user
          # Publish a message
          user.publish("#{user.name} heeft jouw toegevoegt")
          current_user.create_activity action: :add_friend, owner: current_user, recipient: user
        end
      end
    end
    # Karma background job
    karma_for_adding_friend
    # Redirect
    redirect_to :back
  end

  def destroy
    friend = User.find(params[:id])
    unless friend.blank?
      current_user.users.delete(friend)
      set_flash_and_redirect('success', t('flash.friend.removed'), :back)
    end
  end
end
