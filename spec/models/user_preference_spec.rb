require 'rails_helper'

describe UserPreference do
  # Relations
  it { should belong_to(:user) }

end
