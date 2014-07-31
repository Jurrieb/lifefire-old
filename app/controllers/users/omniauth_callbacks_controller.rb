class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # Find of create user
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    # Create relations
    @user.create_relations
    # If there is a user (saved in db), log in!
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      redirect_to new_user_session_path
    end
  end
end
