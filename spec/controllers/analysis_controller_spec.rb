require 'rails_helper'

describe AnalysisController do

  subject(:user) { FactoryGirl.create(:user) }

  before(:each) do
    # Set devise routing
    @request.env["devise.mapping"] = Devise.mappings[:user]
    # Sign in user
    sign_in :user, subject
  end

  describe 'renders view' do
    it '#index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'check user if' do
    it 'it smokes?' do
      expect(subject.smokes?).to eq(subject.userPreference.smokes)
    end

    it 'it sports?' do
      expect(subject.sports?).to eq(subject.userPreference.sports)
    end
  end
end
