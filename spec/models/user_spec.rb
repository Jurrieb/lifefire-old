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


  # Custom functions
  it 'Gives name of user' do
    expect(subject.name).to eq(subject.name)
  end

end
