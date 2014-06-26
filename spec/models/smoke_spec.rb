require 'rails_helper'

describe Smoke do
  # Subjects
  let(:subject) { FactoryGirl.create(:smoke, user_id: 1) }

  # Relations
  it { should belong_to(:user) }

  # Custom methods
  describe '#add_to_smoking_counter' do
    it ', value = 0' do
      # Check increment (returns boolean)
      expect(subject.add_to_smoking_counter(0)).to be_truthy
    end

    it ' ,value = random' do
      # Check increment (returns boolean)
      expect(subject.add_to_smoking_counter(rand(1..40))).to be_truthy
    end
  end
end
