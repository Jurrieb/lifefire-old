require 'rails_helper'

describe KarmaController do

  subject(:user) { FactoryGirl.create(:user) }

  before(:each) do
    # Set devise routing
    @request.env["devise.mapping"] = Devise.mappings[:user]
    # Sign in user
    sign_in :user, subject
  end


end
