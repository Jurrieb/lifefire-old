require 'rails_helper'

describe UserDetail do

  # Relations
  it { should belong_to(:user) }

end
