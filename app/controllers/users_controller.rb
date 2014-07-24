class UsersController < ApplicationController
  # Set current user
  before_action :set_user, only: [:edit, :update, :destroy]

  include Friends

  # Find other user with friendly ID
  def profile
    @user = User.friendly.find(params[:id])
    @messages = Message.where(user_id: @user.id).limit(10).order('id desc')
    # Check if user is a friend of the current user
    @friends = current_user.friendships.exists?(friend_id: @user.id)
    # Publish a message
    @user.publish("#{current_user} heeft je profiel bekeken")
  end

  # Edit a user
  def edit
  end

  # Update user
  def update
    # If no password is submitted
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update!(user_params)
      set_flash_and_redirect('success',
                             t('flash.account_edited'),
                             analysis_index_path)
    else
      set_flash_and_redirect('error',
                             t('flash.account_not_edited'),
                             edit_user_path(@user.id))
    end
    # Karma background job
    karma_for_profile
    # Publish a message
    current_user.publish('Profiel aangepast')
  end

  # Signout user
  def destroy
    if @user.destroy
      # Sign out user
      sign_out @user
      set_flash_and_redirect('success',
                             t('flash.account_deleted'),
                             new_user_session_path)
    else
      set_flash_and_redirect('error',
                             t('flash.account_not_deleted'),
                             edit_user_path(@user.id))
    end
  end

  # First time user needs to update profile
  def setup
    @user = User.find(current_user.id)
    # Set layout without partails
    render layout: 'backdrop'
    # Set programs and save
    @user.userPreference.smokes = true
    @user.userPreference.sports = true
  end

  private

  def set_user
    # Find with relations
    @user = User.includes(:userPreference,
                          :userDetail,
                          :userNotice,
                          :userSmokeAddiction).find(current_user.id)
  end

  def user_params
    params.require(:user).permit(# Preferences
                                 userPreference_attributes: [:id,
                                                             :smokes,
                                                             :sports,
                                                             :public_profile,
                                                             :private_profile],
                                 # User details
                                 userDetail_attributes:     [:id,
                                                             :height,
                                                             :weight,
                                                             :target_weight],
                                 # Notices
                                 userNotice_attributes:     [:id,
                                                             :mail,
                                                             :daily_updates,
                                                             :push_notice],
                                 # Smoke addiction settings
                                 userSmokeAddiction_attributes: [:avarage_smokes_day])
  end
end
