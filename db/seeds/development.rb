# For creating User & Activities
require Rails.root.join('spec','helpers.rb')
require 'rubygems'           #Load gems
require 'factory_girl_rails'

# Create user
10.times { seed_data }

# Create relationships between user
users = User.all
users.each do |user|
  puts "Create friend relation for user: #{user.name}"
  user.users = User.order("RANDOM()").limit(5)
end
