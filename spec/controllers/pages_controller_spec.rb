require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'privacy_policy'" do
    it "returns http success" do
      get 'privacy_policy'
      expect(response).to be_success
    end
  end

end
