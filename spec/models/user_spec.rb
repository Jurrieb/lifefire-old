require 'rails_helper'

describe User do
  # Subject
  let(:subject) { FactoryGirl.create(:user) }
  let(:smoke) { 10.times { FactoryGirl.create(:smoke, user_id: subject.id) }}

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
  it 'check if user follows quit smoking program' do
    expect(subject.userPreference.smokes?).to be(subject.userPreference.smokes)
  end

  it 'check if user follow sporting program' do
    expect(subject.userPreference.sports?).to be(subject.userPreference.sports)
  end

  # Concerns tests
  context 'Smoking Concern' do
    it { expect(subject.cigaret_price).to eql(0.30) }
    it { expect(subject.cigaret_tar.to_f).to eql(0.00001) }

    #  Smoke counters
    it '#smoked_today' do
      # Could return nul if there is no smoke
      expect(subject.smoked_today).to be >= 0
    end

    it '#smoked_this_week' do
      # Could return nul if there is no smoke
      expect(subject.smoked_this_week).to be >= 0
    end

    it '#smoked_this_month' do
      # Could return nul if there is no smoke
      expect(subject.smoked_this_month).to be >= 0
    end

    it '#smoked_all_time' do
      # Could return nul if there is no smoke
      expect(subject.smoked_all_time).to be >= 0
    end

    # Costs counter
    it '#all_costs' do
      # Could return nul if there is no smoke
      expect(subject.smoked_all_time).to be >= 0
    end

    # Calculate
    it '#calculate_tar' do
      # Could return nul if there is no smoke
      expect(subject.calculate_tar).to be >= 0
    end

    it '#avarage_smokes' do
      # Could return nul if there is no smoke
      expect(subject.avarage_smokes).to be >= 0
    end

    it '#reduced_cigarettes' do
      # Could return nul if there is no smoke
      expect(subject.reduced_cigarettes).to be >= 0
    end
  end

  context 'Sporting Concern' do
    it 'Last workout calories' do
      expect(subject.last_workout_calories).to be(subject.sports.last.try(:burned_calories) || nil)
    end

    it '#total_workout_calories' do
      # Could return nul if there is no workout
      expect(subject.total_workout_calories).to be >= 0
    end

    it '#avarage_calories_burned' do
      # Could return nul if there is no workout
      expect(subject.avarage_calories_burned).to be >= 0
    end

    it '#last_workout_with_km_calories' do
      # Could return nul if there is no workout
      expect(subject.last_workout_with_km_calories).to be >= 0
    end

    it '#total_workout_with_km_calories' do
      # Could return nul if there is no workout (with distance)
      expect(subject.total_workout_with_km_calories).to be >= 0
    end
  end

  context 'Karma Calculation Concern' do
    it 'calculates users profile karma?' do
      expect(subject.profile_karma).to be > 0
    end

    it 'calculates users quit smoking karma' do
      expect(subject.smoking_karma).to be > 0
    end

    it 'calculates users sporting karma' do
      expect(subject.sporting_karma).to be > 0
    end

  end
end

