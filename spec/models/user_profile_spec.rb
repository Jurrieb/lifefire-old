require 'rails_helper'

describe UserProfile do

  # Relations
  it { should belong_to(:user) }

end
