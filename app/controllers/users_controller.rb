class UsersController < ApplicationController
  # Set current user
  before_action :set_user, only: [:edit, :update, :destroy, :setup]

  include Friends

  # Find other user with friendly ID
  def profile
    @user = User.friendly.find(params[:id])
    # Check if user is a friend of the current user
    @friends =  current_user.friends.exists?(id: @user.id)
    unless @user.userPreference.public_profile || @user.userPreference.private_profile
      # Redirect back
      redirect_to analysis_index_path
    end
  end

  # Edit a user
  def edit
    # Publish a message
    Redis.new.publish('message-published', { message: "Dit is een test bericht +100 karma" }.to_json)
  end

  # Update user
  def update
    # If no password is submitted
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update!(user_params)
      set_flash_and_redirect('success', t('flash.account_edited') , analysis_index_path)
    else
      set_flash_and_redirect('error', t('flash.account_not_edited') , edit_user_path(@user.id))
    end
  end

  # Signout user
  def destroy
    if @user.destroy
      # Sign out user
      sign_out @user
      set_flash_and_redirect('success', t('flash.account_deleted') , new_user_session_path)
    else
      set_flash_and_redirect('error', t('flash.account_not_deleted') , edit_user_path(@user.id))
    end
  end

  # First time user needs to update profile
  def setup
    # Set layout without partails
    render layout: 'application_without_partials'
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
