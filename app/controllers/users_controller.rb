class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]

  def edit

  end

  def update
    # If no password is submitted
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update!(user_params)
      set_flash_and_redirect('success', t('nl.flash.account_edited') , edit_user_path(@user.id))
    else
      set_flash_and_redirect('error', t('nl.flash.account_not_edited') , edit_user_path(@user.id))
    end
  end

  def destroy
    if @user.destroy
      # Sign out user
      sign_out @user
      set_flash_and_redirect('success', t('nl.flash.account_deleted') , unauthenticated_root_path)
    else
      set_flash_and_redirect('error', t('nl.flash.account_not_deleted') , edit_user_path(@user.id))
    end
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
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :avatar,
                                 # Preferences
                                 userPreference_attributes: [:smokes,
                                                              :sports],
                                 # User details
                                 userDetail_attributes:     [:height,
                                                              :weigth,
                                                              :target_weight],
                                 # Notices
                                 userNotice_attributes:     [:mail,
                                                              :daily_updates,
                                                              :push_notice],
                                 # Smoke addiction settings
                                 userSmokeAddiction_attributes: [:avarage_smokes_day])
  end
end
