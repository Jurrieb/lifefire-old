FactoryGirl.define do
  factory :userPreference do
    smokes { rand(0..1) }
    sports { rand(0..1) }
    public_profile { rand(0..1) }
    private_profile { rand(0..1) }
  end
end
