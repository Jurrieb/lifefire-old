require 'rails_helper'

describe UserNotice do

  # Relations
  it { should belong_to(:user) }

end
