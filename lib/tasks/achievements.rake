namespace :achievements do
  desc "TODO"
  
  task smoking: :environment do
    users = User.all

    users.each do |u|
      progress = u.smoking_progress
      achievements = u.achievements.map { |x| x.code }

      unless achievements.include? 1 
        if progress > 3   
          message = Message.new(
            user_id: u.id, 
            message: "#{u.name} heeft drie dagen lang niet gerookt.")
          message.save_with_achievement(1)
        end
      end

      unless achievements.include? 2
        if progress > 7   
          message = Message.new(
            user_id: u.id, 
            message: "#{u.name} heeft een week lang niet gerookt.")
          message.save_with_achievement(2)
        end
      end

      unless achievements.include? 3
        if progress > 31   
          message = Message.new(
            user_id: u.id, 
            message: "#{u.name} heeft een maand lang niet gerookt.")
          message.save_with_achievement(3)
        end
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