require 'rails_helper'

describe User do

  let(:subject) { FactoryGirl.create(:user) }

  # Relations
  it { should have_one(:userNotice) }
  it { should have_one(:userDetail) }
  it { should have_one(:userDetail) }
  it { should have_one(:userPreference) }
  it { should have_one(:userProfile) }
  it { should have_one(:userSmokeAddiction) }

  it { should have_many(:smokes) }
  it { should have_many(:sports) }
  it { should have_many(:messages) }

  # Custom functions



  # Concerns tests


end



# class User < ActiveRecord::Base

#   # Concerns
#   include Smoking
#   include Sporting


#   # Create needed relations in sign_in
#   def create_relations
#     UserPreference.create(user_id: self.id) unless self.userPreference.present?
#     UserProfile.create(user_id: self.id) unless self.userProfile.present?
#     UserDetail.create(user_id: self.id) unless self.userDetail.present?
#     UserNotice.create(user_id: self.id) unless self.userNotice.present?
#     UserSmokeAddiction.create(user_id: self.id) unless self.userSmokeAddiction.present?
#   end

#   # User is following quit-smoking program?
#   def smokes?
#     self.userPreference.smokes?
#   end

#   # User is following sports program
#   def sports?
#     self.userPreference.sports?
#   end
# end
