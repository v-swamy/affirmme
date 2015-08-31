require 'rails_helper'

describe Affirmation do
  it { should validate_presence_of(:text) }
  it { should belong_to(:user) }
end