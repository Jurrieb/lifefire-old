namespace :activities do
  desc "TODO"
  
  task smoking: :environment do
    users = User.all
    users.each do |u|
      progress = u.smoking_progress

      if progress > 3
        message = Message.new(
          user_id: u.id, 
          message: "#{u.name} heeft drie dagen lang niet gerookt."
          )
        message.save
      end

      if progress > 7
        message = Message.new(
          user_id: u.id, 
          message: "#{u.name} is een week lang gestopt met roken."
          )
        message.save
      end


      if progress > 31
        message = Message.new(
          user_id: u.id, 
          message: "#{u.name} is een maand gestopt met roken."
          )
        message.save
      end

    end
  end

  desc "TODO"
  task sporting: :environment do
    users = User.all
    users.each do |u|
      progress = u.sporting_progress

      if progress[0] > 5
        message = Message.new(
          user_id: u.id, 
          message: "#{u.name} heeft veel sessies gehad."
          )
        message.save
      end

      if progress[1] > 25
        message = Message.new(
          user_id: u.id, 
          message: "#{u.name} heeft veel kilometers gemaakt."
          )
        message.save
      end

      if progress[2] > 1500
        message = Message.new(
          user_id: u.id, 
          message: "#{u.name} heeft heel veel calorien verbrandt."
          )
        message.save
      end
      
    end
  end

end