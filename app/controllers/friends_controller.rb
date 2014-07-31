class FriendsController < ApplicationController
  def index
    @friends = User.where(id: accepted_request_ids)
    @unaccepted_friends = User.where(id: unaccepted_request_ids)
  end

  # Search for an User
  def search
    @results = User.where(User.arel_table[:name].matches("%#{params[:q]}%"))
  end

  # Accept an invitation
  def accept
    # Find friend request, select first
    friend_request = Friendship.where(user_id: params[:friend_id],
                                      friend_id: current_user.id,
                                      accepted: false,
                                      rejected: false).first

    # Create revert relation
    Friendship.create(user_id: current_user.id,
                      friend_id: params[:friend_id],
                      accepted: true,
                      rejected: false)

    # Toggle accepted status
    friend_request.update(accepted: true)

    # Retrieve friend, for setup message and save it
    friend = User.find(params[:friend_id])
    Message.new(user_id: friend.id,
                message: "#{current_user.name} en #{friend.name} zijn vrienden geworden.").save

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
        if current_user.friendships.create(friend_id: user.id)
          # Publish a message
          flash['success'] = "Vriendverzoek is naar #{user.name} verstuurd"
          user.publish("#{user.name} heeft jouw toegevoegt")
          Message.new(user_id: current_user.id,
                      friend_id: user.id,
                      message: "Vriendverzoek is naar #{user.name} verstuurd",
                      karma: 50).save
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
    # Redirect
    redirect_to :back
  end

  private

  # Create array from users who have not accepted the invitation
  def unaccepted_request_ids
    Friendship.unaccepted.where(friend_id: current_user.id,
                                rejected: false).map(&:user_id)
  end

  def accepted_request_ids
    Friendship.accepted.where(user_id: current_user.id,
                              rejected: false).map(&:friend_id)
  end
end
