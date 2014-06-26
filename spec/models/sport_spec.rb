require 'rails_helper'

describe Sport do
  # Relations
  it { should belong_to(:user) }
end
