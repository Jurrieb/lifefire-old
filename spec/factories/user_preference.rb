FactoryGirl.define do
  factory :userPreference do
    smokes { rand(0..1) }
    sports { rand(0..1) }
    profile { rand(0..1) }
  end
end
