class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]

  def edit

  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update(user_params)
      set_flash_and_redirect('success', t('nl.flash.account_edited') , edit_user_path(@user.id))
    else
      set_flash_and_redirect('error', t('nl.flash.account_not_edited') , edit_user_path(@user.id))
    end
  end

  def destroy
    if @user.destroy
      set_flash_and_redirect('success', t('nl.flash.account_deleted') , root_path)
    else
      set_flash_and_redirect('error', t('nl.flash.account_not_deleted') , edit_user_path(@user.id))
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :avatar)
  end
end
