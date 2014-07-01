class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'backdrop'

  def index
  end

  def privacy_policy
  end
end
