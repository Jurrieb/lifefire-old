require 'rails_helper'

describe Smoke do

  # Relations
  it { should belong_to(:user) }

end
