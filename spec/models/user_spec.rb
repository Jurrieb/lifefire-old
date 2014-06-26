require 'rails_helper'

describe User do

  let(:subject) { FactoryGirl.create(:user) }

  # Relations
  it { should have_one(:userNotice) }
  it { should have_many(:userDetail) }
  it { should have_many(:userDetail) }
  it { should have_many(:userPreference) }
  it { should have_many(:userProfile) }
  it { should have_many(:userSmokeAddiction) }


  # Custom functions
  it 'Gives name of user' do
    expect(subject.name).to eq(subject.name)
  end

end
