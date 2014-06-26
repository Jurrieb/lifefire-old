class Users::SessionsController < Devise::SessionsController

  def new
    render layout: "backdrop"
    puts "yolo switch"
  end
end
