FactoryGirl.define do
  factory :user do
    email 'test@test.nl'
    password { SecureRandom.hex(10) }
    provider 'Facebook'
    uid 9999
    name { Faker::Name.name }
    karmapoints 0
    oauth_token 'test'
    oauth_expires_at DateTime.now + 1.week

    # Needed relations
    userDetail
    userNotice
    userPreference
    userProfile
    userSmokeAddiction
  end
end
