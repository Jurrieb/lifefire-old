describe MessagesController do

  subject(:user) { FactoryGirl.create(:user) }

  before(:each) do
    # # Set devise routing
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    # # Sign in user
    # sign_in :user, subject
  end

  describe 'renders view' do
    it '#index as json' do
      get :index, format: :json
      expect(response.header['Content-Type']).to match /json/
    end

    it '#count' do
      get 'count', format: :json
      expect(response.header['Content-Type']).to match /json/
    end
  end
end
