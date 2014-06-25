class Users::SessionsController < Devise::SessionsController

  def create
    render layout: "backdrop" 
  end
end
