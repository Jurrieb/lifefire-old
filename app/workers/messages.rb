class Messages
  include Sidekiq::Worker

  # Create a new message for user
  def create_message(user, status, mention)

  end

end
