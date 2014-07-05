class StreamController < ApplicationController

  include ActionController::Live

  def messages
    # Set content type
    response.headers['Content-Type'] = 'text/event-stream'
    # Create new Server Side Event
    sse = SSE.new(response.stream)
    # New Redis instance, with no timeout (connection reused)
    redis = Redis.new(host: 'localhost',
                      port: 6379,
                      timeout: 0)
    # Listen to a stream
    redis.subscribe('message-published') do |on|
      # If there is a message?
      on.message do |event, notice|
        # Write to SSE, with notice and event
        sse.write(notice, event: event)
      end
    end
  rescue IOError
  ensure
    # Close and quit connections
    sse.close
    redis.quit
  end
end
