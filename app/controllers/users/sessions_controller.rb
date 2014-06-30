class Users::SessionsController < Devise::SessionsController

  def new
    render layout: "backdrop"
  end
end
