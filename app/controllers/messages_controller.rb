class MessagesController < ApplicationController

  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    begin
      loop do
        if (Time.current.sec % 5).zero?
          response.stream.write("event: counter\n")
          response.stream.write("data: 5 seconds passed\n\n")
        end
        sleep 1
      end
    rescue IOError
      # Catch when the client disconnects
    ensure
      response.stream.close
    end
  end

  def count
    # Render JSON of messages where last is first
    render json: Message.where(user_id: current_user.id).order('id DESC')
  end
end
