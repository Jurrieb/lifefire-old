FactoryGirl.define do
  factory :userDetail do
    height { rand(100..250) }
    weight { rand(80..20) }
    target_weight { rand(60..80) }
  end
end



