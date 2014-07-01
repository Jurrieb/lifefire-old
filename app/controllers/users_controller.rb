class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy, :setup]

  def edit

  end

  def update
    # If no password is submitted
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update!(user_params)
      set_flash_and_redirect('success', t('flash.account_edited') , analysis_index_path)
    else
      set_flash_and_redirect('error', t('flash.account_not_edited') , edit_user_path(@user.id))
    end
  end

  def destroy
    if @user.destroy
      # Sign out user
      sign_out @user
      set_flash_and_redirect('success', t('flash.account_deleted') , new_user_session_path)
    else
      set_flash_and_redirect('error', t('flash.account_not_deleted') , edit_user_path(@user.id))
    end
  end

  def setup
    render layout: "backdrop"
    @user.userPreference.smokes = true
    @user.userPreference.sports = true
    puts @user.userPreference.smokes.inspect
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
                                                             :profile],
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
