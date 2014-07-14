#########################################
#       Populair Sports with Kcal       #
#########################################
PopulairSport.create([{ name: 'Fietsen',     kcal: 4  },
                      { name: 'Fitness',     kcal: 6  },
                      { name: 'Hardlopen',   kcal: 12 },
                      { name: 'Joggen',      kcal: 7  },
                      { name: 'Racefietsen', kcal: 12 },
                      { name: 'Spinning',    kcal: 9  },
                      { name: 'Wandelen',    kcal: 4  },
                      { name: 'Zwemmen',     kcal: 6  }])

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
  user.friend_ids = [User.all.shuffle[0].id,
                     User.all.shuffle[0].id,
                     User.all.shuffle[0].id,
                     User.all.shuffle[0].id]

  # Create Activities
  puts "Create activities for user: #{user.name}"
  10.times do |i|
    puts "Activity #{i + 1}"
    user.create_activity action: :add_friend,
                         owner: user,
                         recipient: user
  end
end
