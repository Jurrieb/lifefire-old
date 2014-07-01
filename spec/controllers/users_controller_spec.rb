describe UsersController do

  subject(:user) { FactoryGirl.create(:user) }

  before(:each) do
    # Set devise routing
    @request.env["devise.mapping"] = Devise.mappings[:user]
    # Sign in user
    sign_in :user, subject
  end

  describe 'renders view' do
    it '#edit' do
      get :edit, id: subject
      expect(response).to render_template(:edit)
    end

    it '#update' do

    end

    it "and deletes the user and redirect" do
      delete :destroy, id: subject
      expect(response).to redirect_to new_user_session_path
    end

    it 'sets user up' do

    end
  end
end




#   def update
#     # If no password is submitted
#     params[:user].delete(:password) if params[:user][:password].blank?
#     if @user.update!(user_params)
#       set_flash_and_redirect('success', t('flash.account_edited') , analysis_index_path)
#     else
#       set_flash_and_redirect('error', t('flash.account_not_edited') , edit_user_path(@user.id))
#     end
#   end


#   def setup
#     render layout: "backdrop"
#     @user.userPreference.smokes = true
#     @user.userPreference.sports = true
#     puts @user.userPreference.smokes.inspect
#   end
