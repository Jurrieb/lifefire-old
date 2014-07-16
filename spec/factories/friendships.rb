# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friendship do
    user_is 1
    friend_id 1
    accepted false
  end
end
