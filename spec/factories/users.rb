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
    avatar_remote_url ["http://static4.businessinsider.com/image/51cded17ecad04b340000000-480/bridget-casey.jpg",
                       "http://static4.businessinsider.com/image/5275a3faeab8ea6d23d16dcc-480/barack-obama.jpg",
                       "http://cdn.lovell.co.uk/wp-content/uploads/2012/11/our-people1.jpg",
                       "http://static1.businessinsider.com/image/2e7a6c7983ab514833a9fa00-480/gisellebundchen.jpg"].sample
    # Needed relations
    userDetail
    userNotice
    userPreference
    userProfile
    userSmokeAddiction
  end
end
