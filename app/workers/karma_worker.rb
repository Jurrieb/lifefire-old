# app/workers/karma_worker.rb
class KarmaWorker
  include Sidekiq::Worker

  # Calculate karma based on given program and user_id
  def perform(program, user_id)
    puts "I LIKE THE WAY YOU WORKING"

    user = User.find(user_id)
    user.calculated_karma program
  end
end
