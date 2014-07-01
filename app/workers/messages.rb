class Messages
  include Sidekiq::Worker

  # Create a new message for user
  def perform(user, message)
    puts "I LIKE THE WAY YOU WORKING"
    Message.create!( user_id: user,
                     message: message,
                     seen: false,
                     karma: 0 )
  end
end
