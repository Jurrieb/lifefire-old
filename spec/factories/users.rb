FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(10) }
    provider 'Facebook'
    uid { rand(1...9999)}
    name { Faker::Name.name }
    karma 0
    oauth_token { rand(1...9999) }
    oauth_expires_at DateTime.now + 1.week
    user_hash "jflkasjfdifasfd890f8dsahfjkan329fdisa9fdshakjrn42ql"

    # Needed relations
    userDetail
    userNotice
    userPreference
    userProfile
    userSmokeAddiction
  end
end
