class MessagesController < ApplicationController

  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    last_find = Time.zone.parse('2014-6-2 14:12:12');
    begin
      loop do
        messages = Message.where("created_at > ? AND user_id = ?", last_find, current_user.id).order('id DESC').limit(10).to_json
        unless messages.blank?
          response.stream.write("event: messages\n")
          response.stream.write("data: #{messages}\n\n")
          last_find = Time.zone.now
        end
        sleep 1
      end
    rescue IOError
      # Catch when the client disconnects
    ensure
      response.stream.close
    end
  end

  def update_seen
    Message.update_all(:seen => true, :user_id => current_user.id)
    render layout: false
  end

end
