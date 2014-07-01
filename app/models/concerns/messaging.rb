module Messaging
  extend ActiveSupport::Concern

  # included do
  #   # after_create :create_default_gallery, :send_welcome_email
  # end

  def write_new_message
    # Create new message in background
    message = 'Dit is een test'
    Messages.perform_async(self.id, message)
  end

end
