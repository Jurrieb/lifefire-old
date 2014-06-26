FactoryGirl.define do
  factory :sport do
    user_id 1
    populair_sport_id 1
    date { Date.today }
    duration 100
    distance 100
  end
end
