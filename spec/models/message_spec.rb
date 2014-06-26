require 'rails_helper'

describe Message do

  # Relations
  it { should belong_to(:user) }

end
