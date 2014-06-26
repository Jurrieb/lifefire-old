FactoryGirl.define do
  factory :populairSport do
    name { Faker::Commerce.product_name }
    date { rand(1...100) }
  end
end
